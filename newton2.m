function [xk] = newton2(f,x,accuracy,h)
xk=x;
%xk=x-(f(x)/myDiff(f,x,h));

if(nargin <3), accuracy=15; end
if(nargin <4), h=10^-9; end

ep=500*eps();

for i=1:accuracy
    dif=myDiff(f,xk,h);
    d=max(ep,ep*abs(xk));
     
    if((f(xk-d)*f(xk+d)<0))
        break
    end
    a=f(xk)/dif;

    
    
   
    xk=xk-a;
end

if ~isreal(xk)|| ~isreal(f(xk)), xk=NaN; end
end
