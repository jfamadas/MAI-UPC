function [path,optimalV] = computePath2(mat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[n,m] = size(mat);
matPath = ones(n,m);
i = 1;
j = 1;
matPath(i,j) = 0;

while(i~=n || j~=m)
    % Comprovem primer que no estiguem tocant la paret esquerra o el sostre
    if(i==n)
        j = j+1;
    elseif(j == m)
        i = i+1;
    % En cas de que no ens movem cap al minim
    else
        [val, idx] = min([mat(i+1,j),mat(i,j+1), mat(i+1, j+1)]);
        switch idx
            case 1
                i = i+1;
            case 2
                j = j+1;
            case 3
                i = i+1;
                j = j+1;
        end    
    end
    
    matPath(i,j) = 0;
    
    if (i==n)
        optimalV = val;
        break;
    
end


path = matPath;

end

