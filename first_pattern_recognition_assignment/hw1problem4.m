clear all
clc
%Part(1)
[T1,T2,T3]=readvars('hw1p4_data.csv');
d1=T1(:,1);
d2=T2(:,1);
d3=T3(:,1);
figure(1)
S1=scatter(d1,d2,5,'green');
%Correlation coefficiant is defnitely positive, somewhere between 0.5 and 1
figure(2)
%Without doing any calulations it looks like the correlation coefficiant is
%almost negative 1.
S2=scatter(d1,d3,5,'red');
figure(3)
%This data set is also a negative correlation, looks to be between -0.5 and
%-1
S3=scatter(d2,d3,5,'black');

%Part(2)
C1=cov(d1,d2);
C2=cov(d1,d3);
C3=cov(d2,d3);
sigma1=sqrt(C1(1,1));
sigma2=sqrt(C1(2,2));
sigma3=sqrt(C2(2,2));
%Correlation Coffeiciant Between first and second columns
ro12=C1(1,2)/(sigma1*sigma2);
%Correlation Coffeiciant Between first and third columns
ro13=C2(1,2)/(sigma1*sigma3);
%Correlation Coffeiciant Between second and third columns
ro23=C3(1,2)/(sigma2*sigma3);

%Yes the off diagonal terms are in agreement from what we see in the scatter plots!

mu=[mean(T1) mean(T2) mean(T3)];

%Part(3)and(4)


newdata1=mvnrnd(mu(1,(1:2)),C1,length(d1));

newdata2=mvnrnd([mu(1,1) mu(1,3)],C2,length(d1));

newdata3=mvnrnd(mu(1,(2:3)),C3,length(d1));

figure(4)
hold on
scatter(newdata1(:,1),newdata1(:,2),'+','cyan')
scatter(d1,d2,5,'green');
hold off
figure(5)
hold on
scatter(newdata2(:,1),newdata2(:,2),'+','cyan')
scatter(d1,d3,5,'red');
hold off
figure(6)
hold on
scatter(newdata3(:,1),newdata3(:,2),'+','cyan')
scatter(d2,d3,5,'black');
hold off

%The scatter plots are very similar to those generated with the data
%samples, the only difference now is that the data is gaussian, so the
%scatter plot is no longer skewed as it is before

%Part(5) 



