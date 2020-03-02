clc 
clear all
close all
x=[0:1:2700];
g1=(1/(sqrt(2*pi)*300))*exp(-(x-1500).^2/(2*300^2));
g2=(1/(sqrt(2*pi)*100))*exp(-(x-500).^2/(2*100^2));
g3=(1/(sqrt(2*pi)*100))*exp(-(x-200).^2/(2*100^2));
spdf=0.35*g1+0.40*g2+0.25*g3
N=[200 20000]
for i=1:2
    a=normrnd(1500,300,[1,N(i)*0.35]);
    b=normrnd(500,100,[1,N(i)*0.40]);
    c=normrnd(200,100,[1,N(i)*0.25]);
    samples=[a,b,c];
    figure(i)
    hold on
    histogram(samples(1,:),50,'Normalization','pdf');
    plot(x,spdf,'g','LineWidth',2);
    xlabel('Weight in grams')
    ylabel('Probability')
    hold off
end
