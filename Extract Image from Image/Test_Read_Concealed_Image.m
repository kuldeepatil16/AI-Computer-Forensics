clear
clc
close all

[file,path]=uigetfile('*.png','Open concelled image');
concelled_file_path=(strcat(path,file));
II=Read_Concealed_Image(concelled_file_path);
image(II); % Concelled image
imwrite(II,'concealled_secret.png');






