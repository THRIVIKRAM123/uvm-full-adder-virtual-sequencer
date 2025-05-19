module full_adder(input a,input b,input c,output reg sum,carry);
always@(*)
begin
sum = a^b^c;
carry = (a&b)|(b&c)|(a&c);
end
endmodule
