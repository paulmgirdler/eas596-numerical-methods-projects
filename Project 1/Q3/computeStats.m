function [a, c] = computeStats(A, B)
% Compuate the accuracy in percent, a, and c, the number of correct/common
% entries between matrix A (truth) and matrix B (prediction).
e = abs(A - B);
c = 0;
for i = 1:size(e, 1)
    for j = 1:size(e, 2)
        if e(i, j) == 0;
            c = c + 1;
        end
    end
end
a = c*100/(size(B,1)*size(B,2));