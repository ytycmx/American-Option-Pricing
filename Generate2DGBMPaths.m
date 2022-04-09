function [S1,S2] = Generate2DGBMPaths(N,M,S0_1,S0_2,sigma,r,rho,T)
delT = T/M;
S1 = zeros(N,M);
S2 = zeros(N,M);
S1(:,1) = S0_1*ones(N,1);
S2(:,1) = S0_2*ones(N,1);
for m = 1:M-1
      W1 = randn(N,1);
      Z2 = randn(N,1);
      for n = 1:N
      S1(n,m+1) = S1(n,m)*exp((r-0.5*sigma*sigma)*delT + sigma*sqrt(delT)*W1(n,1));
      S2(n,m+1) = S2(n,m)*exp((r-0.5*sigma*sigma)*delT + sigma*sqrt(delT)*(rho*W1(n,1)+sqrt(1-rho*rho)*Z2(n,1)));
      end
end
end