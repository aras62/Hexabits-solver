%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [pat point] = pattern_Rec_synth(I,point)
k=0;

%% place points of shape in order
while true
    [val loc] = min(point(k+1:6,1,:));
    loc1 = loc(:,:,1);
    loc1 = loc1 + k;
    dir1 = point(loc1,2,1) - point(loc1,2,2);
    pat = 0;
    if dir1 < 0
        startLoc = loc1;
        chk = 1;
        break;
    end
    k = loc1;
end
temp = point(startLoc,:,:);
point(startLoc,:,:) = point(1,:,:);
point(1,:,:) = temp;

for k = 2:5
    if chk == 1
        vx = point(k-1,1,2);
        vy = point(k-1,2,2);
    else
        vx = point(k-1,1,1);
        vy = point(k-1,2,1);
    end
    xrow = 0;
    zrow = 0;
    for i=k:6
        if abs(point(i,1,1)-vx) < 20
            xrow= cat(2,xrow,i);
            zrow= cat(2,zrow,1);
        end
        if abs(point(i,1,2)-vx) < 20
            xrow= cat(2,xrow,i);
            zrow= cat(2,zrow,2);
            
        end
    end
    num = numel(xrow);
    dif = zeros(num-1,3);
    for j = 1:num-1
        
        dif(j,1) = abs(point(xrow(j+1),2,zrow(j+1))- vy);
        dif(j,2) = xrow(j+1);
        dif(j,3) = zrow(j+1);
    end
    
    [junk minLoc] = min(dif(:,1));
    chk = dif(minLoc,3);
    minLoc = dif(minLoc,2);
    temp = point(minLoc,:,:);
    point(minLoc,:,:) = point(k,:,:);
    point(k,:,:) = temp;
end
pat = zeros(1,6);
n = 8;
nPixel = [n 0;0 -n;-n 0;-n 0;0 n;n 0];


for k = 1:6
    xmid =round( (point(k,1,1) - point(k,1,2))/2);
    ymid =round( (point(k,2,1) - point(k,2,2))/2);
    midPoint = point(k,:,1) - [xmid ymid];
    mp = midPoint + nPixel(k,:);
    col = impixel (I,mp(1),mp(2));
    if col(2) < 100
        pat(1,k) = 1;
    end
end
close all



