function [Optionalval, Minibound, Exercisetime] = Test(r,delT,G,N,M,R,V,K,X,Y)
Finalval = zeros(1,G);
B_phi = zeros(R,R);
B_phi_V = zeros(1,R);
Beta = zeros(R,1);
Exercisetime = zeros(1,M);
for o = 1:G
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
            Exercisetime(i) = i;
        else
            V(a) = exp(-r*delT) * V(a);
        end
    end
end
Final = sum(V)/N;
Finalval(o) = Final;
end % repeat for G times and calculate the average as the final American Option values
Optionalval = sum(Finalval)/G;
% and set the minimum of all Gth simulations as the lower bound
Minibound = min(Finalval);
end