module ov5640_dri (
    input                               xclk                       ,//外部时钟
    input                               rst_n                      ,//系统复位，低电平有效 
    //摄像头接口
    output                              cam_pwdn                   ,//电源休眠模式选择信号
    output                              cam_reset                  ,//复位信号，低电平有效
    input              [   7:0]         cam_data                   ,//图像数据信号（data[9:2]）
    input                               cam_pclk                   ,//数据像素时钟
    input                               cam_vsync                  ,//场同步信号
    input                               cam_href                   ,//行同步信号
    //寄存器控制接口
    output                              scl                        ,//SCCB SCL 线
    inout                               sda                        ,//SCCB SDA 线
    //摄像头分辨率配置接口
    input              [  12:0]         cmos_h_pixel               ,//水平方向分辨率
    input              [  12:0]         cmos_v_pixel               ,//垂直方向分辨率
    input              [  12:0]         total_h_pixel              ,//水平总像素大小
    input              [  12:0]         total_v_pixel              ,//垂直总像素大小
    //图像数据采集模块是在DDR3和传感器都初始化完成后才开始传输数据的
    input                               capture_start              ,//图像采集开始信号
    output                              cam_init_done              ,//摄像头初始化完成
    //用户接口
    output                              cmos_fram_vsync            ,//帧有效数据
    output                              cmos_fram_href             ,//行有效数据
    output                              cmos_fram_valid            ,//数据有效使能信号
    output             [  15:0]         cmos_fram_data              //有效数据
);
    //参数定义
    parameter                           SLAVE_ADDR = 7'h3c         ;//ov5640 的器件地址：7'h3c
    parameter                           BIT_CTRL = 1'b1            ;//ov5640 的字节地址为16位（0：8位     1：16位）
    parameter                           CLK_FREQ = 27'd50_000_000  ;//i2c_dri 模块的驱动时钟频率
    parameter                           I2C_FREQ = 18'd250_000     ;//I2C 的 SCL 时钟频率，不超过400KHz
    //线网类型定义
wire                                    i2c_exec                   ;//I2C 触发执行信号
wire                   [  23:0]         i2c_data                   ;//I2C 要配置的地址和数据（高16位地址，低8位数据）
wire                                    i2c_done                   ;//I2C 寄存器配置完成信号
wire                                    i2c_dri_clk                ;//I2C 操作时钟
wire                   [   7:0]         i2c_data_r                 ;//I2C 读出的数据
wire                                    i2c_rh_wl                  ;//I2C 读写控制信号  

/*+-------------------------------------------------------------------------------------------------------------------+
  |                                                   main code                                                       |
  +-------------------------------------------------------------------------------------------------------------------+*/

//ov5640正常工作相关配置
assign cam_pwdn = 1'b0;                                             //电源休眠模式选择 0：正常模式 1：电源休眠模式
assign cam_reset = 1'b1;                                            //cmos 复位设置 低电平有效
//I2C配置模块

//I2C驱动模块

//CMOS图像数据采集模块

endmodule