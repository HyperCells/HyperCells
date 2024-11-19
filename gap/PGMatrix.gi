# Type PGMatricesOfGenerators
DeclareRepresentation("IsPGMatricesOfGeneratorsComponentRep", IsComponentObjectRep,
	[ "fulltg", "tg", "tgquotient", "sparse", "tgGenerators", "pgMatricesRec" ]
);


InstallMethod( \=, [
    IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep,
    IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs1, pgMatsGs2)
	return  GetTriangleGroup(pgMatsGs1) = GetTriangleGroup(pgMatsGs2) and
		GetProperTriangleGroup(pgMatsGs1) = GetProperTriangleGroup(pgMatsGs2) and
		GetTGQuotient(pgMatsGs1) = GetTGQuotient(pgMatsGs2) and
		PGMatricesRec(pgMatsGs1) = PGMatricesRec(pgMatsGs2);
end );

InstallMethod( Signature, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ],
function(pgMatsGs)
	return Signature(pgMatsGs!.fulltg);
end );

InstallMethod( GetTriangleGroup, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.fulltg;
end );

InstallMethod( GetProperTriangleGroup, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.tg;
end );

InstallMethod( TGQuotientName, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return TGQuotientName(pgMatsGs!.tgquotient);
end );

InstallMethod( GetTGQuotient, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.tgquotient;
end );

InstallMethod( IsSparse, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.sparse;
end );

InstallMethod( TGGenerators, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.tgGenerators;
end );

InstallMethod( PGMatricesRec, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return pgMatsGs!.pgMatsRec;
end );


InstallMethod( PrintString, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	return Concatenation( "PGMatricesOfGenerators( ", 
		PrintString(GetTriangleGroup(pgMatsGs)), ", ",
		PrintString(GetProperTriangleGroup(pgMatsGs)), ", ",
		PrintString(GetTGQuotient(pgMatsGs)), ", ",
		"sparse = ", PrintString(IsSparse(pgMatsGs)), ", ",
		"tgGenerators = ", PrintString(TGGenerators(pgMatsGs)),  ", ",
		"pgMatricesRec = ", PrintString(PGMatricesRec(pgMatsGs)), 
	")" );
end );

InstallMethod( PrintObj, [ IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ], 
function(pgMatsGs)
	Print(PrintString(pgMatsGs));
end );


InstallGlobalFunction( PGMatricesOfGenerators,
function(fulltg, tg, tgquotient)
    local signature, sparse, quotient, D, DELTA, symmetries, embDDELTA, G, rels,
     relsfull, cellGamma, GAMMA, fpGAMMA, gensGamma, gensGammaABC, gensGammaFp, 
     homDeltaG, kernDeltaG, isoGamma, PGMRawLst, PGMatrixRaw, transOp, trans1, 
     trans2, tempGroup, homtemp, PGMLst, lst, matInt, item, i, j, entry, 
     row, symNames, idn, F, tgFpObjs, cell, Gplus, pgMatsRec;

    # Check argument:
    # ---------------

    if not IsTriangleGroupObj(fulltg) then
        Error("The first argument must be a TriangleGroup object.");
        return fail;
    fi;

    if not IsProperTriangleGroupObj(tg) then
        Error("The second argument must be a ProperTriangleGroup object.");
        return fail;
    fi;

    if not IsTGQuotientObj(tgquotient) then
        Error("The third argument must be a TGQuotient object.");
        return fail;
    fi;

    if not  Signature(fulltg) = Signature(tg) or not  Signature(tg) = TriangleGroupSignature(tgquotient) then
        Error("The arguments must have the same signatures.");
        return fail;
    fi;

    # --------------
    # Check options:
    # --------------

    sparse := ValueOption("sparse");
    if sparse = fail then
    	sparse := false;
    elif not IsBool(sparse) then
	Error(StringFormatted("The option sparse {} is not valid. It must be a boolean.", sparse));
	return fail;
    fi;

    # ---------------
    # Needed objects:
    # ---------------

    signature := TriangleGroupSignature(tgquotient);
    cell := TGCell(tg, tgquotient);

    # --------------------------------------------------
    # Construct groups, symmetry elements and embedding:
    # -------------------------------------------------- 

    tgFpObjs := constructTGFpAndEmb@(fulltg, tg);
    D := tgFpObjs[1];; DELTA := tgFpObjs[2];; embDDELTA := tgFpObjs[3];
    symmetries := tgFpObjs[4];
	
    # -------------------------------
    # Construct (proper) point group:
    # -------------------------------

    # proper point group
    rels := CellRelators(cell);
    Gplus := D / rels; 
      
    # (full) point group
    relsfull := List(rels, r -> Image(embDDELTA, r));
    G := DELTA / relsfull;

    # ----------------------
    # Check mirror symmetry:
    # ----------------------

    # ensure that quotient is mirror symmetric
    if not Order(G) = 2 * Order(Gplus) then
        Error(StringFormatted(
	    "The given relators {} lead to a quotient that does not have mirror symmetries.",
	    rels
	));
        return fail;
    fi;

    # ------------------
    # Perform embedding:
    # ------------------
     
    # get point group and translation group obj.s
    cellGamma := TGCellTranslationGroup(cell); 

    # construct translation group
    GAMMA := AsTGSubgroup(cellGamma);
    gensGamma := GeneratorsOfGroup(GAMMA);	

    # get translation op.'s in terms of reflection op.'s
    # Note: I explicitly want these generators (in x, y, z) s.t. the 
    # reassignment of GAMMA in terms of a, b, c stays consistent.
    gensGammaABC := List(gensGamma, g -> Image(embDDELTA, g));

    # construct the translation group in terms of a, b, c
    homDeltaG := GroupHomomorphismByImagesNC(DELTA, G);
    kernDeltaG := Kernel(homDeltaG); # translation group in terms of a, b, c
    isoGamma := IsomorphismFpGroupByGenerators(kernDeltaG, gensGammaABC, "g");
    fpGAMMA := Image(isoGamma);
    gensGammaFp := GeneratorsOfGroup(fpGAMMA);

    # -------------------------------------------------------------------
    # Raw: point-group matrix entries in terms of translation generators:
    # -------------------------------------------------------------------

    PGMRawLst := []; 
    for item in symmetries do
	PGMatrixRaw := []; # PG-matrix in terms of translation generators
	for transOp in gensGammaABC do
		trans1 := Image(isoGamma, transOp); # or use GeneratorsOfGroup(FpGroup(cellGamma))
		trans2 := Image(isoGamma, item^-1*transOp*item); # legit since Gamma is a normal subgroup
		Add(PGMatrixRaw, [trans1,  trans2]);
	 od;
	Add(PGMRawLst, [String(item), PGMatrixRaw]);
    od;
            
    # -------------------------------------------------
    # Point-group matrix construction (abelianization):
    # -------------------------------------------------
    
    # drop group structure in order to count exponents
    tempGroup := FreeGroup(Length(gensGammaABC));
    homtemp := GroupHomomorphismByImagesNC(fpGAMMA, tempGroup, 
        gensGammaFp, GeneratorsOfGroup(tempGroup));

    # reassign generators
    gensGammaFp := List(gensGammaFp, g -> Image(homtemp, g));

    PGMLst := [];
    if sparse then
        for PGMatrixRaw in PGMRawLst do
            matInt := [];
	    for i in [1..Length(gensGammaFp)] do
	        for j in [1..Length(gensGammaFp)] do
		    entry := ExponentSumWord(Image(homtemp, PGMatrixRaw[2][i][2]), gensGammaFp[j]);
	            if not entry = 0 then
		        Add(matInt, [[i, j], entry]);
	            fi;
		od;
	    od;
	 Add(PGMLst, [PGMatrixRaw[1], matInt]);
        od;
    else
        for PGMatrixRaw in PGMRawLst do
	    matInt := [];
	    for i in [1..Length(gensGammaFp)] do
	        row := List(gensGammaFp, g -> ExponentSumWord(Image(homtemp, PGMatrixRaw[2][i][2]), g));
	        Add(matInt, row);
	    od;
	 Add(PGMLst, [PGMatrixRaw[1], matInt]);
        od;
    fi;

    # construct record
    pgMatsRec := rec( a := PGMLst[1, 2], b := PGMLst[2, 2], c := PGMLst[3, 2] );
    
    F := NewFamily( "PGMatricesOfGenerators", IsPGMatricesOfGeneratorsObj );
    return Objectify( NewType( F, IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ), rec(
	    fulltg := fulltg,
	    tg := tg,
	    tgquotient := tgquotient,
	    sparse := MakeImmutable(sparse),
	    tgGenerators := MakeImmutable(symmetries),
	    pgMatsRec := MakeImmutable(pgMatsRec)
	    ));
end );


InstallMethod( EvaluatePGMatrix, [ IsElementOfFpGroup, IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ],
function(symmetry, pgMatsGs)	
    local fulltg, tg, tgFpObjs, D, DELTA, embDDELTA, 
     elementsRec, item, PGMat, PGMatRaw, signature, 
     symmetriesDeconstructed;

    # Get needed objects:
    # -------------------
   
    signature := Signature(pgMatsGs);

    # Get symmetries (generators of (full) triangle group), 
    # tg, fulltg as FpGroups D, DELTA, respectively and
    # embedding homomorphism of D in DELTA embDDELTA
    fulltg := GetTriangleGroup(pgMatsGs);
    tg := GetProperTriangleGroup(pgMatsGs);
    tgFpObjs := constructTGFpAndEmb@(fulltg, tg);
    D := tgFpObjs[1];; DELTA := tgFpObjs[2];; embDDELTA := tgFpObjs[3];       
	
    # ---------------
    # Check symmetry:
    # ---------------   

    # check generating set
    if not (symmetry in D or symmetry in DELTA) then
        Error("The symmetry must be an element of the (proper) triangle group used in the construction of the PGMatricesOfGenerators object.");
        return fail;
    fi;

    # -------------------------
    # Rewrite symmetry element:
    # -------------------------
    # If the symmetry is an element of the
    # proper triangle group get the image of the
    # symmetry in the triangle group, through the
    # embedding homomorphism. Additionally, deconstruct
    # the symmetry into its constituents (generators).

    item := symmetry;
    symmetriesDeconstructed := [];
    if item in D then
	item := Image(embDDELTA, item);
    fi;
    # deconstruct the word into an ordered list of generators
    symmetriesDeconstructed := List([1..Length(item)], g -> Subword(item, g, g));
   
    # ------------------------------------------
    # Perform the needed matrix multiplications:
    # ------------------------------------------

    # record of point-group matrices a, b, c
    elementsRec := PGMatricesRec(pgMatsGs); 

    if IsSparse(pgMatsGs) then
        PGMatRaw := [];
        for item in symmetriesDeconstructed do       
           Append(PGMatRaw, [elementsRec.(String(item))]);
        od;
        PGMat := Iterated(PGMatRaw, sparseMatMultiply@);
    else
        PGMatRaw := [];
        for item in symmetriesDeconstructed do       
            Append(PGMatRaw, [elementsRec.(String(item))]);
        od;
        PGMat := Product(PGMatRaw);
    fi;

    return PGMat;
end );



# Type PGMatrices
DeclareRepresentation("IsPGMatricesComponentRep", IsComponentObjectRep,
	[ "PGMatricesOfGenerators", "symmetries", "symmetryNames", "pgMatricesRec" ]
);

InstallMethod( \=, [
    IsPGMatricesObj and IsPGMatricesComponentRep,
    IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats1, pgMats2)
	return 	GetPGMatricesOfGenerators(pgMats1) = GetPGMatricesOfGenerators(pgMats2) and
		Symmetries(pgMats1) = Symmetries(pgMats2) and
		PGMatricesRec(pgMats1) = PGMatricesRec(pgMats2);
end );


InstallMethod( GetPGMatricesOfGenerators, [ IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats)
	return pgMats!.pgMatsGs;
end );

InstallMethod( Symmetries, [ IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats)
	return pgMats!.symmetries;
end );

InstallMethod( SymmetryNames, [ IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats)
	return pgMats!.symmetryNames;
end );

InstallMethod( PGMatricesRec, [ IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats)
	return pgMats!.pgMatsRec;
end );


InstallMethod( PrintString, [ IsPGMatricesObj and IsPGMatricesComponentRep ], 
function(pgMats)
	return Concatenation( "PGMatrices( ", 
		PrintString(GetPGMatricesOfGenerators(pgMats)), ", ",
		"symmetries = ", PrintString(Symmetries(pgMats)), ", ",
		"symmetryNames = ", PrintString(SymmetryNames(pgMats)), ", ",
		"pgMatricesRec = ", PrintString(PGMatricesRec(pgMats)), 
	")" );
end );



InstallGlobalFunction( PGMatrices,
function(symmetries, pgMatsGs)	
    local fulltg, tg, tgFpObjs, D, DELTA, embDDELTA, elementsRec,
     i, item, pgMatsRec, PGMatRaw, signature, symNames, 
     symmetriesDeconstructed, F;

    # Check second argument:
    # ----------------------

    if not IsPGMatricesOfGeneratorsObj(pgMatsGs) then
        Error("The second argument must be a PGMatricesOfGenerators object.");
        return fail;
    fi;

    # -------------------
    # Get needed objects:
    # -------------------
   
    signature := Signature(pgMatsGs);

    # Get symmetries (generators of (full) triangle group), 
    # tg, fulltg as FpGroups D, DELTA, respectively and
    # embedding homomorphism of D in DELTA embDDELTA
    fulltg := GetTriangleGroup(pgMatsGs);
    tg := GetProperTriangleGroup(pgMatsGs);
    tgFpObjs := constructTGFpAndEmb@(fulltg, tg);
    D := tgFpObjs[1];; DELTA := tgFpObjs[2];; embDDELTA := tgFpObjs[3];       
	
    # ----------------------------------
    # Check options and first argument:
    # ----------------------------------  

    # check the format of symmetries, and prepare for further checks
    symNames := ValueOption("symNames");
    if IsString(symNames) = false and IsList(symmetries) = false then
	symmetries := [symmetries];
    elif IsString(symNames) = true and IsList(symmetries) = false then
	symmetries := [symmetries];
	symNames := [symNames];
    fi;

    # symmetry names
    if symNames = fail then
    	symNames := List(symmetries, item -> String(item));
    elif not IsList(symNames) then
	Error(StringFormatted("The option symNames {} is not valid. It must be a list.", symNames));
	return fail;
    elif not Length(symNames) = Length(symmetries) then
	Error(StringFormatted("The length of option symNames {} must be of equivalent length than symmetries {}.", symNames, symmetries));
	return fail;
    elif not SizeBlist(List(symNames, item -> IsString(item))) = Length(symmetries)  then
        Error(StringFormatted("The option symNames {} is not valid. It must be a list of strings.", symNames));
	return fail;
    fi;

    # check generating set
    if not SizeBlist(List(symmetries, w -> w in D or w in DELTA )) = Length(symmetries) then
        Error("The symmetries must be elements of the (proper) triangle group used in the construction of the PGMatricesOfGenerators object.");
        return fail;
    fi;

    # --------------------------
    # Rewrite symmetry elements:
    # --------------------------
    # If an element in the list symmetries is an element
    # of the proper triangle group get the image of this
    # element in the triangle group, through the
    # embedding homomorphism. Additionally, deconstruct
    # all elements into their constituents (generators).

    symmetriesDeconstructed := [];
    for item in symmetries do 
	if item in D then
	   item := Image(embDDELTA, item);
	fi;
	# deconstruct the word into an ordered list of generators
	item := List([1..Length(item)], g -> Subword(item, g, g));
	Append(symmetriesDeconstructed, [item]);
    od;

    # ------------------------------------------
    # Perform the needed matrix multiplications:
    # ------------------------------------------

    # record of point-group matrices a, b, c
    elementsRec := PGMatricesRec(pgMatsGs); 

    pgMatsRec := rec();
    if IsSparse(pgMatsGs) then
        for i in [1..Length(symmetriesDeconstructed)] do 
            PGMatRaw := [];
            for item in symmetriesDeconstructed[i] do       
           	Append(PGMatRaw, [elementsRec.(String(item))]);
            od;
            pgMatsRec.(symNames[i]) := Iterated(PGMatRaw, sparseMatMultiply@);
	od;
    else
        for i in [1..Length(symmetriesDeconstructed)] do 
            PGMatRaw := [];
            for item in symmetriesDeconstructed[i] do       
           	Append(PGMatRaw, [elementsRec.(String(item))]);
            od;
            pgMatsRec.(symNames[i]) := Product(PGMatRaw);
	od;
    fi;

    F := NewFamily( "PGMatrices", IsPGMatricesObj );
    return Objectify( NewType( F, IsPGMatricesObj and IsPGMatricesComponentRep ), rec(
	    pgMatsGs := pgMatsGs,
	    symmetries := MakeImmutable(symmetries),	
	    symmetryNames := MakeImmutable(symNames),	
	    pgMatsRec := MakeImmutable(pgMatsRec)
	    )); 
end );


InstallMethod( Export, [  IsPGMatricesObj, IsOutputTextStream ],
function(pgMats, output)
    local pgMatGs, pgMatGsRec, pgMatSymsRec, tgquotient, syms, symNames;
    
    pgMatGs := GetPGMatricesOfGenerators(pgMats);
    tgquotient := GetTGQuotient(pgMatGs);
    pgMatGsRec := PGMatricesRec(pgMatGs);
    pgMatSymsRec := PGMatricesRec(pgMats);
    syms := Symmetries(pgMats);
    symNames := SymmetryNames(pgMats);

    SetPrintFormattingStatus(output, false);
    
    # version
	AppendTo(output, "HyperCells HCPGM version 1.0");
	AppendTo(output, "\n");

    # write: triangle group, genus bound, list of quotients
	AppendTo(output, Signature(pgMatGs));
	AppendTo(output, "\n");
	AppendTo(output, [TGQuotientName(pgMatGs), TGQuotientOrder(tgquotient), TGQuotientGenus(tgquotient), TGQuotientActionType(tgquotient), TGQuotientRelators(tgquotient)]);
	AppendTo(output, "\n");
	AppendTo(output, IsSparse(pgMatGs));
	AppendTo(output, "\n");

    # write: point-group matrices of generators
	AppendTo(output, List(TGGenerators(pgMatGs), item -> [String(item), pgMatGsRec.(String(item))]));
	AppendTo(output, "\n");

    # write: point-group matrices of symmetries
	AppendTo(output, List([1..Length(symNames)], i -> [[symNames[i], String(syms[i])], pgMatSymsRec.(symNames[i])]));
end );


InstallMethod( Export, [ IsPGMatricesObj, IsString ],
function(pgMats, path)
    local output;

    # open file
    output := OutputTextFile(path, false);

    Export(pgMats, output);

    # close file
    CloseStream(output);
end );


InstallMethod( ExportString, [ IsPGMatricesObj ],
function(pgMats)
	local str, output;

	# open string stream
	str := "";
	output := OutputTextString(str, false);
	
	# export to stream
	Export(pgMats, output);

	# close
	CloseStream(output);

	# return
	return str;
end );


InstallGlobalFunction( ImportPGMatrices,
function(input, args...)
    local version, signature, quotientInfo, elements, sparse, D, DELTA,
     pgMatsGs, pgMatGsLst, pgMatSymsLst, fulltg, tg, tgquotient, F1, F2,
     generatorNames, generators, i, str, PGMatGsRec, PGMatSymsRec,
     symmetryNames, symmetries, syTuple, symmetryStrs, nSys;

	# Check arguments:
	# ----------------

	if not IsInputTextStream(input) then
		Error("The first argument must be an input text stream.");
		return fail;
	fi;

	# --------------
	# Get all infos:
	# --------------

	# version
	version := ReadAllLine(input);

    	signature := EvalString(ReadAllLine(input));
	quotientInfo := EvalString(ReadAllLine(input));
	sparse := EvalString(ReadAllLine(input));
	pgMatGsLst := EvalString(ReadAllLine(input));
	pgMatSymsLst := EvalString(ReadAllLine(input));

	# ---------------------
	# Construct fulltg, tg:
	# ---------------------

	# construct triangle group
	if Length(args) > 0 and IsTriangleGroupObj(args[1]) and Signature(args[1]) = signature then
		fulltg := args[1];
	else
		fulltg := TriangleGroup(signature);
	fi;

	DELTA := FpGroup(fulltg);

	# construct proper triangle group
	if Length(args) > 0 and IsProperTriangleGroupObj(args[2]) and Signature(args[2]) = signature then
		tg := args[2];
	else
		tg := ProperTriangleGroup(signature);
	fi;

	D := FpGroup(tg);

	# ----------------------------
	# Construct TGQuotient object:
	# ----------------------------

  	# construct tgquotient
	tgquotient := Objectify( NewType(
		NewFamily( "TGQuotient", IsTGQuotientObj ),
		IsTGQuotientObj and IsTGQuotientComponentRep),
		rec(
			name := MakeImmutable(quotientInfo[1]),
            		triangle := MakeImmutable(signature), 
            		order := quotientInfo[2],
            		genus := quotientInfo[3],
            		action := MakeImmutable(quotientInfo[4]),
            		relators := MakeImmutable(quotientInfo[5])
		)
	);

	# ----------------------------------------------------
	# Construct words and records of point-group matrices:
	# ----------------------------------------------------	

	PGMatGsRec := rec();
        generators := GeneratorsOfGroup(D);
	generatorNames := List(pgMatGsLst, x -> x[1]);
	for i in [1..3] do
		PGMatGsRec!.(generatorNames[i]) := pgMatGsLst[i, 2];
	od;

	PGMatSymsRec := rec();; nSys := Length(pgMatSymsLst);
	syTuple := List(pgMatSymsLst, x -> x[1]);
	symmetryNames := syTuple{[1..nSys]}{[1]};
	symmetryStrs := syTuple{[1..nSys]}{[2]};; 
	symmetries := [];

	for i in [1..nSys] do
		
		PGMatSymsRec!.(symmetryNames[i, 1]) := pgMatSymsLst[i, 2];
		
		# reconstruct word
		if symmetryStrs[i, 1][1] in "abc" then
			Append(symmetries, [EvalDELTAString@(symmetryStrs[i, 1], DELTA)]);
		else
			Append(symmetries, [EvalDString@(symmetryStrs[i, 1], D)]);
		fi;
	od;

	# --------------------------------
	# Construct the PGMatrices object:
	# --------------------------------

	F1 := NewFamily( "PGMatricesOfGenerators", IsPGMatricesOfGeneratorsObj );
	pgMatsGs := Objectify( NewType( F1, IsPGMatricesOfGeneratorsObj and IsPGMatricesOfGeneratorsComponentRep ), rec(
		fulltg := fulltg,
	   	tg := tg,
	    	tgquotient := tgquotient,
	    	sparse := MakeImmutable(sparse),
	    	tgGenerators := MakeImmutable(generators),
	    	pgMatsRec := MakeImmutable(PGMatGsRec)
	    ));

	F2 := NewFamily( "PGMatrices", IsPGMatricesObj );
    	return Objectify( NewType( F2, IsPGMatricesObj and IsPGMatricesComponentRep ), rec(
		pgMatsGs := pgMatsGs,
		symmetries := MakeImmutable(symmetries),
		symmetryNames := MakeImmutable(symmetryNames),	
		pgMatsRec := MakeImmutable(PGMatSymsRec)
	    ));
end );


InstallGlobalFunction( ImportPGMatricesFromFile,
function(path, args...)
	local input, pgMatrices;

	# open input stream
	input := InputTextFile(path);

	# import
	pgMatrices := CallFuncList(ImportPGMatrices, Concatenation([input], args));

	# close stream
	CloseStream(input);

	return pgMatrices;
end );


InstallGlobalFunction( ImportPGMatricesFromString,
function(string, args...)
	local input, pgMatrices;

	# check arguments
	if not IsString(string) then
		Error("The first argument must be a string.");
		return fail;
	fi;

	# open string stream
	input := InputTextString(string);
	
	# import
	pgMatrices := CallFuncList(ImportPGMatrices, Concatenation([input], args));

	# close stream
	CloseStream(input);

	return pgMatrices;
end );