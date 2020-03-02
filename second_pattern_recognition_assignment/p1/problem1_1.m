clear all
clc
close all
%Part(1)
[T1]=csvread('hw2p1_data.csv');
h=[0.5 1 2];
N=length(T1);
x=linspace(min(T1),max(T1),400)
pke=zeros(3,length(x))

for j=1:length(h)
for i=1:length(x)
    sum=0
for k=1:length(T1)
    kernelwindow=((x(i)-T1(k))/h(j));
    Kx=(2*pi)^(-1/2)*exp((-1/2)*kernelwindow*kernelwindow');
    sum=sum+Kx;
end 
    pke(j,i)=(1/N*h(j))*sum
end
end

hold on
histogram(T1,40,'Normalization','pdf')
plot(x,pke(1,:),'LineWidth',1)
plot(x,pke(2,:),'LineWidth',1)
plot(x,pke(3,:),'LineWidth',1)
legend('histogram','small bandwith','best bandwith','large bandwith')
hold off


