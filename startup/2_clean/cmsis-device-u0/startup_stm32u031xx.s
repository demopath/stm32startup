.syntax unified
.cpu cortex-m0plus
.fpu softvfp
.thumb
.global g_pfnVectors
.global Default_Handler
.word _sidata
.word _sdata
.word _edata
.word _sbss
.word _ebss
.section .text.Reset_Handler
.weak Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
ldr r0, =_estack
mov sp, r0
bl SystemInit
ldr r0, =_sdata
ldr r1, =_edata
ldr r2, =_sidata
movs r3, #0
b LoopCopyDataInit
CopyDataInit:
ldr r4, [r2, r3]
str r4, [r0, r3]
adds r3, r3, #4
LoopCopyDataInit:
adds r4, r0, r3
cmp r4, r1
bcc CopyDataInit
ldr r2, =_sbss
ldr r4, =_ebss
movs r3, #0
b LoopFillZerobss
FillZerobss:
str r3, [r2]
adds r2, r2, #4
LoopFillZerobss:
cmp r2, r4
bcc FillZerobss
bl __libc_init_array
bl main
LoopForever:
b LoopForever
.size Reset_Handler, .-Reset_Handler
.section .text.Default_Handler,"ax",%progbits
Default_Handler:
Infinite_Loop:
b Infinite_Loop
.size Default_Handler, .-Default_Handler
.section .isr_vector,"a",%progbits
.type g_pfnVectors, %object
g_pfnVectors:
.word _estack
.word Reset_Handler
.word NMI_Handler
.word HardFault_Handler
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word SVC_Handler
.word 0
.word 0
.word PendSV_Handler
.word SysTick_Handler
.word WWDG_IWDG_IRQHandler
.word PVD_PVM_IRQHandler
.word RTC_TAMP_IRQHandler
.word FLASH_ECC_IRQHandler
.word RCC_CRS_IRQHandler
.word EXTI0_1_IRQHandler
.word EXTI2_3_IRQHandler
.word EXTI4_15_IRQHandler
.word 0
.word DMA1_Channel1_IRQHandler
.word DMA1_Channel2_3_IRQHandler
.word DMA1_Ch4_7_DMAMUX_OVR_IRQHandler
.word ADC_COMP1_IRQHandler
.word TIM1_BRK_UP_TRG_COM_IRQHandler
.word TIM1_CC_IRQHandler
.word TIM2_IRQHandler
.word TIM3_IRQHandler
.word TIM6_DAC_LPTIM1_IRQHandler
.word TIM7_LPTIM2_IRQHandler
.word TIM15_IRQHandler
.word TIM16_IRQHandler
.word TSC_IRQHandler
.word 0
.word I2C1_IRQHandler
.word I2C2_3_IRQHandler
.word SPI1_IRQHandler
.word SPI2_IRQHandler
.word USART1_IRQHandler
.word USART2_LPUART2_IRQHandler
.word USART3_LPUART1_IRQHandler
.word USART4_IRQHandler
.word RNG_IRQHandler
.size g_pfnVectors, .-g_pfnVectors
.weak NMI_Handler
.thumb_set NMI_Handler,Default_Handler
.weak HardFault_Handler
.thumb_set HardFault_Handler,Default_Handler
.weak SVC_Handler
.thumb_set SVC_Handler,Default_Handler
.weak PendSV_Handler
.thumb_set PendSV_Handler,Default_Handler
.weak SysTick_Handler
.thumb_set SysTick_Handler,Default_Handler
.weak WWDG_IWDG_IRQHandler
.thumb_set WWDG_IWDG_IRQHandler,Default_Handler
.weak PVD_PVM_IRQHandler
.thumb_set PVD_PVM_IRQHandler,Default_Handler
.weak RTC_TAMP_IRQHandler
.thumb_set RTC_TAMP_IRQHandler,Default_Handler
.weak FLASH_ECC_IRQHandler
.thumb_set FLASH_ECC_IRQHandler,Default_Handler
.weak RCC_CRS_IRQHandler
.thumb_set RCC_CRS_IRQHandler,Default_Handler
.weak EXTI0_1_IRQHandler
.thumb_set EXTI0_1_IRQHandler,Default_Handler
.weak EXTI2_3_IRQHandler
.thumb_set EXTI2_3_IRQHandler,Default_Handler
.weak EXTI4_15_IRQHandler
.thumb_set EXTI4_15_IRQHandler,Default_Handler
.weak DMA1_Channel1_IRQHandler
.thumb_set DMA1_Channel1_IRQHandler,Default_Handler
.weak DMA1_Channel2_3_IRQHandler
.thumb_set DMA1_Channel2_3_IRQHandler,Default_Handler
.weak DMA1_Ch4_7_DMAMUX_OVR_IRQHandler
.thumb_set DMA1_Ch4_7_DMAMUX_OVR_IRQHandler,Default_Handler
.weak ADC_COMP1_IRQHandler
.thumb_set ADC_COMP1_IRQHandler,Default_Handler
.weak TIM1_BRK_UP_TRG_COM_IRQHandler
.thumb_set TIM1_BRK_UP_TRG_COM_IRQHandler,Default_Handler
.weak TIM1_CC_IRQHandler
.thumb_set TIM1_CC_IRQHandler,Default_Handler
.weak TIM2_IRQHandler
.thumb_set TIM2_IRQHandler,Default_Handler
.weak TIM3_IRQHandler
.thumb_set TIM3_IRQHandler,Default_Handler
.weak TIM6_DAC_LPTIM1_IRQHandler
.thumb_set TIM6_DAC_LPTIM1_IRQHandler,Default_Handler
.weak TIM7_LPTIM2_IRQHandler
.thumb_set TIM7_LPTIM2_IRQHandler,Default_Handler
.weak TIM15_IRQHandler
.thumb_set TIM15_IRQHandler,Default_Handler
.weak TIM16_IRQHandler
.thumb_set TIM16_IRQHandler,Default_Handler
.weak TSC_IRQHandler
.thumb_set TSC_IRQHandler,Default_Handler
.weak I2C1_IRQHandler
.thumb_set I2C1_IRQHandler,Default_Handler
.weak I2C2_3_IRQHandler
.thumb_set I2C2_3_IRQHandler,Default_Handler
.weak SPI1_IRQHandler
.thumb_set SPI1_IRQHandler,Default_Handler
.weak SPI2_IRQHandler
.thumb_set SPI2_IRQHandler,Default_Handler
.weak USART1_IRQHandler
.thumb_set USART1_IRQHandler,Default_Handler
.weak USART2_LPUART2_IRQHandler
.thumb_set USART2_LPUART2_IRQHandler,Default_Handler
.weak USART3_LPUART1_IRQHandler
.thumb_set USART3_LPUART1_IRQHandler,Default_Handler
.weak USART4_IRQHandler
.thumb_set USART4_IRQHandler,Default_Handler
.weak RNG_IRQHandler
.thumb_set RNG_IRQHandler,Default_Handler
.weak SystemInit