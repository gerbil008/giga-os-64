#include "I-O.h"

void outb(uint16_t port, uint8_t value) {
    __asm__ __volatile__ (
        "outb %0, %1"
        :
        : "a" (value), "Nd" (port)
    );
}

uint8_t inb(uint16_t port) {
    uint8_t value;
    __asm__ __volatile__ (
        "inb %1, %0"
        : "=a" (value)
        : "Nd" (port)
    );
    return value;
}