module picture_size (
    input                               clk                        ,//系统时钟 
    input                               rst_n                      ,//系统复位，低电平有效
    input              [  15:0]         ID_lcd                     ,// 正点原子屏幕器件地址

    output reg         [  12:0]         cmos_h_pixel               ,//水平方向分辨率（行有效长度）
    output reg         [  12:0]         cmos_v_pixel               ,//垂直方向分辨率（场有效长度）
    output reg         [  12:0]         total_h_pixel              ,//水平总像素大小（场宽，行长度，HTS，=行有效长度+行消隐）
    output reg         [  12:0]         total_v_pixel              ,//垂直总像素大小（场高，帧长度，VTS，=场有效长度+场消隐）
    output reg         [  23:0]         sdram_max_addr              // DDR3最大读写地址（=cmos_h_pixel*coms_v_pixel）
);
    parameter                           ID_4342 = 16'h4342         ;//分辨率：130_560  --列：480   行：272
    parameter                           ID_7084 = 16'h7084         ;//分辨率：384_000  --列：800   行：480
    parameter                           ID_7016 = 16'h7016         ;//分辨率：614_400  --列：1024  行：600
    parameter                           ID_1018 = 16'h1018         ;//分辨率：1_024_000--列：1280  行：800
    parameter                           ID_4384 = 16'h4384         ;//分辨率：384_000  --列：800   行：480
/*+-------------------------------------------------------------------------------------------------------------------+
  |                                                   main code                                                       |
  +-------------------------------------------------------------------------------------------------------------------+*/
  //配置摄像头输出尺寸的大小
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cmos_h_pixel <= 13'b0;
        cmos_v_pixel <= 13'b0;
        sdram_max_addr<=23'b0;
    end
    else begin
        case (ID_lcd)
            16'h4342 : begin
                cmos_h_pixel = 13'd480;
                cmos_v_pixel = 13'd272;
                sdram_max_addr = 23'd130560;
            end
            16'h7084 : begin
                cmos_h_pixel = 13'd800;
                cmos_v_pixel = 13'd480;
                sdram_max_addr = 23'd384000;
            end
            16'h7016 : begin
                cmos_h_pixel = 13'd1024;
                cmos_v_pixel = 13'd600;
                sdram_max_addr = 23'd614400;
            end
            16'h1018 : begin
                cmos_h_pixel = 13'd1280;
                cmos_v_pixel = 13'd800;
                sdram_max_addr = 23'd1024000;
            end
            16'h4384 : begin
                cmos_h_pixel = 13'd800;
                cmos_v_pixel = 13'd480;
                sdram_max_addr = 23'd384000;
            end
            default: begin
                cmos_h_pixel = 13'd800;
                cmos_v_pixel = 13'd480;
                sdram_max_addr = 23'd384000;
            end
        endcase
    end
  end
  //对HTS及VTS的配置会影响摄像头输出图像的帧率，FPS = PCLK/（VTS*HTS）
  always @(*) begin
    case (ID_lcd)
        ID_4342 : begin
            total_h_pixel = 13'd1800;
            total_v_pixel = 13'd1000;
        end
        ID_7084 : begin
            total_h_pixel = 13'd1800;
            total_v_pixel = 13'd1000;
        end
        ID_7016 : begin
            total_h_pixel = 13'd2200;
            total_v_pixel = 13'd1000;
        end
        ID_1018 : begin
            total_h_pixel = 13'd2570;
            total_v_pixel = 13'd980;
        end
        ID_4384 : begin
            total_h_pixel = 13'd1800;
            total_v_pixel = 13'd1000;
        end
        default : begin
            total_h_pixel = 13'd1800;
            total_v_pixel = 13'd1000;
        end
    endcase
  end
endmodule