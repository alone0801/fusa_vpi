#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <gelf.h>
#include <fcntl.h>

#ifdef __cplusplus
extern "C" {
#endif

uint8_t big_endian;

uint8_t *dump_program_data(Elf *elf_object, int *size)
{
    uint8_t *buffer = NULL;
    Elf_Data *data = NULL;
    size_t phdr_num;
    size_t max_paddr = 0;
    size_t i = 0;
    GElf_Phdr phdr;

    *size = 0;

    int ret = elf_getphdrnum(elf_object, &phdr_num);
    if (ret) {
        printf("Problem during ELF parsing\n");
        return NULL;
    }

    if (phdr_num == 0)
        return NULL;

    for (i = 0; i < phdr_num; i++) {
        if (gelf_getphdr(elf_object, i, &phdr) != &phdr) {
            printf("Problem during ELF parsing\n");
            free(buffer); // Free previously allocated memory
            return NULL;
        }

        printf("Program header %lu: addr 0x%08X,", i, (unsigned int)phdr.p_paddr);
        printf(" size 0x%08X\n", (unsigned int)phdr.p_filesz);

        if (phdr.p_paddr + phdr.p_filesz >= max_paddr) {
            max_paddr = phdr.p_paddr + phdr.p_filesz;
            uint8_t *new_buffer = (uint8_t *)realloc(buffer, max_paddr);
            if (new_buffer == NULL) {
                printf("Memory allocation failed\n");
                free(buffer); // Free previously allocated memory
                return NULL;
            }
            buffer = new_buffer;
        }

        data = elf_getdata_rawchunk(elf_object, phdr.p_offset, phdr.p_filesz, ELF_T_BYTE);
        if (data != NULL) {
            memcpy(buffer + phdr.p_paddr, data->d_buf, data->d_size);
        } else {
            printf("Couldn't load program data chunk\n");
            free(buffer); // Free previously allocated memory
            return NULL;
        }
    }

    *size = max_paddr;
    return buffer;
}

uint8_t *dump_section_data(Elf *elf_object, int *size)
{
    uint8_t *buffer = NULL;
    Elf_Data *data = NULL;
    size_t shdr_num;
    size_t max_saddr = 0;
    GElf_Shdr shdr;
    size_t shstrndx;
    char *name = NULL;

    *size = 0;

    int ret = elf_getshdrnum(elf_object, &shdr_num);
    if (ret) {
        printf("Problem during ELF parsing\n");
        return NULL;
    }

    if (shdr_num == 0)
        return NULL;

    Elf_Scn *cur_section = NULL;
    ret = elf_getshdrstrndx(elf_object, &shstrndx);
    if (ret)
        printf("No string table found\n");

    while ((cur_section = elf_nextscn(elf_object, cur_section)) != NULL ) {
        if (gelf_getshdr(cur_section, &shdr) != &shdr) {
            printf("Problem during ELF parsing\n");
            free(buffer); // Free previously allocated memory
            return NULL;
        }

        if ((shdr.sh_type == SHT_PROGBITS) && (shdr.sh_flags & SHF_ALLOC) && shdr.sh_size != 0) {

            name = elf_strptr(elf_object, shstrndx , shdr.sh_name);
            printf("Loading section %s, size 0x%08X lma 0x%08X\n",
                name ? name : "??", (unsigned int)shdr.sh_size, (unsigned int)shdr.sh_addr);

            if (shdr.sh_addr + shdr.sh_size >= max_saddr) {
                max_saddr = shdr.sh_addr + shdr.sh_size;
                uint8_t *new_buffer = (uint8_t *)realloc(buffer, max_saddr);
                if (new_buffer == NULL) {
                    printf("Memory allocation failed\n");
                    free(buffer); // Free previously allocated memory
                    return NULL;
                }
                buffer = new_buffer;
            }

            data = elf_getdata(cur_section, data);
            if (data != NULL) {
                memcpy(buffer + shdr.sh_addr, data->d_buf, data->d_size);
            } else {
                printf("Couldn't load section data chunk\n");
                free(buffer); // Free previously allocated memory
                return NULL;
            }
        }
    }

    *size = max_saddr;
    return buffer;
}
uint8_t *load_elf_file(char *elf_file_name, int *size)
{
	uint8_t *buf = NULL;
	char *id;

	if (elf_version(EV_CURRENT) == EV_NONE)
		return NULL;

	int fd = open(elf_file_name, O_RDONLY , 0);
	if (fd < 0) {
		printf("Can't open %s\n", elf_file_name);
		return NULL;
	}

	Elf *elf_object = elf_begin(fd , ELF_C_READ , NULL);
	if (elf_object == NULL) {
		printf("Problem while starting ELF parsing\n");
		close(fd);
		return NULL;
	}

	if (elf_kind(elf_object) != ELF_K_ELF) {
		printf("%s is not an ELF file\n", elf_file_name);
		elf_end(elf_object);
		close(fd);
		return NULL;
	}

	if (( id = elf_getident (elf_object , NULL )) == NULL )
		printf("getident() failed : %s.",
		elf_errmsg(-1));

	if (id[EI_DATA] == ELFDATA2LSB)
		big_endian = 0;
	else if (id[EI_DATA] == ELFDATA2MSB)
		big_endian = 1;
	else {
		printf("%s has unknown endianness '%d'\n", elf_file_name, id[EI_DATA]);
		elf_end(elf_object);
		close(fd);
		return NULL;
	}

	buf = dump_program_data(elf_object, size);

	if (buf == NULL)
		buf = dump_section_data(elf_object, size);

	elf_end(elf_object);
	close(fd);

	return buf;
}
unsigned int read_32(uint8_t *bin_file, unsigned int address)
{
  if (big_endian)
	return (bin_file[address] << 24) | (bin_file[address + 1] << 16) |
	       (bin_file[address + 2] << 8) | (bin_file[address + 3]);
  else
	return (bin_file[address + 3] << 24) | (bin_file[address + 2] << 16) |
	       (bin_file[address + 1] <<  8) | (bin_file[address + 0]);
}

unsigned short read_16(uint8_t *bin_file, unsigned int address)
{
	return (bin_file[address] << 8) | (bin_file[address + 1]);
}

#ifdef __cplusplus
}
#endif
