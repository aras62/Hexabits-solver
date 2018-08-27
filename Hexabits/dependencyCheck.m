%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [wrong,gridCheck,tileEdgeMap] = dependencyCheck(gId,grid,tileEdgeMap,gridCheck,i,wrong,g)
while true
    for j = 1:(numel(find(gId(g,:,1) ~= 0))) ;
        a=  gId(g,j,3);
        b=  gId(g,j,2);
        if tileEdgeMap(i,gId(g,j,1)) ~= grid(a,b)
            wrong = 1;
            break;
        end
    end
    if wrong == 1 && gridCheck (g,i,2)< 5
        tileEdgeMap(i,:) = circshift(tileEdgeMap(i,:),[0,1]);
        gridCheck (g,i,2) = gridCheck (g,i,2)+1;
        wrong =0;
    else
        break;
    end
end