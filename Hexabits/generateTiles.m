%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [face]= generateTiles (x,y,dim,tileSize,generate)
if generate == 1

    w = 1;
    f = patGen(x,y,w);
    face = f;
    w = w +1;
    
    for g = 1:tileSize - 1 
        while true
            f = patGen(x,y,w);
            check = 0;
            for k = 1:w-1
                tile =['Tiles/tile',num2str(k),'.bmp'];
                I1 = imread(tile);
                for l = 1: 6
                    hex = ['hexRot/hex',num2str(l),'.bmp'];
                    I2 = imread(hex);
                    if isequal(I1,I2)
                        disp('Match Found Regenerate');
                        check = 1;
                        break;
                    end
                end
                if check == 1
                    break;
                end
            end
            if check == 0
                break;
            end
        end
        w = w +1;
        face = cat(2,face,f);
    end
    
    for g = 1: tileSize
        start = g + (2*(g-1));
        board = figure(4);
        fc = face(:,start:start+2);
        subplot(dim,(round(tileSize/dim) + 1),g);
        axis off
        axis square
        patch(x ,y ,[1 1 1], 'Faces',1:7);
        patch(x ,y ,[1 1 1],'Faces',fc,'FaceColor','blue','EdgeColor','none');
    end
    file ='Board/board';
    saveas(board,file ,'jpg');
end