function Total = count(file)
close all
Ac=imread(file);
A=rgb2gray(Ac);
figure,imshow(A); title('Original Image');
%Convert the Image to binary
B=im2bw(A);
B=~B;
figure (3);
imshow(B);
%Fill the holes
B= bwmorph(B,'dilate',3);
C=imfill(B,'holes');
figure (4);
imshow(C);
%Label the connected components
[Label,Total]=bwlabel(C,8);
figure,imshow(C); title('Labelled Image');
%Rectangle containing the region
Sdata=regionprops(Label,'BoundingBox');

%Crop all objects
for i=1:Total
    Img=imcrop(Ac,Sdata(i).BoundingBox);
    d = figure;
    imshow(Img); %title(Name);
    file = ['Cropped_tiles/ct',num2str(i)];
    saveas(d,file ,'jpg');
end
