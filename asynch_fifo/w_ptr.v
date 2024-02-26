module w_ptr #(parameter ADDR_BITS=4)
            (output reg [ADDR_BITS:0]   w_ptr,
             output     [ADDR_BITS-1:0] w_addr,
             output      reg            w_full, // high if the fifo is empty 
             input      [ADDR_BITS:0]   ff2_r_ptr, // syncronized output form the syn_r_w,v moduker 
             input                      w_inc, w_clk,w_rst );

    reg [ADDR_BITS:0] w_bin ;// to hold binaty value from the gray counter 
    wire [ADDR_BITS:0] w_gray_next,w_bin_next ; //  nxt buit 
    wire               w_full_w ;
  // this logec is for the pointer incremetnt usinf gray counter 
    always @ (posedge w_clk,w_rst)
    begin
        if(w_rst) {w_bin ,w_ptr} <=0;
        else      {w_bin,w_ptr} <= {w_bin_next,w_gray_next}; 
    end
    assign w_addr = w_bin[ADDR_BITS-1:0];
    assign w_bin_next = w_bin +( w_inc & !w_full);
    assign w_gray_next = (w_bin_next>>1) ^ w_bin_next;

   // assign w_full_w = ( w_gray_next == {!ff2_r_ptr[ADDR_BITS:ADDR_BITS-1],ff2_r_ptr[ADDR_BITS-2:0]});
assign w_full_w = (( w_gray_next[ADDR_BITS] != ff2_r_ptr[ADDR_BITS]) && (w_gray_next[ADDR_BITS-1:0] != ff2_r_ptr[ADDR_BITS-1])&&(w_gray_next[ADDR_BITS-2:0] != ff2_r_ptr[ADDR_BITS-2:0]));
    always @( posedge w_clk,w_rst )
    begin
        if(w_rst) w_full <= 1'b0;
        else w_full <= w_full_w;
    end

endmodule