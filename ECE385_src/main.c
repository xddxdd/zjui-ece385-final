#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "system.h"

int main(void)
{
	printf("Hello World\n");
	usleep(5000);

	int* eth0_mdio = ETH0_MDIO_BASE;
	int* eth1_mdio = ETH1_MDIO_BASE;

	printf("Initializing eth0\n");
	eth0_mdio[0x10] |= 0x0060;
	eth0_mdio[0x14] |= 0x0082;
	eth0_mdio[0x00] |= 0x8000;
	while(eth0_mdio[0x00] & 0x8000);

	printf("Initializing eth1\n");
	eth1_mdio[0x10] |= 0x0060;
	eth1_mdio[0x14] |= 0x0082;
	eth1_mdio[0x00] |= 0x8000;
	while(eth1_mdio[0x00] & 0x8000);

	printf("Done\n");

	return 0;
}