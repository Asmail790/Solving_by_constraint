% from https://sandiway.arizona.edu/sudoku/examples.html
include "all_different.mzn";
int:Size = 9;
array[1..Size,1..Size] of 0..9:incompleteBoard = 
[|
 0,2,0,0,0,0,0,0,0
|0,0,0,6,0,0,0,0,3
|0,7,4,0,8,0,0,0,0
|0,0,0,0,0,3,0,0,2
|0,8,0,0,4,0,0,1,0
|6,0,0,5,0,0,0,0,0
|0,0,0,0,1,0,7,8,0
|5,0,0,0,0,9,0,0,0
|0,0,0,0,0,0,0,4,0
|];


array[1..Size,1..Size] of var 1..9:completeBoard;

constraint forall(row in 1..Size,col in 1..Size) ( if incompleteBoard[row,col] >= 1 then incompleteBoard[row,col] == completeBoard[row,col] endif );
constraint forall(row in 1..Size) (all_different(completeBoard[row,1..Size]));
constraint forall(col in 1..Size) (all_different(completeBoard[1..Size,col]));

solve satisfy;

output [join("\n",([ join(",",[format(completeBoard[row,col] )| col in 1..Size]) |row in 1..Size ]))];


