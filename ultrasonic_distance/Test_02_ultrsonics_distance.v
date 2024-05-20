module Test_02_ultrsonics_distance(

input clk , 
input on_off , 
input echo,
output trig,
output [6:0]ones, 
output [6:0]tens
);

reg [8:0]waitftriger = 9'b000000000; //50 Mhz /(10us == 100 000 Hz )  =>  500 tick   ,  2^9 = 512
reg [18:0]waitfecho = 19'b0000000000000000000;   //50 MHz *0.038  =>1 900 000 tick (4 meter),   475000 tick  (1 meter)  2^19 = 524288 
reg [9:0]dist_mm; //2^10 =1024
reg [6:0]digitones ;
reg [6:0]digittens;
reg stage =1'b0 ;
reg trigstatus = 1'b0;
reg thloop = 8'b00000000;

//initial 
//begin
//  trig = 1'b0;
//  ones = 7'b0000000; 
//  tens = 7'b0000000;  
//end

//trig üret
//waitfecho arttır
//echo geldi
//waitftrig arttır



//clock 50 Mhz 
//I need to produce 10 us high 
//I need to count reflectin distance in time
// more than 38ms means no object nearby
always @(  clk) begin

	if( trig == 1'b0 && (waitftriger ==9'd500 || waitfecho ==19'd475000) ) begin 
		trigstatus  <= 1'b1;  
		waitfecho =  19'd0;
		waitftriger  = 9'd0;
		stage = 1'b0 ;  //no reflection or ready to brodcast
	end 

	else if( trig == 1'b1 && waitftriger == 9'd500 ) begin 
		trigstatus   = 1'b0;
		waitftriger  = 9'd0;
		stage  = 1'b1 ; //stop brod cast and oppen the ears
	end

	else if( echo == 1'b1 && waitftriger == 9'd0  &&  trig == 1'b0 ) begin 
		stage  = 1'b0 ; //stop increment do the calculation 
	//fonksiyon kullanmaya bak	
	
	dist_mm = waitfecho[15:10];
		//setSevenseg led1( (waitfecho[18:15]) , (digitones));
	//	setSevenseg(.digit(dist_mm[3:0]) ,.sevenled(digitones));
		//setSevenseg led2( (waitfecho[14:11]) , (digittens));
	//	setSevenseg(.digit(dist_mm[7:4]) ,.sevenled(digittens));
	//fonksiyon yerine bit ata gitsin sadece kontrol için	
	
//		digitones <= waitfecho[17:11];
//		digittens  <= waitfecho[10:4];
		
		//if(thloop == 8'b00000000) begin
			// setSevenseg(.digit(dist_mm[7:4]) ,.sevenled(digittens));
		case(dist_mm[7:4]) 
			  4'b0000: digittens = 7'b0111111; // 0
			  4'b0001: digittens = 7'b0000110; // 1
			  4'b0010: digittens = 7'b1011011; // 2
			  4'b0011: digittens = 7'b1001111; // 3
			  4'b0100: digittens = 7'b1100110; // 4
			  4'b0101: digittens = 7'b1101101; // 5
			  4'b0110: digittens = 7'b1111101; // 6
			  4'b0111: digittens = 7'b0000111; // 7
			  4'b1000: digittens = 7'b1111111; // 8
			  4'b1001: digittens = 7'b1101111; // 9
			  4'b1010: digittens = 7'b1110111; // A
			  4'b1011: digittens = 7'b1111100; // b
			  4'b1100: digittens = 7'b0111001; // C
			  4'b1101: digittens = 7'b1011110; // d
			  4'b1110: digittens = 7'b1111001; // E
			  4'b1111: digittens = 7'b1110001; // F
			  default: digittens = 7'b0000111; // Default to all segments off
		 endcase
		case(dist_mm[3:0]) 
			  4'b0000: digitones = 7'b0111111; // 0
			  4'b0001: digitones = 7'b0000110; // 1
			  4'b0010: digitones = 7'b1011011; // 2
			  4'b0011: digitones = 7'b1001111; // 3
			  4'b0100: digitones = 7'b1100110; // 4
			  4'b0101: digitones = 7'b1101101; // 5
			  4'b0110: digitones = 7'b1111101; // 6
			  4'b0111: digitones = 7'b0000111; // 7
			  4'b1000: digitones = 7'b1111111; // 8
			  4'b1001: digitones = 7'b1101111; // 9
			  4'b1010: digitones = 7'b1110111; // A
			  4'b1011: digitones = 7'b1111100; // b
			  4'b1100: digitones = 7'b0111001; // C
			  4'b1101: digitones = 7'b1011110; // d
			  4'b1110: digitones = 7'b1111001; // E
			  4'b1111: digitones = 7'b1110001; // F
			  default: digitones = 7'b1110000; // Default to all segments off
		 endcase
		
		
//		thloop = 8'b00000000;
//		end
		
		
		waitfecho  = 19'd0;
	end

	else if( echo == 1'b0 && waitfecho ==19'd475000 ) begin 
		waitfecho = 19'd0;
		waitftriger = 9'd0 ;
		stage  = 1'b0 ;
	end


 

	case(stage) 

		1'b0 : waitftriger = waitftriger + 1'b1;
		1'b1 : waitfecho = waitfecho + 1'b1;

	default  : waitftriger = waitftriger + 1'b1 ;	
	endcase 
 
end
 
assign  trig = trigstatus ;
assign ones = ~digitones;
assign tens = ~digittens;

 
endmodule

