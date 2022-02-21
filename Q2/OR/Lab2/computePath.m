function [path] = computePath(mat)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
[n,m] = size(mat);
matPath = ones(n,m);
i = n;
j = m;
matPath(i,j) = 0;

while(i~=1 || j~=1) 
    % Comprovem primer que no estiguem tocant la paret esquerra o el sostre
    if(i==1)
        j = j-1;
    elseif(j == 1)
        i = i-1;
    % En cas de que no ens movem cap al minim
    else
        [val, idx] = min([mat(i-1,j),mat(i,j-1), mat(i-1, j-1)]);
        switch idx
            case 1
                i = i-1;
            case 2
                j = j-1;
            case 3
                i = i-1;
                j = j-1;
        end    
    end
    
    matPath(i,j) = 0;
    
    
    
    
end


path = matPath;

end

