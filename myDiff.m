function [der] = myDiff(g,x,h)
if(nargin <3)
    h=10^-7;
end
der =( g(x+h)- g(x-h) )/(2*h);
end