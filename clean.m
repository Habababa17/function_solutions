function [z] = clean(z,f)
% usuwa kopie, Inf i NaN wartości oraz nie miejsca zerowe funkcji f
ep=500*eps();
%%
%czyszczenie wektora z 
z=real(z);
z=unique(z);
%usuwanie Nan i Inf wartości
z=z(~(isnan(z) | isinf(z)));


%% miejsca zerowe
if nargin == 2
    w=[];
for i=1:length(z)
    
    d=max(ep,ep*abs(z(i)));

    if(f(z(i)-d)*f(z(i)+d)<=0)
        w=[w,z(i)];
    end 
   
end
z=w;
end
%% kopie
for i=1:length(z)-1
    d=max(ep,ep*abs(z(i)));
    if(abs(z(i)-z(i+1))<2*d)
       z(i+1)=z(i); 
    end
end
z=unique(z);

end

