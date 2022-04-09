r=0.05; sigma=0.2; rho=0.1; T=1; K=11; S0 = 10;delT = T/M;q = 40+N;
N = 50;% number of assets
K = 10; % number of paths in each asset
M = 365; % number of MC samples
[S] = GenerateHDGBMPaths(N,M,S0,sigma,r,rho,T);
payoff = zeros(1,M);
for s = 2:M
   payoff(s) = exp(-r*s*delT)*max(max(S(:,s)),0);
end
S_payoff = [S;payoff];
%%%%% next is finding the r_n^theta in the essay
for m = M-1:-1:2
    r_mphim = exp(-r*m*delT)*max(max(S(:,m)),0)*BigF_phi(S_payoff(:,m),q,N)+exp(-r*(m+1)*delT)*max(max(S(:,m+1)),0)*(1-BigF_phi(S_payoff(:,m+1),q,N));
end
%%%%% Until now, we need to use mini-batch gradient ascent with Xavier
%%%%% initialization to max over parameters in BigF_phi.m to get each
%%%%% parameters and then use it to obtain backwardly each phi in our
%%%%% algorithm.     (how to achieve that?)
%%%%% Then, next is obtaining the tau we see in the essay as:
tau = 0;
multipart = 1;
for p = 1:M-1
    for u =1:p
        multipart = multipart*(1-f_phi(A_1n,A_2n,b_1,b_2,S_payoff(:,u)));
    end
   tau = tau + p*f_phi(A_1n,A_2n,b_1,b_2,S_payoff(:,p))*multipart;
end
%%%%% and next is using tau to obtain the option price
option_price = exp(-r*tau*delT)*max(max(S(:,tau)),0);