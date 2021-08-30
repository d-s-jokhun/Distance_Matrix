%%% position_1.csv contains all the dots from cell 1 %%%
%%% provides distance matrix and also distance between each telomere and
%%% its closest to furthest neighbour%%%


clc;
clear all;


for c = 7:9:16   %%% csv files which have to be processed  %%%  
                    % c starts at 7 and ends at 16 with an increment of 9 (c = 7 and 16)
    
       distance = [];             
                    
    cell = strcat ('C2-Cell_0',num2str(c),'.csv')
    position = importdata(cell); % Imports the data from the csv file 'position.csv'
                                                                                       
position= str2double(position.textdata (1:end,1:3));
size1 = size (position) ;
size1 = size1 (1,1) ;
 
 for a=1:size1
   for  b=1:size1
     distance (1,b+1) =b ;
     distance (b+1,1) =b ;       
       
     distance (a+1,b+1) = sqrt(((position(a,1) - position(b,1))^2) + ((position(a,2) - position(b,2))^2) + ((position(a,3) - position(b,3))^2));
     
   end
 end
 
 filename = strcat ('distance_',cell);
 csvwrite (filename , distance);
 
 
 %%%Finding the closest neighbour of each telomere%%%
 dist = distance (2:end , 2:end);
 size_d = size (dist) ;
 size_d = size_d (1,1);
 for i = 1:size_d
     for j = 1:size_d
         if dist (i,j) == 0
             dist (i,j) = NaN ;  %distance of a telomere from itself will become NaN
         end
     end
 end
 sorted_dist = sort (dist);
 filename = strcat ('sorted_distance_',cell);
 sorted_dist = sorted_dist .';
 sorted_dist (:,end)=[]; % all the NaN would have moved to the last column
 csvwrite (filename , sorted_dist);
 
 
end