function value = Phi(R,x,y)
         if R == 1
             value=1;
         elseif R ==2 
             %value= -(x.*y)+ones(length(x),1);
             value = x;
         elseif R== 3
             %value=((x.^2).*(y.^2)-(x.*y).*4+ones(length(x),1).*2).*0.5;
             value = y;
         elseif R== 4
             %value=(-(x.^3).*(y.^3)+(x.^2).*(y.^2).*9-(x.*y).*18+ones(length(x),1).*6).*(1/6);
             value = x.^2;
         elseif R == 5
             value = y.^2;
         elseif R== 6
             value = x.^3;
         elseif R== 7
            value = y.^3;
         elseif R== 8
             value = x.*y;
         elseif R==9
             value = (x.^2).*y;
         elseif R==10
             value = x.*(y.^2);
         end
         %value = exp((-0.001)*(x.*y)).*value;% weighting used in Longstaff-Schwartz paper
end