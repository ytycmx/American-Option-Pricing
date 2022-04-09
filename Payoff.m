function payoff = Payoff(K,x,y)
payoff = max(max(x,y)-K,0);
end