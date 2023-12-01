clear
clc
close all

[file,path]=uigetfile('*.png','Open image');
file_path=(strcat(path,file));
[file,path]=uigetfile('*.png','Open secret image');
concelled_file_path=(strcat(path,file));

III=Write_Concealed_Image(file_path,concelled_file_path);

I=imread(file_path);
image(I); % Original image
figure

II=imread(concelled_file_path);
image(II); % Concelled image
figure

image(III); % Final image
imwrite(III,'concealled.png');
