
module setSevenseg(digit, sevenled);
    input [3:0] digit;
    output reg [6:0] sevenled;
 
	 always @* begin
	 
		 case(digit) 
			  4'b0000: sevenled = 7'b0111111; // 0
			  4'b0001: sevenled = 7'b0000110; // 1
			  4'b0010: sevenled = 7'b1011011; // 2
			  4'b0011: sevenled = 7'b1001111; // 3
			  4'b0100: sevenled = 7'b1100110; // 4
			  4'b0101: sevenled = 7'b1101101; // 5
			  4'b0110: sevenled = 7'b1111101; // 6
			  4'b0111: sevenled = 7'b0000111; // 7
			  4'b1000: sevenled = 7'b1111111; // 8
			  4'b1001: sevenled = 7'b1101111; // 9
			  4'b1010: sevenled = 7'b1110111; // A
			  4'b1011: sevenled = 7'b1111100; // b
			  4'b1100: sevenled = 7'b0111001; // C
			  4'b1101: sevenled = 7'b1011110; // d
			  4'b1110: sevenled = 7'b1111001; // E
			  4'b1111: sevenled = 7'b1110001; // F
			  default: sevenled = 7'b0000000; // Default to all segments off
		 endcase
	
	end

endmodule


