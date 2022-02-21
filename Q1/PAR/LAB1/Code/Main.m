
clear all;
close all; 
clc;
for i=5:5:30
    %Solve the problem for the first configuration for 6 maxcolumnsnum
    %values.
    [endflag,Environment,plans,visitedstates,totalvisitedstates]=NLPRegression('test.txt',['outputConfig1MaxColumns' num2str(i/5+1) '.txt'],i-5);
    x(i/5,1) = size(visitedstates,2);%store the number of accepted states.
    x(i/5,3) = totalvisitedstates; %store the number of accepted+discarded states.
    if (endflag~=0)
        x(i/5,2) = size(plans{endflag},2)-1; %store the size of the plan
    else
        x(i/5,2) = 0;%if the problem was unsolvable set the size of the plan to 0.
    end
end

for i=35:5:60
    [endflag,Environment,plans,visitedstates,totalvisitedstates]=NLPRegression('test.txt',['outputConfig2MaxColumns' num2str((i-30)/5+1) '.txt'],i-5);
       y((i-30)/5,1) = size(visitedstates,2);
       y((i-30)/5,3) = totalvisitedstates;
    if (endflag~=0)
        y((i-30)/5,2) = size(plans{endflag},2)-1;
    else
        y((i-30)/5,2) = 0;
    end
end

for i=65:5:90
    [endflag,Environment,plans,visitedstates,totalvisitedstates]=NLPRegression('test.txt',['outputConfig3MaxColumns' num2str((i-60)/5+1) '.txt'],i-5);
       t((i-60)/5,1) = size(visitedstates,2);
       t((i-60)/5,3) = totalvisitedstates;
    if (endflag~=0)
        t((i-60)/5,2) = size(plans{endflag},2)-1;
    else
        t((i-60)/5,2) = 0;
    end
end

for i=95:5:120
    [endflag,Environment,plans,visitedstates,totalvisitedstates]=NLPRegression('test.txt',['outputConfig4MaxColumns' num2str((i-90)/5+1) '.txt'],i-5);
       w((i-90)/5,1) = size(visitedstates,2);
       w((i-90)/5,3) = totalvisitedstates;
    if (endflag~=0)
        w((i-90)/5,2) = size(plans{endflag},2)-1;
    else
        w((i-90)/5,2) = 0;
    end
end

for i=125:5:150
    [endflag,Environment,plans,visitedstates,totalvisitedstates]=NLPRegression('test.txt',['outputConfig5MaxColumns' num2str((i-120)/5+1) '.txt'],i-5);
       h((i-120)/5,1) = size(visitedstates,2);
       h((i-120)/5,3) = totalvisitedstates;
    if (endflag~=0)
        h((i-120)/5,2) = size(plans{endflag},2)-1;
    else
        h((i-120)/5,2) = 0;
    end
end

z = [2,3,4,5,6,7];
figure(1);
plot(z,x(:,1))
hold on
plot(z,y(:,1))
plot(z,t(:,1),'g')
plot(z,w(:,1),'b')
plot(z,h(:,1),'r')
figure(2)
plot(z,x(:,2))
hold on
plot(z,y(:,2))
plot(z,t(:,2),'g')
plot(z,w(:,2),'b')
plot(z,h(:,2),'r')

