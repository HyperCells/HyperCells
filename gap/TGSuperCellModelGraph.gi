# Type TGCellModelGraph
DeclareRepresentation("IsTGSuperCellModelGraphComponentRep", IsComponentObjectRep, [
	"primitivecell",
	"supercell",
	"cellembed",
	"center",
	"type",
	"vertices",
	"vertexpos",
	"edges",
	"faces"
] );

# Type TGCellEmbedding
DeclareRepresentation("IsTGCellEmbeddingComponentRep", IsComponentObjectRep,
	[ "GAMpc", "GAMsc", "Q", "T", "hom" ]
);

InstallMethod( \=, [
    IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep,
    IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ], 
function(mg1, mg2)
	return GetTGPrimitiveCell(mg1) = GetTGPrimitiveCell(mg2) and
		GetTGSuperCell(mg1) = GetTGSuperCell(mg2) and
		CellEmbedding(mg1) = CellEmbedding(mg2) and
		CellCenter(mg1) = CellCenter(mg2) and
        ModelType(mg1) = ModelType(mg2) and
		CellVertices(mg1) = CellVertices(mg2) and
		PrintString(CellVertexPositions(mg1)) = PrintString(CellVertexPositions(mg2)) and
		PrintString(CellEdges(mg1)) = PrintString(CellEdges(mg2)) and
        CellFaces(mg1) = CellFaces(mg2);
end );

InstallMethod( PrintString, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return Concatenation("TGSuperCellModelGraph( ",
		"primitive cell = ", PrintString(GetTGPrimitiveCell(model)), ", ",
		"supercell = ", PrintString(GetTGSuperCell(model)), ", ",
		"cell embedding = ", PrintString(CellEmbedding(model)), ", ",
		"center = ", PrintString(CellCenter(model)), ", ",
        "type = ", PrintString(ModelType(model)), ", ",
		"vertices = ", PrintString(CellVertices(model)), ", ",
		"edges = ", PrintString(CellEdges(model)), ", ",
		"faces = ", PrintString(CellFaces(model)),
	" )");
end );

InstallMethod( PrintObj, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	Print(PrintString(model));
end );

# Accessors

InstallMethod( GetProperTriangleGroup, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return GetProperTriangleGroup(model!.primitivecell);
end );

InstallMethod( PrimitiveCellRelators, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return CellRelators(model!.primitivecell);
end );

InstallMethod( SuperCellRelators, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return CellRelators(model!.supercell);
end );

InstallMethod( CellCenter, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.center;
end );

InstallMethod( GetTGPrimitiveCell, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.primitivecell;
end );

InstallMethod( GetTGSuperCell, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.supercell;
end );

InstallMethod( GetTGCell, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return GetTGSuperCell(model);
end );

InstallMethod( ModelType, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.type;
end );

InstallMethod( CellVertices, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.vertices;
end );

InstallMethod( CellVertexPositions, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	# local TGGw, pos, v;

	# # vertex labels
	# TGGw := GetRightTransversal(TGCellMSWPs(model!.supercell));

	# # obtain vertex labels in correct order
	# pos := [];
	# for v in model!.vertices do
	# 	Append(pos, [ TGGw[v[1]][v[2]] ]);
	# od;

	# return pos;
	return model!.vertexpos;
end );

InstallMethod( CellEdges, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.edges;
end );

InstallMethod( CellEdgeTranslations, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return List(model!.edges, e -> e[4]);
end );

InstallMethod( CellFaces, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.faces;
end );

InstallMethod( CellEmbedding, [ IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ],
function(model)
	return model!.cellembed;
end );

# Methods

# Decomposes an element d of D according to the coset decomposition:
#   d = r * g * gam,
# where
#   r in {g in T_D(GAM) : g in Gw}
#   g in T_G(Gw)
#   gam in GAM
# and returns the record with components r, g, gam.
TGCellDecomposition@ := function(cell, w, d)
    local dG, g, rG, r, gam;

    dG := Image(QuotientHomomorphism(TGCellPointGroup(cell)), d); # in G, coset d * GAM
    g := GetRightTransversal(TGCellMSWPs(cell))[w][PositionCanonical(AsQuotient(TGCellMSWPs(cell))[w], dG)]; # in T_G(G_w), rep of dinG
    rG := Image(QuotientHomomorphism(TGCellPointGroup(cell)), d * g^-1); # in Gw, arbitrary rep of coset r * GAM
    rG := GetKernel(TGCellMSWPs(cell))[w][Position(GetKernel(TGCellMSWPs(cell))[w], rG)]; # pick canonical rep
    r := PreImagesRepresentative(QuotientHomomorphism(TGCellPointGroup(cell)), rG); # in {g in T_D(GAM) : g in Gw}
    gam := g^-1 * r^-1 * d;

    return rec(
        r := r,
        g := g,
        gam := gam
    );
end;

# Decomposes an element d of D according to the coset decomposition:
#   d = r * g * gam,
# where
#   r in {g in T_D(GAM) : g in Gw}
#   g in T_G(Gw)
#   gam in GAM
# and returns only g
TGCellDecompositionSiteLabel@ := function(cell, w, d)
    local dG;

	# in G, coset d * GAM
    dG := Image(QuotientHomomorphism(TGCellPointGroup(cell)), d);

	# in T_G(G_w), rep of dinG
    return GetRightTransversal(TGCellMSWPs(cell))[w][PositionCanonical(AsQuotient(TGCellMSWPs(cell))[w], dG)];
end;

InstallGlobalFunction( TGSuperCellModelGraph,
function(model, sc)
    local simplify, tg, D, pc,
        ucverts, ucvertpos, ucedges, ucetransls, ucfaces,
        verts, pos, vertexpos, edges, faces,
        QGAMs, TGAMs,
        i, i1, i2, j, k, e, v1, v2,
        eta, gam0, eta2, gam1, gam2, gam,
        w, d0, g, w1, d10, d1, w2, d20, d2,
		cellembed;
	
	# check arguments
	if not (IsTGCellModelGraphObj(model) or IsTGSuperCellModelGraphObj(model)) then
		Error("The first argument must be a TGCellModelGraph (or IsTGSuperCellModelGraph) object.");
		return fail;
	fi;
	if not IsTGCellObj(sc) then
		Error("The second argument must be a TGCell object.");
		return fail;
	fi;

    # options
    simplify := ValueOption("simplify");
    if simplify = fail then
        simplify := 0;
    fi;

    # triangle group
    tg := GetProperTriangleGroup(model);
    if not (tg = GetProperTriangleGroup(sc)) then
        Error(StringFormatted("The triangle groups {} and {} of the primitive cell and supercell, respectively, do not match.", tg, GetProperTriangleGroup(sc)));
    fi;
    D := FpGroup(tg);
    
    # primitive unit cell
    pc := GetTGCell(model);

	if not IsSubgroup(AsTGSubgroup(TGCellTranslationGroup(pc)), AsTGSubgroup(TGCellTranslationGroup(sc))) then
		Error(StringFormatted("Supercell translation group {} is not a subgroup of the primitive-cell translation group {}.", AsTGSubgroup(TGCellTranslationGroup(sc)), AsTGSubgroup(TGCellTranslationGroup(pc))));
	fi;

    # model graph
    ucverts := CellVertices(model);
    ucvertpos := CellVertexPositions(model);
    ucedges := CellEdges(model);
    ucetransls := CellEdgeTranslations(model);
	ucfaces := CellFaces(model);

	# construct quotient GAM_pc/GAM_sc
	QGAMs := RightTransversal(AsTGSubgroup(TGCellTranslationGroup(pc)), AsTGSubgroup(TGCellTranslationGroup(sc)));
	TGAMs := Filtered(GetRightTransversal(TGCellPointGroup(sc)),
			d -> Image(QuotientHomomorphism(TGCellPointGroup(pc)), d) = One(AsQuotientGroup(TGCellPointGroup(pc)))
	); # intersection of T_D(GAM_sc) with Kernel(homDG_pc)
	
	# sort representatives according to ordering in transversal
	SortBy(TGAMs, d -> PositionCanonical(QGAMs, d));

	# vertices and their positions
	verts := [];
	pos := [];

	for i in [1..Length(TGAMs)] do # iterate over representatives of GAM0/GAM
		eta := TGAMs[i]; # in D, ~ pc in sc

		# vertices in supercell
		for j in [1..Length(ucverts)] do # iterate over representatives of G0
			w := ucverts[j][1]; # Schwarz site
			d0 := ucvertpos[j]; # in T_G0(Gw0), ~ site in pc
			
			# construct site in translated pc and decompose
			g := TGCellDecompositionSiteLabel@(sc, w, d0 * eta);

			# vertex
			# label [ w, position in T_D(GAM), position in T_GAM0(GAM) ]
			Append(verts, [ Concatenation(ucverts[j], [i]) ]);
			Append(pos, [ g ]); # in T_G(Gw)
		od;
	od;

	# edges and edge translations
	edges := [];

	for i1 in [1..Length(TGAMs)] do # iterate over representatives of GAMMA0/GAMMA
		eta := TGAMs[i1]; # in D, ~ pc in sc

		# edges in supercell
		for k in [1..Length(ucedges)] do # iterate over edges
			# edge in the unit cell
			e := ucedges[k];
			w1 := ucverts[e[1]][1]; # Schwarz site for site1
			d10 := ucvertpos[e[1]]; # in T_G0(Gw0), ~ site1 in pc
			w2 := ucverts[e[2]][1]; # Schwarz site for site2
			d20 := ucvertpos[e[2]]; # in T_G0(Gw0), ~ site2 in pc
			gam0 := PreImagesRepresentative(FpIsomorphism(TGCellTranslationGroup(pc)), ucetransls[k]); # in GAM0, edge translation
			# d02' = d02 * gam0
		
			# initial vertex in translated pc
			v1 := Position(verts, Concatenation(ucverts[e[1]], [i1])); # label
			d1 := TGCellDecomposition@(sc, w1, d10 * eta);
			gam1 := SimplifyWord@(FpGroup(TGCellTranslationGroup(sc)), Image(FpIsomorphism(TGCellTranslationGroup(sc)), d1.gam), simplify : simplifyMethod := ValueOption("simplifyMethod"));

			# target vertex
			eta2 := gam0 * eta; # target pc
			i2 := PositionCanonical(QGAMs, eta2); # same as position in TGAM0GAM
			v2 := Position(verts, Concatenation(ucverts[e[2]], [i2])); # label
			d2 := TGCellDecomposition@(sc, w2, d20 * eta2);
			gam2 := SimplifyWord@(FpGroup(TGCellTranslationGroup(sc)), Image(FpIsomorphism(TGCellTranslationGroup(sc)), d2.gam), simplify : simplifyMethod := ValueOption("simplifyMethod"));

			# translation in supercell
			# assuming d1 = r1 * g1 is in pc, d2 = r2 * g2 * gam
			gam := SimplifyWord@(FpGroup(TGCellTranslationGroup(sc)), gam2 * gam1^-1, simplify : simplifyMethod := ValueOption("simplifyMethod"));

			# edge
			Append(edges, [ [ v1, v2, e{[1..3]}, gam ] ]);
		od;
	od;

	# faces
	faces := []; # TODO: implement faces

	# embedding
	cellembed := Objectify( NewType( NewFamily( "TGCellEmbedding", IsTGCellEmbeddingObj ),
			IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ),
		rec(
			GAMpc := TGCellTranslationGroup(pc),
			GAMsc := TGCellTranslationGroup(sc),
			Q := QGAMs,
			T := TGAMs,
			hom := false
		)
	);

	return Objectify( NewType( NewFamily( "TGSuperCellModelGraph", IsTGSuperCellModelGraphObj ), IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ), rec(
		primitivecell := pc,
		supercell := sc,
		cellembed := cellembed,
		center := CellCenter(model),
        type := ModelType(model),
		vertices := MakeImmutable(verts),
		vertexpos := MakeImmutable(pos),
		edges := MakeImmutable(edges),
		faces := MakeImmutable(faces)
	));
end );

InstallGlobalFunction( UnrefinedTGSuperCellModelGraph,
function(model, scquotient, args...)
	local simplify, tg, D, pc, GAMMA0, screls,
		Gplus, GAM, GAMMA, homDG, fpGAM, isofpGAM, TDGAM,
		ucverts, ucvertpos, ucedges, ucetransls, ucfaces,
        QGAMs, TGAMs,
        verts, pos, vertexpos, edges, faces,
		i, i1, i2, j, k, e, v1, v2,
        eta, gam0, eta2, gam1, gam2, gam,
        w, g0, g, w1, d10, d1, w2, d20, d2,
		schwarz, GwGens, GwElems, QGGw, TGGw, itriangle, sc,
		cellembed;

	# check arguments
	if not (IsTGCellModelGraphObj(model) or IsTGSuperCellModelGraphObj(model)) then
		Error("The first argument must be a TGCellModelGraph (or IsTGSuperCellModelGraph) object.");
		return fail;
	fi;
	if not IsTGQuotientObj(scquotient) then
		Error("The second argument must be a TGQuotient object.");
		return fail;
	fi;

	# options
    simplify := ValueOption("simplify");
    if simplify = fail then
        simplify := 0;
    fi;

	# triangle group
    tg := GetProperTriangleGroup(model);
	D := FpGroup(tg);

	# primitive unit cell
    pc := GetTGCell(model);
	GAMMA0 := AsTGSubgroup(TGCellTranslationGroup(pc));

	## supercell ##
	# point group
	screls := TGQuotientRelators(tg, scquotient);
    Gplus := D / screls;

	# translation group
	GAM := CallFuncList(TGTranslationGroupFromQuotient,
		Concatenation([ D, Gplus, TGQuotientGenus(scquotient) ], args)
	);
	GAMMA := AsTGSubgroup(GAM);
	homDG := QuotientHomomorphism(GAM);
	fpGAM := FpGroup(GAM);
	isofpGAM := FpIsomorphism(GAM);

	# transversal T_D(GAMMA)
	if Length(args) > 1 then
		TDGAM := args[2];
	else
		TDGAM := List(Elements(Gplus), g -> PreImagesRepresentative(homDG, g));
	fi;

	# construct quotient GAMMA0/GAMMA
	QGAMs := RightTransversal(GAMMA0, GAMMA);
	if Length(args) > 2 then
		TGAMs := args[3];
	else
		TGAMs := Filtered(List(Elements(Gplus), g -> PreImagesRepresentative(homDG, g)),
				d -> Image(QuotientHomomorphism(TGCellPointGroup(pc)), d) = One(AsQuotientGroup(TGCellPointGroup(pc)))
		); # intersection of T_D(GAM_sc) with Kernel(homDG_pc)
	fi;

	# sort representatives according to ordering in transversal
	SortBy(TGAMs, d -> PositionCanonical(QGAMs, d));

	# model graph
    ucverts := CellVertices(model);
    ucvertpos := CellVertexPositions(model);
    ucedges := CellEdges(model);
    ucetransls := CellEdgeTranslations(model);
	ucfaces := CellFaces(model);

	# vertices and their positions
	verts := [];
	pos := [];

	for i in [1..Length(TGAMs)] do # iterate over representatives of GAM0/GAM
		eta := TGAMs[i]; # in D, ~ pc in sc

		# vertices in supercell
		for j in [1..Length(ucverts)] do # iterate over representatives of G0
			g0 := ucvertpos[j]; # in T_G0(Gw0), ~ site in pc
			
			# construct site in translated pc
			g := g0*eta;

			# vertex
			# label [ w, position in T_D(GAMMA), position in T_GAMMA0(GAMMA) ]
			Append(verts, [ Concatenation(ucverts[j], [i]) ]);
			Append(pos, [ g ]); # in T_G(Gw)
		od;
	od;

	# edges and edge translations
	edges := [];

	for i1 in [1..Length(TGAMs)] do # iterate over representatives of GAMMA0/GAMMA
		eta := TGAMs[i1]; # in D, ~ pc in sc

		# edges in supercell
		for k in [1..Length(ucedges)] do # iterate over edges
			# edge in the unit cell
			e := ucedges[k];

			# edge translation in GAM0 (d02' = d02 * gam0)
			gam0 := PreImagesRepresentative(FpIsomorphism(TGCellTranslationGroup(pc)), ucetransls[k]);

			# initial vertex in translated pc
			v1 := Position(verts, Concatenation(ucverts[e[1]], [i1])); # label

			# target vertex
			eta2 := gam0 * eta; # target pc
			i2 := PositionCanonical(QGAMs, eta2); # same as position in T_GAM0(GAM)
			v2 := Position(verts, Concatenation(ucverts[e[2]], [i2])); # label

			# translation in supercell
			gam := SimplifyWord@(fpGAM, Image(isofpGAM, TGAMs[i2]^-1*eta2), simplify : simplifyMethod := ValueOption("simplifyMethod"));

			# edge
			Append(edges, [ [ v1, v2, e{[1..3]}, gam ] ]);
		od;
	od;

	# faces
	faces := []; # TODO: implement faces

	# supercell 
	sc := Objectify( NewType( NewFamily( "TGCell", IsTGCellObj ), IsTGCellObj and IsTGCellComponentRep ), rec(
		trianglegroup := tg,
		relators := MakeImmutable(screls),
        GAM := Objectify( NewType(
			NewFamily( "TGCellTranslationGroup", IsTGCellTranslationGroupObj ),
			IsTGCellTranslationGroupObj and IsTGCellTranslationGroupComponentRep),
			rec(
				group := GAMMA,
				generators := MakeImmutable(GeneratorsOfGroup(GAMMA)),
				isofpgroup := isofpGAM,
				fpgroup := fpGAM
			)
		),
        G := Objectify( NewType(
			NewFamily( "TGCellPointGroup", IsTGCellPointGroupObj ),
			IsTGCellPointGroupObj and IsTGCellPointGroupComponentRep),
			rec(
				group := Gplus,
				Q := RightTransversal(D, GAMMA),
				T := MakeImmutable(TDGAM),
				qhom := homDG
			)
        ),
        GGw := false # TODO: implement GGw?
    ));

	# embedding
	cellembed := Objectify( NewType( NewFamily( "TGCellEmbedding", IsTGCellEmbeddingObj ),
			IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ),
		rec(
			GAMpc := TGCellTranslationGroup(pc),
			GAMsc := TGCellTranslationGroup(sc),
			Q := QGAMs,
			T := TGAMs,
			hom := false
		)
	);

	return Objectify( NewType( NewFamily( "TGSuperCellModelGraph", IsTGSuperCellModelGraphObj ), IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ), rec(
		primitivecell := pc,
		supercell := sc,
		cellembed := cellembed,
		center := CellCenter(model),
        type := ModelType(model),
		vertices := MakeImmutable(verts),
		vertexpos := MakeImmutable(pos),
		edges := MakeImmutable(edges),
		faces := MakeImmutable(faces)
	));
end );

InstallGlobalFunction( RandomTGSuperCellModelGraph,
function(model, scquotient, args...)
	Print("Warning: The function RandomTGSuperCellModelGraph has been renamed to UnrefinedTGSuperCellModelGraph. The old name will be deprecated, use UnrefinedTGSuperCellModelGraph instead.\n");
	return CallFuncList(UnrefinedTGSuperCellModelGraph, Concatenation([model, scquotient], args));
end );

InstallMethod( \=, [
    IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep,
    IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ], 
function(embd1, embd2)
	return PrimitiveCellTranslationGroup(embd1) = PrimitiveCellTranslationGroup(embd2) and
		SuperCellTranslationGroup(embd1) = SuperCellTranslationGroup(embd2) and
		AsQuotient(embd1) = AsQuotient(embd2) and
		GetRightTransversal(embd1) = GetRightTransversal(embd2);
end );

InstallMethod( PrintString, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	return Concatenation("TGCellEmbedding( ",
		"primitive cell = ", PrintString(PrimitiveCellTranslationGroup(cellembed)), ", ",
		"supercell = ", PrintString(SuperCellTranslationGroup(cellembed)), ", ",
		"transversal = ", PrintString(GetRightTransversal(cellembed)), ", ",
        "embedding = ", PrintString(TranslationGroupEmbedding(cellembed)), 
	" )");
end );

InstallMethod( PrintObj, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	Print(PrintString(cellembed));
end );

InstallMethod( PrimitiveCellTranslationGroup, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	return cellembed!.GAMpc;
end );

InstallMethod( SuperCellTranslationGroup, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	return cellembed!.GAMsc;
end );

InstallMethod( AsQuotient, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	return cellembed!.Q;
end );

InstallMethod( GetRightTransversal, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	return cellembed!.T;
end );

InstallMethod( TranslationGroupEmbedding, [ IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ],
function(cellembed)
	local simplify, GAM0, GAM, GAMgens, imgs, hom;

	if cellembed!.hom = false then
		# options
		simplify := ValueOption("simplify");
		if simplify = fail then
			simplify := 0;
		fi;

		# get translation groups
		GAM0 := PrimitiveCellTranslationGroup(cellembed);
		GAM := SuperCellTranslationGroup(cellembed);

		# construct images of generators under homomorphism GAM -> GAM0
		GAMgens := GeneratorsOfGroup(FpGroup(GAM));
		if simplify > 0 then
			imgs := List(GAMgens, g -> SimplifyWord@(FpGroup(GAM0), Image(FpIsomorphism(GAM0), PreImagesRepresentative(FpIsomorphism(GAM), g)), simplify : simplifyMethod := ValueOption("simplifyMethod")));
		else
			imgs := List(GAMgens, g -> Image(FpIsomorphism(GAM0), PreImagesRepresentative(FpIsomorphism(GAM), g)));
		fi;

		hom := GroupHomomorphismByImages(FpGroup(GAM), FpGroup(GAM0), GAMgens, imgs);
		cellembed!.hom := hom;
	fi;

	return cellembed!.hom;
end );

InstallMethod( Export, [ IsTGSuperCellModelGraphObj, IsOutputTextStream ],
function(model, output)
    local pc, GAM0, sc, GAM;

    # set formatting
    SetPrintFormattingStatus(output, false);
	
	# version
	AppendTo(output, "HyperCells HCS version 1.0");
	AppendTo(output, "\n");

    # write defining information: triangle group, relators, center
	AppendTo(output, Signature(GetProperTriangleGroup(model)));
	AppendTo(output, "\n");
	AppendTo(output, [PrimitiveCellRelators(model), SuperCellRelators(model), CellCenter(model)]);
	AppendTo(output, "\n");

    # get primitive cell and supercell
	pc :=  GetTGPrimitiveCell(model);
    GAM0 := TGCellTranslationGroup(pc);
	sc :=  GetTGSuperCell(model);
    GAM := TGCellTranslationGroup(sc);

	# primitive cell: translation group generators
	AppendTo(output, GeneratorsOfGroup(FpGroup(GAM0)));
	AppendTo(output, " -> ");
	AppendTo(output, Generators(GAM0));
	AppendTo(output, "\n");

    # primitive cell: Schwarz triangles, i.e., transversal T_D(GAMMA)
	AppendTo(output, ReplacedString(PrintString(GetRightTransversal(TGCellPointGroup(pc))), "<identity ...>", "1"));
	AppendTo(output, "\n");

	# primitive cell: vertex positions, i.e., transversal T_G+(Gw+)
	AppendTo(output, ReplacedString(PrintString(GetRightTransversal(TGCellMSWPs(pc))), "<identity ...>", "1"));
	AppendTo(output, "\n");

	# supercell: translation group generators
	AppendTo(output, GeneratorsOfGroup(FpGroup(GAM)));
	AppendTo(output, " -> ");
	AppendTo(output, Generators(GAM));
	AppendTo(output, "\n");

	# embedding of supercell translation group in primitive cell translation group
	AppendTo(output, PrintString(TranslationGroupEmbedding(CellEmbedding(model))));
	AppendTo(output, "\n");
	AppendTo(output, ReplacedString(PrintString(GetRightTransversal(CellEmbedding(model))), "<identity ...>", "1"));
	AppendTo(output, "\n");

    # supercell: Schwarz triangles, i.e., transversal T_D(GAMMA)
	AppendTo(output, ReplacedString(PrintString(GetRightTransversal(TGCellPointGroup(sc))), "<identity ...>", "1"));
	AppendTo(output, "\n");

	# supercell: vertex positions, i.e., transversal T_G+(Gw+)
	if HasTGCellMSWPs(sc) then
		AppendTo(output, ReplacedString(PrintString(GetRightTransversal(TGCellMSWPs(sc))), "<identity ...>", "1"));
	else
		AppendTo(output, "[ ]");
	fi;
	AppendTo(output, "\n");

    # type
    AppendTo(output, ModelType(model));
	AppendTo(output, "\n");

    # vertices
	AppendTo(output, PrintString(CellVertices(model)));
	AppendTo(output, "\n");

	# vertex positions
	AppendTo(output, ReplacedString(PrintString(CellVertexPositions(model)), "<identity ...>", "1"));
	AppendTo(output, "\n");

	# edges
	AppendTo(output, PrintString(List(CellEdges(model), e -> e{[1..3]})));
	AppendTo(output, "\n");

	# edge translations
	AppendTo(output, ReplacedString(PrintString(CellEdgeTranslations(model)), "<identity ...>", "1"));
	AppendTo(output, "\n");

    # faces
    AppendTo(output, PrintString(CellFaces(model)));
end );

InstallMethod( Export, [ IsTGSuperCellModelGraphObj, IsString ],
function(model, path)
    local output;

    # open file
    output := OutputTextFile(path, false);

    Export(model, output);

    # close file
    CloseStream(output);
end );

InstallMethod( ExportString, [ IsTGSuperCellModelGraphObj ],
function(model)
	local str, output;

	# open string stream
	str := "";
	output := OutputTextString(str, false);
	
	# export to stream
	Export(model, output);

	# close
	CloseStream(output);

	# return
	return str;
end );

InstallGlobalFunction( ImportTGSuperCellModelGraph,
function(input, args...)
    local version, sign, tg, D, info, pcrels, screls, center,
        pcGAMgens, pcTDGAM, pcTGGw, pcquotient, pc,
		scGAMgens, scTDGAM, scTGGw, scquotient, sc,
		GAMembdimgs, GAMembd, TGAM0GAM, type,
        verts, pos, vertexpos, edges, t, transls, i, faces,
		cellembed;

	# check arguments
	if not IsInputTextStream(input) then
		Error("The first argument must be an input text stream.");
		return fail;
	fi;

	# version
	version := ReadAllLine(input);

    sign := EvalString(ReadAllLine(input));

	# construct triangle group
	if Length(args) > 0 and IsProperTriangleGroupObj(args[1]) and Signature(args[1]) = sign then
		tg := args[1];
	else
		tg := ProperTriangleGroup(sign);
	fi;
	D := FpGroup(tg);

	# get relators and center
	info := EvalDString@(ReadAllLine(input), D);
	pcrels := info[1];
	screls := info[2];
	center := info[3];

    # primitive cell: get translation group generators
	pcGAMgens := SplitString(ReplacedString(ReadAllLine(input), "->", ":"), ":")[2];
    NormalizeWhitespace(pcGAMgens);
    pcGAMgens := EvalDString@(pcGAMgens, D);

	# primitive cell: get T_D(GAMMA)
	pcTDGAM := EvalDString@(ReadAllLine(input), D);

	# primitive cell: get T_G+(Gw+)
	pcTGGw := EvalDString@(ReadAllLine(input), D);

    # construct primitive cell
	pcquotient := Objectify( NewType(
		NewFamily( "TGQuotient", IsTGQuotientObj ),
		IsTGQuotientObj and IsTGQuotientComponentRep),
		rec(
			name := MakeImmutable(""),
            triangle := MakeImmutable(sign), 
            order := Length(pcTDGAM),
            genus := Length(pcGAMgens)/2,
            action := MakeImmutable(""),
            relators := PrintString(pcrels)
		)
	);
	pc := TGCell(tg, pcquotient, pcGAMgens, pcTDGAM, pcTGGw);

	# supercell: get translation group generators
	scGAMgens := SplitString(ReplacedString(ReadAllLine(input), "->", ":"), ":")[2];
    NormalizeWhitespace(scGAMgens);
    scGAMgens := EvalDString@(scGAMgens, D);

	# embedding of supercell translation group: images of generators
	GAMembdimgs := SplitString(ReplacedString(ReadAllLine(input), "->", ":"), ":")[2];
	NormalizeWhitespace(GAMembdimgs);
	GAMembdimgs := EvalGroupString@(GAMembdimgs, FpGroup(TGCellTranslationGroup(pc)));

	# T_GAM0(GAMMA)
	TGAM0GAM := EvalDString@(ReadAllLine(input), D);

	# supercell: get T_D(GAMMA)
	scTDGAM := EvalDString@(ReadAllLine(input), D);

	# supercell: get T_G+(Gw+)
	scTGGw := EvalDString@(ReadAllLine(input), D);
	if scTGGw = [] then
		scTGGw := false;
	fi;

    # construct supercell
	scquotient := Objectify( NewType(
		NewFamily( "TGQuotient", IsTGQuotientObj ),
		IsTGQuotientObj and IsTGQuotientComponentRep),
		rec(
			name := MakeImmutable(""),
            triangle := MakeImmutable(sign), 
            order := Length(scTDGAM),
            genus := Length(scGAMgens)/2,
            action := MakeImmutable(""),
            relators := PrintString(screls)
		)
	);;
	sc := TGCell(tg, scquotient, scGAMgens, scTDGAM, scTGGw);

	# embedding of supercell translation group: homomorphism
	GAMembd := GroupHomomorphismByImages(FpGroup(TGCellTranslationGroup(sc)), FpGroup(TGCellTranslationGroup(pc)), GeneratorsOfGroup(FpGroup(TGCellTranslationGroup(sc))), GAMembdimgs);

    # type
    type := EvalString(ReadAllLine(input));

    # vertices
    verts := EvalString(ReadAllLine(input));
	vertexpos := EvalDString@(ReadAllLine(input), D);

    # edges
    edges := EvalString(ReadAllLine(input));

    # edge translations
	transls := ReadAllLine(input);
	if Length(transls) < 5000 then
		transls := EvalGroupString@(transls, FpGroup(TGCellTranslationGroup(sc)));
	else
		RemoveCharacters(transls,"[ ]");
        transls := SplitString(transls, ",");
        for t in [1..Length(transls)] do
            if transls[t] = "1" then
                transls[t] := One(FpGroup(TGCellTranslationGroup(sc)));
            else
                transls[t] := EvalGroupString@(transls[t], FpGroup(TGCellTranslationGroup(sc)));
            fi;
        od;
	fi;

    for i in [1..Length(edges)] do
		Append(edges[i], [transls[i]]);
	od;

    # faces
    faces := ReadAllLine(input);
    faces := EvalString(faces);

	# embedding
	cellembed := Objectify( NewType( NewFamily( "TGCellEmbedding", IsTGCellEmbeddingObj ),
			IsTGCellEmbeddingObj and IsTGCellEmbeddingComponentRep ),
		rec(
			GAMpc := TGCellTranslationGroup(pc),
			GAMsc := TGCellTranslationGroup(sc),
			Q := RightTransversal(
				AsTGSubgroup(TGCellTranslationGroup(pc)),
				AsTGSubgroup(TGCellTranslationGroup(sc))
			),
			T := TGAM0GAM,
			hom := GAMembd
		)
	);

    return Objectify( NewType( NewFamily( "TGSuperCellModelGraph", IsTGSuperCellModelGraphObj ), IsTGSuperCellModelGraphObj and IsTGSuperCellModelGraphComponentRep ), rec(
		primitivecell := pc,
		supercell := sc,
		cellembed := cellembed,
		center := center,
        type := type,
		vertices := MakeImmutable(verts),
		vertexpos := MakeImmutable(vertexpos),
		edges := MakeImmutable(edges),
		faces := MakeImmutable(faces)
	));
end );

InstallGlobalFunction( ImportTGSuperCellModelGraphFromFile,
function(path, args...)
	local input, model;

	# open input stream
	input := InputTextFile(path);

	# import
	model := CallFuncList(ImportTGSuperCellModelGraph, Concatenation([input], args));

	# close stream
	CloseStream(input);

	return model;
end );

InstallGlobalFunction( ImportTGSuperCellModelGraphFromString,
function(string, args...)
	local input, model;

	# check arguments
	if not IsString(string) then
		Error("The first argument must be a string.");
		return fail;
	fi;

	# open string stream
	input := InputTextString(string);
	
	# import
	model := CallFuncList(ImportTGSuperCellModelGraph, Concatenation([input], args));

	# close stream
	CloseStream(input);

	return model;
end );