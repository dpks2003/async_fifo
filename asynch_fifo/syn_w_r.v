module syn_w2r #( parameter ADDR_BITS = 4)
                (output reg [ADDR_BITS:0] ff2_w_ptr,
                 input      [ADDR_BITS:0] w_ptr,   
                 input                    r_clk,r_rst); // active on high reset 

 reg [ADDR_BITS:0] ff1_w_ptr;

 always @(posedge r_clk or posedge r_rst)
 begin
   if (r_rst) {ff2_w_ptr,ff1_w_ptr} <=0;
   else       {ff2_w_ptr,ff1_w_ptr} <= {ff1_w_ptr,w_ptr};
 end
endmodule