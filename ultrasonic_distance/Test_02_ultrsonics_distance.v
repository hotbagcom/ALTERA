module Test_02_ultrsonics_distance( clk , on_off , echo , trig , ones , tens  );

input clk , on_off , echo;
output trig;
output [3:0]ones ; 
output [3:0]tens;
reg [8:0]waitftriger = 9'b000000000; //50 Mhz /(10us == 100 000 Hz )  =>  500 tick   ,  2^9 = 512
reg [18:0]waitfecho = 19'b0000000000000000000;   //50 MHz *0.038  =>1 900 000 tick (4 meter),   475000 tick  (1 meter)  2^19 = 524288 
 // reg [9:0]dist_mm; //2^10 =1024
reg [6:0]digitones ;
reg [6:0]digittens;
reg [1:0]stage =2'b00;
reg trigstatus = 1'b0;

//trig üret
//waitfecho arttır
//echo geldi
//waitftrig arttır




//clock 50 Mhz 
//I need to produce 10 us high 
//I need to count reflectin distance in time
// more than 38ms means no object nearby
always @(posedge clk) begin;

	if( trig == 1'b0 && (waitftriger ==9'd500 || waitfecho ==19'd475000) ) begin 
		trigstatus  = 1'b1;  
		waitfecho =  19'd0;
		waitftriger = 9'd0;
		stage <= 2'b01;  //no reflection or ready to brodcast
	end 

	else if( trig == 1'b1 && waitftriger == 9'd500 ) begin 
		trigstatus   = 1'b0;
		waitftriger  = 9'd0;
		stage <= 2'b10; //stop brod cast and oppen the ears
	end

	else if( echo == 1'b1 && waitftriger == 9'd0  &&  trig == 1'b0 ) begin 
		stage <= 2'b00; //stop increment do the calculation 
	fonksiyon kullanmaya bak	setSevenseg(waitfecho[18:15] , digitones);
		setSevenseg(waitfecho[14:11] , digittens);
		waitfecho <= 19'd0;
	end

	else if( echo == 1'b0 && waitfecho ==19'd475000 ) begin 
		waitfecho = 19'd0;
		waitftriger = 9'd0 ;
		stage  = 2'b01;
	end


 

	case(stage) 

		2'b01: waitftriger = waitftriger + 1'b1;
		2'b10: waitfecho = waitfecho + 1'b1;
		2'b11: begin 
		setsetSevenseg(waitfecho[18:15] , digitones);
		setsetSevenseg(waitfecho[14:11] , digittens);
		stage = 2'b00; 
		end
	  
	default   ;	
	endcase 
 
end
 
 assign  trig = trigstatus ;
 assign ones = digitones;
assign tens = digittens;
 
endmodule

module setSevenseg (
    input [3:0] digit,
    output reg [6:0] sevenled
);
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
