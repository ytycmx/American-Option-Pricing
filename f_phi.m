function [val] = f_phi(A_1n,A_2n,b_1,b_2,x)
A_1 = A_1n*x+b_1;
A_1(A_1<0) = 0;
val_test = A_2n * (A_1)+b_2;
if  val_test >= 0
val = val_test;
else
val = 0;
end
end