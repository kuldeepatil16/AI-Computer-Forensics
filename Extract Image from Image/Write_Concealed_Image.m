function III=Write_Concealed_Image(file_path,secret_file_path)
I=imread(file_path);
II=imread(secret_file_path);
II=imresize(II,[size(I,1) size(I,2)]);
II=imbinarize(II);
III=I;
for i=1:size(I,1)
for j=1:size(I,2)
    if II(i,j,1)==true && mod(I(i,j,1),2)==0
        III(i,j,1)=III(i,j,1)+1;
    end
    if II(i,j,1)==false && mod(I(i,j,1),2)==1
        III(i,j,1)=III(i,j,1)-1;
    end
end
end
end