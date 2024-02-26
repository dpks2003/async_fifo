// this is the top  module 
   // `include "r_ptr.v"
   // `include "w_ptr.v"
   // `include "ram.v"
   // `include "syn_r_w.v"

module asyn_fifo#(parameter D_BITS = 8,
                  parameter A_BITS = 4)
                 ( output [D_BITS-1 :0] r_data,
                   output               w_full,
                   output               r_empty,
                   input [D_BITS-1:0] w_data,
                   input              w_inc, w_clk,w_rst,
                   input              r_inc,r_clk,r_rst);
    
    wire [A_BITS-1:0] w_addr ,r_addr;
    wire [A_BITS:0]     w_ptr, r_ptr , ff2_r_ptr,ff2_w_ptr;

    syn_r2W #(A_BITS) syn_r2W
                     (.ff2_r_ptr(ff2_r_ptr),
                      .r_ptr(r_ptr),
                      .w_clk(w_clk),
                      .w_rst(w_rst));

    syn_w2r #(A_BITS) syn_w2r
                    (.ff2_w_ptr(ff2_w_ptr),
                     .w_ptr(w_ptr),   
                    .r_clk(r_clk),
                    .r_rst(r_rst));

    ram #(D_BITS,A_BITS) ram
                         ( .r_data(r_data), // data read line 
                           .w_data(w_data), // data write line
                           .w_addr(w_addr),
                           .r_addr(r_addr), // w adrress
                           .w_clk_en(w_inc) , 
                           .w_full(w_full) ,
                           .w_clk(w_clk));
    r_ptr #(A_BITS) r_ptr1
                    (.r_ptr(r_ptr),
                     .r_addr(r_addr),
                     .r_empty(r_empty),  
                     .ff2_w_ptr(ff2_w_ptr), 
                     .r_inc(r_inc), 
                     .r_clk(r_clk),
                     .r_rst(r_rst) );

    w_ptr #(A_BITS) w_ptr2
                    (.w_ptr(w_ptr),
                     .w_addr(w_addr),
                     .w_full(w_full),  
                     .ff2_r_ptr(ff2_r_ptr), 
                     .w_inc(w_inc), 
                     .w_clk(w_clk),
                     .w_rst(w_rst) );


endmodule