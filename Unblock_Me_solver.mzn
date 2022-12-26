% not done.
int: Size = 6;
int: totalSteps = 10;
enum sticks = {red,stick1,stick2,stick3,stick4,stick5};
enum direction = {vertical,horizontal};

array[sticks] of 1..Size:stick_x_start_pos = [1,2,3,4,5,6]; % left to right
array[sticks] of 1..Size:stick_y_start_pos = [1,2,3,4,5,6]; % top to bottom
array[sticks] of direction:stick_direction = [vertical,horizontal,vertical,horizontal,horizontal,horizontal];
array[sticks] of 2..Size:stick_size = [2,3,2,3,2,3];


array[1..totalSteps,sticks,1..6,1..6] of var -6..6:states;

% constraint for inside map
% constraint that two consecutive actions or state are legit. < function
% constraint last step red stick is on right position.
% minizme "indexof" red stick right position.

constraint forall(s1 in  sticks,s2 in sticks,step in 1..totalStep where s1 !=s2) (
);
