module ram #(parameter  DATA_BITS = 8,  // meory data word witdth 
              parameter ADDR_BITS = 4)// no of ram adress
            ( output[DATA_BITS-1:0] r_data, // data read line 
              input [DATA_BITS-1:0] w_data, // data write line
              input [ADDR_BITS-1:0] w_addr,r_addr, // w adrress
              input                w_clk_en , w_full ,w_clk);   // clk and enable for write 

              localparam fifo_depth = 1<<ADDR_BITS ;

reg[DATA_BITS-1:0] ram [0:fifo_depth-1];

assign r_data = ram[r_addr];

always@(posedge w_clk)
  if(w_clk_en && !w_full) ram[w_addr] <= w_data;
endmodule