module VGA_Entity_Manager(
	// Avalon Clock Input
	input logic CLK,
	
	// Avalon Reset Input
	input logic RESET,
	
	// Avalon-MM Slave Signals
	input  logic AVL_READ,					// Avalon-MM Read
	input  logic AVL_WRITE,					// Avalon-MM Write
	input  logic [3:0] AVL_ADDR,			// Avalon-MM Address
	input  logic [31:0] AVL_WRITEDATA,	// Avalon-MM Write Data
	output logic [31:0] AVL_READDATA,	// Avalon-MM Read Data
	
	// Interface with VGA controller
	input logic  [9:0] DrawX, DrawY,
	
	// Interface with sprite manager
	output logic [7:0] PIC_ID,
	output logic [9:0] X, Y
);

// 0: X
// 1: Y
// 2: Vx
// 3: Vy
// 4: Ax
// 5: Ay
// 6: W
// 7: H
// 8: Pic#

logic[31:0][15:0] reg_out;

generate
genvar i, j;
for(i = 0; i < 32; i++) begin
	for(j = 0; j < 16; j++) begin
		register(.Clk(CLK), .Reset(RESET), .Load(AVL_WRITE && AVL_ADDR[8:4] == i && AVL_ADDR[3:0] == j), .Din(AVL_WRITEDATA), .Dout(reg_out[i][j]));
	end
end
endgenerate

assign AVL_READDATA = reg_out[AVL_ADDR[8:4]][AVL_ADDR[3:0]];



endmodule
