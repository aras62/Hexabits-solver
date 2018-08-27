%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [gCord]= generateGrid(x,y,dim,gCord)
dx = x;
dy = y;
grow = dim;
count = (dim*2)-1;
row = 0;

for j = 1:count
    for i= 1 : grow
        row = row +1;
        xH = dx + ((x(2) - x(6))*(i-1));
        yH = dy + ((y(2) - y(6))*(i-1));
        if i == 1
            x = xH;
            y = yH;
        end
        figure(1);
        axis off
        axis square
        gCord(:,1,row) = xH;
        gCord(:,2,row) = yH;
        patch(xH,yH,[1 1 1],'Faces',1:7);
        
    end
    if j < dim
        grow = grow+1;
        dx = x + (x(5) - x(1));
        dy = y + (y(5) - y(1));
    else
        grow = grow-1;
        dx = x + (x(3) - x(1));
        dy = y + (y(3) - y(1));
    end
end
