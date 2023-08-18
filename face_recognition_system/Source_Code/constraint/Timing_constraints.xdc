#作为FPGA开发者来说我们需要编写规范的代码，能做多好就做多好，这样可以尽可能降低编译器的工作难度，如果再适时地给编译器一些恰当的指导和建议（通过约束），就可以使FPGA设计更加高效。

creat_clock -period 40.000 -name cmos_pclk [get_ports cam_pclk]
#为什么需要约束主时钟？
##
#这个时序约束是一开始就算出来的，还是后面报错了再约束的？
##
#怎么做出来的？

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cam_pclk_IBUF]
#这条语句的作用是什么？
##Vivado工具在编译时通常会自动识别设计中的时钟网络，并将其分配到专用的时钟布局布线资源中。通过对某些时钟网络设置CLOCK_DEDICATED_ROUTE值为FALSE，可以将被识别为时钟网络并按照时钟网络进行布局布线的时钟信号安排到通用的布线资源中。比如，某些时钟信号由于设计疏忽或其它原因，没有被安排到FPGA器件的时钟专用引脚上，在编译的时候就会报错，此时就可以使用CLOCK_DEDICATED_ROUTE约束来忽略这个错误。
