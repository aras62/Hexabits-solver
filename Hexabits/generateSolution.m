%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function generateSolution(gCord,gridCheck,face,dim,g,tileEdge,tileEdgeMap)
x = [0,0.255,0.815,1.070,0.815,0.255,0,0.5];
y = [0.5,0,0,0.5,1,1,0.5,0.5];
dx = x;
dy = y;
grow = dim;
count = (dim*2)-1;
row = 0;
check = [1 1 1];

for j = 1:count
    for i= 1 : grow
        row = row +1;
        xH = dx + ((x(2) - x(6))*(i-1));
        yH = dy + ((y(2) - y(6))*(i-1));
        if i == 1
            x = xH;
            y = yH;
        end
        figure(5);
        axis off
        axis square
        gCord(:,1,row) = xH;
        gCord(:,2,row) = yH;
        patch(xH,yH,[1 1 1],'Faces',1:7);
        
        if row <= g
            tileNum = find(gridCheck(row,:,1));
            offset = 1 +((tileNum-1)*3);
            for i = 0:5
                if tileEdge(tileNum,:) == tileEdgeMap(tileNum,:)
                    break;
                else
                    tileEdge(tileNum,:) = circshift(tileEdge(tileNum,:),[0,1]);
                end
            end
            if  i ~= 0  
                for k = 1: i 
                    for p= 1:size(face(:,1))
                        if ~isequal(face(p,offset:offset+2),check)
                            face(p,offset:offset+2) = face(p,offset:offset+2) + 1;
                        end
                        if face(p,offset) == 7
                            face(p,offset) = 1;
                        end
                        if face(p,offset+1) == 7
                            face(p,offset+1) = 1;
                        end
                        if face(p,offset+2) == 7
                            face(p,offset+2) = 1;
                        end
                        if face(p,offset+2) == 9
                            face(p,offset+2) = 8;
                        end
                    end
                end
            end
            
            patch(xH,yH,[1 1 1],'Faces',face(:,offset:offset+2),'FaceColor','blue','EdgeColor','none');
        end
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