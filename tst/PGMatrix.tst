gap> START_TEST("HyperCells: PGMatrix.tst");


# Define needed functions:
# ------------------------

# This should only be used internally for this test file !!!
gap> syntacticEqualPGMatricesOfGeneratorsObjs@ := function(pgMatsGs1, pgMatsGs2)
>       return  Signature(GetTriangleGroup(pgMatsGs1)) = Signature(GetTriangleGroup(pgMatsGs2)) and
>               Signature(GetProperTriangleGroup(pgMatsGs1)) = Signature(GetProperTriangleGroup(pgMatsGs2)) and
>               GetTGQuotient(pgMatsGs1) = GetTGQuotient(pgMatsGs2) and
>               PGMatricesRec(pgMatsGs1) = PGMatricesRec(pgMatsGs2);
> end;;

# This should only be used internally for this test file !!!
gap> syntacticEqualPGMatricesObjs@ := function(pgMats1, pgMats2)
>       return  syntacticEqualPGMatricesOfGeneratorsObjs@(GetPGMatricesOfGenerators(pgMats1), GetPGMatricesOfGenerators(pgMats2)) and
>               SymmetryNames(pgMats1) = SymmetryNames(pgMats2) and
>               PGMatricesRec(pgMats1) = PGMatricesRec(pgMats2);
> end;;

# Start tests:
# ------------

# Triangle group (2,8,8)
gap> fulltg := TriangleGroup( [ 2, 8, 8 ] );;
gap> tg := ProperTriangleGroup( [ 2, 8, 8 ] );;
gap> qpc := TGQuotient( 1, [ 2, 8, 8 ] );;

# FpGroups and symmetry elements
gap> D := FpGroup(tg);;
gap> DELTA := FpGroup(fulltg);;
gap> symmetries := [DELTA.1, DELTA.2, DELTA.3, D.1, D.2, D.3];;
gap> symNames := ["A", "B", "C", "X", "Y", "Z"];;

gap> pgMatGs := PGMatricesOfGenerators(fulltg, tg, qpc);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, \
Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a", "b", "c" \
], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [ [ 0, -1, 0,\
 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0\
, 0, -1, 0 ] ] ))

gap> Signature(pgMatGs);
[ 2, 8, 8 ]
gap> GetTriangleGroup(pgMatGs);
TriangleGroup(2, 8, 8)
gap> GetProperTriangleGroup(pgMatGs);
ProperTriangleGroup(2, 8, 8)
gap> TGQuotientName(pgMatGs);
[ 2, 6 ]
gap> GetTGQuotient(pgMatGs);
TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ])
gap> IsSparse(pgMatGs);
false
gap> PGMatricesRec(pgMatGs);
rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ],
  b := [ [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ],
  c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0, 0, -1, 0 ] ] )


# Test single symmetry
gap> pgMat := PGMatrices(symmetries[1], pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a\
", "b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [\
 [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, \
0, -1 ], [ 0, 0, -1, 0 ] ] )), symmetryNames = [ "a" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ \
-1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ] ))
gap> pgMat := PGMatrices(symmetries[1], pgMatGs : symNames := symNames[1]);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a\
", "b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [\
 [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, \
0, -1 ], [ 0, 0, -1, 0 ] ] )), symmetryNames = [ "A" ], pgMatricesRec = rec( A := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ \
-1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ] ))

# Test list of symmetries
gap> pgMat := PGMatrices(symmetries, pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a\
", "b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [\
 [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, \
0, -1 ], [ 0, 0, -1, 0 ] ] )), symmetryNames = [ "a", "b", "c", "x", "y", "z" ], pgMatricesRec = rec( a := [ [ 0, 1, 0\
, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [ [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [\
 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0, 0, -1, 0 ] ], x := [ [ -1, 0, 0, 0 ], \
[ 0, -1, 0, 0 ], [ 0, 0, -1, 0 ], [ 0, 0, 0, -1 ] ], y := [ [ -1, -1, -1, -1 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 0\
, 1, 0 ] ], z := [ [ 0, -1, 0, 0 ], [ 0, 0, -1, 1 ], [ 0, 0, 0, -1 ], [ 1, 1, 1, 0 ] ] ))
gap> pgMat := PGMatrices(symmetries, pgMatGs : symNames := symNames);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a\
", "b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [\
 [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, \
0, -1 ], [ 0, 0, -1, 0 ] ] )), symmetryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatricesRec = rec( A := [ [ 0, 1, 0\
, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], B := [ [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [\
 0, 0, 0, -1 ] ], C := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0, 0, -1, 0 ] ], X := [ [ -1, 0, 0, 0 ], \
[ 0, -1, 0, 0 ], [ 0, 0, -1, 0 ], [ 0, 0, 0, -1 ] ], Y := [ [ -1, -1, -1, -1 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 0\
, 1, 0 ] ], Z := [ [ 0, -1, 0, 0 ], [ 0, 0, -1, 1 ], [ 0, 0, 0, -1 ], [ 1, 1, 1, 0 ] ] ))
gap> GetPGMatricesOfGenerators(pgMat);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, \
Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = false, generatorNames = [ "a", "b", "c" \
], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ], b := [ [ 0, -1, 0,\
 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ], c := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0\
, 0, -1, 0 ] ] ))
gap> PGMatricesRec(pgMat);
rec( A := [ [ 0, 1, 0, 0 ], [ 1, 0, 0, 0 ], [ -1, -1, -1, 0 ], [ 0, 0, 0, 1 ] ],
  B := [ [ 0, -1, 0, 0 ], [ -1, 0, 0, 0 ], [ 1, 1, 1, 0 ], [ 0, 0, 0, -1 ] ],
  C := [ [ -1, 0, 0, 0 ], [ 1, 1, 1, 1 ], [ 0, 0, 0, -1 ], [ 0, 0, -1, 0 ] ],
  X := [ [ -1, 0, 0, 0 ], [ 0, -1, 0, 0 ], [ 0, 0, -1, 0 ], [ 0, 0, 0, -1 ] ],
  Y := [ [ -1, -1, -1, -1 ], [ 1, 0, 0, 0 ], [ 0, 1, 1, 0 ], [ 0, 0, 1, 0 ] ],
  Z := [ [ 0, -1, 0, 0 ], [ 0, 0, -1, 1 ], [ 0, 0, 0, -1 ], [ 1, 1, 1, 0 ] ] )


# sparse
gap> pgMatGs := PGMatricesOfGenerators(fulltg, tg, qpc : sparse := true);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, \
Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a", "b", "c" ]\
, pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], \
[ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4\
, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ]\
, -1 ], [ [ 4, 3 ], -1 ] ] ))

gap> Signature(pgMatGs);
[ 2, 8, 8 ]
gap> GetTriangleGroup(pgMatGs);
TriangleGroup(2, 8, 8)
gap> GetProperTriangleGroup(pgMatGs);
ProperTriangleGroup(2, 8, 8)
gap> TGQuotientName(pgMatGs);
[ 2, 6 ]
gap> GetTGQuotient(pgMatGs);
TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ])
gap> IsSparse(pgMatGs);
true
gap> PGMatricesRec(pgMatGs);
rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ],
  b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ],
  c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ],
      [ [ 4, 3 ], -1 ] ] )

gap> # Test single symmetry
gap> pgMat := PGMatrices(symmetries[1], pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a"\
, "b", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3,\
 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ]\
, 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ]\
, [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ] )), symmetryNames = [ "a" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2\
, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ] ))
gap> pgMat := PGMatrices(symmetries[1], pgMatGs : symNames := symNames[1]);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a"\
, "b", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3,\
 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ]\
, 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ]\
, [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ] )), symmetryNames = [ "A" ], pgMatricesRec = rec( A := [ [ [ 1, 2 ], 1 ], [ [ 2\
, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ] ))

gap> # Test list of symmetries
gap> pgMat := PGMatrices(symmetries, pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a"\
, "b", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3,\
 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ]\
, 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ]\
, [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ] )), symmetryNames = [ "a", "b", "c", "x", "y", "z" ], pgMatricesRec = rec( a :=\
 [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [\
 [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1\
, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ],\
 x := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ] ], \
y := [ [ [ 1, 1 ], -1 ], [ [ 1, 2 ], -1 ], [ [ 1, 3 ], -1 ], [ [ 1, 4 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], 1 ], [ [ 3\
, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], 1 ] ], z := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 2, 2 \
], -1 ], [ [ 2, 3 ], -1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 1 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 4, 3 ], 1 ] ] ))
gap> pgMat := PGMatrices(symmetries, pgMatGs : symNames := symNames);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a"\
, "b", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3,\
 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ]\
, 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ]\
, [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ] )), symmetryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatricesRec = rec( A :=\
 [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ], B := [ [\
 [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ], C := [ [ [ 1\
, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ],\
 X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ] ], \
Y := [ [ [ 1, 1 ], -1 ], [ [ 1, 2 ], -1 ], [ [ 1, 3 ], -1 ], [ [ 1, 4 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], 1 ], [ [ 3\
, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], 1 ] ], Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 2, 2 \
], -1 ], [ [ 2, 3 ], -1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 1 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 4, 3 ], 1 ] ] ))
gap> GetPGMatricesOfGenerators(pgMat);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8, 8 ], 8, 2, \
Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a", "b", "c" ]\
, pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], \
[ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4\
, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ]\
, -1 ], [ [ 4, 3 ], -1 ] ] ))
gap> PGMatricesRec(pgMat);
rec( A := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ],
  B := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ],
  C := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ],
      [ [ 4, 3 ], -1 ] ], X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ],
      [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ] ],
  Y := [ [ [ 1, 1 ], -1 ], [ [ 1, 2 ], -1 ], [ [ 1, 3 ], -1 ], [ [ 1, 4 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], 1 ],
      [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], 1 ] ],
  Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ],
      [ [ 4, 1 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 4, 3 ], 1 ] ] )


# Test export and import
gap> str := "";;
gap> output := OutputTextString(str, false);;
gap> Export(pgMat, output);;
gap> CloseStream(output);;
gap> Print(str);
HyperCells HCPGM version 1.0
[ 2, 8, 8 ]
[ [ 2, 6 ], 8, 2, "Action reflexible [m,n]", "[ x^2, x * y * z, x * z * y, y^3 * z^-1 ]" ]
true
[ [ "a", [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ] ]\
, [ "b", [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ] ]\
, [ "c", [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [\
 4, 3 ], -1 ] ] ] ]
[ [ "A", [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ] ]\
, [ "B", [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ] ]\
, [ "C", [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [\
 4, 3 ], -1 ] ] ], [ "X", [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], \
[ [ 4, 4 ], -1 ] ] ], [ "Y", [ [ [ 1, 1 ], -1 ], [ [ 1, 2 ], -1 ], [ [ 1, 3 ], -1 ], [ [ 1, 4 ], -1 ], [ [ 2, 1 ], 1 ]\
, [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], 1 ] ] ], [ "Z", [ [ [ 1, 2 ], -1 ],\
 [ [ 2, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 1 ], 1 ], [ [ 4, 2 ],\
 1 ], [ [ 4, 3 ], 1 ] ] ] ]

gap> input := InputTextString(str);;
gap> pgMat2 := ImportPGMatrices(input);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 2, 6 ], [ 2, 8,\
 8 ], 8, 2, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^3 * z^-1 ]), sparse = true, generatorNames = [ "a"\
, "b", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3,\
 3 ], -1 ], [ [ 4, 4 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ]\
, 1 ], [ [ 4, 4 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ]\
, [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ] )), symmetryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatricesRec = rec( A :=\
 [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], 1 ] ], B := [ [\
 [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 1 ], 1 ], [ [ 3, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 4, 4 ], -1 ] ], C := [ [ [ 1\
, 1 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 2, 2 ], 1 ], [ [ 2, 3 ], 1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ] ],\
 X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ] ], \
Y := [ [ [ 1, 1 ], -1 ], [ [ 1, 2 ], -1 ], [ [ 1, 3 ], -1 ], [ [ 1, 4 ], -1 ], [ [ 2, 1 ], 1 ], [ [ 3, 1 ], 1 ], [ [ 3\
, 2 ], 1 ], [ [ 3, 3 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], 1 ] ], Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 2, 2 \
], -1 ], [ [ 2, 3 ], -1 ], [ [ 2, 4 ], 1 ], [ [ 3, 4 ], -1 ], [ [ 4, 1 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 4, 3 ], 1 ] ] ))
gap> pgMat2 = pgMat;
false
gap> syntacticEqualPGMatricesObjs@(pgMat2, pgMat);
true



# Test on supercell
gap> qsc := TGQuotient( [3, 11] );;

gap> pgMatGs := PGMatricesOfGenerators(fulltg, tg, qsc);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3\
, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "b", "c" ], p\
gMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0\
, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ],\
 [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0\
, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] ))

gap> Signature(pgMatGs);
[ 2, 8, 8 ]
gap> GetTriangleGroup(pgMatGs);
TriangleGroup(2, 8, 8)
gap> GetProperTriangleGroup(pgMatGs);
ProperTriangleGroup(2, 8, 8)
gap> TGQuotientName(pgMatGs);
[ 3, 11 ]
gap> GetTGQuotient(pgMatGs);
TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ])
gap> IsSparse(pgMatGs);
false
gap> PGMatricesRec(pgMatGs);
rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ],
  b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ],
  c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ],
      [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] )

# Test single symmetry
gap> pgMat := PGMatrices(symmetries[1], pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "\
b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0,\
 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0,\
 -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0,\
 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] )), sym\
metryNames = [ "a" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ \
0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ] ))
gap> pgMat := PGMatrices(symmetries[1], pgMatGs : symNames := symNames[1]);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "\
b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0,\
 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0,\
 -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0,\
 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] )), sym\
metryNames = [ "A" ], pgMatricesRec = rec( A := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ \
0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ] ))


# Test list of symmetries
gap> pgMat := PGMatrices(symmetries, pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "\
b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0,\
 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0,\
 -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0,\
 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] )), sym\
metryNames = [ "a", "b", "c", "x", "y", "z" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ],\
 [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 \
], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ]\
, c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0,\
 0 ], [ 0, 1, 1, 0, 0, 1 ] ], x := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, -\
1, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, 0, 0, -1 ] ], y := [ [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, \
0, 0, 1, 0 ], [ 0, 1, 0, 0, 0, 0 ], [ 0, -1, -1, 0, 0, -1 ], [ 0, 0, 0, 1, 0, 0 ] ], z := [ [ 0, -1, 0, 0, 0, 0 ], [ 0\
, 0, 0, -1, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, -1, 0, 0, 0 ], [ 1, 0, 0, 1, 1, 0 ] ] ))
gap> pgMat := PGMatrices(symmetries, pgMatGs : symNames := symNames);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "\
b", "c" ], pgMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0,\
 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0,\
 -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0,\
 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] )), sym\
metryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatricesRec = rec( A := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ],\
 [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], B := [ [ 0, -1, 0, 0, 0, 0 \
], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ]\
, C := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0,\
 0 ], [ 0, 1, 1, 0, 0, 1 ] ], X := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, -\
1, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, 0, 0, -1 ] ], Y := [ [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, \
0, 0, 1, 0 ], [ 0, 1, 0, 0, 0, 0 ], [ 0, -1, -1, 0, 0, -1 ], [ 0, 0, 0, 1, 0, 0 ] ], Z := [ [ 0, -1, 0, 0, 0, 0 ], [ 0\
, 0, 0, -1, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, -1, 0, 0, 0 ], [ 1, 0, 0, 1, 1, 0 ] ] ))
gap> GetPGMatricesOfGenerators(pgMat);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3\
, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = false, generatorNames = [ "a", "b", "c" ], p\
gMatricesRec = rec( a := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ], [ 0\
, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ], b := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ],\
 [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ], c := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0\
, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ] ))
gap> PGMatricesRec(pgMat);
rec( A := [ [ 0, 1, 0, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 1, 0, 0 ], [ 0, 0, 1, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, 1 ], [ 0, 0, 0, 0, 1, 0 ] ],
  B := [ [ 0, -1, 0, 0, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ],
      [ 0, 0, 0, 0, 0, -1 ], [ 0, 0, 0, 0, -1, 0 ] ],
  C := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, 0, -1, 0 ],
      [ 0, 0, 0, -1, 0, 0 ], [ 0, 1, 1, 0, 0, 1 ] ],
  X := [ [ -1, 0, 0, 0, 0, 0 ], [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, -1, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ],
      [ 0, 0, 0, 0, -1, 0 ], [ 0, 0, 0, 0, 0, -1 ] ],
  Y := [ [ 0, 0, 1, 0, 0, 0 ], [ 1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 1, 0 ], [ 0, 1, 0, 0, 0, 0 ],
      [ 0, -1, -1, 0, 0, -1 ], [ 0, 0, 0, 1, 0, 0 ] ],
  Z := [ [ 0, -1, 0, 0, 0, 0 ], [ 0, 0, 0, -1, 0, 0 ], [ -1, 0, 0, 0, 0, 0 ], [ 0, 0, 0, 0, 0, -1 ],
      [ 0, 0, -1, 0, 0, 0 ], [ 1, 0, 0, 1, 1, 0 ] ] )


# sparse
gap> pgMatGs := PGMatricesOfGenerators(fulltg, tg, qsc : sparse := true);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3\
, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b", "c" ], pg\
MatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, \
5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 \
], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ]\
, 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] ))

gap> Signature(pgMatGs);
[ 2, 8, 8 ]
gap> GetTriangleGroup(pgMatGs);
TriangleGroup(2, 8, 8)
gap> GetProperTriangleGroup(pgMatGs);
ProperTriangleGroup(2, 8, 8)
gap> TGQuotientName(pgMatGs);
[ 3, 11 ]
gap> GetTGQuotient(pgMatGs);
TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ])
gap> IsSparse(pgMatGs);
true
gap> PGMatricesRec(pgMatGs);
rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ],
  b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] ],
  c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ],
      [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )


# Test single symmetry
gap> pgMat := PGMatrices(symmetries[1], pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b\
", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], \
1 ], [ [ 6, 5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 \
], [ [ 6, 5 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ]\
, [ [ 6, 2 ], 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )), symmetryNames = [ "a" ], pgMatricesRec = rec( a := [ [ [ 1, \
2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ] ))
gap> pgMat := PGMatrices(symmetries[1], pgMatGs : symNames := symNames[1]);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b\
", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], \
1 ], [ [ 6, 5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 \
], [ [ 6, 5 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ]\
, [ [ 6, 2 ], 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )), symmetryNames = [ "A" ], pgMatricesRec = rec( A := [ [ [ 1, \
2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ] ))

# Test list of symmetries
gap> pgMat := PGMatrices(symmetries, pgMatGs);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b\
", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], \
1 ], [ [ 6, 5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 \
], [ [ 6, 5 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ]\
, [ [ 6, 2 ], 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )), symmetryNames = [ "a", "b", "c", "x", "y", "z" ], pgMatrices\
Rec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ]\
 ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] \
], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ], [\
 [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ], x := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ], [ [ \
5, 5 ], -1 ], [ [ 6, 6 ], -1 ] ], y := [ [ [ 1, 3 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 5 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 5, 2 \
], -1 ], [ [ 5, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 4 ], 1 ] ], z := [ [ [ 1, 2 ], -1 ], [ [ 2, 4 ], -1 ], [ [ 3, 1 ],\
 -1 ], [ [ 4, 6 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 6, 1 ], 1 ], [ [ 6, 4 ], 1 ], [ [ 6, 5 ], 1 ] ] ))
gap> pgMat := PGMatrices(symmetries, pgMatGs : symNames := symNames);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b\
", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], \
1 ], [ [ 6, 5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 \
], [ [ 6, 5 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ]\
, [ [ 6, 2 ], 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )), symmetryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatrices\
Rec = rec( A := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ]\
 ], B := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] \
], C := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ], [\
 [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ], X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ], [ [ \
5, 5 ], -1 ], [ [ 6, 6 ], -1 ] ], Y := [ [ [ 1, 3 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 5 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 5, 2 \
], -1 ], [ [ 5, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 4 ], 1 ] ], Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 4 ], -1 ], [ [ 3, 1 ],\
 -1 ], [ [ 4, 6 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 6, 1 ], 1 ], [ [ 6, 4 ], 1 ], [ [ 6, 5 ], 1 ] ] ))
gap> GetPGMatricesOfGenerators(pgMat);
PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8, 8 ], 16, 3\
, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b", "c" ], pg\
MatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, \
5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 \
], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ]\
, 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] ))
gap> PGMatricesRec(pgMat);
rec( A := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ],
  B := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] ],
  C := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ],
      [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ],
  X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ], [ [ 5, 5 ], -1 ], [ [ 6, 6 ], -1 ] ],
  Y := [ [ [ 1, 3 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 5 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 5, 2 ], -1 ], [ [ 5, 3 ], -1 ],
      [ [ 5, 6 ], -1 ], [ [ 6, 4 ], 1 ] ],
  Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 4 ], -1 ], [ [ 3, 1 ], -1 ], [ [ 4, 6 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 6, 1 ], 1 ],
      [ [ 6, 4 ], 1 ], [ [ 6, 5 ], 1 ] ] )

# Test export and import
gap> str := "";;
gap> output := OutputTextString(str, false);;
gap> Export(pgMat, output);;
gap> CloseStream(output);;
gap> Print(str);
HyperCells HCPGM version 1.0
[ 2, 8, 8 ]
[ [ 3, 11 ], 16, 3, "Action reflexible [m,n]", "[ x^2, x * y * z, x * z * y, y^-8 ]" ]
true
[ [ "a", [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ] ], [\
 "b", [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] ] ]\
, [ "c", [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ], \
[ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] ] ]
[ [ "A", [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ] ] ], [\
 "B", [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] ] ]\
, [ "C", [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ], \
[ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] ], [ "X", [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ],\
 [ [ 5, 5 ], -1 ], [ [ 6, 6 ], -1 ] ] ], [ "Y", [ [ [ 1, 3 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 5 ], 1 ], [ [ 4, 2 ], 1 ], \
[ [ 5, 2 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 4 ], 1 ] ] ], [ "Z", [ [ [ 1, 2 ], -1 ], [ [ 2, 4 ], -1 ]\
, [ [ 3, 1 ], -1 ], [ [ 4, 6 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 6, 1 ], 1 ], [ [ 6, 4 ], 1 ], [ [ 6, 5 ], 1 ] ] ] ]
gap> input := InputTextString(str);;
gap> pgMat2 := ImportPGMatrices(input);
PGMatrices( PGMatricesOfGenerators( TriangleGroup(2, 8, 8), ProperTriangleGroup(2, 8, 8), TGQuotient([ 3, 11 ], [ 2, 8\
, 8 ], 16, 3, Action reflexible [m,n], [ x^2, x * y * z, x * z * y, y^-8 ]), sparse = true, generatorNames = [ "a", "b\
", "c" ], pgMatricesRec = rec( a := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], \
1 ], [ [ 6, 5 ], 1 ] ], b := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 \
], [ [ 6, 5 ], -1 ] ], c := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ]\
, [ [ 6, 2 ], 1 ], [ [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ] )), symmetryNames = [ "A", "B", "C", "X", "Y", "Z" ], pgMatrices\
Rec = rec( A := [ [ [ 1, 2 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 4 ], 1 ], [ [ 4, 3 ], 1 ], [ [ 5, 6 ], 1 ], [ [ 6, 5 ], 1 ]\
 ], B := [ [ [ 1, 2 ], -1 ], [ [ 2, 1 ], -1 ], [ [ 3, 4 ], -1 ], [ [ 4, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 5 ], -1 ] \
], C := [ [ [ 1, 1 ], -1 ], [ [ 2, 3 ], -1 ], [ [ 3, 2 ], -1 ], [ [ 4, 5 ], -1 ], [ [ 5, 4 ], -1 ], [ [ 6, 2 ], 1 ], [\
 [ 6, 3 ], 1 ], [ [ 6, 6 ], 1 ] ], X := [ [ [ 1, 1 ], -1 ], [ [ 2, 2 ], -1 ], [ [ 3, 3 ], -1 ], [ [ 4, 4 ], -1 ], [ [ \
5, 5 ], -1 ], [ [ 6, 6 ], -1 ] ], Y := [ [ [ 1, 3 ], 1 ], [ [ 2, 1 ], 1 ], [ [ 3, 5 ], 1 ], [ [ 4, 2 ], 1 ], [ [ 5, 2 \
], -1 ], [ [ 5, 3 ], -1 ], [ [ 5, 6 ], -1 ], [ [ 6, 4 ], 1 ] ], Z := [ [ [ 1, 2 ], -1 ], [ [ 2, 4 ], -1 ], [ [ 3, 1 ],\
 -1 ], [ [ 4, 6 ], -1 ], [ [ 5, 3 ], -1 ], [ [ 6, 1 ], 1 ], [ [ 6, 4 ], 1 ], [ [ 6, 5 ], 1 ] ] ))
gap> pgMat2 = pgMat;
false
gap> syntacticEqualPGMatricesObjs@(pgMat2, pgMat);
true

gap> STOP_TEST("PGMatrix.tst");