function [finalCost, resultMat] = multiDTW(seq1,seq2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = size(seq1,1);
m = size(seq2,1);
DTWmat = zeros(n,m);

%Initialization
DTWmat(:,1) = inf; 
DTWmat(1,:) = inf;
DTWmat(1,1) = 0;

%Computing
for i = 2:n
    for j = 2:m
        cost = norm(seq1(i,:)-seq2(j,:)); % Això s'ha de adaptar per multi.
        DTWmat(i,j) = cost + min([DTWmat(i-1,j), DTWmat(i,j-1), DTWmat(i-1,j-1)]);
        
    end
    
end



finalCost = DTWmat(n,m);
resultMat = DTWmat;
end