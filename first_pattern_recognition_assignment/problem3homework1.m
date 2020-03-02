clear all
clc
syms x;
pw1=9999/10000;
pw2=1/10000;
c12=1*10^6;
c21=20000;
%ML then MAP then Bayes risk
criteria=[1 pw2/pw1 (c12*pw2)/(c21*pw1)];
for i=1:3
eqn=((1/(sqrt(2*pi)*0.3))*exp(-(x)^2/(2*0.3^2)))/((1/(sqrt(2*pi)*0.1))*exp(-(x-1)^2/(2*0.1^2))) == criteria(i);
if i==1
S1=solve(eqn,x)
elseif i==2
S2=solve(eqn,x)
else
S3=solve(eqn,x) 
end
end
