module bit_gen2 #(parameter COUNTER_BITS = 10)(
		input bright,
		input [21 : 0] vga_in,
		input [COUNTER_BITS - 1 : 0] h_count, v_count,
		output reg [7 : 0] red_out, green_out, blue_out 
	);
	
	parameter OFF 	= 8'b00000000;
	parameter ON 	= 8'b11111111;
	
	// left over as huge stupid numbers, I didn't want to change the tbird_fsm code I wrote
	parameter [21:0] L1 = ~22'b0000000001100000000000; 										// left step 5
	parameter [21:0] L2 = ~22'b0000001111100000000000;											// left step 4
	parameter [21:0] L3 = ~22'b0001111111100000000000; 										// left step 3
	parameter [21:0] L4 = ~22'b0111111111100000000000; 										// left step 2
	parameter [21:0] L5 = ~22'b1111111111100000000000; 										// left step 1
	parameter [21:0] R1 = ~22'b0000000000011000000000; 										// right step 1
	parameter [21:0] R2 = ~22'b0000000000011111000000; 										// right step 2
	parameter [21:0] R3 = ~22'b0000000000011111111000; 										// right step 3
	parameter [21:0] R4 = ~22'b0000000000011111111110; 										// right step 4
	parameter [21:0] R5 = ~22'b0000000000011111111111; 										// right step 5
	parameter [21:0] H =  ~22'b1111111111111111111111; 										// all on, hazards
	parameter [21:0] O =  ~22'b0000000000000000000000; 
	
	always @(*)
		begin
			// turn off pixel
			if(~bright)
				begin
					red_out 		= OFF;
					green_out 	= OFF;
					blue_out 	= OFF;
				end
			// heres all the states for the tbird_fsm
			else
				begin
					case (vga_in)
						// first stage
						L1: 
							begin
								if(((h_count >= 250) && (h_count <= 300)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						// second stage
						L2: 
							begin
								if(((h_count >= 200) && (h_count <= 250)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
						// blah blah blah, you get the idea
						L3: 
							begin
								if(((h_count >= 150) && (h_count <= 200)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						L4: 
							begin
								if(((h_count >= 100) && (h_count <= 150)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						L5: 
							begin
								if(((h_count >= 50) && (h_count <= 100)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						R1: 
							begin
								if(((h_count >= 340) && (h_count <= 390)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						R2: 
							begin
								if(((h_count >= 390) && (h_count <= 440)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						R3: 
							begin
								if(((h_count >= 440) && (h_count <= 490)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						R4: 
							begin
								if(((h_count >= 490) && (h_count <= 540)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						R5: 
							begin
								if(((h_count >= 540) && (h_count <= 590)) && ((v_count >= 200) && (v_count <= 280)))
									begin
										red_out 		= ON;
										green_out 	= OFF;
										blue_out	 	= OFF;
									end
								else
									begin
										red_out 		= OFF;
										green_out 	= OFF;
										blue_out 	= OFF;
									end
							end
							
						H: 
							begin
								red_out 		= ON;
								green_out 	= OFF;
								blue_out	 	= OFF;
							end
							
						O: 
							begin
								red_out 		= OFF;
								green_out 	= OFF;
								blue_out 	= OFF;
							end
					endcase
				end
		end
endmodule 