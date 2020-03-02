clc
clear all
close all
X=ones(48,1);
mu1=[5 0 5, X']
mu2=[4 6 7, X']
mu3=[6 2 4, X']
v=36*ones(51,1);
D1=diag(v)
D2=diag(v)
D3=diag(v)
sigma1=[5 -4 -2;-4 4 0;-2 0 5]
for k=1:3
for i=1:3
    D1(k,i)=sigma1(k,i)
end
end
sigma2=[3 0 0;0 3 0;0 0 3]
for k=1:3
for i=1:3
    D2(k,i)=sigma2(k,i)
end
end
sigma3=[6 5 6;5 6 7;6 7 9]
for k=1:3
for i=1:3
    D3(k,i)=sigma3(k,i)
end
end
data1=mvnrnd(mu1,D1,250)
data2=mvnrnd(mu2,D2,250)
data3=mvnrnd(mu3,D3,250)
alldata=[data1;data2;data3]
average=mean(alldata);
centereddata=alldata-average;
sig2=cov(centereddata);
[vectors, values]=eig(sig2);
eigenvalues=diag(values)
%Sorted the eigenvalues from the line of code above from largest to
%smallest
[descendingorder, index]=sort(eigenvalues,'descend')
% I arranged the eigenvectors from largest to smallest, starting with the
% eigenvector that corresponds to the largest eigenvalue and etc.
[descendingordervectors]=vectors(:,index)

figure(1)
hold on
text(data1*descendingordervectors(:,1),data1*descendingordervectors(:,2),'PCA Data1','Color','blue')
axis([-30 30 -30 30])
xlabel('Data Projected onto First Eigenvector')
ylabel('Data Projected onto Second Eigenvector')
title('PCA')
text(data2*descendingordervectors(:,1),data2*descendingordervectors(:,2),'PCA Data2','Color','red')
axis([-30 30 -30 30])
text(data3*descendingordervectors(:,1),data3*descendingordervectors(:,2),'PCA Data3','Color','green')
axis([-30 30 -30 30])
hold off


class=[mu1;mu2;mu3]

[y, v, d] = tamu_lda(alldata, [ones(250,1);2*ones(250,1);3*ones(250,1)]);


figure(2)
hold on
text(data1*v(:,1),data1*v(:,2),'LDA Data1','Color','blue')
axis([-20 20 -20 20])
text(data2*v(:,1),data2*v(:,2),'LDA Data2','Color','red')
axis([-20 20 -20 20])
text(data3*v(:,1),data3*v(:,2),'LDA Data3','Color','green')
axis([-20 20 -20 20])
xlabel('Data Projected onto First Eigenvector')
ylabel('Data Projected onto Second Eigenvector')
title('LDA')
