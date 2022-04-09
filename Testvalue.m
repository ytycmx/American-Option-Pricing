function [optval,V_hat,X,Y] = Testvalue(r,delT,S0_1,S0_2,sigma,rho,T,N,M,R,K)
X = [];
Y = [];
[X, Y] = Generate2DGBMPaths(N,M,S0_1,S0_2,sigma,r,rho,T);
V = Payoff(K, X(:,M),Y(:,M));
V_hat = [zeros(N, M-1) V];
B_phi = zeros(R,R);
B_phi_V = zeros(1,R);
Beta = zeros(R,1);
for j = 1:M-2
    i = M-j;
    for q = 1:R
        for p = 1:R
            B_phi(q,p) = sum(Phi(q,X(:,i),Y(:,i)).*Phi(p,X(:,i),Y(:,i)))/N;
        end
    end
    for q = 1:R
        B_phi_V (q) = sum(V(:).*Phi(q,X(:,i),Y(:,i)))/N;
    end
    Beta(:,i) = B_phi\(B_phi_V');
    for a = 1:N
        ContinuationVal=0;
        for q = 1:R
            ContinuationVal =  ContinuationVal + Phi(q,X(a,i),Y(a,i)) * Beta(q,i);
        end
        if ContinuationVal < Payoff(K,X(a,i),Y(a,i))
            V(a) = Payoff(K,X(a,i),Y(a,i));
        else
            V(a) = exp(-r*delT) * V(a);
        end
        V_hat(a,i) = V(a);
    end
end
optval = sum(V)/N;
end