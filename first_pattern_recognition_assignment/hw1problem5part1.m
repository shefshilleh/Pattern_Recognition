clear all
clc
[X1,X2]=readvars('hw1p5_data.csv');
data=[X1 X2];
n=10
y=datasample(data,n)
y1=y(:,1);
y2=y(:,2);
polynomial=polyfit(y1,y2,1);
Pval=polyval(polynomial,X1);
err1=immse(data,[X1,Pval])
figure(1)
plot(X1,X2,'o',X1,Pval,'green','LineWidth',1)
title('part 1, polynomial of order 1')
xlabel('X1')
ylabel('X2')
