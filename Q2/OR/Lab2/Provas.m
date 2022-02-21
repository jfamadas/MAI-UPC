clc; clear all; close all;
i = linspace(0,1,1000);

a = sin(2*pi*i)';
b = sin(2*pi*2*i)';
%b = b(1:size(b,1)/2,:);

% figure(3)
% plot(a);
% hold on
% plot(b);


[dist,DTWmat] = multiDTW(a,b);

% figure(1)
% plot(DTWmat(end,:))
% 
% figure(2)
% plot(DTWmat(:,end))

% matrix = 
figure(4)
imshow(uint8(DTWmat))

path = computePath(DTWmat);

figure;
imshow(path);