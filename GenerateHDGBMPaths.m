function [S] = GenerateHDGBMPaths(N,M,S0,sigma,r,rho,T)
delT = T/M;
Omega = eye(N) + rho*(ones(N)-eye(N));
L = chol(Omega,'lower');
S = zeros(N,M);
S(:,1) = S0*ones(N,1);
rng('shuffle');
W = sqrt(delT)*L*randn(N,M);
for n = 1:N
    for m = 1:M-1
        S(n,m+1) = S(n,m)*exp((r-0.5*sigma*sigma)*delT + sigma*W(n,m));
    end 
end
end