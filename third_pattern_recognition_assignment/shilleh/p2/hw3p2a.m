clear all
clc
close all
A1=csvread('world_city_distance.csv');
ONE=ones(1,length(A1));
Z=diag(ONE)-(1/length(A1));
B=(-1/2)*Z*(A1.^2)*Z;
[v,d]=eig(B);
eigenvalues=diag(d)
%Sorted the eigenvalues from the line of code above from largest to
%smallest
[descendingorder, index]=sort(eigenvalues,'descend')
% I arranged the eigenvectors from largest to smallest, starting with the
% eigenvector that corresponds to the largest eigenvalue and etc.
[descendingordervectors]=v(:,index)
X=descendingordervectors(:,1:64)*(diag(descendingorder(1:64,1))).^(1/2)
figure(1)
scatter(X(:,1),X(:,2),'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
title('2D Distance Between Major World Cities')
xlabel('X Distance (meters)')
ylabel('Y Distance (meters)')
ax = gca;
ax.FontSize = 15;
figure(2)
scatter3(X(:,1),X(:,2),X(:,3),'MarkerEdgeColor',[0.5 0 0],'MarkerFaceColor',[0.7 .4 0],'LineWidth',1.5)
title('3D Distance Between Major World Cities')
xlabel('X Distance (meters)')
ylabel('Y Distance (meters)')
zlabel('Z distance (meters)')


ax = gca;
ax.FontSize = 15;