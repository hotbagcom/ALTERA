module Test_0(clc,switch,ledline);
input clc ;
input switch ;
output [6:0]ledline;
reg [6:0]number = 7'b0011001;

always @(*) begin
	if (clc)begin
		number = 7'b0010110;
	end else begin
		number = 7'b1101001;
	end


end
assign ledline = number;
endmodule 
