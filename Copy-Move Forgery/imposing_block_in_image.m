% Imposing a block in an image
M = 100; % diemension of the image
x=20; y=35; % Position of the centre of the block
s=8; %half of the size of the block
m=zeros(M); % definint the image
b=255*ones(2*s); % definint the block

imshow(m);
% Note checking positoins out of the image!!!!
m(x-s:x+s-1,y-s:y+s-1)=b;
figure
imshow(m)

