function [val] = BigF_phi(x,q,M)
%%%%%% we need to set up some unknown variables inside this function
syms A_1n [q M+1]; % for simplicity, I assume I know the neural network has only 3 hidden layers
syms A_2n [1 q];
syms b_1 [q 1];
syms b_2;
A_1 = A_1n*x+b_1;
A_1(A_1<0) = 0;
val_test = A_2n * (A_1)+b_2;
val = 1/(1+exp(-val_test));
end