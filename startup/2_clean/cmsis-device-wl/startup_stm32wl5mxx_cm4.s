.syntax unified
.cpu cortex-m4
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
.size g_pfnVectors, .-g_pfnVectors
g_pfnVectors:
.word _estack
.word Reset_Handler
.word NMI_Handler
.word HardFault_Handler
.word MemManage_Handler
.word BusFault_Handler
.word UsageFault_Handler
.word 0
.word 0
.word 0
.word 0
.word SVC_Handler
.word DebugMon_Handler
.word 0
.word PendSV_Handler
.word SysTick_Handler
.word WWDG_IRQHandler
.word PVD_PVM_IRQHandler
.word TAMP_STAMP_LSECSS_SSRU_IRQHandler
.word RTC_WKUP_IRQHandler
.word FLASH_IRQHandler
.word RCC_IRQHandler
.word EXTI0_IRQHandler
.word EXTI1_IRQHandler
.word EXTI2_IRQHandler
.word EXTI3_IRQHandler
.word EXTI4_IRQHandler
.word DMA1_Channel1_IRQHandler
.word DMA1_Channel2_IRQHandler
.word DMA1_Channel3_IRQHandler
.word DMA1_Channel4_IRQHandler
.word DMA1_Channel5_IRQHandler
.word DMA1_Channel6_IRQHandler
.word DMA1_Channel7_IRQHandler
.word ADC_IRQHandler
.word DAC_IRQHandler
.word C2SEV_PWR_C2H_IRQHandler
.word COMP_IRQHandler
.word EXTI9_5_IRQHandler
.word TIM1_BRK_IRQHandler
.word TIM1_UP_IRQHandler
.word TIM1_TRG_COM_IRQHandler
.word TIM1_CC_IRQHandler
.word TIM2_IRQHandler
.word TIM16_IRQHandler
.word TIM17_IRQHandler
.word I2C1_EV_IRQHandler
.word I2C1_ER_IRQHandler
.word I2C2_EV_IRQHandler
.word I2C2_ER_IRQHandler
.word SPI1_IRQHandler
.word SPI2_IRQHandler
.word USART1_IRQHandler
.word USART2_IRQHandler
.word LPUART1_IRQHandler
.word LPTIM1_IRQHandler
.word LPTIM2_IRQHandler
.word EXTI15_10_IRQHandler
.word RTC_Alarm_IRQHandler
.word LPTIM3_IRQHandler
.word SUBGHZSPI_IRQHandler
.word IPCC_C1_RX_IRQHandler
.word IPCC_C1_TX_IRQHandler
.word HSEM_IRQHandler
.word I2C3_EV_IRQHandler
.word I2C3_ER_IRQHandler
.word SUBGHZ_Radio_IRQHandler
.word AES_IRQHandler
.word RNG_IRQHandler
.word PKA_IRQHandler
.word DMA2_Channel1_IRQHandler
.word DMA2_Channel2_IRQHandler
.word DMA2_Channel3_IRQHandler
.word DMA2_Channel4_IRQHandler
.word DMA2_Channel5_IRQHandler
.word DMA2_Channel6_IRQHandler
.word DMA2_Channel7_IRQHandler
.word DMAMUX1_OVR_IRQHandler
.weak NMI_Handler
.thumb_set NMI_Handler,Default_Handler
.weak HardFault_Handler
.thumb_set HardFault_Handler,Default_Handler
.weak MemManage_Handler
.thumb_set MemManage_Handler,Default_Handler
.weak BusFault_Handler
.thumb_set BusFault_Handler,Default_Handler
.weak UsageFault_Handler
.thumb_set UsageFault_Handler,Default_Handler
.weak SVC_Handler
.thumb_set SVC_Handler,Default_Handler
.weak DebugMon_Handler
.thumb_set DebugMon_Handler,Default_Handler
.weak PendSV_Handler
.thumb_set PendSV_Handler,Default_Handler
.weak SysTick_Handler
.thumb_set SysTick_Handler,Default_Handler
.weak WWDG_IRQHandler
.thumb_set WWDG_IRQHandler,Default_Handler
.weak PVD_PVM_IRQHandler
.thumb_set PVD_PVM_IRQHandler,Default_Handler
.weak TAMP_STAMP_LSECSS_SSRU_IRQHandler
.thumb_set TAMP_STAMP_LSECSS_SSRU_IRQHandler,Default_Handler
.weak RTC_WKUP_IRQHandler
.thumb_set RTC_WKUP_IRQHandler,Default_Handler
.weak FLASH_IRQHandler
.thumb_set FLASH_IRQHandler,Default_Handler
.weak RCC_IRQHandler
.thumb_set RCC_IRQHandler,Default_Handler
.weak EXTI0_IRQHandler
.thumb_set EXTI0_IRQHandler,Default_Handler
.weak EXTI1_IRQHandler
.thumb_set EXTI1_IRQHandler,Default_Handler
.weak EXTI2_IRQHandler
.thumb_set EXTI2_IRQHandler,Default_Handler
.weak EXTI3_IRQHandler
.thumb_set EXTI3_IRQHandler,Default_Handler
.weak EXTI4_IRQHandler
.thumb_set EXTI4_IRQHandler,Default_Handler
.weak DMA1_Channel1_IRQHandler
.thumb_set DMA1_Channel1_IRQHandler,Default_Handler
.weak DMA1_Channel2_IRQHandler
.thumb_set DMA1_Channel2_IRQHandler,Default_Handler
.weak DMA1_Channel3_IRQHandler
.thumb_set DMA1_Channel3_IRQHandler,Default_Handler
.weak DMA1_Channel4_IRQHandler
.thumb_set DMA1_Channel4_IRQHandler,Default_Handler
.weak DMA1_Channel5_IRQHandler
.thumb_set DMA1_Channel5_IRQHandler,Default_Handler
.weak DMA1_Channel6_IRQHandler
.thumb_set DMA1_Channel6_IRQHandler,Default_Handler
.weak DMA1_Channel7_IRQHandler
.thumb_set DMA1_Channel7_IRQHandler,Default_Handler
.weak ADC_IRQHandler
.thumb_set ADC_IRQHandler,Default_Handler
.weak DAC_IRQHandler
.thumb_set DAC_IRQHandler,Default_Handler
.weak C2SEV_PWR_C2H_IRQHandler
.thumb_set C2SEV_PWR_C2H_IRQHandler,Default_Handler
.weak COMP_IRQHandler
.thumb_set COMP_IRQHandler,Default_Handler
.weak EXTI9_5_IRQHandler
.thumb_set EXTI9_5_IRQHandler,Default_Handler
.weak TIM1_BRK_IRQHandler
.thumb_set TIM1_BRK_IRQHandler,Default_Handler
.weak TIM1_UP_IRQHandler
.thumb_set TIM1_UP_IRQHandler,Default_Handler
.weak TIM1_TRG_COM_IRQHandler
.thumb_set TIM1_TRG_COM_IRQHandler,Default_Handler
.weak TIM1_CC_IRQHandler
.thumb_set TIM1_CC_IRQHandler,Default_Handler
.weak TIM2_IRQHandler
.thumb_set TIM2_IRQHandler,Default_Handler
.weak TIM16_IRQHandler
.thumb_set TIM16_IRQHandler,Default_Handler
.weak TIM17_IRQHandler
.thumb_set TIM17_IRQHandler,Default_Handler
.weak I2C1_EV_IRQHandler
.thumb_set I2C1_EV_IRQHandler,Default_Handler
.weak I2C1_ER_IRQHandler
.thumb_set I2C1_ER_IRQHandler,Default_Handler
.weak I2C2_EV_IRQHandler
.thumb_set I2C2_EV_IRQHandler,Default_Handler
.weak I2C2_ER_IRQHandler
.thumb_set I2C2_ER_IRQHandler,Default_Handler
.weak SPI1_IRQHandler
.thumb_set SPI1_IRQHandler,Default_Handler
.weak SPI2_IRQHandler
.thumb_set SPI2_IRQHandler,Default_Handler
.weak USART1_IRQHandler
.thumb_set USART1_IRQHandler,Default_Handler
.weak USART2_IRQHandler
.thumb_set USART2_IRQHandler,Default_Handler
.weak LPUART1_IRQHandler
.thumb_set LPUART1_IRQHandler,Default_Handler
.weak LPTIM1_IRQHandler
.thumb_set LPTIM1_IRQHandler,Default_Handler
.weak LPTIM2_IRQHandler
.thumb_set LPTIM2_IRQHandler,Default_Handler
.weak EXTI15_10_IRQHandler
.thumb_set EXTI15_10_IRQHandler,Default_Handler
.weak RTC_Alarm_IRQHandler
.thumb_set RTC_Alarm_IRQHandler,Default_Handler
.weak LPTIM3_IRQHandler
.thumb_set LPTIM3_IRQHandler,Default_Handler
.weak SUBGHZSPI_IRQHandler
.thumb_set SUBGHZSPI_IRQHandler,Default_Handler
.weak IPCC_C1_RX_IRQHandler
.thumb_set IPCC_C1_RX_IRQHandler,Default_Handler
.weak IPCC_C1_TX_IRQHandler
.thumb_set IPCC_C1_TX_IRQHandler,Default_Handler
.weak HSEM_IRQHandler
.thumb_set HSEM_IRQHandler,Default_Handler
.weak I2C3_EV_IRQHandler
.thumb_set I2C3_EV_IRQHandler,Default_Handler
.weak I2C3_ER_IRQHandler
.thumb_set I2C3_ER_IRQHandler,Default_Handler
.weak SUBGHZ_Radio_IRQHandler
.thumb_set SUBGHZ_Radio_IRQHandler,Default_Handler
.weak AES_IRQHandler
.thumb_set AES_IRQHandler,Default_Handler
.weak RNG_IRQHandler
.thumb_set RNG_IRQHandler,Default_Handler
.weak PKA_IRQHandler
.thumb_set PKA_IRQHandler,Default_Handler
.weak DMA2_Channel1_IRQHandler
.thumb_set DMA2_Channel1_IRQHandler,Default_Handler
.weak DMA2_Channel2_IRQHandler
.thumb_set DMA2_Channel2_IRQHandler,Default_Handler
.weak DMA2_Channel3_IRQHandler
.thumb_set DMA2_Channel3_IRQHandler,Default_Handler
.weak DMA2_Channel4_IRQHandler
.thumb_set DMA2_Channel4_IRQHandler,Default_Handler
.weak DMA2_Channel5_IRQHandler
.thumb_set DMA2_Channel5_IRQHandler,Default_Handler
.weak DMA2_Channel6_IRQHandler
.thumb_set DMA2_Channel6_IRQHandler,Default_Handler
.weak DMA2_Channel7_IRQHandler
.thumb_set DMA2_Channel7_IRQHandler,Default_Handler
.weak DMAMUX1_OVR_IRQHandler
.thumb_set DMAMUX1_OVR_IRQHandler,Default_Handler
.weak SystemInit