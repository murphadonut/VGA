`timescale 1 ns / 1 ns
module vga_tb();

	reg clk_50MHz, clear;
	wire h_sync, v_sync, bright;
	wire [9:0] h_count, v_count;
	
	vga_control test(
		.clk_50MHz(clk_50MHz),
		.clear(clear),
		.bright(bright),
		.h_sync(h_sync),
		.v_sync(v_sync),
		.clk_25MHz(clk_25MHz),
		.h_count(h_count),
		.v_count(v_count)
	);
	
	initial
		begin
			clear = 0;
			#10;
			clear = 1;
			#10;
		end

		//enough to show the sinals
	always
		begin
			clk_50MHz <= 0; #10;
			clk_50MHz <= 1; #10;
		end

endmodule 