module Test_02_ultrasonics_distance
( clk , on_off , echo , trig , ones , tens  );

input clk , on_off , echo;
output trig;
output [6:0]ones , [6:0]tens;
reg [11:0]waitftriger = 3'x000;
reg [15:0]waitforecho = 4'x0001;
reg [9:0]dist_mm; //2^10 =1024
reg [6:0]digitones , [6:0]digittens;
reg [3:0]counttrigbrust;
//clock 50 Mhz 
//I need to produce 10 us high 
//I need to count reflectin distance in time
// more than 38ms means no object nearby
always @(posedge clk) begin;

//check is wave expected means incrementing wait for echo



// else no wave expecting produce trig  


end

end module

module setSevenseg(input [3:0]digit, output [6:0]sevenled);
	case(digit)
		4'b0000:  sevenled=7'b0111111;//0
		4'b0001:  sevenled=7'b0000110;//1
		4'b0010:  sevenled=7'b1011011;//2
		4'b0011:  sevenled=7'b1001111;//3
		4'b0100:  sevenled=7'b1100110;//4
		4'b0101:  sevenled=7'b1101101;//5
		4'b0110:  sevenled=7'b1111101;//6
		4'b0111:  sevenled=7'b0000111;//7
		4'b1000:  sevenled=7'b1111111;//8
		4'b1001:  sevenled=7'b1101111;//9
		4'b1010:  sevenled=7'b1110111;//A
		4'b1011:  sevenled=7'b1111100;//b
		4'b1100:  sevenled=7'b0111001;//C
		4'b1101:  sevenled=7'b1011110;//d
		4'b1110:  sevenled=7'b1111001;//E
		4'b1111:  sevenled=7'b1110001;//F
	endcase

endmodule

module timecount( clk , increment , timecount)
input clk , increment;
output timecount = 

endmodule
