// $ sudo apt install gcc-aarch64-linux-gnu binutils-aarch64-linux-gnu libi2c-dev:arm64
// $ aarch64-linux-gnu-gcc main.c -o app -static -li2c
#include <fcntl.h>
#include <i2c/smbus.h>
#include <linux/i2c-dev.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <unistd.h>

int write_byte(char *location, int address, unsigned char byte) {
    int device;
    // Open device file
    if ((device = open(location, O_RDWR)) == -1) {
        fprintf(stderr, "ERROR: failed to open i2c bus at %s\n", location);
        return EXIT_FAILURE;
    }
    // Set slave address
    ioctl(device, I2C_SLAVE, address);
    // Write
    i2c_smbus_write_byte(device, byte);

    // Close device file
    close(device);

    return EXIT_SUCCESS;
}

int read_byte(char *location, int address, unsigned char *byte) {
    int device;
    // Open device file
    if ((device = open(location, O_RDWR)) == -1) {
        fprintf(stderr, "ERROR: failed to open i2c bus at %s\n", location);
        return EXIT_FAILURE;
    }
    // Set slave address
    ioctl(device, I2C_SLAVE, address);
    // Write
    *byte = i2c_smbus_read_byte(device);

    // Close device file
    close(device);
    return EXIT_SUCCESS;
}

int main() {
    char *location = "/dev/i2c-3";
    int address = 0x20;

    unsigned char byte;
    read_byte(location, address, &byte);
    fprintf(stdout, "BYTE: %d\n", byte);

    switch (byte) {
    case 0x1f:  // 0 diodes
        byte = 0x1e;
        break;
    case 0x1e:  // 1 diode
        byte = 0x1c;
        break;
    case 0x1c:  // 2 diodes
        byte = 0x18;
        break;
    case 0x18:  // 3 diodes
        byte = 0x10;
        break;
    case 0x10:  // 4 diodes
        byte = 0x00;
        break;
    case 0x00:  // 5 diodes
        byte = 0x1f;
        break;
    }

    write_byte(location, address, byte);

    return EXIT_SUCCESS;
}
