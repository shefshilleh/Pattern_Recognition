clear all
clc
%Part(1)
[X1,X2]=readvars('hw1p5_data.csv');
data=[X1 X2];
n=[10 15 20 25 50 100 200];
vec=zeros(100,10);
%vec2=zeros(10,100)
G=zeros(7,10);
for k=1:7
for j=1:100
y=datasample(data,n(k));
y1=y(:,1);
y2=y(:,2);
    for i=1:10
        polynomial=polyfit(y1,y2,i);
        Pval=polyval(polynomial,X1);
        %figure(i)
        %plot(X1,X2,'o',X1,Pval,'green')
        %grid on
        err1=immse(data,[X1,Pval]);
        vec(j,i)=err1;
    end
end
G(k,:)=mean(vec)
end
for Q=1:7
    figure(Q)
semilogx(G(Q,:),1:10,'b--o','LineWidth',1)
xlabel('Average MSE for 100 Trials')
ylabel('polynomial order')
end


