module asymmetric_distributed_ram(clk);
parameter WIDTH_IN = 64;
parameter WIDTH_OUT = WIDTH_IN;
parameter DEPTH = 32;
parameter ADDR_WIDTH = log2(DEPTH-1);
localparam RATIO = WIDTH_IN / WIDTH_OUT;

input clk;
input we;
input [ADDR_WIDTH - 1:0] addr_a;
input [WIDTH_IN - 1:0] in;
input [ADDR_WIDTH + RATIO - 1:0] addr_b;
output [WIDTH_OUT - 1:0] out;

reg [WIDTH_OUT - 1:0] ram_out [0: RATIO - 1];
genvar g;
generate for(g = 0; g < RATIO; g = g + 1) begin
    reg [WIDTH_OUT - 1:0] ram [0:DEPTH - 1];
    always @(posedge clk) begin
        if(we)
            ram[addr_a] <= in[(g+1)*WIDTH_OUT - 1 -: WIDTH_OUT];
    end
    always @*
        ram_out[g] = ram[addr_b[ADDR_WIDTH + RATIO - 1 -:ADDR_WIDTH]];
end
endgenerate

assign out = ram_out[addr_b[RATIO-1:0]];

endmodule
