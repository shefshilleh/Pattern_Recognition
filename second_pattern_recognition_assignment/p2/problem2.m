clear all
clc
%part(a)
a=csvread('hw2p2_data.csv');
figure(1)
scatter3(a(1,:),a(2,:),a(3,:),'g','h')
rotate3d
xlabel('row1')
ylabel('row2')
zlabel('row3')
title('Comparison of first three rows')
%Part b, I am centering the data at the origin and computing the
%eigenvalues and vectors through the covariance matrix
average=mean(a);
centereddata=a-average;
sig=cov(a);
sig2=cov(centereddata);
[vectors, values]=eig(sig);
eigenvalues=diag(values)
%Sorted the eigenvalues from the line of code above from largest to
%smallest
[descendingorder, index]=sort(eigenvalues,'descend')
% I arranged the eigenvectors from largest to smallest, starting with the
% eigenvector that corresponds to the largest eigenvalue and etc.
[descendingordervectors]=vectors(:,index)

figure(2)
plot(descendingorder,'--o','LineWidth',1)
xlabel('lambda')
ylabel('value')
title('Eigenvalues descending order')

figure(3)
scatter3(a*descendingordervectors(:,1),a*descendingordervectors(:,2),a*descendingordervectors(:,3),'fill','magenta')
xlabel('Most significant eigenvector')
ylabel('Second most significant eigenvector')
zlabel('Third most significant eigenvector')
title('Three most significant eigenvectors')












