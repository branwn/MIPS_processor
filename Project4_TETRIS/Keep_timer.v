module	Keep_timer(iCLK,oRESET);
input		iCLK;
output reg	oRESET;
reg	[19:0]	Cont;
reg   [19:0]   timer;

initial begin
	timer <= 20'd0;
end

always@(posedge iCLK)
begin
	if(Cont!=20'hFFFFF) begin
		Cont	<=	Cont+20'd1;
		oRESET	<=	1'b0;
	end
	else begin
	oRESET	<=	1'b1;
	end
	if(timer==Cont) begin
		timer <= timer+20'd1;
	end
	else begin
		timer <= timer;
	end
end

endmodule