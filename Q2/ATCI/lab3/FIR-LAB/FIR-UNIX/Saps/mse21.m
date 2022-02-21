function [error,num,den11,den2] = mse2(y1,y2)

[siz,a]=size(y1);
for i=1:siz,
    numq(i,1) = (y1(i,1)-y2(i,1))^2;
end;
num = sum(numq)/siz;

for i=1:siz,
    den1(i,1)=y1(i,1)^2;
end;
den11=sum(den1)/siz;
den2=(sum(y1)/siz)^2;
den= den11-den2;

error=(num/den)*100;
return;
