W = 50;
Upp = zeros(1,W);
Final_optval = zeros(1,W);
r=0.05; sigma=0.2; rho=0.1; T=1; K=11; S0_1=10; S0_2=10; 
N = 10; % number of paths
N_0 = 3; % number of paths of each suboptimal question
M = 30; % number of MC samples
M_0 = 3;% number of MC samples in suboptimal question
R = 10; % number of type 1 basis functions
%R = 4; % number of type 2 basis functions
E = 10; % number of repeating times
delT = T/M;
X=[];
Y=[];
Optvaltest = zeros(N,M);
Final_upperbound = zeros(1,E);
for w = 1:W
[optval,V_hat,X,Y] = Testvalue(r,delT,S0_1,S0_2,sigma,rho,T,N,M,R,K);
Final_optval(w) = optval; %%%% get the corresponding option value here
for o = 1:E
for j = 1:N
    %%%% now get the option value in each node pair via the mini-paths
    for i = 2:M
        [Optvaltest(j,i)] = Testvalue(r,delT,X(j,i),Y(j,i),sigma,rho,T,N_0,M_0,R,K);
    end
end
M_hat = sum(V_hat-Optvaltest,2);
Max_value = zeros(N,M);
for j = 1:N
    for i = 2:M
        %%%%%% now get the M_hat in our lecture note
        Max_value(j,i) = exp(-r*(i)*delT)*Payoff(K,X(j,i),Y(j,i)) - M_hat(j);
    end
end
Max_value(:,1) = [];
Find = max(Max_value,[],2);
Upperboundvalue = sum(Find)/(N);
Final_upperbound(o) = Upperboundvalue;
end
upper = sum(Final_upperbound)/E;
Upp(w) = upper;
end
Finalupper = sum(Upp)/W;
Finaloptval = sum(Final_optval)/W;