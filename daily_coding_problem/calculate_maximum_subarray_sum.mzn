% "Calculate maximum subarray sum" from the book "daily coding problem get exceptionally good at coding interviews by solving one problem every day".

array[int] of int: data = [34, -50, 42, 14, -5, 86];

var 1..length(data) :i;
var 1..length(data) :j;
constraint i <= j;

var int: CONTINUOUS_SUM = sum(x in i..j) (data[x]);
solve maximize CONTINUOUS_SUM;

output  ["i=\(i), j =\(j) CONTINUOUS_SUM=\(CONTINUOUS_SUM) "]

