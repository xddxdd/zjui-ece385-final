module wm8731_buffer(
	input logic Clk, Reset,
	
	// Interface with WM8731 module
	input logic data_over,
	output logic [15:0] LDATA, RDATA,
	
	// Interface with On-Chip Memory & Nios II
	input logic [31:0] MEM_ADDR_END,
	output logic [31:0] MEM_ADDR,
	input logic [31:0] MEM_DATA
);

logic [31:0] MEM_ADDR_NEXT;
assign MEM_ADDR_NEXT = MEM_ADDR + 1;

logic BUFFER_REACHED_END;
assign BUFFER_REACHED_END = (MEM_ADDR == MEM_ADDR_END);

always_ff @ (negedge data_over) begin
	if(Reset) begin
		MEM_ADDR <= 32'b0;
	end else if(!BUFFER_REACHED_END) begin
		MEM_ADDR <= MEM_ADDR_NEXT;
	end
end

assign LDATA = MEM_DATA[15:0];
assign RDATA = MEM_DATA[31:16];

endmodule
