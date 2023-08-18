module ov5640_lcd (
    input                               sys_clk                    ,//系统时钟
    input                               sys_rst_n                  ,//系统复位，低电平有效
    //摄像头接口
    output                              cam_pwdn                   ,//
    output                              cam_reset                  ,//
    output                              cam_xclk                   ,//
    input              [   7:0]         cam_data                   ,//
    input                               cam_pclk                   ,//
    input                               cam_vsync                  ,//
    input                               cam_href                   ,//
    output                              cam_scl                    ,//
    inout                               cam_sda                    ,//
    //DDR3接口
    
    //LCD接口

    output                              lcd_pclk                    //
);
    
endmodule