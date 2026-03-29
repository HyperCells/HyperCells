#!
#!
#! @Chapter Triangle-Group Cells
#!
#!
#! @Section Cell Graphs
#! @SectionLabel TGCellGraph
#!
#! Given a triangle-group quotient $G^+\cong\Delta^+/\Gamma$ and a choice of center,
#! the cell graph defines a maximally symmetric triangular tessellation of the
#! corresponding connected and compactified translation unit cell.
#! It is implemented as a `TGCellGraph` object with the following components:
#! - <Ref Oper='GetTGCell' Label='for TGCellGraph'/>:
#!   the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>)
#! - <Ref Oper='CellCenter' Label='for TGCellGraph'/>:
#!   the center of the cell graph
#! - <Ref Oper='CellVertices' Label='for TGCellGraph'/>:
#!   the vertices of the cell graph
#! - <Ref Oper='CellEdges' Label='for TGCellGraph'/>:
#!   the edges of the cell graph including potential translations associated with
#!   them
#! - <Ref Oper='CellFaces' Label='for TGCellGraph'/>:
#!   the oriented faces of the cell graph
#! - <Ref Oper='CellBoundary' Label='for TGCellGraph'/>:
#!   the boundary specifications of the cell graph giving the boundary identifications
#! and is printed in the form
#! @BeginLog
#! TGCellGraph( cell,
#!   center = w,
#!   vertices = [ [ w1, gi1 ], [ w2, gi2 ], ... ],
#!   edges = [ [ v1, v2, s, gam ], ... ],
#!   faces = [ [ [ e1, o1 ], [ e2, o2 ], ... ], ... ],
#!   boundary = [ [ d1, d2, e, b, m, gam ], ... ]
#! )
#! @EndLog
#! See the corresponding references above for details.
#!
#! Cell graphs are constructed using the function <Ref Func='TGCellGraph'/>
#! by specifying the triangle group, its quotient and the center.

DeclareCategory( "IsTGCellGraphObj", IsObject );

#! @Description
#!   Construct the cell graph representing a connected and symmetric cell that is
#!   specified by
#!   - the `ProperTriangleGroup` (see <Ref Sect='Section_TriangleGroups'/>) <A>tg</A>,
#!   - the `TGQuotient` (see <Ref Sect='Section_TGQuotient'/>) <A>quotient</A>
#!   - and is centered at <A>center</A>, an integer between $1$ and $3$ corresponding
#!     to one of the three vertices $x$, $y$, $z$, of the fundamental Schwarz triangle.
#!
#!   Optionally, generators <A>GAMgens</A> of the translation group $\Gamma$ can be
#!   explicitly given as elements of <A>tg</A>. If not given, they are computed
#!   automatically.
#!   Similarly, choices for the transversals $T_{\Delta^+}(\Gamma)$ and $T_{G^+}(G_w^+)$
#!   can be given as <A>TDGAM</A> and <A>TGGw</A>, respectively. If not given, they
#!   are computed automatically.
#!   Here, <A>TDGAM</A> is a list of elements of <A>tg</A> and <A>TGGw</A> is a list
#!   of three lists, one for $w=x,y,z$, respectively, of elements of <A>tg</A>.
#!
#!   The option `simplify`, which takes a non-negative integer as argument, can be
#!   used to specify the level of simplification of words in the translation group,
#!   both for the translation generators expressed in terms of generators of the
#!   proper triangle group and for the translations expressed as elements of the
#!   finitely presented group
#!   `FpGroup(TGCellTranslationGroup(GetTGCell(`<A>cellgraph</A>`)))`. The additional option
#!   `simplifyMethod`, which takes a string, can be used to specify the method of simplification. 
#!   By default `simplifyMethod` is set to `"BruteForce"`. If the package kbmag 
#!   (see kbmag reference manual <URL Text="kbmag Reference Manual ">https://docs.gap-system.org/pkg/kbmag/doc/chap0_mj.html</URL>)
#!   is loaded it is possible to set `simplifyMethod` to `"KnuthBendix"`, such that the 
#!   Knuth-Bendix completion algorithm is used in the simplification. This method uses the available space in cache, 
#!   which can be flushed by calling `FlushCaches` 
#!   (see section Mutability and Copying in the <URL Text="GAP Reference Manual ">https://docs.gap-system.org/doc/ref/chap0_mj.html</URL>). 
#! @Arguments tg,quotient,center[,GAMgens[,TDGAM[,TGGw]]]
#! @Returns cell graph as `TGCellGraph` object (see <Ref Sect='Section_TGCellGraph'/>).
DeclareGlobalFunction( "TGCellGraph" );

# # @Description
# #   Construct a cell graph specified by the triangle group `tg` and its quotient `quotient` centered at `center`, which is `1`, `2` or `3`, with random choices of representatives.
# #   The resulting cell does **not** correspond to a symmetric connected cell.
# # @Arguments tg,quotient,center[,generators]
# # @Returns cell graph as `TGCellGraph`
# DeclareGlobalFunction( "RandomTGCellGraph" );

#! @Description
#!   returns the proper triangle group $\Delta^+$ on which the cell is based
#!   as a `ProperTriangleGroup` object (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "GetProperTriangleGroup", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the relators in terms of elements of
#!   `GetProperTriangleGroup(`<A>cellgraph</A>`)` defining the cell.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellRelators", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the an integer between $1$ and $3$ indicating the type of vertex of the
#!   triangle tessellation at the center of the cell graph with $1$, $2$, $3$
#!   corresponding to the vertices $x$, $y$, $z$, of the fundamental Schwarz triangle.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellCenter", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the vertices of the cell graph as a list.
#!
#!   Each vertex is of the form `[ w, gi ]` with `w` an integer between 1 and 3
#!   indicating the vertex of the fundamental Schwarz triangle and `gi` the position
#!   of the element in the transversal $T_{G^+}(G_w^+)$ labeling the vertex.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellVertices", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the positions of the vertices as elements of the proper triangle
#!   group $\Delta^+$.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellVertexPositions", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the edges of the cell graph as a list.
#! 
#!   Each edge is of the form `[ v1, v2, s, gam ]` with `v1`, `v2` the positions of
#!   the vertices in `CellVertices(`<A>cellgraph</A>`)` connected by the edge, `s`
#!   the position of the element of $T_{\Delta^+}(\Gamma)$ labeling the Schwarz
#!   triangle this edge is a part of, and `gam` the translation relating the unit	
#!   cell containing `v1` to the unit cell containing `v2`, as element of the
#!   finitely presented group
#!   `FpGroup(TGCellTranslationGroup(GetTGCell(`<A>cellgraph</A>`)))`.
#!   If `v1` corresponds to the vertex $(w, [g_{u_w}]_w)$ and `v2` to the vertex
#!   $(w', [g_{\tilde{u}_{w'}}]_{w'})$, then `gam` corresponds to the translation
#!   $\gamma$ such that
#!   $$g_{\tilde{u}_{w'}} = g_{u_w}\gamma.$$
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellEdges", [ IsTGCellGraphObj ] );
#! @Description
#!   returns only the list of translations associated with the edges of the cell graph
#!   in the same format as <Ref Oper="CellEdges" Label="for TGCellGraph"/>.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellEdgeTranslations", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the faces of the cell graph as a list.
#!
#!   Each face is an ordered list of tuples `[ edge, orientation ]`, where `edges`
#!   is a position in `CellEdges(`<A>cellgraph</A>`)` and `orientation` is equal to
#!   +1 (-1) if the orientation is the same (opposite) compared to the entry in
#!   `CellEdges(`<A>cellgraph</A>`)`.
#!   The edges of the face are ordered such that the orientation of the face is
#!   positive.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellFaces", [ IsTGCellGraphObj ] );
#! @Description
#!   returns a list of three lists with faces of the cell graph with the $x$, $y$, $z$
#!   vertex of the fundamental Schwarz triangle as center, respectively.
#!   The format of the faces is the same as
#!   <Ref Oper="CellFaces" Label="for TGCellGraph"/>.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellFacesWithCenter", [ IsTGCellGraphObj ] );
#! @Description
#!   returns a list of boundary specifications of the cell.
#!
#!   Each boundary is described by a list of the form `[ d1, d2, e, b, m, gam ]`,
#!   where `d1`, `d2` are elements of $T_{\Delta^+}(\Gamma)\subset\Delta^+$ labeling
#!   the Schwarz triangles this edge is a part of, `e` the position in the list of
#!   edges `CellEdges(`<A>cellgraph</A>`)`, `b` the index of the boundary (identical
#!   for identified boundaries), `m` either 0 or 1 indicating the orientation of the
#!   triangle associated with this instance of the boundary (0 for gray and 1 for white),
#!   and `gam` the translation relating the given to the identified boundary, as
#!   an element of the finitely presented group
#!   `FpGroup(TGCellTranslationGroup(GetTGCell(`<A>cellgraph</A>`)))`.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "CellBoundary", [ IsTGCellGraphObj ] );
#! @Description
#!   returns the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>).
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "GetTGCell", [ IsTGCellGraphObj ] );

#! @BeginGroup ExportTGCellGraph
#! @GroupTitle Exporting TGCellGraph Objects

#! @Description
#!   Export the cell graph <A>cellgraph</A> to the `OutputTextStream`
#!   <A>output-stream</A>
#! @Arguments cellgraph,output-stream
#! @Label for TGCellGraph, OutputTextStream
DeclareOperation( "Export", [ IsTGCellGraphObj, IsOutputTextStream ] );

#! @Description
#!   or to the file at the path given by the string <A>path</A>.
#! @Arguments cellgraph,path
#! @Label for TGCellGraph, String
DeclareOperation( "Export", [ IsTGCellGraphObj, IsString ] );

#! @Description
#!   Alterantively, the cell graph can be exported to a string with
#!   `ExportString`, which returns said string.
#! @Arguments cellgraph
#! @Label for TGCellGraph
DeclareOperation( "ExportString", [ IsTGCellGraphObj ] );

#! @EndGroup

#! @BeginGroup ImportTGCellGraph
#! @GroupTitle Importing TGCellGraph Objects

#! @Description
#!   Import a cell graph from the `InputTextStream` <A>input-stream</A>
#! @Arguments input-stream[,tg]
#! @Returns cell graph as `TGCellGraph`
#! (see <Ref Sect='Section_TGCellGraph'/>).
DeclareGlobalFunction( "ImportTGCellGraph" );

#! @Description
#!   or from the file at the path given by the string <A>path</A>.
#! @Arguments path[,tg]
#! @Returns cell graph as `TGCellGraph`
#! (see <Ref Sect='Section_TGCellGraph'/>).
DeclareGlobalFunction( "ImportTGCellGraphFromFile" );

#! @Description
#!   Alterantively, the cell graph can be imported from the string <A>string</A>.
#!   Optionally, the triangle group can be given as a `ProperTriangleGroup` object
#!   <A>tg</A> (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments string[,tg]
#! @Returns cell graph as `TGCellGraph`
#! (see <Ref Sect='Section_TGCellGraph'/>).
DeclareGlobalFunction( "ImportTGCellGraphFromString" );

#! @EndGroup