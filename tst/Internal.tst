gap> START_TEST("HyperCells: Internal.tst");

# Create sparse random matrix
gap> sparseRandomMat := function(n, m)
> 	local randMatDense, sparseMaskMat;
> 	randMatDense := RandomMat(n, m);
> 	sparseMaskMat := RandomMat(n, m, [0,1]);
> 	return List([1..n], i -> List([1..m], j -> randMatDense[i,j]*sparseMaskMat[i,j]));
> end;
function( n, m ) ... end

# 4x4 Matrices
gap> randMat11 := sparseRandomMat(4,4);;
gap> randMat12 := sparseRandomMat(4,4);;
gap> Mat1 := randMat11*randMat12;;

gap> randMat11s := toSparseMat@HyperCells(randMat11);;
gap> randMat12s := toSparseMat@HyperCells(randMat12);;
gap> Mat1s := sparseMatMultiply@HyperCells(randMat11s,randMat12s, [4,4]);;

# test whether sparseMatMultiply@ works properly
gap> Mat1 = toDenseMat@HyperCells(Mat1s, [4,4]);
true


# 6x6 Matrices
gap> randMat11 := sparseRandomMat(6,6);;
gap> randMat12 := sparseRandomMat(6,6);;
gap> Mat1 := randMat11*randMat12;;

gap> randMat11s := toSparseMat@HyperCells(randMat11);;
gap> randMat12s := toSparseMat@HyperCells(randMat12);;
gap> Mat1s := sparseMatMultiply@HyperCells(randMat11s,randMat12s, [6,6]);;

# test whether sparseMatMultiply@ works properly
gap> Mat1 = toDenseMat@HyperCells(Mat1s, [6,6]);
true


# 40x40 Matrices
gap> randMat11 := sparseRandomMat(40,40);;
gap> randMat12 := sparseRandomMat(40,40);;
gap> Mat1 := randMat11*randMat12;;

gap> randMat11s := toSparseMat@HyperCells(randMat11);;
gap> randMat12s := toSparseMat@HyperCells(randMat12);;
gap> Mat1s := sparseMatMultiply@HyperCells(randMat11s,randMat12s, [40,40]);;

# test whether sparseMatMultiply@ works properly
gap> Mat1 = toDenseMat@HyperCells(Mat1s, [40,40]);
true

# 202x202 Matrices
gap> randMat11 := sparseRandomMat(202,202);;
gap> randMat12 := sparseRandomMat(202,202);;
gap> Mat1 := randMat11*randMat12;;

gap> randMat11s := toSparseMat@HyperCells(randMat11);;
gap> randMat12s := toSparseMat@HyperCells(randMat12);;
gap> Mat1s := sparseMatMultiply@HyperCells(randMat11s,randMat12s, [202,202]);;

# test whether sparseMatMultiply@ works properly
gap> Mat1 = toDenseMat@HyperCells(Mat1s, [202,202]);
true

gap> STOP_TEST("TGCell.tst");