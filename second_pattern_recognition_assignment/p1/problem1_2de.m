clear all
clc
close all
%Part(2c) steps a&b done for every data point
h=1
[T1]=csvread('hw2p1_data.csv');
N=length(T1);
r=iqr(T1)/1.34;
sdev=std(T1);
A=min(r,sdev);
hzero=0.9*A*(N^(-1/5))
hlog = logspace(log(hzero/100)/log(10),log(hzero*100)/log(10),100);
for L=1:length(hlog)
for n=1:length(T1)
   b = T1(T1~=T1(n));
   summ=0;
for i=1:length(b)  
   kernelwindow=((T1(n)-b(i))/hlog(L));
   Kx=(2*pi)^(-1/2)*exp((-1/2)*kernelwindow*kernelwindow');
   summ=summ+Kx;
end
   pkde(n)=(1/((N-1)*hlog(L)))*summ;
end
logp_n=log(pkde);
hstart(L)=(1/N)*sum(logp_n);
end

plot(hlog,hstart,'-o','LineWidth',1)