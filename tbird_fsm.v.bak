// Murphy Rickett
// Thunderbird Finite State Machine
// 09/31/23
// ECE 3710

module tbird_fsm #( 																						// 1 means light on, 0 means light off
	parameter [21:0] L1 = ~22'b0000000001100000000000, 										// left step 5
	parameter [21:0] L2 = ~22'b0000001111100000000000,											// left step 4
	parameter [21:0] L3 = ~22'b0001111111100000000000, 										// left step 3
	parameter [21:0] L4 = ~22'b0111111111100000000000, 										// left step 2
	parameter [21:0] L5 = ~22'b1111111111100000000000, 										// left step 1
	parameter [21:0] R1 = ~22'b0000000000011000000000, 										// right step 1
	parameter [21:0] R2 = ~22'b0000000000011111000000, 										// right step 2
	parameter [21:0] R3 = ~22'b0000000000011111111000, 										// right step 3
	parameter [21:0] R4 = ~22'b0000000000011111111110, 										// right step 4
	parameter [21:0] R5 = ~22'b0000000000011111111111, 										// right step 5
	parameter [21:0] H =  ~22'b1111111111111111111111, 										// all on, hazards
	parameter [21:0] O =  ~22'b0000000000000000000000, 										// all off
	parameter [24:0] divide_factor = 5000000 													// factor to slow clock down
) (
	input wire clk, rst, l, r, h, 																	// for the clock input and buttons
	output reg [21:0] out 																				// LED's  to light up
);
		
reg [21:0] unclocked_next_state, state; 															// for current state and next state
wire [21:0] next_state; 																				// set when flip flop, flips, to unclocked_next_state
reg [24:0] counter; 																						// used to create slow clock
reg slow_clk; 																								// slowed clock

flip_flop ff(.clk(slow_clk), .rst(rst), .d(unclocked_next_state), .q(next_state));	// make a flip flop

always @(posedge clk, negedge rst) begin
	if(!rst) begin 																						// check for change in reset button
		unclocked_next_state <= O; 																	// turn all lights off
		counter <= 0; 																						// reset counter
		slow_clk <= 0; 																					// reset slow clock
	end else begin
	
		if(counter == divide_factor) begin 															// once counter has reached the divide factor, flip slow_clock and reset counter
			counter = 0;
			slow_clk = ~slow_clk;
		end else counter <= counter + 1; 															// otherwise, increment counter
		
		if(~h && state != H) unclocked_next_state <= H; 										// check if hazard button is being pressed and current state isn't already H (Hazards)
		else if(~l && state == O) unclocked_next_state <= L1; 								// check if left button is being pressed and that it won't overlap any other process
		else if(~r && state == O) unclocked_next_state <= R1; 								// same as above but for the right button
		else begin
			case(state)
				L1: unclocked_next_state <= L2; 														// progress left light from state one to five, then back to state zero
				L2: unclocked_next_state <= L3;
				L3: unclocked_next_state <= L4;
				L4: unclocked_next_state <= L5;
				R1: unclocked_next_state <= R2; 														// same as left but for the right
				R2: unclocked_next_state <= R3;
				R3: unclocked_next_state <= R4;
				R4: unclocked_next_state <= R5;
				L5, R5, H, O: unclocked_next_state <= O; 											// if current state is last left state, last right state, hazard on, or all off, go to all off state.
			endcase
		end
	end
end
always @(*) state = next_state; 																		// if next_state changes, update state
always @(*) out = state; 																				// if state changes, update output lights
endmodule


module flip_flop(																							// Flip flop module to hold the last state on posedge of slow clock
	input wire clk, rst, 																				// normal clk input and reset button
	input wire[21:0] d, 																					// state to update to on posedge
	output reg [21:0] q																					// holds old state until posedge
);

always @(posedge clk, negedge rst) begin
	if(!rst) q <= ~22'b0000000000000000000000;														// check for reset button press
	else q <= d;																							// update hold state to new state	
end

endmodule 