#include <stdio.h>

#include <gelf.h>
#include <libelf.h>

void main(void) {
    Elf *elf_object;
    size_t phdr_num;

    int ret = elf_getphdrnum(elf_object, &phdr_num);

//    extern int elf_getphdrnum (Elf *__elf, size_t *__dst);

    printf("ret: %d",&ret);
} 
