%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% A Visual solver for The Hexabits Puzzle  %%%%%
%%%%%                                          %%%%%
%%%%%    Author: Amir Rasouli                  %%%%%
%%%%%    Date: April 2013                      %%%%%
%%%%%                                          %%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function  fSet=patGen(x,y,w)
 verNum = 7;
 sizeF = 0;

 check = [1 1 1];
 for j=1: (verNum-2)
 for i = 1: (verNum-(2+(j-1)))
     sizeF = sizeF+i;
 end
 end
  fSet = ones(sizeF,3);
 f = [1 2 3;1 2 4;1 2 5; 1 2 6; 1 2 8;1 3 4; 1 3 5;1 3 6 ; 1 3 8; 1 4 5; 1 4 6; 1 4 8;...
     1 5 6; 1 5 8; 1 6 8; 2 3 4; 2 3 5; 2 3 6; 2 3 8;2 4 5; 2 4 6; 2 4 8; 2 5 6; 2 5 8 ; 2 6 8;...
     3 4 5; 3 4 6; 3 4 8;3 5 6; 3 5 8; 3 6 8; 4 5 6; 4 5 8; 4 6 8; 5 6 8];


 for k = 1:sizeF
   if randi(8,1) == 1
       if f(k,1) ~= f(k,2) + 3 && f(k,3)~= 8 
        fSet(k,:) = f(k,:);
       end
   end
 end
fCheck = fSet;
axis off
axis equal
for i = 1: 6
  for j= 1:sizeF
      if ~isequal(fCheck(j,:),check)
         fCheck(j,:) = fCheck(j,:) + 1;
        if fCheck(j,1) == 7
            fCheck(j,1) = 1;
        end
      if fCheck(j,2) == 7
            fCheck(j,2) = 1;
      end
      if fCheck(j,3) == 7
            fCheck(j,3) = 1;
      end
        if fCheck(j,3) == 9
            fCheck(j,3) = 8;
        end
      end
  end
  d = figure(2);
  axis off
  axis equal
  patch(x,y,[1 1 1], 'Faces',1:7);
  patch(x,y,[1 1 1],'Faces',fCheck,'FaceColor','blue','EdgeColor','none');
  file = ['hexRot/hex',num2str(i)];
  saveas(d,file ,'bmp');
  close(d);
end
 h = figure(3);
 axis off
 axis equal
 file1 = ['Tiles/tile',num2str(w)];
 patch(x,y,[1 1 1], 'Faces',1:7,'EdgeColor','black'); 
 patch(x,y,[1 1 1],'Faces',fSet,'FaceColor','blue','EdgeColor','none');
 saveas(h,file1 ,'bmp');
 close(h);
 
 
