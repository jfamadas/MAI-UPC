function [gest,ngest] = gestureCuts(X,Y)
    [row,col] = find(Y>0);
    ngest = round(size(row,1));
    row = [1; row];
    gest=[];
    for i = 2:ngest+1
        gest(i,1:3) = [col(i-1) row(i-1) row(i)];
    end
return

