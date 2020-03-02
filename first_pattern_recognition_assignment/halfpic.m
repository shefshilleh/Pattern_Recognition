%NOTE THAT PART OF THIS FUNCTION WAS TAKEN FROM AN ONLINE SOURCE: https://www.mathworks.com/matlabcentral/answers/49166-to-divide-an-image-into-2-equal-halves
function [blackpixels1,blackpixels2] = halfpic(x)
n = floor(size(x)/2)
m = size(x);
Lpic = x(:,1:n(2),:);
Rpic = x(:,n(2)+1:m(2),:);
%figure
%imshow(Lpic);
%figure
%imshow(Rpic);
blackpixels1=sum(Lpic(:))
blackpixels2=sum(Rpic(:))
end

