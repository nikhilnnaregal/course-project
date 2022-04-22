module test_mips32;
reg clk1, clk2;
integer k;
pipe_riscv a(clk1, clk2);
initial
begin
clk1=0; clk2=0;
repeat(20)
begin
#5 clk1=1; #5 clk1=0;
#5 clk2=1; #5 clk2=0;
end
end
initial
	begin
		for(k=0; k<15; k=k+1)
			a.Reg[k]=k;
			a.Mem[0] = 16'b1010000001001011;
			a.Mem[1] = 16'b1010000010001010;
			a.Mem[2] = 16'b1010000011001010;
			a.Mem[3] = 16'b0000001010100000;
			
			a.HALTED =0;
			a.PC=0;
			a.TAKEN_BRANCH = 0;
			
			#280
			for(k=0; k<5; k=k+1)
				$display("R%1d - %2d", k ,a.Reg[k]);
	end
initial 
	begin
		$dumpfile("mips.vcd");
		$dumpvars (0, test_mips32);
		#300 $finish;
	end
endmodule
