#!
#!
#! @Chapter Representations of point groups


#! @Section Point-group matrices
#!
#! Point-group matrices are representations of group elements in the point group $G\cong\Delta/\Gamma$. 
#! These matrices can efficiently be constructed. Given any symmetry `g` in the point group $G$ and a
#! set `I` of all translation generators $\gamma_i$ of the translation group $\Gamma$, a corresponding
#! point-group matrix can be determined through the set of the symmetry transformed elements $g \gamma_i g^{-1}$ <Cite Key='Chen:2023'/>.
#! Point-group matrices enable the conduction of symmetry analysis on any given (supercell) model graph.
#!
#! @Section PGMatricesOfGenerators
#! @SectionLabel PGMatricesOfGenerators
#!
#!   - <Ref Oper='Signature' Label='for PGMatricesOfGenerators' />:
#!     signature of the underlying triangle group
#!   - <Ref Oper='GetTriangleGroup' Label='for PGMatricesOfGenerators' />:
#!     the triangle group $\Delta$ 
#!   - <Ref Oper='GetProperTriangleGroup' Label='for PGMatricesOfGenerators' />:
#!     the proper triangle group $\Delta^+$
#!   - <Ref Oper='TGQuotientName' Label='for PGMatricesOfGenerators' />:
#!     name of the triangle group quotient
#!   - <Ref Oper='GetTGQuotient' Label='for PGMatricesOfGenerators' />:
#!     the triangle group quotient
#!   - <Ref Oper='IsSparse' Label='for PGMatricesOfGenerators' />:
#!     boolean, if true the point-group matrices are sparsely represented
#!   - <Ref Oper='TGGenerators' Label='for PGMatricesOfGenerators' />:
#!     list of triangle group generators `a`, `b` and `c`
#!   - <Ref Oper='PGMatricesRec' Label='for PGMatricesOfGenerators' />:
#!     record of three point-group matrices for the generators `a`, `b` and `c`
#!     of the triangle group $\Delta$
#!
#! and is printed in the form
#!   @BeginLog
#!    PGMatricesOfGenerators(
#!      TriangleGroup(...), 
#!      ProperTriangleGroup(...),
#!      TGQuotient(...),
#!      sparse = bool,
#!      generators = [ a, b, c ],
#!      pgMatricesRec = rec( a := pgMatA, b := pgMatB, c := pgMatC )
#!    )
#!   @EndLog

DeclareCategory( "IsPGMatricesOfGeneratorsObj", IsObject );


#! @Description
#!   Constructs the point-group matrices for the generators `a`, `b` and `c` of the triangle group $\Delta$
#!   specified by the `TriangleGroup` object <A>fulltg</A> (see <Ref Sect="Section_TriangleGroups"/>), which 
#!   define a representation of the point group $G\cong\Delta/\Gamma$ specified by the triangle group quotient 
#!   <A>tgquotient</A>, a `TGQuotient` object (see <Ref Sect="TGQuotient"/>). They are constructed through the
#!   use of the embedding homomorphism from the proper triangle group $\Delta^+$ to the triangle group $\Delta$, 
#!   where the former is specified by the `ProperTriangleGroup` object <A>tg</A> (see <Ref Sect="Section_TriangleGroups"/>).
#!
#!   The option `sparse`, which takes a boolean, can be used to generate a sparse 
#!   representation of the point-group matrices. If `sparse` is `true`, the point-group matrices are of the
#!   form `[ [ [ rowIdx, colIdx ], entry ], ... ]`, where `entry` is the corresponding matrix element at
#!   position `rowIdx` and `colIdx`, which represent indices of the matrix rows and columns, 
#!   respectively. The default is `false`.
#! @Arguments fulltg, tg, tgquotient
#! @Returns the point-group matrices of the (full) triangle group generators `a`, `b` and `c` as a
#!   `PGMatricesOfGenerators` object.
DeclareGlobalFunction( "PGMatricesOfGenerators" );


#! @Description
#!   returns the signature of the triangle group associated with <A>pgMatGs</A>, `[ r, q, p ]`.
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "Signature", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns the triangle group on which the `PGMatricesOfGenerators` <A>pgMatsGs</A> is based as
#!   a `TriangleGroup` object (see <Ref Sect="Section_TriangleGroups"/>).
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "GetTriangleGroup", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns the proper triangle group on which the `PGMatricesOfGenerators` <A>pgMatsGs</A> is based as
#!   a `ProperTriangleGroup` object (see <Ref Sect="Section_TriangleGroups"/>).
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "GetProperTriangleGroup", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns the name of the triangle group quotient. For quotients from the library, i.e., Conder’s list,
#!   this takes the form `[genus, number]`, `number` is a running index over all triangle groups for the
#!   given genus.
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "TGQuotientName", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns the triangle group quotient on which the `PGMatricesOfGenerators` <A>pgMatsGs</A> is based as
#!   a `TGQuotient` object (see <Ref Sect="Section_TGQuotient"/>).
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "GetTGQuotient", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns a boolean, `true` if the point-group matrices in <A>pgMatsGs</A> are sparse `false` otherwise.
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "IsSparse", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns the triangle group generators on which the `PGMatricesOfGenerators` <A>pgMatsGs</A> 
#!   is based.
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "TGGenerators", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns a `record` (see chapter Records in the <URL Text="GAP Reference Manual ">https://docs.gap-system.org/doc/ref/chap0_mj.html</URL>) 
#!   of three point-group matrices for the triangle group generators. Each component is of the form  `"tgGenerator" := pgMat`,
#!   where `"tgGenerator"` is a string `"a"`, `"b"` or `"c"` denoting one of the generators of the triangle group 
#!   and `pgMat` the corresponding point-group matrix.
#! @Arguments pgMatsGs
#! @Label for PGMatricesOfGenerators
DeclareOperation( "PGMatricesRec", [ IsPGMatricesOfGeneratorsObj ] );

#! @Description
#!   returns a point-group matrix for a symmetry element <A>symmetry</A> in the 
#!   triangle group or proper triangle group specified through `fulltg` or `tg`, respectively.
#! @Arguments symmetry, pgMatsGs 
#! @Label for PGMatricesOfGenerators
DeclareOperation( "EvaluatePGMatrix", [ IsElementOfFpGroup, IsPGMatricesOfGeneratorsObj ] );


#! @Section PGMatrices
#! @SectionLabel PGMatrices
#!
#!   - <Ref Oper='GetPGMatricesOfGenerators' Label='for PGMatrices' />:
#!     a `PGMatricesOfGenerators` object for the point-group matrices corresponding 
#!     of the (full) triangle group generators `a`, `b` and `c`
#!   - <Ref Oper='Symmetries' Label='for PGMatrices' />:
#!     list of symmetry elements given as words in the triangle group $\Delta$ or proper triangle group $\Delta^+$
#!   - <Ref Oper='SymmetryNames' Label='for PGMatrices' />:
#!     list of names denoting the symmetry elements
#!   - <Ref Oper='PGMatricesRec' Label='for PGMatrices' />:
#!     record of point-group matrices for the symmetry elements
#!     in the triangle group $\Delta$ or proper triangle group $\Delta^+$
#!
#! and is printed in the form
#!   @BeginLog
#!    PGMatrices(
#!      PGMatricesOfGenerators( ... ), 
#!      symmetries = [ sym1, sym2, ... ],
#!      symmetryNames = [ "symName1", "symName2", ... ],
#!      pgMatricesRec = rec( symName1 := pgMat1, symName2 := pgMat2, ... )
#!    )
#!   @EndLog

DeclareCategory( "IsPGMatricesObj", IsObject );


#! @Description
#!   Constructs point-group matrices for a single symmetry element or a list of symmetry elements 
#!   given as words written in terms of the rotation generators `a`, `b`, `c` of the triangle group $\Delta$ 
#!   or the reflection generators `x`, `y`, `z` of the proper triangle group $\Delta^+$, specified by the 
#!   `TriangleGroup` object `fulltg` and `ProperTriangleGroup` object `tg`, respectively 
#!   (see <Ref Sect="Section_TriangleGroups"/>). Each point-group matrix is constructed through a sequence of
#!   matrix multiplications of the point-group matrices in <A>pgMatsGs</A>, i.e., the point-group matrices of
#!   the generators `a`, `b` and `c` of $\Delta$, which form representations of the point group previously 
#!   specified by a corresponding triangle group quotient, `fulltg` and `tg`. The sequences are specified by the corresponding 
#!   words in <A>symmetries</A>.
#!
#!   The option `symNames` can be used to specify the names of the <A>symmetries</A>. If a 
#!   single symmetry is provided in the argument <A>symmetries</A>, `symNames` takes a single
#!   string, otherwise a list of strings with the same number of elements as in <A>symmetries</A>
#!   must be provided. The names will be used to label the corresponding point-group matrices. 
#!   If `symNames` is not specified, the words in <A>symmetries</A> will used as labels instead.
#!   
#!   If  the option `sparse` was used in the construction of <A>pgMatsGs</A>, the point-group 
#!   matrices will be sparsely represented as well and will be of the form `[ [ [ rowIdx, colIdx ], entry ], ... ]`, 
#!   where `entry` is the corresponding matrix element at position `rowIdx` and `colIdx`, which represent
#!   indices of the matrix rows and columns, respectively. 
#! @Arguments symmetries, pgMatsGs
#! @Returns list of point-group matrices as a `PGMatrices` object.
DeclareGlobalFunction( "PGMatrices" );


#! @Description
#!   returns the point-group matrices of the (full) triangle group generators `a`, `b` and `c` as a
#!   `PGMatricesOfGenerators` object.
#! @Arguments pgMats
#! @Label for PGMatrices
DeclareOperation( "GetPGMatricesOfGenerators", [ IsPGMatricesObj ] );

#! @Description
#!   returns the symmetry elements of the (proper) triangle group on which the `PGMatrices` <A>pgMats</A> 
#!   is based.
#! @Arguments pgMats
#! @Label for PGMatrices
DeclareOperation( "Symmetries", [ IsPGMatricesObj ] );

#! @Description
#!   returns the names of the symmetry elements of the (proper) triangle group on which the `PGMatrices` <A>pgMats</A> 
#!   is based.
#! @Arguments pgMats
#! @Label for PGMatrices
DeclareOperation( "SymmetryNames", [ IsPGMatricesObj ] );

#! @Description
#!   returns a `record` (see chapter Records in the <URL Text="GAP Reference Manual ">https://docs.gap-system.org/doc/ref/chap0_mj.html</URL>) 
#!   of point-group matrices for symmetry elements in the point group written in terms of (proper) triangle group generators. 
#!   Each component is of the form `SymmetryName := pgMat`, where `SymmetryName` is a string denoting 
#!   one of the symmetries used and `pgMat` the corresponding point-group matrix.
#! @Arguments pgMats
#! @Label for PGMatrices
DeclareOperation( "PGMatricesRec", [ IsPGMatricesObj ] );


#!
#!
#! @Section Export and Import

#! @BeginGroup ExportPGMatrices
#! @GroupTitle Exporting PGMatrices Objects
#!
#! @Description
#!   Export point-group matrices `PGMatrices` <A>pgMats</A> to the `OutputTextStream`  
#!   <A>output-stream</A>
#! @Arguments pgMats, output-stream
#! @Label for PGMatrices, OutputTextStream
DeclareOperation( "Export", [ IsPGMatricesObj, IsOutputTextStream ] );
#!
#! @Description
#!   or to the file at the path given by the string <A>path</A>.
#! @Arguments pgMats, path
#! @Label for PGMatrices, String
DeclareOperation( "Export", [ IsPGMatricesObj, IsString ] );
#!
#! @Description
#!   Alternatively, point-group matrices can be exported to a string.
#! @Arguments pgMats
#! @Label for PGMatrices
DeclareOperation( "ExportString", [ IsPGMatricesObj ] );
#!
#! @EndGroup

#!
#! @BeginGroup ImportPGMatrices
#! @GroupTitle Importing PGMatrices Objects
#!
#! @Description
#!   Import point-group matrices from the `InputTextStream` <A>input-stream</A>
#! @Arguments input-stream[, fulltg, tg]
#! @Returns point-group matrices as a `PGMatrices` object
#! (see <Ref Sect='Section_PGMatrices'/>).
DeclareGlobalFunction( "ImportPGMatrices" );
#!
#! @Description
#!   or from the file at the path given by the string <A>path</A>.
#! @Arguments path[, fulltg, tg]
#! @Returns point-group matrices as a `PGMatrices` object
#! (see <Ref Sect='Section_PGMatrices'/>).
DeclareGlobalFunction( "ImportPGMatricesFromFile" );
#!
#! @Description
#!   Alternatively, point-group matrices can be imported from the string <A>string</A>.
#!   Optionally, the triangle group and the proper triangle group can be given as a TriangleGroup
#!   object <A>fulltg</A> and a ProperTriangleGroup object <A>tg</A>, respectively, 
#!   (see <Ref Sect="Section_TriangleGroups"/>).
#! @Arguments string[, fulltg, tg]
#! @Returns point-group matrices as a `PGMatrices` object
#! (see <Ref Sect='Section_PGMatrices'/>).
DeclareGlobalFunction( "ImportPGMatricesFromString" );
#!
#! @EndGroup



