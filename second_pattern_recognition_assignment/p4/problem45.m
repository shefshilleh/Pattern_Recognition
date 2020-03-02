%THIS IS THE SCRIPT USED IN PROBLEM 4&5%%%%
% USER CAN CHANGE THE FUNCTION ON LINE 69 WHICH OUTPUTS THE PERFORMANCE OF
% THE CLASSIFIER! THERE ARE 6 classifier FUNCTIONS to choose FROM!
% NAMES: quadratic,quadraticPCA,quadraticLDA, KNNHD,KNNPCA,KNNLDA
% note that these functions take the three dimensional array, and also not
% that the KNN needs an extra parameter, that is K, when calling the
% function
% User can adjust the trials in this script since the data is random, the
% trials can be adjusted on line 44!
clc
clear all
close all
X=ones(48,1);
mu1=[5 0 5, X'];
mu2=[4 6 7, X'];
mu3=[6 2 4, X'];
v=36*ones(51,1);
D1=diag(v);
D2=diag(v);
D3=diag(v);
sigma1=[5 -4 -2;-4 4 0;-2 0 5];
for k=1:3
for i=1:3
    D1(k,i)=sigma1(k,i);
end
end
sigma2=[3 0 0;0 3 0;0 0 3];
for k=1:3
for i=1:3
    D2(k,i)=sigma2(k,i);
end
end
sigma3=[6 5 6;5 6 7;6 7 9];
for k=1:3
for i=1:3
    D3(k,i)=sigma3(k,i);
end
end

%I am repeating steps a&b for as many trials to get the average
%classification rate
%You can play with the amount of trials here to get a better representation
%of the classifier
trials=20
for I=1:trials
data1=mvnrnd(mu1,D1,250);
data2=mvnrnd(mu2,D2,250);
data3=mvnrnd(mu3,D3,250);
p = randperm(length(data1));
%Splitting Data into 75 percent for training and 25% for test data
%For data set 1
indicesoftestdata1= p(1,1:round(length(data1)*.25));
indicesoftrainingdata1= p(1,(round(length(data1)*.25))+1:end);
testdata1=data1(indicesoftestdata1,:);
trainingdata1=data1(indicesoftrainingdata1,:);
%For data set 2
indicesoftestdata2= p(1,1:round(length(data2)*.25));
indicesoftrainingdata2= p(1,(round(length(data2)*.25))+1:end);
testdata2=data2(indicesoftestdata2,:);
trainingdata2=data2(indicesoftrainingdata2,:);
%For data set 3
indicesoftestdata3= p(1,1:round(length(data3)*.25));
indicesoftrainingdata3= p(1,(round(length(data3)*.25))+1:end);
testdata3=data3(indicesoftestdata3,:);
trainingdata3=data3(indicesoftrainingdata3,:);
%stack the data in three dimensions to make it more organized by using the cat command!
STACKEDtestdata = cat(3,testdata1,testdata2,testdata3);
STACKEDtrainingdata = cat(3,trainingdata1,trainingdata2,trainingdata3);

%Now I have all of the test and sample data in two arrays
[pf] = KNNLDA(STACKEDtestdata,STACKEDtrainingdata,1/3,187);
totalperformance(I)=pf;
end
totalperformance=sum(totalperformance)/length(totalperformance)


    
