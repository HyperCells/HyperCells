#!
#!
#! @Chapter Triangle-Group Cells

#!
#!
#! @Section Cells
#! @SectionLabel TGCell
#!
#! A triangle-group cells is defined by the quotient group of a triangle group
#! $\Delta$ by a subgroup of translations $\Gamma$, i.e., a torsion-free
#! normal subgroup of the proper triangle group $\Delta^+$.
#! Geometrically, this includes a choice of transversal $T_{\Delta^+}(\Gamma)$
#! characterizing the cell and a choice of transversal $T_{G^+}(G_w^+)$, where
#! $G^+\cong\Delta^+/\Gamma$ is the (proper) point group of the cell and $G_w^+$
#! is the stabilizer of a maximally symmetric Wyckoff position of type $w$ in the cell.
#!
#! The cell is implemented as an object of category `TGCellObj` with the following
#! components:
#! - <Ref Oper='GetProperTriangleGroup' Label='for TGCell' />:
#!   the proper triangle group $\Delta^+$
#! - <Ref Oper='CellRelators' Label='for TGCell' />:
#!   the relators defining $\Delta^+/\Gamma$ as elements of $\Delta^+$
#! - <Ref Oper='TGCellTranslationGroup' Label='for TGCell' />:
#!   the translation group $\Gamma$
#! - <Ref Oper='TGCellPointGroup' Label='for TGCell' />:
#!   the (proper) point group $G^+\cong\Delta^+/\Gamma$
#! - <Ref Oper='TGCellMSWPs' Label='for TGCell' />:
#!   the maximally symmetric Wyckoff positions in the cell
#! and is printed in the form
#! @BeginLog
#! TGCell( ProperTriangleGroup(r, q, p), rels )
#! @EndLog
#! where $(r,q,p)$ is the signature of the underlying triangle group and
#! `rels` the relators defining the cell in terms of the generators $x$, $y$, $z$
#! of the proper triangle group $\Delta^+$.

#! @Description
#!   Construct the cell for the triangle group <A>tg</A> ($\Delta^+$), given as
#!   `ProperTriangleGroup` object (see <Ref Sect="Section_TriangleGroups"/>),
#!   specified by the quotient <A>q</A> given as a `TGQuotient` object <A>quotient</A>
#!   (see <Ref Sect="Section_TGQuotient"/>).
#!
#!   Optionally, generators <A>GAMgens</A> of the translation group $\Gamma$ can be
#!   explicitly given as elements of <A>tg</A>. If not given, they are computed
#!   automatically.
#!   Similarly, choices for the transversals $T_{\Delta^+}(\Gamma)$ and $T_{G^+}(G_w^+)$
#!   can be given as <A>TDGAM</A> and <A>TGGw</A>, respectively. If not given, they
#!   are computed automatically.
#!   Here, <A>TDGAM</A> is a list of elements of <A>tg</A> and <A>TGGw</A> is a list
#!   of three lists, one for $w=x,y,z$, respectively, of elements of <A>tg</A>.
#! @Arguments tg,quotient[,GAMgens[,TDGAM[,TGGw]]]
#! @Returns cell as `TGCell` object
DeclareGlobalFunction( "TGCell" );

#! @Description
#!   Construct the **symmetric** and at `center` centered cell for the triangle group
#!   <A>tg</A> ($\Delta^+$), given as `ProperTriangleGroup` object
#!   (see <Ref Sect="Section_TriangleGroups"/>), specified by the quotient <A>q</A>
#!   given as a `TGQuotient` object <A>quotient</A>
#!   (see <Ref Sect="Section_TGQuotient"/>).
#! @Arguments tg,quotient,center
#! @Returns cell as `TGCell` object
DeclareGlobalFunction( "TGCellSymmetric" );

#!
#!
#! @Section Cell Properties

DeclareCategory( "IsTGCellObj", IsObject );

#! @Description
#!   returns the proper triangle group on which the cell <A>cell</A> is based as
#!   a `ProperTriangleGroup` object (see <Ref Sect="Section_TriangleGroups"/>).
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "GetProperTriangleGroup", [ IsTGCellObj ] );
#! @Description
#!   returns the relators defining the cell as elements of
#!   `GetProperTriangleGroup(`<A>cell</A>`)`
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "CellRelators", [ IsTGCellObj ] );
#! @Description
#!   returns the translations group $\Gamma$ as a `TGCellTranslationGroup` object
#!   (see <Ref Sect="Section_TGCellTranslationGroup"/>).
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "TGCellTranslationGroup", [ IsTGCellObj ] );
#! @Description
#!   returns the (proper) point group $G^+\cong\Delta^+/\Gamma$ as a
#!   `TGCellPointGroup` object (see <Ref Sect="Section_TGCellPointGroup"/>).
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "TGCellPointGroup", [ IsTGCellObj ] );
#! @Description
#!   returns true if the the maximally symmetry Wyckoff positions are precomputed,
#!   false otherwise.
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "HasTGCellMSWPs", [ IsTGCellObj ] );
#! @Description
#!   returns the maximally symmetry Wyckoff positions as a `TGCellMSWPs` object
#!   (see <Ref Sect="Section_TGCellMSWPs"/>) and computes them if necessary.
#!
#!   Call <Ref Oper='HasTGCellMSWPs' Label='for TGCell' /> first to check if they
#!   are already precomputed.
#! @Arguments cell
#! @Label for TGCell
DeclareOperation( "TGCellMSWPs", [ IsTGCellObj ] );

#!
#!
#! @Section Query Information from Cells
#! @Description
#!   returns the index of the Schwarz triangle representative in the cell, i.e.,
#!   the position in `GetRightTransversal(TGCellPointGroup(`<A>cell</A>`))`, for
#!   a given element <A>elem</A> of the proper triangle group
#!   `GetProperTriangleGroup(`<A>cell</A>`)`.
#! @Arguments cell, elem
#! @Label for TGCell
DeclareOperation( "TGCellSchwarzTriangleRep", [ IsTGCellObj, IsElementOfFpGroup ] );

#!
#!
#! @Section Cell Translation Group
#! @SectionLabel TGCellTranslationGroup
#!
#! Cell translation groups are characterized by the translation group $\Gamma$,
#! a normal subgroup of the proper triangle group $\Delta^+$, and an explicit choice
#! of generators.
#! This is implemented as an object of category `TGCellTranslationGroupObj` with
#! the following components:
#! - <Ref Oper='AsTGSubgroup' Label='for TGCellTranslationGroup' />:
#!   the translation group $\Gamma$ as a subgroup of the proper triangle group $\Delta^+$
#! - <Ref Oper='Generators' Label='for TGCellTranslationGroup' />:
#!   the generators of $\Gamma$ as elements of the proper triangle group $\Delta^+$
#! - <Ref Oper='FpGroup' Label='for TGCellTranslationGroup' />:
#!   the translation group $\Gamma$ as a finitely presented group
#! - <Ref Oper='FpIsomorphism' Label='for TGCellTranslationGroup' />:
#!   the group isomorphism from $\Gamma$ to the finitely presented group
#! and is printed in the form
#! @BeginLog
#! TGCellTranslationGroup( < g1, g2, ... > | rel1, rel2, ... > )
#! @EndLog
#! where `g1`, `g2`, ... are the generators of $\Gamma$ as finitely presented group,
#! <Ref Oper='FpGroup' Label='for TGCellTranslationGroup' />, and `rel1`, `rel2`, ...
#! are the corresponding relators.

DeclareCategory( "IsTGCellTranslationGroupObj", IsObject );
#! @Description
#!   returns the translation group <A>Gamma</A> as a subgroup of the proper triangle
#!   group $\Delta^+$.
#! @Arguments Gamma
#! @Label for TGCellTranslationGroup
DeclareOperation( "AsTGSubgroup", [ IsTGCellTranslationGroupObj ] );
#! @Description
#!   returns the generators of the translation group <A>Gamma</A> as elements of
#!   the proper triangle group $\Delta^+$.
#! @Arguments Gamma
#! @Label for TGCellTranslationGroup
DeclareOperation( "Generators", [ IsTGCellTranslationGroupObj ] );
#! @Description
#!   returns the translation group Gamma as a finitely presented group with generators
#!   `g1`, `g2`, ....
#! @Arguments Gamma
#! @Label for TGCellTranslationGroup
DeclareOperation( "FpGroup", [ IsTGCellTranslationGroupObj ] );
#! @Description
#!   returns the group isomorphism from `AsTGSubgroup(`<A>Gamma</A>`)`, the translation
#!   group as a subgroup of proper triangle group $\Delta^+$, to the finitely presented
#!   group `FpGroup(`<A>Gamma</A>`)`.
#! @Arguments Gamma
#! @Label for TGCellTranslationGroup
DeclareOperation( "FpIsomorphism", [ IsTGCellTranslationGroupObj ] );

#!
#!
#! @Section Cell Point Group
#! @SectionLabel TGCellPointGroup
#!
#! The (proper) point group $G^+$ of a triangle-group cell is ismomorphic to the
#! quotient group $\Delta^+/\Gamma$ of the proper triangle group $\Delta^+$ by the
#! translation group $\Gamma$.
#! It is implemented as an object of category `TGCellPointGroupObj` with the following
#! components:
#! - <Ref Oper='AsQuotientGroup' Label='for TGCellPointGroup' />:
#!   the quotient group $G^+\cong\Delta^+/\Gamma$ as a quotient group of the proper
#!   triangle group $\Delta^+$ by the translation group $\Gamma$
#! - <Ref Oper='AsQuotient' Label='for TGCellPointGroup' />:
#!   the quotient $G^+\cong\Delta^+/\Gamma$ as a `RightTransversal` object
#! - <Ref Oper='GetRightTransversal' Label='for TGCellPointGroup' />:
#!   the right transversal with representatives of point group elements as elements
#!   of the proper triangle group $\Delta^+$
#! - <Ref Oper='QuotientHomomorphism' Label='for TGCellPointGroup' />:
#!   the group homomorphism from the proper triangle group $\Delta^+$ to the quotient
#!   group $G^+\cong\Delta^+/\Gamma$
#! and is printed in the form
#! @BeginLog
#! TGCellPointGroup( < x, y, z > | rel1, rel2, ... > )
#! @EndLog
#! where `x`, `y`, `z` are the generators of the point group $G^+$ and `rel1`,
#! `rel2`, ... are the corresponding relators.


DeclareCategory( "IsTGCellPointGroupObj", IsObject );
#! @Description
#!   returns the (proper) point group $G^+$ as quotient group $\Delta^+/\Gamma$.
#! @Arguments G
#! @Label for TGCellPointGroup
DeclareOperation( "AsQuotientGroup", [ IsTGCellPointGroupObj ] );
#! @Description
#!   returns the (proper) point group $G^+\cong\Delta^+/\Gamma$ as a `RightTransversal`
#!   object.
#! @Arguments G
#! @Label for TGCellPointGroup
DeclareOperation( "AsQuotient", [ IsTGCellPointGroupObj ] );
#! @Description
#!   returns the right transversal with representatives of point group elements
#!   as elements of the proper triangle group $\Delta^+$.
#! @Arguments G
#! @Label for TGCellPointGroup
DeclareOperation( "GetRightTransversal", [ IsTGCellPointGroupObj ] );
#! @Description
#!   returns the group homomorphism from the proper triangle group $\Delta^+$ to
#!   the quotient `AsQuotientGroup(`<A>G</A>`)` corresponding to the point group $G^+$.
#! @Arguments G
#! @Label for TGCellPointGroup
DeclareOperation( "QuotientHomomorphism", [ IsTGCellPointGroupObj ] );

#!
#!
#! @Section Maximally Symmetric Wyckoff Positions
#! @SectionLabel TGCellMSWPs
#!
#! The maximally symmetric Wyckoff positions in a triangle-group cell are
#! given by the orbital stabilizer theorem as the coset representatives of the
#! right cosets of the stabilizer of a maximally symmetric Wyckoff position of
#! type $w$ in the (proper) point group $G^+$, i.e., as elements of the right
#! transversal $T_{G^+}(G_w^+)$.
#! Here the types of maximally symmetric Wyckoff positions, $w=x,y,z$, are distinguished
#! by the order of their stabilizer group: $|G_x^+|=r$, $|G_y^+|=q$, and $|G_z^+|=p$.
#! 
#! This is implemented as an object of category `TGCellMSWPsObj` with the following
#! components:
#! - <Ref Oper='AsQuotient' Label='for TGCellMSWPs' />:
#!   the list of the three quotients $G^+/G_w^+$, $w=x,y,z$, as `RightTransversal`
#!   objects
#! - <Ref Oper='GetRightTransversal' Label='for TGCellMSWPs' />:
#!   the list of the three right transversals $T_{G^+}(G_w^+)$, $w=x,y,z$, with
#!   representatives as elements of the proper triangle group $\Delta^+$
#! - <Ref Oper='GetKernel' Label='for TGCellMSWPs' />:
#!   the list of the three kernels $G_w^+$, $w=x,y,z$, as ordered lists of elements
#!   of the proper point group $G^+$
#! and is printed in the form
#! @BeginLog
#! TGCellMSWPs( [ TGGx, TGGy, TGGz ] )
#! @EndLog
#! where `TGGx`, `TGGy`, `TGGz` are the right transversals $T_{G^+}(G_x^+)$,
#! $T_{G^+}(G_y^+)$, $T_{G^+}(G_z^+)$, respectively.


DeclareCategory( "IsTGCellMSWPsObj", IsObject );
#! @Description
#!   returns the list of the three quotients $G^+/G_w^+$, $w=x,y,z$, corresponding
#!   to the list of maximally symmetric Wyckoff positions in the cell.
#!   Each quotient is given as a `RightTransversal` object.
#! @Arguments obj
#! @Label for TGCellMSWPs
DeclareOperation( "AsQuotient", [ IsTGCellMSWPsObj ] );
#! @Description
#!   returns the list of the three right transversals $T_{G^+}(G_w^+)$, $w=x,y,z$.
#!   Each right transversal is given as a list of elements of the proper triangle
#!   group $\Delta^+$, such that each elements represents a maximally symmetric
#!   Wyckoff positions of type $w$.
#! @Arguments obj
#! @Label for TGCellMSWPs
DeclareOperation( "GetRightTransversal", [ IsTGCellMSWPsObj ] );
#! @Description
#!   returns the list of the three kernels, each corresponding to the list of elements
#!   of the on-site symmetry group of the maximally symmetric Wyckoff position.
#!   The list entries are given as elements of the proper point group $G^+$.
#! @Arguments obj
#! @Label for TGCellMSWPs
DeclareOperation( "GetKernel", [ IsTGCellMSWPsObj ] );