function [B] = computeAbstention(A)
% Compute the number of abstention votes = 0

for i = 1:size(A,1);
    n = 0;
    for j = 1:size(A,2);
        if A(i,j)==0;
            n = n + 1;
        end
    end
    B(i,1)=n;
end
    