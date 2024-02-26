`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.02.2024 22:13:27
// Design Name: 
// Module Name: tb_asyn_fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_asyn_fifo();
                   parameter D_BITS = 8;
                  parameter A_BITS = 4;
                   wire[D_BITS-1 :0] r_data;
                   wire               w_full;
                   wire               r_empty;
                   reg [D_BITS-1:0] w_data;
                   reg            w_inc, w_rst;
                   reg             w_clk;
                   reg             r_inc,r_clk,r_rst;
                   
 asyn_fifo  dut

    (r_data,
                   w_full,
                   r_empty,
                   w_data,
                   w_inc, w_clk,w_rst,
                   r_inc,r_clk,r_rst);
                   
 initial begin 
  w_inc =1'b1;
  r_inc =1'b1;
  r_rst= 1'b1;
  w_rst = 1'b1;
  w_clk = 1'b0;
  r_clk = 1'b0;
 end
 initial begin
 #100 
 r_rst = 1'b0;
 w_rst = 1'b0; 
 end
always #10 w_clk = ~w_clk;
always #100 r_clk =~r_clk;
integer i;
initial begin
   
        for (i = 0; i < 100; i = i + 1) begin
         @(posedge w_clk);
         w_data = $urandom;
 end
end
endmodule
