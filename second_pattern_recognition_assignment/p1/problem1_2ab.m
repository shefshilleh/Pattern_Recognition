clear all
clc
close all
%Part(2)a&b
[T1]=csvread('hw2p1_data.csv');
N=length(T1);
b = T1(T1~=T1(1))
h=1
summ=0
for i=1:length(b)  
   kernelwindow=((T1(1)-b(i))/h);
   Kx=(2*pi)^(-1/2)*exp((-1/2)*kernelwindow*kernelwindow');
   summ=summ+Kx;
end
pkde=(1/(N-1)*h)*summ
logp_n=exp(pkde)
hstart=(1/N)*logp_n