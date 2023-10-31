module vga #(parameter H_RES = 640, V_RES = 480, COUNTER_BITS = 10)(
		input clk_50MHz, red_switch, green_switch, blue_switch, clear,
		output clk_25MHz, h_sync, v_sync, sync_n, blank_n,
		output [7 : 0] red_out, green_out, blue_out
	);
	
	wire bright;
	wire [COUNTER_BITS - 1 : 0] h_count, v_count;
	
	assign sync_n = 0;
	assign blank_n = bright;
	
	vga_control #(H_RES, V_RES, COUNTER_BITS)
	controller(
		.clk_50MHz(clk_50MHz), 
		.clear(clear),
		.bright(bright),
		.h_sync(h_sync),
		.v_sync(v_sync),
		.clk_25MHz(clk_25MHz),
		.h_count(h_count),
		.v_count(v_count)
	);
	
	bit_gen #(COUNTER_BITS)
	bits(
		.bright(bright),
		.red_switch(red_switch),
		.green_switch(green_switch),
		.blue_switch(blue_switch),
		.h_count(h_count),
		.v_count(v_count),
		.red_out(red_out),
		.green_out(green_out),
		.blue_out(blue_out)
	);
	
endmodule 