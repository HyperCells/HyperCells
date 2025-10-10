#!
#!
#! @Chapter Supercells
#!
#!
#! @Section Supercell Model Graphs
#! @SectionLabel TGSuperCellModelGraph
#!
#! Supercell model graphs are used to describe the extension of a cell model graph
#! defined on a primitive cell to a supercell.
#! The vertices and edges of the supercell model graph retain information about
#! the vertices and edges of the primitive cell model graph and the elements of the
#! quotient group $\Gamma_\mathrm{pc}/\Gamma_\mathrm{sc}$ distinguishing the
#! different copies of the primitive cell in the supercell.
#!
#! Supercell model graphs are implemented as objects of category `TGSuperCellModelGraph`
#! with the following components:
#! - <Ref Oper="GetTGPrimitiveCell" Label='for TGSuperCellModelGraph'/>:
#!   the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>) for the
#!   primitive cell
#! - <Ref Oper="GetTGSuperCell" Label='for TGSuperCellModelGraph'/>:
#!   the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>) for the
#!   supercell
#! - <Ref Oper="CellCenter" Label='for TGSuperCellModelGraph'/>:
#!   the cell center of the supercell model graph
#! - <Ref Oper='CellEmbedding' Label='for TGSuperCellModelGraph'/>:
#!   the embedding of the primitive cell in the supercell as a `TGCellEmbedding`
#!   object (see <Ref Sect='Section_TGCellEmbedding'/>)
#! - <Ref Oper='ModelType' Label='for TGSuperCellModelGraph'/>:
#!   identifier of the type of model, e.g., tessellation, kagome etc.
#! - <Ref Oper='CellVertices' Label='for TGSuperCellModelGraph'/>:
#!   the vertices of the supercell model graph, i.e., the sites of the tight-binding
#!   model
#! - <Ref Oper='CellVertexPositions' Label='for TGSuperCellModelGraph'/>:
#!   the positions of the vertices of the supercell model graph as elements of the
#!   proper triangle group
#! - <Ref Oper='CellEdges' Label='for TGSuperCellModelGraph'/>:
#!   the edges of the supercell model graph, i.e., the hoppings of the tight-binding
#!   model, including potential translations associated with them
#! - <Ref Oper='CellFaces' Label='for TGSuperCellModelGraph'/>:
#!   the faces of the supercell model graph, i.e., the plaquettes of the tight-binding
#!   model
#! and is printed in the form
#! @BeginLog
#! TGSuperCellModelGraph(
#!   primitive cell = TGCell( ... ),
#!   supercell = TGCell( ... ),
#!   center = w,
#!   type = <type>,
#!   vertices = [ [ w1, gi1 ], [ w2, gi2 ], ... ],
#!   edges = [ [ v1, v2, tag, gam ], ... ],
#!   faces = [ [ [ e1, o1 ], [ e2, o2 ], ... ], ... ]
#! )
#! @EndLog
#! See the corresponding references above for details.
#!

DeclareCategory( "IsTGSuperCellModelGraphObj", IsObject );

#!
#!
#! @Section Constructing Supercell Models
#! @SectionLabel ConstructingSupercellModels
#! 
#! There are two functions for constructing supercell models based on a given model
#! graph:
#! - <Ref Func='TGSuperCellModelGraph'/>:
#!   constructs a supercell model graph from a model graph and a supercell choosing
#!   representatives such that the resulting supercell is a symmetric connected cell.
#! - <Ref Func='UnrefinedTGSuperCellModelGraph'/>:
#!   constructs a supercell model graph from a model graph and relators specifying
#!   the supercell. Note that the resulting supercell is neither symmetric nor connected
#!   in general. Usually, the representatives are automatically chosen and arbitrary,
#!   but they can be explicitly passed if desired.

#! In all of those functions, the option `simplify`, which takes a non-negative
#! integer as argument, can be used to specify the level of simplification of words
#! in the translation group, both for the translation generators expressed in terms
#! of generators of the proper triangle group and for the translations expressed
#! as elements of the finitely presented group. The additional option
#! `simplifyMethod`, which takes a string, can be used to specify the method of simplification. 
#! By default `simplifyMethod` is set to `"BruteForce"`. If the package kbmag 
#! (see kbmag reference manual <URL Text="kbmag Reference Manual ">https://docs.gap-system.org/pkg/kbmag/doc/chap0_mj.html</URL>)
#! is loaded it is possible to set `simplifyMethod` to `"KnuthBendix"`, such that the 
#! Knuth-Bendix completion algorithm is used in the simplification. This method uses the available space in cache, 
#! which can be flushed by calling `FlushCaches` 
#! (see section Mutability and Copying in the <URL Text="GAP Reference Manual ">https://docs.gap-system.org/doc/ref/chap0_mj.html</URL>).

#! @Description
#!   Constructs the supercell model graph obtained from extending the model <A>model</A>
#!   given as a `TGCellModelGraph` object (see <Ref Sect='Section_TGCellModelGraph'/>)
#!   to the supercell <A>sc</A> given as a `TGCell`object (see
#!   <Ref Sect='Section_TGCell'/>).
#!   The resulting supercell is both symmetric and connected.
#! @Arguments model,sc
#! @Returns model graph as `TGSuperCellModelGraph` object
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "TGSuperCellModelGraph" );

#! @Description
#!   Constructs the supercell model graph obtained from extending the model <A>model</A>
#!   given as a `TGCellModelGraph` object (see <Ref Sect='Section_TGCellModelGraph'/>)
#!   to the supercell specified by the `TGQuotient` <A>scquotient</A>
#!   (see <Ref Sect='Section_TGQuotient'/>).
#!   Generally, the resulting supercell is neither symmetric nor connected.
#!
#!   If desired, explicit, e.g., symmetric, choices for the generators of supercell
#!   translation group $\Gamma_\mathrm{sc}$, $T_{\Delta^+}(\Gamma_\mathrm{sc})$,
#!   and $T_{\Gamma_\mathrm{pc}}(\Gamma_\mathrm{sc})$ can be given as optional
#!   arguments <A>GAMgens</A>, <A>TDGAM</A>, and <A>TGAMs</A>, respectively.
#! @Arguments model,scquotient[,GAMgens[,TDGAM[,TGAMs]]]
#! @Returns cell graph as `Section_TGSuperCellModelGraph` object
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "UnrefinedTGSuperCellModelGraph" );

#! @Description
#!   Same as <Ref Func='UnrefinedTGSuperCellModelGraph'/> but will be deprecated due to
#!   the misleading name.
#! @Arguments model,scquotient[,GAMgens[,TDGAM[,TGAMs]]]
#! @Returns cell graph as `Section_TGSuperCellModelGraph` object
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "RandomTGSuperCellModelGraph" );

#!
#!
#! @Section Supercell Model Properties
#! 
#! @Description
#!   returns the proper triangle group $\Delta^+$ on which the model is based
#!   as a `ProperTriangleGroup` object (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "GetProperTriangleGroup", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the relators in terms of elements of
#!   `GetProperTriangleGroup(`<A>model</A>`)` specifying the **primitive cell**
#!   on which the model is defined.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "PrimitiveCellRelators", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the relators in terms of elements of
#!   `GetProperTriangleGroup(`<A>model</A>`)` specifying the **supercell**.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "SuperCellRelators", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the an integer between $1$ and $3$ indicating the type of vertex of the
#!   triangle tessellation at the center of the cell graph with $1$, $2$, $3$
#!   corresponding to the vertices $x$, $y$, $z$, of the fundamental Schwarz triangle.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellCenter", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the `TGCell` object (see <Ref Sect='Section_TGCell'/>) associated with
#!   the model's **primitive cell**.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "GetTGPrimitiveCell", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the `TGCell` object (see <Ref Sect='Section_TGCell'/>) associated with
#!   the model's **supercell**.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "GetTGSuperCell", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   This is an alias for <Ref Oper='GetTGSuperCell' Label='for TGSuperCellModelGraph'/>.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "GetTGCell", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns a the identifier of the model type. See
#!   <Ref Oper='ModelType' Label='for TGCellModelGraph'/> for more details.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "ModelType", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the vertices of the model graph as a list.
#!
#!   Each vertex is of the form `[ w, gi, etaj ]` with `w` an integer between 1 and 3
#!   indicating the vertex of the fundamental Schwarz triangle, `gi` the position
#!   of the element in the transversal $T_{G^+}(G_w^+)$ labeling the vertex, and
#!   `etaj` the position of the element in the transversal
#!   $T_{\Gamma_\mathrm{pc}}(\Gamma_\mathrm{sc})$ labeling the copy of the primitive
#!   cell containing the vertex inside the supercell.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellVertices", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the positions of the vertices as elements of the proper triangle
#!   group $\Delta^+$.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellVertexPositions", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the edges of the model graph as a list.
#! 
#!   Each edge is of the form `[ v1, v2, tag, gam ]` with `v1`, `v2` the positions of
#!   the vertices in `CellVertices(`<A>model</A>`)` connected by the edge, `tag`
#!   uniquely identifying the edge, and `gam` the translation relating the unit	
#!   cell containing `v1` to the unit cell containing `v2`, as element of the
#!   finitely presented group
#!   `FpGroup(TGCellTranslationGroup(GetTGCell(`<A>model</A>`)))`.
#!   If `v1` corresponds to the vertex $(w, [g_{u_w}]_w)$ and `v2` to the vertex
#!   $(w', [g_{\tilde{u}_{w'}}]_{w'})$, then `gam` corresponds to the translation
#!   $\gamma$ such that
#!   $$g_{\tilde{u}_{w'}} = g_{u_w}\gamma.$$
#!
#!   The tag `tag` is of the form `[ v1pc, v2pc, tagpc ]` with `v1pc`, `v2pc` the
#!   positions of the vertices in the primitive cell, and `tagpc` the tag of the
#!   edge in the primitive cell (see <Ref Sect='Section_ConstructingModels'/>).
#!   Thus, `tag` specifies (up to the translation) the edge in the primitive cell.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellEdges", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the translations associated with the edges of the model graph.
#!   The translations are given as elements of the finitely presented group `FpGroup(TGCellTranslationGroup(GetTGCell(`model`)))` and describe the translation of the unit cell containing the first vertex of the oriented edge to the unit cell containing the second.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellEdgeTranslations", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the faces of the model graph as a list.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellFaces", [ IsTGSuperCellModelGraphObj ] );
#! @Description
#!   returns the embedding of the primitive cell in the supercell as a
#!   `TGCellEmbedding` object (see <Ref Sect='Section_TGCellEmbedding'/>).
#! @Arguments supercell-model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "CellEmbedding", [ IsTGSuperCellModelGraphObj ] );

#! @Section Embedding of the Primitive Cell in the Supercell
#! @SectionLabel TGCellEmbedding
#!

DeclareCategory( "IsTGCellEmbeddingObj", IsObject );

#!
#! @Description
#!   returns the primitive cell translation group as a `TGCellTranslationGroup` object
#!   (see <Ref Sect="Section_TGCellTranslationGroup"/>).
#! @Arguments cellembed
#! @Label for TGCellEmbedding
DeclareOperation( "PrimitiveCellTranslationGroup", [ IsTGCellEmbeddingObj ] );
#! @Description
#!   returns the supercell translation group as a `TGCellTranslationGroup` object
#!   (see <Ref Sect="Section_TGCellTranslationGroup"/>).
#! @Arguments cellembed
#! @Label for TGCellEmbedding
DeclareOperation( "SuperCellTranslationGroup", [ IsTGCellEmbeddingObj ] );
#! @Description
#!   returns the quotient group $\Gamma_\mathrm{pc}/\Gamma_\mathrm{sc}$ of the
#!   primitive cell by the supercell translation group as a `RightTransversal`
#!   object.
#! @Arguments cellembed
#! @Label for TGCellEmbedding
DeclareOperation( "AsQuotient", [ IsTGCellEmbeddingObj ] );
#! @Description
#!   returns the right transversal of the quotient group
#!   $\Gamma_\mathrm{pc}/\Gamma_\mathrm{sc}$ of the primitive cell by the supercell
#!   translation group as a list of representatives in $\Gamma$.
#! @Arguments cellembed
#! @Label for TGCellEmbedding
DeclareOperation( "GetRightTransversal", [ IsTGCellEmbeddingObj ] );
#! @Description
#!   Constructs an embedding homomorphism from the supercell translation group
#!   (as an abstract finitely-presented group) to the primitive-cell translation
#!   group (also as an abstract finitely-presented group).
#! @Arguments supercell-model
#! @Returns group homomorphism from the translation group associated with
#! `GetTGSuperCell(`supercell-model`)` to the translation group associated with
#! `GetTGPrimitiveCell(`supercell-model`)`, each obtained from the cell using
#! `FpGroup(TGCellTranslationGroup(`cell`))`.
#! @Label for TGCellEmbedding
DeclareOperation( "TranslationGroupEmbedding", [ IsTGCellEmbeddingObj ] );

#!
#!
#! @Section Export and Import
#! 
#! @BeginGroup ExportTGSuperCellModelGraph
#! @GroupTitle Exporting TGSuperCellModelGraph Objects
#!
#! @Description
#!   Export the supercell model graph <A>model</A> to the `OutputTextStream`
#!   <A>output-stream</A>
#! @Arguments model,output-stream
#! @Label for TGSuperCellModelGraph, OutputTextStream
DeclareOperation( "Export", [ IsTGSuperCellModelGraphObj, IsOutputTextStream ] );
#!
#! @Description
#!   or to the file at the path given by the string <A>path</A>.
#! @Arguments model,path
#! @Label for TGSuperCellModelGraph, String
DeclareOperation( "Export", [ IsTGSuperCellModelGraphObj, IsString ] );
#!
#! @Description
#!   Alternatively, the supercell model graph can be exported to a string with
#!   `ExportString`, which returns said string.
#! @Arguments model
#! @Label for TGSuperCellModelGraph
DeclareOperation( "ExportString", [ IsTGSuperCellModelGraphObj ] );
#!
#! @EndGroup
#!
#! @BeginGroup ImportTGSuperCellModelGraph
#! @GroupTitle Importing TGSuperCellModelGraph Objects
#!
#! @Description
#!   Import a supercell model graph from the `InputTextStream` <A>input-stream</A>
#! @Arguments input-stream[,tg]
#! @Returns model graph as `TGSuperCellModelGraph`
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGSuperCellModelGraph" );
#!
#! @Description
#!   or from the file at the path given by the string <A>path</A>.
#! @Arguments path[,tg]
#! @Returns model graph as `TGSuperCellModelGraph`
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGSuperCellModelGraphFromFile" );
#!
#! @Description
#!   Alterantively, the supercell model graph can be imported from the string
#!   <A>string</A>.
#!   Optionally, the triangle group can be given as a `ProperTriangleGroup` object
#!   <A>tg</A> (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments string[,tg]
#! @Returns model graph as `TGSuperCellModelGraph`
#! (see <Ref Sect='Section_TGSuperCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGSuperCellModelGraphFromString" );
#!
#! @EndGroup