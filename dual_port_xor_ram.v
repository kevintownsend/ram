module dual_port_xor_ram(clk, wr_a, addr_a, q_a, wr_b, addr_b, q_b);
parameter DEPTH = 512;
parameter ADDR_WIDTH = log2(DEPTH - 1);
input clk;
input wr_a;
input [ADDR_WIDTH - 1:0] addr_a;
output q_a;
input wr_b;
input [ADDR_WIDTH - 1:0] addr_b;
output q_b;


(* ram_style = "distributed" *) reg ram_0 [0:DEPTH - 1];
(* ram_style = "distributed" *) reg ram_1 [0:DEPTH - 1];
integer i = 0;
initial begin
    for(i = 0; i < DEPTH; i = i + 1) begin
        ram_0[i] = 0;
        ram_1[i] = 0;
    end
end

wire ram_00_q = ram_0[addr_a];
wire ram_01_q = ram_0[addr_b];
wire ram_10_q = ram_1[addr_a];
wire ram_11_q = ram_1[addr_b];

assign q_a = ram_00_q ^ ram_01_q;
assign q_b = ram_10_q ^ ram_11_q;

wire tmp0 = ram_00_q ^ wr_a;
always @(posedge clk) begin
    ram_0[addr_a] <= tmp0;
end
wire tmp1 = ram_11_q ^ wr_b;
always @(posedge clk) begin
    ram_1[addr_b] <= tmp1;
end
`include "common.vh"
endmodule
