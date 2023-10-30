module vga #(parameter H_RES = 640, V_RES = 480)(
		input clk_50MHz, clear,
		output reg h_sync, v_sync, bright, h_disp,
		output reg [9 : 0] h_count, v_count
	);
	
	parameter h_ts 	= 800;
	parameter h_tdisp = 640;
	parameter h_tpw 	= 96;
	parameter h_tfp 	= 16;
	parameter h_tbp 	= 48;
	
	reg flippy = 0;
	
	always @(negedge clear, posedge clk_50MHz)
	begin
		if(~clear) h_count = 0;
		else if(flippy)
			begin
				flippy = 0;
				if (h_count == h_tpw + h_tbp + h_tdisp + h_tfp) h_count = 0;
				else h_count = h_count + 1;
			end
		else flippy = 1;
	end
	
	always @(h_count)
	begin
		if(h_count == 0) h_sync = 1;
		else if (h_count == h_tpw) h_sync = 0;
		else if (h_count == h_tpw + h_tbp) h_disp = 1;
		else if (h_count == h_tpw + h_tbp + h_tdisp) h_disp = 0;
	end
	
endmodule 