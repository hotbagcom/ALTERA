module Test_01_seven_seg( bitsbut,rstcountreg,counterbtn, sevenseg,sevenseg2);
input [3:0]bitsbut ;
input counterbtn;
input rstcountreg;
output [6:0]sevenseg;
output [6:0]sevenseg2;

reg [6:0]number = 7'b0000000;

reg [6:0]number2 = 7'b0000000;

reg stepup =1'b0;
reg [3:0]countreg=4'b0000;
reg [3:0]countreg1=4'b0000;
always @(*) begin
	if(~stepup && ~counterbtn)begin//if push pressed
		stepup <= 1'b1;//last status btn pressed
		countreg <= countreg1 + 4'b0001;
	end
	else if( (stepup) && ~counterbtn)begin//if push released
		stepup <= 1'b0; // last status btn released
		countreg1 <= countreg; 
		
	end
	
	if(~rstcountreg)begin
		countreg <= 4'b0000;
	end
	case(bitsbut)//toogle controlled
		4'b0000: number=7'b0111111;//0
		4'b0001: number=7'b0000110;//1
		4'b0010: number=7'b1011011;//2
		4'b0011: number=7'b1001111;//3
		4'b0100: number=7'b1100110;//4
		4'b0101: number=7'b1101101;//5
		4'b0110: number=7'b1111101;//6
		4'b0111: number=7'b0000111;//7
		4'b1000: number=7'b1111111;//8
		4'b1001: number=7'b1101111;//9
		4'b1010: number=7'b1110111;//A
		4'b1011: number=7'b1111100;//b
		4'b1100: number=7'b0111001;//C 
		4'b1101: number=7'b1011110;//d
		4'b1110: number=7'b1111001;//E
		4'b1111: number=7'b1110001;//F
		default : number = 7'b0000000;//turn off  all led
	endcase
	
		case(countreg)//push controlled
		4'b0000: number2=7'b0111111;//0
		4'b0001: number2=7'b0000110;//1
		4'b0010: number2=7'b1011011;//2
		4'b0011: number2=7'b1001111;//3
		4'b0100: number2=7'b1100110;//4
		4'b0101: number2=7'b1101101;//5
		4'b0110: number2=7'b1111101;//6
		4'b0111: number2=7'b0000111;//7
		4'b1000: number2=7'b1111111;//8
		4'b1001: number2=7'b1101111;//9
		4'b1010: number2=7'b1110111;//A
		4'b1011: number2=7'b1111100;//b
		4'b1100: number2=7'b0111001;//C
		4'b1101: number2=7'b1011110;//d
		4'b1110: number2=7'b1111001;//E
		4'b1111: number2=7'b1110001;//F
	endcase


end
assign sevenseg = ~number;
assign sevenseg2 = ~number2;
endmodule 