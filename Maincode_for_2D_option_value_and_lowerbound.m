r=0.05; sigma=0.2; rho=0.1; T=1; K=11; S0_1=10; S0_2 = 10;
N = 100;% number of sample paths
M = 365; % number of MC samples
%R = 10; % number of type 1 basis functions
R = 4; % number of type 2 basis functions
delT = T/M;
G = 10;
X = [];
Y = [];
[X, Y] = Generate2DGBMPaths(N,M,S0_1,S0_2,sigma,r,rho,T);
V = Payoff(K, X(:,M),Y(:,M));
[option_value, lowerbound, exercise_time] = Test(r,delT,G,N,M,R,V,K,X,Y);% obtain the American option value and its lowerbound
% now implement the duality to check the upper bound -- in next MATLAB file!


