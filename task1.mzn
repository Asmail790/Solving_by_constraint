include "at_most.mzn";

/*
Problem statement:
Given a Integer N with four digits and Integer K. Return the maxium possible number that can obatined 
by performing at most K increase by one of any of the digits in N.

For example N=6855 and K=7 the maxium possible number is 9985.
The first digit  N[0]=6 is increased by 3.
The second digit N[1]=8 is increased by 1.
The third digit  N[2]=5 is increased by 3.
The fourth digit N[3]=5 is increased by	 0.

A MiniZinc  solution.
*/

int: K = 7;


int: N0 = 6; % =  N[0]
int: N1 = 8; % =  N[1]
int: N2 = 5; % =  N[2]
int: N3 = 5; % =  N[3]

% orginal number
int: ORG_NBR = N0*1000 + N1*100 +N2*10 +N3*1;


% KS repsents the counts.

set of int: KS = 0..K-1;

% LENGTH repsents the digts indices.
set of int: LENGTH = 0..3;

/*
A matrix where row repsents a digit and column repsents a "increase by one" operation.  
A "increase by one" operation increases a digit by one. 
Example:
with N=6855 and K=7 the maxium possible number is 9985. 
We see that: 
The first digit N[0]=6 have used three "increase by one" to become 9. 
The second digit N[1]=8 have used one "increase by one" to become 9. 
The third digit N[2]=5 is have used three  "increase by one" to become 8. 
The fourth digit N[2]=5 is have used zero  "increase by one". 
This can be represented by a matrix: 

[
[1,1,1,0,0,0,0],
[0,0,0,1,0,0,0],
[0,0,0,0,1,1,1],
[0,0,0,0,0,0,0]
]

Since K=7, 7 "increase by one" operation is possible to spend and hence 7 columns on the digits of N. 
Since the orginal number (allways) consist of 4 digits and each row repsents a digit,four row is used. 

A entry with value 1 at row = i and col = j indicate that the j:th "increase by one" operation is spended on digit N[i].
A entry with value 0 at row = i and col = j indicate that the j:th "increase by one" operation is not spended on digit N[i].

Interpreting the matrix:
> The entries at (0,0),(0,1),(0,2) indicate the first,second and third "increase by one" operations are spended by the first digit (N[0]=6).
> The entries at (0,3),(0,4),(0,5),(0,6) indicate the fourth,fith,sixth and seventh "increase by one" are not spended by the first digit (N[0]=6).
> The entry at (1,3) indicate the fourth "increase by one" is used by the second digit (N[1]=8).
> The entry at (1,0),(1,1),(1,2),(1,4),(1,5),(1,6) indicate the first,second,third,fith,sixth and seventh "increase by one" are not spended by the second digit (N[1]=8).

A "increase by one" operation can only be spended by one digt at most. 
This modeled by at_most predicate: In one column at most one row can take the value 1. 

*/
array[LENGTH,KS] of var int:t;


constraint forall(i in LENGTH,j in KS)(0 <= t[i,j] /\  t[i,j] <= 1);


constraint N0 +     sum(t[0,KS]) <= 9;
constraint N1 +     sum(t[1,KS]) <= 9;
constraint N2 +     sum(t[2,KS]) <= 9;
constraint N3 +     sum(t[3,KS]) <= 9;


% at_most constraint is deprecated !!.  
/*
A "increase by one" operation can only be used by one digt at most. 
This modeled by at_most predicate: In one column at most one row can take the value 1. 
*/
int: count = 1;
int: value = 1;
constraint forall(j in KS) (at_most(count,t[LENGTH,j],value));

% Maxium possible number that can obatined afther performing at most K increase by one of any of the digits in N.
var int: MAX_NBR = (N0 + sum(t[0,KS]))*1000 + (N1 +sum(t[1,KS]))*100 + (N2 +  sum(t[2,KS]))*10 + (N3 +  sum(t[3,KS])) ;


solve maximize MAX_NBR;

output  ["N=\(ORG_NBR), K =\(K)",
"\n",     "MAX_NBR[0] =  N[0] + \(sum(t[0,KS])) = \(N0) + \(sum(t[0,KS])) = \(N0 + sum(t[0,KS]))", 
"\n",     "MAX_NBR[1] = N[1] + \(sum(t[1,KS])) = \(N1) + \(sum(t[1,KS])) = \(N1 + sum(t[1,KS]))",
"\n",     "MAX_NBR[2] = N[2] + \(sum(t[2,KS])) = \(N2) + \(sum(t[2,KS])) = \(N2 + sum(t[2,KS]))",
"\n",     "MAX_NBR[3] = N[3] + \(sum(t[3,KS])) = \(N3) + \(sum(t[3,KS])) = \(N3 + sum(t[3,KS]))",
"\n", "The maxium possible number afther the increases is MAX_NBR=\(MAX_NBR)"];


