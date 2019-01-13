clear;
clc;

f = fopen('house_names.txt');             
hn = textscan(f,'%s','delimiter','\n');
fclose(f);
h_names = [hn{:}];

f = fopen('senate_names.txt');             
sn = textscan(f,'%s','delimiter','\n');
fclose(f);
s_names = [sn{:}];

h_votes = load('house_votes.txt');
h_parties = load('house_parties.txt');
s_votes = load('senate_votes.txt');
s_parties = load('senate_parties.txt');

[Uh,Sh,Vh] = svd(h_votes);
[Us,Ss,Vs] = svd(s_votes);
sh = svd(h_votes);
ss = svd(s_votes);

% PLOT SINGULAR VALUES
figure(1)
semilogy(sh);
vline(20);
title('Voting Patterns US House Votes');
xlabel('singular value (i)');
ylabel('singular value');

figure(2)
semilogy(ss);
vline(5);
title('Voting Patterns US Senate Votes');
xlabel('singular value (i)');
ylabel('singular value');

figure(3)
gscatter(Uh(:,1),Uh(:,2),h_parties,'br','xo');
title('PCA - US House Votes');
xlabel('PC1');
ylabel('PC2');
legend('Democrats','Republicans','Location','northwest');
text(Uh(:,1),Uh(:,2),h_names,'right','FontSize',5);

figure(4)
gscatter(Us(:,1),Us(:,2),s_parties,'brk','xox');
title('PCA - US Senate Votes');
xlabel('PC1');
ylabel('PC2');
legend('Democrats','Republicans','Independents','Location','northwest');
text(Us(:,1),Us(:,2),s_names,'right','FontSize',5);


% Use a low rank approximation of the voting record using the first two dominant
% singular values of the SVD.

% HOUSE VOTE LOW RANK APPROXIMATION
k = 3;
% Bh is k = 2 low rank prediction of the House voting record
Bh = round(Uh(:,1:k)*Sh(1:k,1:k)*Vh(:,1:k)',0);
[pah, cvh] = computeStats(h_votes, Bh);
% cv - total number of matches i.e. correct votes
% pa - predictive accuracy

% Compute the prediction accuracy for the House voting record approximation
pah = cvh*100/(size(Bh,1)*size(Bh,2));

% SENATE VOTE LOW RANK APPROXIMATION
% Bs is k = 2 low rank prediction of the Senate voting record
Bs = round(Us(:,1:k)*Ss(1:k,1:k)*Vs(:,1:k)',0);
[pas, cvs] = computeStats(s_votes, Bs);
% cv - total number of matches i.e. correct votes
% pa - predictive accuracy

% Plot this number for each representative versus the u1 vector.
% HOUSE

% Compute p vector
for k = 1:size(h_votes,1)
[a, c] = computeStats(h_votes(k,:), Bh(k,:));
ph(1,k) = a;
end

for k = 1:size(s_votes,1)
[a, c] = computeStats(s_votes(k,:), Bs(k,:));
ps(1,k) = a;
end

% PLOT PREDICTION ACCURACY vs PC1
figure(5);
gscatter(Uh(:,1),ph,h_parties,'br','xo');
text(Uh(:,1),ph,h_names,'right','FontSize',5);
title('US House Votes: Prediction Accuracy vs PC1');
xlabel('PC1');
ylabel('Prediction Accuracy');
legend('Democrats','Republicans','Location','southeast');

figure(6);
gscatter(Us(:,1),ps,s_parties,'brk','xox');
text(Us(:,1),ps,s_names,'right','FontSize',5);
title('US Senate Votes: Prediction Accuracy vs PC1');
xlabel('PC1');
ylabel('Prediction Accuracy');
legend('Democrats','Republicans','Independents','Location','southeast');

h_abs = computeAbstention(h_votes); % Vector showing the no. of absention votes
s_abs = computeAbstention(s_votes); % Vector showing the no. of absention votes