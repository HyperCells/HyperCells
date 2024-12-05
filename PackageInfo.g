#
# HyperCells: A GAP package for constructing primitive cells and supercells of hyperbolic lattices
#
# This file contains package meta data. For additional information on
# the meaning and correct usage of these fields, please consult the
# manual of the "Example" package as well as the comments in its
# PackageInfo.g file.
#
SetPackageInfo( rec(

PackageName := "HyperCells",
Subtitle := "A GAP package for constructing primitive cells and supercells of hyperbolic lattices",
Version := "1.0.0",
Date := "03/12/2024", # dd/mm/yyyy format
License := "CC BY-SA 4.0",

Persons := [
  rec(
    FirstNames := "Patrick M.",
    LastName := "Lenggenhager",
    WWWHome := "https://patrick-lenggenhager.github.io",
    Email := "plengg@pks.mpg.de",
    IsAuthor := true,
    IsMaintainer := true,
    Place := "Zurich, Switzerland",
    Institution := "ETH Zurich, Paul Scherrer Institute, University of Zurich",
  ),
  rec(
    FirstNames := "Joseph",
    LastName := "Maciejko",
    Email := "maciejko@ualberta.ca",
    IsAuthor := true,
    IsMaintainer := false,
    Place := "Edmonton, Alberta, Canada",
    Institution := "University of Alberta",
  ),
  ,
  rec(
    FirstNames := "Tomáš",
    LastName := "Bzdušek",
    Email := "tomas.bzdusek@uzh.ch",
    IsAuthor := true,
    IsMaintainer := false,
    Place := "Zurich, Switzerland",
    Institution := "University of Zurich",
  ),
],

SourceRepository := rec(
    Type := "git",
    URL := "https://github.com/HyperCells/HyperCells",
),
GithubWWW       := ~.SourceRepository.URL,
IssueTrackerURL := Concatenation( ~.SourceRepository.URL, "/issues" ),
PackageWWWHome  := "https://HyperCells.github.io/HyperCells/",
PackageInfoURL  := Concatenation( ~.PackageWWWHome, "PackageInfo.g" ),
README_URL      := Concatenation( ~.PackageWWWHome, "README.md" ),
ArchiveURL      := Concatenation( ~.SourceRepository.URL,
                                 "/releases/download/v", ~.Version,
                                 "/", ~.PackageName, "-", ~.Version ),

ArchiveFormats := ".tar.gz",

##  Status information. Currently the following cases are recognized:
##    "accepted"      for successfully refereed packages
##    "submitted"     for packages submitted for the refereeing
##    "deposited"     for packages for which the GAP developers agreed
##                    to distribute them with the core GAP system
##    "dev"           for development versions of packages
##    "other"         for all other packages
##
Status := "dev",

AbstractHTML   :=  "",

PackageDoc := rec(
  BookName  := "HyperCells",
  ArchiveURLSubset := ["doc"],
  HTMLStart := "doc/chap0_mj.html",
  PDFFile   := "doc/manual.pdf",
  SixFile   := "doc/manual.six",
  LongTitle := "A GAP package for constructing primitive cells and supercells of hyperbolic lattices",
),

Dependencies := rec(
  GAP := ">= 4.11",
  NeededOtherPackages := [ ],
  SuggestedOtherPackages := [ ["kbmag", ">= 1.5.10"] ],
  ExternalConditions := [ ],
),

AvailabilityTest := ReturnTrue,

TestFile := "tst/testall.g",

Keywords := [ "hyperbolic lattices", "triangle groups" ]
 
));
