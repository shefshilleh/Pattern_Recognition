close all
clear all
clc

% I just want to note that I did not use the same functions I used in
% problem four and 5 because the data here is not even and I cannot make it
% into a 3d array, hence I created functions that are similar but take
% different inputs. 

Traininglabels = csvread('hw2p6_c1.csv');
Trainingvalues = csvread('hw2p6_x1.csv');
A=[Traininglabels,Trainingvalues];
B=sortrows(A);
trainingdata1=B(1:97,2:end);
trainingdata2=B(98:186,2:end);
trainingdata3=B(187:300,2:end);

Testlabels = csvread('hw2p6_c2.csv');
Testvalues = csvread('hw2p6_x2.csv');
C=[Testlabels,Testvalues];
D=sortrows(C);
testdata1=D(1:36,2:end);
testdata2=D(37:62,2:end);
testdata3=D(63:100,2:end);
STACKEDtestdata=[testdata1;testdata2;testdata3]




MU=mean(Trainingvalues);
COV=cov(Trainingvalues);

[vectors, values]=eig(COV);
eigenvalues=diag(values);
[descendingorder, index]=sort(eigenvalues,'descend');
[descendingordervectors]=vectors(:,index);

sumeig=sum(eigenvalues);
PofV=0;
H=0;

while PofV<0.9
    H=H+1; %Counting how many eigenvalues we need in the PCA to capture 90 percent of the vartiance
    PofV=(PofV+(descendingorder(H)/sumeig));
end
 [y, v, d] = tamu_lda(Trainingvalues, Traininglabels); % Using LDA to see how much of the variance is captured

%PART A end here
 
 
%PART B, you can call the functions here to analyze which actually performs
%better
%FUNCTIONS are the following quadratic6,quadraticLDA6,quadraticPCA6,KNNHD6,KNNPCA6,KNNLDA6

[class1,class2,class3] = hw2p6('hw2p6_x1.csv')

 
 
 