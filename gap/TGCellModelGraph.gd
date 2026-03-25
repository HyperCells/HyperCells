#!
#!
#! @Chapter Tight-binding Model Graphs
#!
#!
#! @Section Cell Model Graphs
#! @SectionLabel TGCellModelGraph
#! 
#! Tight-binding models are defined on top of a cell graph by selecting some of the
#! vertices of the cell graph and adding edges between them.
#! The model is thus defined on a **cell** and forms itself a graph of the same structure
#! as the cell graph. The vertices of the model graph are a subset of vertices of
#! the cell graph, while the edges must not be a subset of the edges of the cell graph.
#! Faces are given as ordered lists of edges of the model graph.
#!
#! Model graphs are implemented as objects of category `TGCellModelGraph` with
#! the following components:
#! - <Ref Oper='GetTGCell' Label='for TGCellModelGraph'/>:
#!   the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>)
#! - <Ref Oper='CellCenter' Label='for TGCellModelGraph'/>:
#!   the cell center of the model graph
#! - <Ref Oper='ModelType' Label='for TGCellModelGraph'/>:
#!   identifier of the type of model, e.g., tessellation, kagome, Lieb etc.
#! - <Ref Oper='CellVertices' Label='for TGCellModelGraph'/>:
#!   the vertices of the model graph, i.e., the sites of the tight-binding model
#! - <Ref Oper='CellEdges' Label='for TGCellModelGraph'/>:
#!   the edges of the model graph, i.e., the hoppings of the tight-binding model,
#!   including potential translations associated with them
#! - <Ref Oper='CellFaces' Label='for TGCellModelGraph'/>:
#!   the oriented faces of the model graph, i.e., the plaquettes of the tight-binding
#!   model
#! and is printed in the form
#! @BeginLog
#! TGCellModelGraph( cell,
#!   center = w,
#!   type = <type>,
#!   vertices = [ [ w1, gi1 ], [ w2, gi2 ], ... ],
#!   edges = [ [ v1, v2, tag, gam ], ... ],
#!   faces = [ [ [ e1, o1 ], [ e2, o2 ], ... ], ... ],
#!   boundary = [ [ d1, d2, e, b, m, gam ], ... ]
#! )
#! @EndLog
#! See the corresponding references above and the discussion of `tag` in
#! <Ref Sect='Section_TGCellModelGraph'/> for details.
#!

DeclareCategory( "IsTGCellModelGraphObj", IsObject );

#!
#!
#! @Section Constructing Models
#! @SectionLabel ConstructingModels
#! 
#! There are several functions for constructing specfic tight-binding models:
#! - <Ref Func='TGCellModelGraph'/>:
#!   constructs a model graph from a cell graph and a specification of which cell-graph
#!   vertices are to be used as vertices of the model graph, which define edges,
#!   and which define faces of the model graph.
#! - <Ref Func='TessellationModelGraph'/>:
#!   constructs a tessellation graph from a cell graph of a triangle group.
#! - <Ref Func='KagomeModelGraph'/>:
#!   constructs a kagome graph from a cell graph of a triangle group.
#! - <Ref Func='LiebModelGraph'/>:
#!   constructs a Lieb graph from a cell graph of a triangle group.

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

#! As shown in <Ref Sect='Section_TGCellModelGraph'/>, additional information about the
#! edges is given by edge tags. The edge tags depend on the particular model type, but
#! follow the basic structure
#!   @BeginLog
#! [ n, root ]
#!   @EndLog
#! where `n` specifies the range of the edge, i.e., `1` for nearest-neighbors (based on
#! the cell graph), `2` for next-nearest-neighbors, and so on, and `root` specifies how
#! the edge was constructed.
#! For `n=1`, `root` takes the form
#!   @BeginLog
#! [ [ w, gi ], s1, s2 ]
#!   @EndLog
#! where `gi` is the position of the element $\delta$ in $T_{G^+}(G_w^+)$ characterizing the
#! cell-graph edge vertex the edge roots in, and `s1`, `s2` are the positions of the
#! Schwarz triangles $g_1,g_2$ associated with the cell-graph edges in $T_{\Delta^+}(\Gamma)$.
#! We can obtain $\delta$ as follows:
#!   @BeginLog
#! GetRightTransversal( TGCellMSWPs( GetTGCell( model ) ) )[w][gi]
#!   @EndLog
#! and $g_1$:
#!   @BeginLog
#! GetRightTransversal( TGCellPointGroup( GetTGCell( model ) ) )[s1]
#!   @EndLog
#! For `n=2`, on the other hand, edges are constructed based on faces, and as such `root`
#!   takes the form
#!   @BeginLog
#! [ f, e1, e2 ]
#!   @EndLog
#! where `f` is the position of the face characterizing the edge in the list of faces
#! `CellFaces(model)`, and `e1`, `e2` are the positions of the nearest-neighbor
#! edges that together connect the same vertices as the next-nearest-neighbor edge
#! in the list of edges `CellEdges(model)`.


#! @Description
#!   Constructs the model graph derived from the `TGCellGraph` (see
#!   <Ref Sect='Section_TGCellGraph'/>) <A>cellgraph</A> by selecting the vertices
#!   of types given in the list <A>vfs</A> as vertices of the model graph.
#!   The type is given in terms of the cell graph's vertex type, i.e., 1, 2, or 3,
#!   corresponding to the vertices of the fundamental Schwarz triangle $x$, $y$, and $z$,
#!   respectively.
#!   The edges of the model graph are determined by adjacency to the cell-graph vertices
#!   of the type given in the list <A>efs</A> and the faces are determined by the
#!   cell-graph vertices of the type given in the list <A>ffs</A>.
#!   
#!   The model type is set to
#!   @BeginLog
#! [ "VEF", [ vfs, efs, ffs ] ]
#!   @EndLog
#!   and edge tags take the form
#!   @BeginLog
#! [ 1, [ ve, s1, s2 ] ]
#!   @EndLog
#!   where the first entry, `1`, indicates a nearest-neighbor edge, `ve=[w,gi]` specifies
#!   the cell-graph edge vertex with `gi` the position of the element in $T_{G^+}(G_w^+)$,
#!   and `s1`, `s2` are the positions of the Schwarz triangles associated with the
#!   cell-graph edges in $T_{\Delta^+}(\Gamma)$.
#! @Arguments cellgraph,vfs,efs,ffs
#! @Returns the model graph as `TGCellModelGraph` object
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "TGCellModelGraph" );

#! @Description
#!   Constructs the $\{p,q\}$-tessellation model graph derived from the `TGCellGraph`
#!   (see <Ref Sect='Section_TGCellGraph'/>) <A>cellgraph</A> of the triangle group
#!   $(2,q,p)$ associated with <A>cellgraph</A>.
#!   If the optional argument <A>dual</A> is set to true, the $\{q,p\}$-tessellation
#!   is constructed instead.
#!   
#!   The model type is set to
#!   @BeginLog
#! [ "TESS", [ p, q ], [ "VEF", [ [ 2 ], [ 1 ], [ 3 ] ] ] ]
#!   @EndLog
#!   for the $\{p,q\}$ tessellation and to
#!   @BeginLog
#! [ "TESS", [ q, p ], [ "VEF", [ [ 3 ], [ 1 ], [ 2 ] ] ] ]
#!   @EndLog
#!   for the $\{q,p\}$ tessellation.
#!   The edge tags are given in the same format as in <Ref Func='TGCellModelGraph'/>.
#! @Arguments cellgraph[,dual]
#! @Returns the model graph as `TGCellModelGraph` object
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "TessellationModelGraph" );

#! @Description
#!   Modifies the $\{p,q\}$-tessellation model graph <A>model</A> in place by adding
#!   oriented next-nearest neighbor edges to all faces with at least five edges.
#!   The orientation of the next-nearest neighbor edges follows the positive
#!   orientation of the faces of the $\{p,q\}$-tessellation.
#!   Faces with four or less edges are ignored.
#!   
#!   The edge tags of the next-nearest neighbor edges take the form
#!   @BeginLog
#! [ 2, [ f, e1, e2 ] ]
#!   @EndLog
#!   where the first entry, `2`, indicates a next-nearest-neighbor edge, `f` is the
#!   position of the face characterizing the edge in the list of faces
#!   `CellFaces(`<A>model</A>`)`, and `e1`, `e2` are the positions of the nearest-neighbor
#!   edges that together connect the same vertices as the next-nearest-neighbor edge
#!   in the list of edges `CellEdges(`<A>model</A>`)`.
#!   The model type remains unchanged.
#! @Arguments model
DeclareGlobalFunction( "AddOrientedNNNEdgesToTessellationModelGraph" );

#! @Description
#!   Constructs the $p$-kagome model graph derived from the `TGCellGraph`
#!   (see <Ref Sect='Section_TGCellGraph'/>) <A>cellgraph</A> of the triangle group
#!   $(2,3,p)$ associated with <A>cellgraph</A>.
#!   
#!   The model type is set to
#!   @BeginLog
#! [ "KAGOME", p, [ "VEF", [ [ 1 ], [ 2 ], [ 2, 3 ] ] ] ]
#!   @EndLog
#!   The edge tags are given in the same format as in <Ref Func='TGCellModelGraph'/>.
#! @Arguments cellgraph
#! @Returns the model graph as `TGCellModelGraph` object
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "KagomeModelGraph" );

#! @Description
#!   Constructs the $\{p,q\}$-Lieb model graph derived from the `TGCellGraph`
#!   (see <Ref Sect='Section_TGCellGraph'/>) <A>cellgraph</A> of the triangle group
#!   $(2,q,p)$ associated with <A>cellgraph</A>.
#!   If the optional argument <A>dual</A> is set to true, the $\{q,p\}$-Lieb
#!   is constructed instead.
#!   
#!   The model type is set to
#!   @BeginLog
#! [ "LIEB", [ p, q ], [ "VEF", [ [ 1, 2 ], [  ], [ 3 ] ] ] ]
#!   @EndLog
#!   for the $\{p,q\}$ tessellation and to
#!   @BeginLog
#! [ "LIEB", [ q, p ], [ "VEF", [ [ 1, 3 ], [  ], [ 2 ] ] ] ]
#!   @EndLog
#!   for the $\{q,p\}$ tessellation.
#!   The edge tags are given in the same format as in <Ref Func='TGCellModelGraph'/>.
#! @Arguments cellgraph[,dual]
#! @Returns the model graph as `TGCellModelGraph` object
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "LiebModelGraph" );


#!
#!
#! @Section Model Properties
#! 
#! @Description
#!   returns the proper triangle group $\Delta^+$ on which the model is based
#!   as a `ProperTriangleGroup` object (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "GetProperTriangleGroup", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the relators in terms of elements of
#!   `GetProperTriangleGroup(`<A>model</A>`)` specifying the cell on which the model
#!   is defined.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellRelators", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the an integer between $1$ and $3$ indicating the type of vertex of the
#!   triangle tessellation at the center of the cell graph with $1$, $2$, $3$
#!   corresponding to the vertices $x$, $y$, $z$, of the fundamental Schwarz triangle.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellCenter", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the associated `TGCell` object (see <Ref Sect='Section_TGCell'/>).
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "GetTGCell", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns a the identifier of the model type.
#!   
#!   The following model types are currently implemented:
#!   - **Derived graph**: general model graph with vertices, edges, and faces derived from
#!     the cell graph. The model type is given as
#!     @BeginLog
#! [ "VEF", [ vfs, efs, ffs ] ]
#!     @EndLog
#!     where `vfs`, `efs`, and `ffs` are lists of integers between 1 and 3
#!     indicating the vertex types, edge types, and face types, respectively.
#!     See <Ref Func='TGCellModelGraph'/> for details.
#!   - **Tessellation graph**: tessellation model graph derived from a cell graph of a triangle
#!     group. The model type is given as
#!     @BeginLog
#! [ "TESS", [ p, q ], [ "VEF", [ [ 2 ], [ 1 ], [ 3 ] ] ] ]
#!     @EndLog
#!     for the $\{p,q\}$ tessellation and as
#!     @BeginLog
#! [ "TESS", [ q, p ], [ "VEF", [ [ 3 ], [ 1 ], [ 2 ] ] ] ]
#!     @EndLog
#!     for the (dual) $\{q,p\}$ tessellation.
#!     See <Ref Func='TessellationModelGraph'/> for details.
#!   - **Kagome graph**: kagome model graph derived from a cell graph of a triangle
#!     group. The model type is given as
#!     @BeginLog
#! [ "KAGOME", p, [ "VEF", [ [ 1 ], [ 2 ], [ 2, 3 ] ] ] ]
#!     @EndLog
#!     See <Ref Func='KagomeModelGraph'/> for details.
#!   - **Lieb graph**: Lieb model graph derived from a cell graph of a triangle
#!     group. The model type is given as
#!     @BeginLog
#! [ "LIEB", [ p, q ], [ "VEF", [ [ 1, 2 ], [  ], [ 3 ] ] ] ]
#!     @EndLog
#!     for the $\{p,q\}$ tessellation and as
#!     @BeginLog
#! [ "LIEB", [ q, p ], [ "VEF", [ [ 1, 3 ], [  ], [ 2 ] ] ] ]
#!     @EndLog
#!     for the (dual) $\{q,p\}$ tessellation.
#!     See <Ref Func='LiebModelGraph'/> for details.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "ModelType", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns a friendly name of the model.
#!   The friendly name is constructed from the model type and for the implemented
#!   model types is given as
#!   - **Derived graph**: `"derived-model&lt;[vfs,efs,ffs]&gt;"`
#!   - **Tessellation graph**: `"{p,q}-tess"`
#!   - **Kagome graph**: `"p-kagome"`
#!   - **Lieb graph**: `"{p,q}-Lieb"`
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "ModelName", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the vertices of the model graph as a list.
#!
#!   Each vertex is of the form `[ w, gi ]` with `w` an integer between 1 and 3
#!   indicating the vertex of the fundamental Schwarz triangle and `gi` the position
#!   of the element in the transversal $T_{G^+}(G_w^+)$ labeling the vertex.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellVertices", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the positions of the vertices as elements of the proper triangle
#!   group $\Delta^+$.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellVertexPositions", [ IsTGCellModelGraphObj ] );
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
#!   More details on the tags are given in the methods for constructing different
#!   models, see <Ref Sect='Section_ConstructingModels'/>.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellEdges", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns only the list of translations associated with the edges of the model
#!   in the same format as <Ref Oper="CellEdges" Label="for TGCellModelGraph"/>.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellEdgeTranslations", [ IsTGCellModelGraphObj ] );
#! @Description
#!   returns the faces of the model graph as a list.
#!
#!   Each face is an ordered list of tuples `[ edge, orientation ]`, where `edges`
#!   is a position in `CellEdges(`<A>model</A>`)` and `orientation` is equal to
#!   +1 (-1) if the orientation is the same (opposite) compared to the entry in
#!   `CellEdges(`<A>model</A>`)`.
#!   The edges of the face are ordered such that the orientation of the face is
#!   positive.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "CellFaces", [ IsTGCellModelGraphObj ] );

#!
#!
#! @Section Export and Import
#! 
#! @BeginGroup ExportTGCellModelGraph
#! @GroupTitle Exporting TGCellModelGraph Objects
#!
#! @Description
#!   Export the model graph <A>model</A> to the `OutputTextStream`
#!   <A>output-stream</A>
#! @Arguments model,output-stream
#! @Label for TGCellModelGraph, OutputTextStream
DeclareOperation( "Export", [ IsTGCellModelGraphObj, IsOutputTextStream ] );

#! @Description
#!   or to the file at the path given by the string <A>path</A>.
#! @Arguments model,path
#! @Label for TGCellModelGraph, String
DeclareOperation( "Export", [ IsTGCellModelGraphObj, IsString ] );

#! @Description
#!   Alternatively, the model graph can be exported to a string with
#!   `ExportString`, which returns said string.
#! @Arguments model
#! @Label for TGCellModelGraph
DeclareOperation( "ExportString", [ IsTGCellModelGraphObj ] );
#!
#! @EndGroup
#!
#! @BeginGroup ImportTGCellModelGraph
#! @GroupTitle Importing TGCellModelGraph Objects
#!
#! @Description
#!   Import a model graph from the `InputTextStream` <A>input-stream</A>
#! @Arguments input-stream[,tg]
#! @Returns model graph as `TGCellModelGraph`
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGCellModelGraph" );

#! @Description
#!   or from the file at the path given by the string <A>path</A>.
#! @Arguments path[,tg]
#! @Returns model graph as `TGCellModelGraph`
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGCellModelGraphFromFile" );

#! @Description
#!   Alterantively, the model graph can be imported from the string <A>string</A>.
#!   Optionally, the triangle group can be given as a `ProperTriangleGroup` object
#!   <A>tg</A> (see <Ref Sect='Section_TriangleGroups'/>).
#! @Arguments string[,tg]
#! @Returns model graph as `TGCellModelGraph`
#! (see <Ref Sect='Section_TGCellModelGraph'/>).
DeclareGlobalFunction( "ImportTGCellModelGraphFromString" );
#!
#! @EndGroup