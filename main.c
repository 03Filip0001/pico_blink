#define RESET_BASE 0x40020000
#define RESET_CLEAR (RESET_BASE + 0x3000)
#define RESET_RESET (RESET_BASE + 0x0)
#define RESET_DONE (RESET_BASE + 0x8)

#define APB_BASE 0x40000000

#define BANK0_BASE (APB_BASE + 0x28000)

#define GPIO_IO_BASE 0x40028000
#define GPIO_CTRL (GPIO_IO_BASE + 0x7c)

#define SIO_BASE 0xd0000000

#define GPIO_OUT (SIO_BASE + 0x18)
#define GPIO_OE (SIO_BASE + 0x38)

#define NES sizeof(int)

int main(){

    volatile int* reset_reset = (int*) RESET_CLEAR;
    *reset_reset = (1 << 5);

    volatile int* reset_done = (int*) RESET_DONE;

    while(((*reset_done) & (1 << 5)) == 0);

    volatile int* gpio0_ctrl = (int*) GPIO_CTRL;
    *gpio0_ctrl = 0x05;

    ////////////////

    volatile int* gpio_oe = (int*) GPIO_OE;
    *gpio_oe = (1 << 14);

    volatile int* gpio_out = (int*) GPIO_OUT;
    *gpio_out = (1 << 14);

    while(1){
        
    }

    return 0;
}