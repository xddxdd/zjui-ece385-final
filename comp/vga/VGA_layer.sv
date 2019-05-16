module VGA_layer #(
	parameter LAYERS = 4
) (
	input logic [LAYERS-1:0] VGA_SPRITE_ISOBJ,
	input logic [LAYERS-1:0][15:0] VGA_SPRITE_PIXEL,
						
	output logic [7:0] VGA_R, VGA_G, VGA_B,
	input logic [15:0] VGA_VAL
);

logic [15:0] VGA_DISPLAY;
assign VGA_R = {VGA_DISPLAY[4:0], VGA_DISPLAY[4:2]};
assign VGA_G = {VGA_DISPLAY[10:5], VGA_DISPLAY[10:9]};
assign VGA_B = {VGA_DISPLAY[15:11], VGA_DISPLAY[15:13]};

always_comb begin
	VGA_DISPLAY = VGA_VAL;
	for(integer i = 0; i < LAYERS; i++) begin
		if(VGA_SPRITE_ISOBJ[i]) begin
			VGA_DISPLAY = VGA_SPRITE_PIXEL[i];
		end
	end
end

endmodule
