module vga_2 #(parameter H_RES = 640, V_RES = 480, COUNTER_BITS = 10)(
		input clk_50MHz, clear, left_button, right_button, hazard_button, 
		output clk_25MHz, h_sync, v_sync, sync_n, blank_n,
		output [7 : 0] red_out, green_out, blue_out
		//output [21 : 0] led_out
	);
	
	wire bright;
	wire [COUNTER_BITS - 1 : 0] h_count, v_count;
	wire [21 : 0] tbird_out;
	
	assign sync_n = 0;
	assign blank_n = bright;
	
	// This would be uncommented if I wanted to show the signal on the LEDS to, but then I would have
	// to assign more pins with the god awful pin planner.
	//assign led_out = tbird_out;
	
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
	
	bit_gen2 #(COUNTER_BITS)
	bits(
		.bright(bright),
		.vga_in(tbird_out),
		.h_count(h_count),
		.v_count(v_count),
		.red_out(red_out),
		.green_out(green_out),
		.blue_out(blue_out)
	);
	
	tbird_fsm 
	tb(
		.clk(clk_50MHz),
		.rst(clear),
		.l(left_button),
		.r(right_button),
		.h(hazard_button),
		.out(tbird_out)
	);
	
endmodule 