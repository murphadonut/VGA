module bit_gen #(parameter COUNTER_BITS = 10)(
		input bright, red_switch, green_switch, blue_switch,
		input [COUNTER_BITS - 1 : 0] h_count, v_count,
		output reg [7 : 0] red_out, green_out, blue_out 
	);
	
	parameter OFF 	= 8'b00000000;
	parameter ON 	= 8'b11111111;
	
	always @(*)
		begin
			if(~bright)
				begin
					red_out 		= OFF;
					green_out 	= OFF;
					blue_out 	= OFF;
				end
			else
				begin
					red_out		= red_switch 	? ON : OFF;
					green_out 	= green_switch ? ON : OFF;
					blue_out 	= blue_switch 	? ON : OFF;
				end
		end
endmodule 