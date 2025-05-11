#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <vpi_user.h>
#include <libxml/parser.h>
#include <libxml/tree.h>

#define MEM_FILE "memory_init.txt"
#define FAULT_XML_FILE "fault.xml"

// name match
int is_memory_type(const char* signal_name) {
    return (strstr(signal_name, "sram") || strstr(signal_name, "ram") ||
            strstr(signal_name, "rom") || strstr(signal_name, "mem"));
}

// mem to 0
void initialize_memory(vpiHandle handle) {
    s_vpi_value val;
    val.format = vpiIntVal;
    val.value.integer = 0;
    vpi_put_value(handle, &val, NULL, vpiNoDelay);
}

// recursive
void recursive_scan(vpiHandle scope) {
    vpiHandle reg_iter = vpi_iterate(vpiReg, scope);
    vpiHandle reg;

    while (reg_iter && (reg = vpi_scan(reg_iter)) != NULL) {
        const char* name = vpi_get_str(vpiName, reg);
        if (is_memory_type(name)) {
            int width = vpi_get(vpiSize, reg);
            if(width == 1)
                initialize_memory(reg);
            else
            {
                int i;
                for (i = 0; i < width; ++i) {
                    vpiHandle bit = vpi_handle_by_index(reg, i);
                    if (bit) {
                        initialize_memory(bit);
                    }
                }
            }
        }
    }

    vpiHandle mem_iter = vpi_iterate(vpiMemory, scope);
    vpiHandle mem;
    while (mem_iter && (mem = vpi_scan(mem_iter)) != NULL) {
        const char* name = vpi_get_str(vpiName, mem);
        if (is_memory_type(name)) {
            int depth = vpi_get(vpiSize, mem);
            int i;
            for (i = 0; i < depth; ++i) {
                vpiHandle word = vpi_handle_by_index(mem, i);
                if (word) {
                    initialize_memory(word);
                }
            }
        }
    }

    vpiHandle inst_iter = vpi_iterate(vpiModule, scope);
    vpiHandle inst;
    while (inst_iter && (inst = vpi_scan(inst_iter)) != NULL) {
        recursive_scan(inst);
    }
}

// clear_mem
PLI_INT32 vpi_clear_memory_calltf(PLI_BYTE8* user_data) {
    vpiHandle top = vpi_handle_by_name("autosoc_tb.dut", NULL);
    if (top) {
        recursive_scan(top);
        vpi_printf("[VPI] Cleared memory recursively.\n");
    } else {
        vpi_printf("[VPI] Could not find top module 'dut'.\n");
    }
    return 0;
}

// file_init_mem
PLI_INT32 vpi_init_from_file_calltf(PLI_BYTE8* user_data) {
    FILE* file = fopen(MEM_FILE, "r");
    if (!file) {
        vpi_printf("[VPI] Cannot open file: %s\n", MEM_FILE);
        return 0;
    }

    char line[256];
    while (fgets(line, sizeof(line), file)) {
        unsigned int addr, val;
        if (sscanf(line, "%x %x", &addr, &val) == 2) {
            vpiHandle mem = vpi_handle_by_name("dut.main_mem", NULL);
            if (mem) {
                vpiHandle word = vpi_handle_by_index(mem, addr);
                if (word) {
                    s_vpi_value v;
                    v.format = vpiIntVal;
                    v.value.integer = val;
                    vpi_put_value(word, &v, NULL, vpiNoDelay);
                }
            }
        }
    }

    fclose(file);
    vpi_printf("[VPI] Initialized from file: %s\n", MEM_FILE);
    return 0;
}

// xml_init_mem
PLI_INT32 vpi_init_from_xml_calltf(PLI_BYTE8* user_data) {
    xmlDocPtr doc = xmlParseFile(FAULT_XML_FILE);
    if (!doc) {
        vpi_printf("[VPI] Cannot parse XML: %s\n", FAULT_XML_FILE);
        return 0;
    }

    xmlNodePtr root = xmlDocGetRootElement(doc);
    xmlNodePtr node;
    for (node = root->children; node; node = node->next) {
        if (node->type == XML_ELEMENT_NODE && strcmp((const char*)node->name, "memory") == 0) {
            char* addr_str = (char*)xmlGetProp(node, (const xmlChar*)"address");
            char* val_str = (char*)xmlGetProp(node, (const xmlChar*)"value");

            if (addr_str && val_str) {
                unsigned int addr = (unsigned int)strtol(addr_str, NULL, 16);
                unsigned int val = (unsigned int)strtol(val_str, NULL, 16);

                vpiHandle mem = vpi_handle_by_name("dut.main_mem", NULL);
                if (mem) {
                    vpiHandle word = vpi_handle_by_index(mem, addr);
                    if (word) {
                        s_vpi_value v;
                        v.format = vpiIntVal;
                        v.value.integer = val;
                        vpi_put_value(word, &v, NULL, vpiNoDelay);
                    }
                }
            }

            if (addr_str) xmlFree(addr_str);
            if (val_str) xmlFree(val_str);
        }
    }

    xmlFreeDoc(doc);
    vpi_printf("[VPI] Initialized from XML: %s\n", FAULT_XML_FILE);
    return 0;
}

/*
// register
void register_vpi_callbacks() {
    static s_vpi_systf_data tf_list[] = {
        {vpiSysTask, 0, "$clear_mem",     vpi_clear_memory_calltf,     NULL, NULL, NULL},
        {vpiSysTask, 0, "$file_init_mem", vpi_init_from_file_calltf,   NULL, NULL, NULL},
        {vpiSysTask, 0, "$xml_init_mem",  vpi_init_from_xml_calltf,    NULL, NULL, NULL},
        {0}
    };

    for (int i = 0; tf_list[i].type != 0; ++i) {
        vpi_register_systf(&tf_list[i]);
    }
}

void (*vlog_startup_routines[])() = {
    register_vpi_callbacks,
    0
};
*/
