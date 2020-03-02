%aspectratio code seperates the screw
clear all
clc
close all 
images=dir('*.jpg');
AR=zeros();
maximum=zeros();
difference=zeros(1,length(images));
ratio=zeros(1,length(images));
ratio2=zeros(1,length(images));
for i=1:length(images)
    images=dir('*.jpg');
    images=images(i,:);
    A=imread(images.name);
    G=rgb2gray(A);
    BW = imbinarize(G);
    BW1=imcomplement(BW);
    BW2 = imfill(BW1,'holes');
    BW11=imresize(BW1, [128 128]);
    BW22=imresize(BW2, [128 128]);
    CBW=imcomplement(BW);
    AX=regionprops(CBW,'MajorAxisLength','MinorAxisLength');
    for k=1:length(AX);
        maxmajor(k)=AX(k).MajorAxisLength;
        maxminor(k)=AX(k).MinorAxisLength;
    end
    MA=max(maxmajor);
    MI=max(maxminor);
    AR(i)=MA/MI;
    difference(i)=sum(BW22(:))-sum(BW11(:));
    %the difference algorithm seperates the brackets away from the washers and nuts by closing the
    %hole in the image and taking the binary difference
    BW2=imresize(BW, [64 64]);
    J=imcrop(BW2,[30 30 4 4]);
    numberOfWhitePixels = sum(J(:));
    numberOfBlackPixels = numel(BW) - numberOfWhitePixels;
    ratio(i) = numberOfBlackPixels/numberOfWhitePixels;
    %ratio seperates washers and nuts from the rest 
    halfpic(CBW);
    [bp1,bp2]=halfpic(CBW);
    ratio2(i)=bp1/bp2;
    %ratio2 implements a function taken from an online source and compares
    %the left half and right half of the images, the idea is that washers
    %are more symmetric than nuts on average due to the fact that the
    %washers are circular and nuts tend to be hexagonal
end


subplot(4,4,1)
hold on
scatter(AR(1:10),AR(1:10),'red','fill')
scatter(AR(11:20),AR(11:20),'blue','fill')
scatter(AR(21:30),AR(21:30),'green','fill')
scatter(AR(31:40),AR(31:40),'cyan','fill')
legend('bracket','nut','screw','washer','fill')
ylabel('feature 1 aspect ratio')
title('feature 1 aspect ratio')
subplot(4,4,2)
hold on
scatter(difference(1:10),AR(1:10),'red','fill')
scatter(difference(11:20),AR(11:20),'blue','fill')
scatter(difference(21:30),AR(21:30),'green','fill')
scatter(difference(31:40),AR(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
title('feature 2 difference')
hold off
subplot(4,4,3)
hold on
scatter(difference(1:10),ratio(1:10),'red','fill')
scatter(difference(11:20),ratio(11:20),'blue','fill')
scatter(difference(21:30),ratio(21:30),'green','fill')
scatter(difference(31:40),ratio(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
title('feature 3 ratio')
hold off
subplot(4,4,4)
hold on
scatter(ratio2(1:10),AR(1:10),'red','fill')
scatter(ratio2(11:20),AR(11:20),'blue','fill')
scatter(ratio2(21:30),AR(21:30),'green','fill')
scatter(ratio2(31:40),AR(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
title('feature 4 ratio2')
hold off
subplot(4,4,5)
hold on
scatter(AR(1:10),difference(1:10),'red','fill')
scatter(AR(11:20),difference(11:20),'blue','fill')
scatter(AR(21:30),difference(21:30),'green','fill')
scatter(AR(31:40),difference(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
ylabel('feature 2 difference')
hold off
subplot(4,4,6)
hold on
scatter(difference(1:10),difference(1:10),'red','fill')
scatter(difference(11:20),difference(11:20),'blue','fill')
scatter(difference(21:30),difference(21:30),'green','fill')
scatter(difference(31:40),difference(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,7)
hold on
scatter(ratio(1:10),difference(1:10),'red','fill')
scatter(ratio(11:20),difference(11:20),'blue','fill')
scatter(ratio(21:30),difference(21:30),'green','fill')
scatter(ratio(31:40),difference(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,8)
hold on
scatter(ratio2(1:10),difference(1:10),'red','fill')
scatter(ratio2(11:20),difference(11:20),'blue','fill')
scatter(ratio2(21:30),difference(21:30),'green','fill')
scatter(ratio2(31:40),difference(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
subplot(4,4,9)
hold on
scatter(AR(1:10),ratio(1:10),'red','fill')
scatter(AR(11:20),ratio(11:20),'blue','fill')
scatter(AR(21:30),ratio(21:30),'green','fill')
scatter(AR(31:40),ratio(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
ylabel('feature 3 ratio')
hold off
subplot(4,4,10)
hold on
scatter(difference(1:10),ratio(1:10),'red','fill')
scatter(difference(11:20),ratio(11:20),'blue','fill')
scatter(difference(21:30),ratio(21:30),'green','fill')
scatter(difference(31:40),ratio(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,11)
hold on
scatter(ratio(1:10),ratio(1:10),'red','fill')
scatter(ratio(11:20),ratio(11:20),'blue','fill')
scatter(ratio(21:30),ratio(21:30),'green','fill')
scatter(ratio(31:40),ratio(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,12)
hold on
scatter(ratio2(1:10),ratio(1:10),'red','fill')
scatter(ratio2(11:20),ratio(11:20),'blue','fill')
scatter(ratio2(21:30),ratio(21:30),'green','fill')
scatter(ratio2(31:40),ratio(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off 
subplot(4,4,13)
hold on
scatter(AR(1:10),ratio2(1:10),'red','fill')
scatter(AR(11:20),ratio2(11:20),'blue','fill')
scatter(AR(21:30),ratio2(21:30),'green','fill')
scatter(AR(31:40),ratio2(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
ylabel('feature 4 ratio2')
hold off
subplot(4,4,14)
hold on
scatter(difference(1:10),ratio2(1:10),'red','fill')
scatter(difference(11:20),ratio2(11:20),'blue','fill')
scatter(difference(21:30),ratio2(21:30),'green','fill')
scatter(difference(31:40),ratio2(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,15)
hold on
scatter(ratio(1:10),ratio2(1:10),'red','fill')
scatter(ratio(11:20),ratio2(11:20),'blue','fill')
scatter(ratio(21:30),ratio2(21:30),'green','fill')
scatter(ratio(31:40),ratio2(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off
subplot(4,4,16)
hold on
scatter(ratio2(1:10),ratio2(1:10),'red','fill')
scatter(ratio2(11:20),ratio2(11:20),'blue','fill')
scatter(ratio2(21:30),ratio2(21:30),'green','fill')
scatter(ratio2(31:40),ratio2(31:40),'cyan','fill')
legend('bracket','nut','screw','washer')
hold off

