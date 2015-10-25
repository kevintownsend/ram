module dual_port_xor_ram(clk, rst, wr_a, addr_a, q_a, wr_b, addr_b, q_b);
parameter DEPTH = 512;
parameter ADDR_WIDTH = log2(DEPTH - 1);
input clk;
input rst;
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

assign q_a = ram_00_q ^ ram_10_q;
assign q_b = ram_01_q ^ ram_11_q;

always @(posedge clk) begin
    if(wr_a) begin
        $display("ram_0[0]: %H", ram_0[0]);
        $display("ram_1[0]: %H", ram_1[0]);
    end
    if(wr_a) begin
        $display("ram_0[1]: %H", ram_0[1]);
        $display("ram_1[1]: %H", ram_1[1]);
    end
    if(wr_b != 0) begin
        $display("wr_b: %d", wr_b);
    end
end
wire tmp0 = rst ? 0 : ram_00_q ^ wr_a;
always @(posedge clk) begin
    ram_0[addr_a] <= tmp0;
end
wire tmp1 = rst ? 0 : ram_11_q ^ wr_b;
always @(posedge clk) begin
    ram_1[addr_b] <= tmp1;
end
/*
always @(posedge clk) begin
    $display();
    $display("xor debug %d", $time);
    $display("rst: %d", rst);
    $display("ram_1[0]: %d", ram_1[0]);
    $display("ram_11_q: %d", ram_11_q);
    $display("tmp1: %d", tmp1);
    $display("wr_b: %d", wr_b);
    $display("end xor debug");
    $display();
end
*/
`include "common.vh"
endmodule
