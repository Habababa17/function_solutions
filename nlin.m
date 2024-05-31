function [w] = nlin(f)
%% 
%8.56
%parametry
    Nstart=2500;
    sensivity=0.01;
    sensivity_small=0.00001;
   
    delta=0.01;
    k_max=20;
    accuracy=0.04;
    derivative_max=100;
    dN=50;
    z=[];

%dalekie przeszukiwanie
    EXP(50)=0;
    e_small=exp(0.5);
    e_smaller=exp(0.25);
    EXP(1)=exp(3);
    for i=1:50
       EXP(i+1)=EXP(i)*e_small;
    end
%%
%generowanie potencjalnych miejsc zerowych
%0+
    k=0;
%zasięg przeszukiwania

    N_positive=0;
    for i=0:dN:Nstart
        if(~isreal(f(i)) || k>k_max), break, end
        N_positive=N_positive+dN;
        if(abs(f(i)-f(i+dN))<delta || abs(myDiff(f,i))>derivative_max ), k=k+1; end
    end

%szukanie miejsc zerowych w zasięgu
    s_half=sensivity/2;
    for i=0:sensivity:N_positive
        if  f(i)*f(i+sensivity)<=0
            z=[z,i+s_half];
        end
    end

%szukanie miejsc zerowych "dalekich"

    for i=1:length(EXP)-1
        if  f(EXP(i))*f(EXP(i+1))<=0
            z=[z,EXP(i)*e_smaller];
        end
    end
%% 
%generowanie potencjalnych miejsc zerowych
%0-
    k=0;
%zasięg przeszukiwania
    N_negative=0;
%N_negative=Nstart;
    for i=0:-dN:-Nstart
        if(~isreal(f(i)) || k>k_max), break, end
        N_negative=N_negative-dN;

        if(abs(f(i)-f(i+dN))<delta || abs(myDiff(f,i))>derivative_max)
            k=k+1;
        end
    end
      
%szukanie miejsc zerowych w zasięgu  
    for i=0:-sensivity:N_negative
        if  f(i)*f(i-sensivity)<=0
            z=[z,i-s_half];
        end
    end
    
%szukanie miejsc zerowych "dalekich"

    for i=1:length(EXP)-1
        if  f(-EXP(i))*f(-EXP(i+1))<=0
            z=[z,-EXP(i)*e_smaller];
        end
    end
 
%% przybliżanie miejsc zerowych
    for i=1:length(z)
        z(i)=newton2(f,z(i));
    end
 
%%  
    w=clean(z,f);
%%
    if(length(w)<100)
        k=0;
        z=[];
        temp=[];
        for i=1:length(w)-1
    
            if(k>=5)
                for j=w(i-5)-accuracy:sensivity_small:w(i)+accuracy
                    if f(j)*f(j+sensivity_small)<=0
                        temp=[temp,newton2(f,j)];
                    end
                end
                z=[z,temp];
                temp=[];
            end

            if( w(i+1)-w(i)<accuracy)
                k=k+1;
            else
                k=0;
            end
        end

        z=clean(z,f);
        w=[w,z];
        w=clean(w);
    end
end