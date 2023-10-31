module vga_control #(parameter H_RES = 640, V_RES = 480, COUNTER_BITS = 10)(
		input clk_50MHz, clear,
		output bright, 
		output reg h_sync, v_sync, clk_25MHz,
		output reg [COUNTER_BITS - 1 : 0] h_count, v_count
	);
	
	// in terms of clock cycles
	parameter h_ts 	= 800;
	parameter h_tdisp = 640;
	parameter h_tpw 	= 96;
	parameter h_tfp 	= 16;
	parameter h_tbp 	= 48;
	
	// in terms of horizontal lines, not clock cycles
	parameter v_ts		= 521;
	parameter v_tdisp	= 480;
	parameter v_tpw	= 2;
	parameter v_tfp	= 10;
	parameter v_tbp	= 29;
	
	reg h_bright, v_bright;
	assign bright = h_bright && v_bright;
	
	always @(negedge clear, posedge clk_50MHz)
	begin
		if(~clear) 
			begin
				h_count = 0;
				v_count = 0;
				clk_25MHz = 0;
			end
		else if(clk_25MHz)
			begin
				clk_25MHz = 0;
				if (h_count == h_tdisp + h_tfp + h_tpw + h_tbp) 
					begin 
						h_count = 0;
						if (v_count == v_tdisp + v_tfp + v_tpw + v_tbp) v_count = 0;
						else v_count = v_count + 1;
					end
				else h_count = h_count + 1;
			end
		else clk_25MHz = 1;
	end
	
	always @(h_count)
		begin
			if(h_count == 0) 
				begin
					h_bright = 1;
					h_sync = 1;
				end
			else if (h_count == h_tdisp) h_bright = 0;
			else if (h_count == h_tdisp + h_tfp) h_sync = 0;
			else if (h_count == h_tdisp + h_tfp + h_tpw) h_sync = 1;
		end
		
	always @(v_count)
		begin
			if(v_count == 0) 
				begin
					v_bright = 1;
					v_sync = 1;
				end
			else if (v_count == v_tdisp) v_bright = 0;
			else if (v_count == v_tdisp + v_tfp) v_sync = 0;
			else if (v_count == v_tdisp + v_tfp + v_tpw) v_sync = 1;
		end
endmodule 