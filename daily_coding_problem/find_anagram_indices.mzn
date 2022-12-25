% "Find anagram indices" from the book "daily coding problem get exceptionally good at coding interviews by solving one problem every day".
enum Char = {Q,W,E,R,T,Y,U,I,O,P,A,S,D,F,G,H,J,K,L,Z,X,C,V,B,N,M};

array[int] of Char : s = [A,B,C,D,Q,F,B,A,C]; 

array[int] of Char : w = [A,B,C];

var set of 1..length(s)-length(w) + 1:indices;

function array[Char] of int: CountChars(array[int] of Char:window) = array1d(Char,[ count(window,x) | x in Char ]);




constraint forall (i in indices) (
CountChars(s[i..(i +length(w) -1) ]) == CountChars(w)
);

  
solve maximize card(indices);

string : wAsStr = join("", [ format(x) | x in w]);
string : sAsStr = join("", [ format(x) | x in s]);
output  [
"start indices of anagrams in string s = \(sAsStr) with the word w = \(wAsStr): \(indices)."

]
