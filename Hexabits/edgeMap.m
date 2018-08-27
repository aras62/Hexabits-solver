%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate Edge map of Tiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function tileEdgeMap =edgeMap(face,tileSize,generate)
if generate == 1
tileEdgeMap = zeros(tileSize,6);
    for w = 1:tileSize
         offset = w + (2*(w-1));
        for u = 1:35
            if face(u,offset) == face(u,offset+1) - 1
            tileEdgeMap (w,face(u,offset)) = 1;
            end
            if face(u,3) ~= 8
                if face(u,offset+1) == face(u,offset+2) -1
                tileEdgeMap (w,face(u,offset+1)) = 1;
                end 
                if face(u,offset+2) == face(u,offset) + 5
                tileEdgeMap (w,face(u,offset+2)) = 1;
                end
            end
        end
    end
end