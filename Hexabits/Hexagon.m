%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% function grid
clear all
close all
global show_int_images
show_int_images = 0;
tier = 1;
dim = 2;
gridSize = 3*(dim^2)-3*dim +1;
gCord = zeros(8,2,gridSize);
generate = 1;
x = [0,0.5,1.5,2,1.5,0.5,0,1];
y = [0.866,0,0,0.866,1.732,1.732,0.866,0.866];
max_it = dim + (dim-1);
gen = 1;
tileSize = gridSize;

%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Generate Grid%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%
[gCord]= generateGrid(x,y,dim,gCord);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Generate Tiles%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[face]= generateTiles (x,y,dim,tileSize,generate);
recognition ('board.jpg');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate Edge map of Tiles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tileEdgeMap = edgeMap(face,tileSize,generate);
tileEdge = tileEdgeMap;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Calculate free edges of grid for rotation check
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[gId,gCord] = calculateDependency (dim,gridSize,gCord);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%______Search__________%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g = 1;
i = 1;
grid = zeros(gridSize,6);
gridCheck = zeros(gridSize,tileSize,2);
while g <= gridSize
    if g - 1 == 0
        while true
            
            if  numel(find(gridCheck(1,i,1) == 1)) == 0
                grid(g,:) = tileEdgeMap(i,:);
                gridCheck(g,i,1) = 1;
                i = 1;
                g = g+1;
                break
            elseif  gridCheck(g,i,2) < 5
                tileEdgeMap(i,:)= circshift(tileEdgeMap(i,:),[0 1]);
                gridCheck(g,i,2) = gridCheck(g,i,2) +1;
                grid(g,:) = tileEdgeMap(i,:);
                gridCheck(g,i,1) = 1;
                i = 1;
                g = g +1;
                
                break;
            else
                while i <= tileSize
                    if i >tileSize
                        break;
                    end
                    if numel(find(gridCheck(:,i,1) == 1)) == 0
                        break
                    else
                        i = i+1;
                    end
                end
                if i == tileSize
                    break;
                end
            end
        end
    else
        
        %%%%%%%%%%%% after first grid___%%%%%%%%%%%%%%%
        
        while true
            wrong = 0;
            if  numel(find(gridCheck(:,i,1) == 1)) == 0
                  while true
                    for j = 1:(numel(find(gId(g,:,1) ~= 0))) ;
                        a=  gId(g,j,3);
                        b=  gId(g,j,2);
                        if tileEdgeMap(i,gId(g,j,1)) ~= grid(a,b)
                            wrong = 1;
                            break;
                        else
                            wrong = 0;
                        end
                    end
                    if wrong == 1
                        tileEdgeMap(i,:) = circshift(tileEdgeMap(i,:),[0,1]);
                        gridCheck (g,i,2) = gridCheck (g,i,2)+1;
                        if gridCheck (g,i,2) > 5
                            
                            break;
                        end
                    else
                        break;
                    end
                end
                
            else
                wrong = 1;
            end
            if wrong == 1
                while i <= tileSize
                    i = i+1;
                    if i >tileSize
                        break;
                    end
                    if numel(find(gridCheck(:,i,1) == 1)) == 0
                        break
                    end
                end
                
            else
                grid(g,:) = tileEdgeMap(i,:);
                gridCheck(g,i,1) = 1;
                g = g+1;
                break;
            end
            if i >tileSize
                break;
            end
            
        end
    end
    %%second tier search
    
    if i > tileSize
        
        if tier == 1
            disp('Search Again');
            g = g-1;
            if g ~= 0
                while true
                    grid(g:gridSize,:) = 0;
                    lastTile = find(gridCheck(g,:,1) == 1, 1, 'last' );
                    if gridCheck(g,lastTile,2) < 5
                        disp('Search Last Spot');
                        gridCheck(g:gridSize,:,1) = 0;
                        tileEdgeMap(lastTile,:) = circshift(tileEdgeMap(lastTile,:),[0,1]);
                        gridCheck (g,lastTile,2) = gridCheck (g,lastTile,2)+1;
                        i = lastTile;
                        break;
                    else
                        i = lastTile +1;
                        gridCheck(g:gridSize,:,:) = 0;
                        grid(g:gridSize,:) = 0;
                        if i > tileSize
                            gridCheck(g:gridSize,:,:)=0;
                            g = g-1;
                            i = 1;
                            disp('One Spot Back');
                            
                        else
                            break;
                        end
                    end
                    if  g == 0
                        disp('No Solution');
                        break;
                    end
                end
            else
                disp('no solution');
                break;
                
            end
        else
            disp('no solution');
            break;
        end
    else
        i = 1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% Generate Solution%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generateSolution(gCord,gridCheck,face,dim,g,tileEdge,tileEdgeMap);
figure(10);
imshow('board.jpg');










