%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function  recognition (file)
Total = count(file);
global show_int_images
close all
i=1;
% Upload Image
for l=1:Total
    obj = ['Cropped_tiles/ct',num2str(l),'.jpg'];
    I= imread(obj);
    I = imresize(I, 0.2);%2 for the mixed image, 0.4 for regular board
    %Convert Image to grayscale
    Ig = rgb2gray(I);
    %Calculate threshold
    t = graythresh(Ig);
    %Convert to Binary
    Ib = im2bw(Ig, t);
    %Complement Image Binary
    Ic = imcomplement(Ib);
    %Fill The Entire area inside shape
    Icf= bwmorph(Ic,'dilate',3);
    Icf = imfill(Icf,'holes');
    a = regionprops(Icf,'area');
    dist= sqrt((2*a.Area)/(sqrt(3)));
    Icf= bwmorph(Icf,'endpoints');
    if show_int_images
    axis off
    axis equal
    figure(1)
    imshow(Icf)
    end
    [H t r] = hough(Icf);
    peaks = houghpeaks(H,6);
    point = zeros(6,2,2);
    lines= houghlines(Icf,t,r,peaks,'MinLength',3);
    for k = 1:length(lines)
        point(k,:,1) = lines(k).point1;
        point(k,:,2) = lines(k).point2;
        xy = [lines(k).point1; lines(k).point2];
        plot(xy(:,1),xy(:,2),'-rs','LineWidth',2,'Color','r','MarkerEdgeColor','k','MarkerFaceColor','g','MarkerSize',10)%,'Tag','line'
    end
    d = zeros(5);
    for k= 2:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        d(k-1) =  Dist(lines(1).point1, lines(1).point2,lines(k).point1, lines(k).point2);
    end
    shape = 0;
    dmax = max(max(d));
    if abs(dmax - dist) < 4
        disp('Hexagon');
        shape = 1;
    else
        disp('Wrong Shape');
    end
    
    if shape == 1
        [pat(2:7,i) point] = pattern_Rec_synth(I,point);
        pat(1,i) = l;%to change if dont need to include the not relevant objects
        fprintf('Tile Patern %d...\n\t',l);
        i= i+1;
    end
end

end














