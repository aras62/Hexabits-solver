%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate free edges of grid for rotation check
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [gId,gCord] = calculateDependency(dim,gridSize,gCord)
grow = dim;
count = (dim*2)-1;
gId = zeros(gridSize,3,4); 
num =0;
for i = 1:count
    for j=1: grow
        num = num +1;
        if j ~= grow && i < dim
            gId(num,:,4) = [2 3 4];
        elseif j == grow && i < dim
            gId(num,:,4) = [3 4 0];
        end
        if j == 1 && dim <= i && i < count
            gId(num,:,4) = [2 3 0];
        elseif j ~= grow && dim <= i< count
            gId(num,:,4) = [2 3 4];
        end
        if i == count && j ~=grow
            gId(num,:,4) = [2 0 0];
        end
        if i >= dim && i ~= count && j == grow
            gId(num,:,4)=[4 0 0];
        end
    end
    if i < dim
        grow = grow +1;
    else
        grow = grow -1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Train the whole system to find dependencies
%% if start from top
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gCord = gCord *1000;
gCord = int16(gCord);
gCord = double(gCord);
gCord = gCord/1000;
for w = 1:  gridSize
    c = 0;
    for i=1:dim+(dim-1)
        check =0;
        if w-i ==0
            break;
        end
        for j= 6 :-1:1
            for k=1:6
                if isequal(gCord(j,:,(w-i)),gCord(k,:,w))
                    c = c+1;
                    gId(w,c,1)=k;
                    gId(w,c,2)=j-1;
                    gId(w,c,3)=w-i;
                    check = 1;
                    break;
                end
            end
            if check ==1 || c>3
                break;
            end
        end
    end
end