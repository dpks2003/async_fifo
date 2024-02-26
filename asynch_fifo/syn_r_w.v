module syn_r2W #( parameter ADDR_BITS = 4)
                (output reg [ADDR_BITS:0] ff2_r_ptr,
                 input      [ADDR_BITS:0] r_ptr,
                 input                    w_clk,w_rst); // active on high reset 

 reg [ADDR_BITS:0] ff1_r_ptr;

 always @(posedge w_clk or posedge w_rst)
 begin
   if (w_rst) {ff2_r_ptr,ff1_r_ptr} <=0;
   else       {ff2_r_ptr,ff1_r_ptr} <= {ff1_r_ptr,r_ptr};
 end
endmodule

