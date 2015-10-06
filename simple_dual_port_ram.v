module simple_dual_port_ram(clk, wr, addr_a, d, addr_b, q);
parameter WIDTH = 64;
parameter DEPTH = 512;
parameter LOG2_DEPTH = log2(DEPTH - 1);
input clk;
input wr;
input [LOG2_DEPTH - 1:0] addr_a;
input [WIDTH - 1:0] d;
input [LOG2_DEPTH - 1:0] addr_b;
output [WIDTH - 1:0] q;
reg [WIDTH - 1:0] ram_q;

reg [WIDTH - 1:0] ram [0:DEPTH - 1];
always @(posedge clk) begin
    if(wr) begin
        ram[addr_a] <= d;
        //if(addr_a == addr_b)
        //    q <= d;
    end
    ram_q <= ram[addr_b];
end
reg [WIDTH - 1:0] d_r;
reg addr_eq;
always @(posedge clk) begin
    addr_eq <= addr_a == addr_b;
    d_r <= d;
end

assign q = addr_eq ? d_r : ram_q;

`include "common.vh"
endmodule
