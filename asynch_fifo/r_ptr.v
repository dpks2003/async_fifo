module r_ptr #(parameter ADDR_BITS=4)
            (output reg [ADDR_BITS:0]   r_ptr,
             output     [ADDR_BITS-1:0] r_addr,
             output     reg                r_empty, // high if the fifo is empty 
             input      [ADDR_BITS:0]   ff2_w_ptr, // syncronized output form the syn_r_w,v moduker 
             input                      r_inc, r_clk,r_rst );

    reg [ADDR_BITS:0] r_bin ;// to hold binaty value from the gray counter 
    wire [ADDR_BITS:0] r_gray_next,r_bin_next ; //  nxt buit 
    wire               r_empty_w ;
  // this logec is for the pointer incremetnt usinf gray counter 
    always @ (posedge r_clk,r_rst)
    begin
        if(r_rst) {r_bin ,r_ptr} <=0;
        else      {r_bin,r_ptr} <= {r_bin_next,r_gray_next}; 
    end
    assign r_addr = r_bin[ADDR_BITS-1:0];
    assign r_bin_next = r_bin +( r_inc & !r_empty);
    assign r_gray_next = (r_bin_next>>1) ^ r_bin_next;

    assign r_empty_w = ( r_gray_next == ff2_w_ptr);

    always @( posedge r_clk,r_rst )
    begin
        if(r_rst) r_empty <= 1'b1;
        else r_empty <= r_empty_w;
    end

endmodule