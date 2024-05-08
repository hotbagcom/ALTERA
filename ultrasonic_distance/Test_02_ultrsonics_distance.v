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
 // reg [9:0]dist_mm; //2^10 =1024
reg [6:0]digitones ;
reg [6:0]digittens;
reg stage =1'b0 ;
reg trigstatus = 1'b0;

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
		//setSevenseg led1( (waitfecho[18:15]) , (digitones));
		//setSevenseg led2( (waitfecho[14:11]) , (digittens));
	//fonksiyon yerine bit ata gitsin sadece kontrol için	
		digitones <= waitfecho[14:8];
		digittens  <= waitfecho[7:1];
		
		
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
assign ones = digitones;
assign tens = digittens;

 
endmodule

