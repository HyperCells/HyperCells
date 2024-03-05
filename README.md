# The GAP package HyperCells

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.10222599.svg)](https://doi.org/10.5281/zenodo.10222599)

HyperCells is a [GAP](https://www.gap-system.org/) package that allows
constructing primitive cells and supercells of hyperbolic lattices based on
triangle groups and quotients with normal subgroups.
An introduction to the underlying concepts can be found in the following preprint

> P. M. Lenggenhager, J. Maciejko, and T. Bzdušek,
  *Non-Abelian hyperbolic band theory from supercells*,
  [Phys. Rev. Lett. 131, 226401](https://doi.org/10.1103/PhysRevLett.131.226401) (2023)

and the doctoral thesis

> P. M. Lenggenhager,
  *Emerging avenues in band theory: multigap topology and hyperbolic lattices*,
  [PhD thesis](https://doi.org/10.3929/ethz-b-000645370), ETH Zurich (2023)

If you use this package, please cite at least one of the above references in
addition to the package itself:
> P. M. Lenggenhager, J. Maciejko, and T. Bzdušek,
  *HyperCells: A GAP package for constructing primitive cells and supercells of
  hyperbolic lattices*, [https://github.com/patrick-lenggenhager/HyperCells](https://github.com/patrick-lenggenhager/HyperCells),
  [10.5281/zenodo.10222598](https://doi.org/10.5281/zenodo.10222598) (2023)

and the list of quotient groups:
> M. Conder, *Quotients of triangle groups acting on surfaces of genus 2 to 101*,
  [https://www.math.auckland.ac.nz/~conder/TriangleGroupQuotients101.txt](https://www.math.auckland.ac.nz/~conder/TriangleGroupQuotients101.txt) (2007)


A getting-started guide for this and its sister package
([HyperBloch](https://github.com/patrick-lenggenhager/HyperBloch)) can be found
[here](https://patrick-lenggenhager.github.io/software/2024/01/10/HyperGuide.html).


Please refer to [CONTRIBUTING.md](CONTRIBUTING.md) on how you can contribute to
the development of this package.

#### Table of Contents  
- [Authors and developers](#authors-and-developers)
- [Installation](#installation)
- [Documentation](#documentation)
- [Limitations](#limitations)
- [HyperBloch package](#hyperbloch-package)
- [How to cite](#how-to-cite)
- [Contact](#contact)
- [License and copyright](#license-and-copyright)

## Authors and developers

Main developer:\
&ensp;&ensp;**Patrick M. Lenggenhager**\
&ensp;&ensp;Email: plengg@pks.mpg.de\
&ensp;&ensp;Website: [https://patrick-lenggenhager.github.io](https://patrick-lenggenhager.github.io)

Coauthors:\
&ensp;&ensp;**Joseph Maciejko** (maciejko@ualberta.ca)\
&ensp;&ensp;**Tomáš Bzdušek** (tomas.bzdusek@uzh.ch)

## Installation

To install the HyperCells package, clone this repository in the `~/.gap/pkg/`
directory.
GAP should automatically detect the package and make it available for loading
using the command
```GAP
LoadPackage("HyperCells");
```

## Documentation

The documentation is available on the accompanying Github pages website.

## Limitations
Note that at this point *HyperCells* is still under development and, because the
limitations have not yet been fully determined, released only as a beta version.
Further testing will be required before an official release. However, the package
is already fully functional and documented and can be used to reproduce the results
of the publication mentioned above.

### Known limitations
- `TGCellGraph` objects and symmetric `TGCell` objects cannot be produced for
  cells without mirror symmetries, i.e., for quotients that act "chirally" on
  the surface.
- Faces of `TGCellGraph` objects have only been tested in the context of
  `TGTessellationGraph` and `TGKagomeGraph` and might not work in general.

## HyperBloch package

The HyperBloch package is a companion package to HyperCells for Mathematica.
It allows to study the band structure of hyperbolic lattices by applying hyperbolic
band theory and the supercell method. Additionally, it provides many functions
to visualize the output of HyperCells. It is available on Github at
> [https://github.com/patrick-lenggenhager/HyperBloch](https://github.com/patrick-lenggenhager/HyperBloch)


## How to cite

If you use this package, please cite the package itself
```BibTeX
@misc{HyperCells,
  title           = {Hyper{C}ells: {A} {GAP} package for constructing primitive cells and supercells of hyperbolic lattices},
  author          = {Lenggenhager, Patrick M. and Maciejko, Joseph and Bzdu\v{s}ek, Tom\'{a}\v{s}},
  year            = {2023},
  doi             = {10.5281/zenodo.10222598},
  note            = {\url{https://github.com/patrick-lenggenhager/HyperCells}}
}
```
and at least one of the following references:
```BibTeX
@article{Lenggenhager:2023,
  title               = {Non-{A}belian hyperbolic band theory from supercells}, 
  author              = {Lenggenhager, Patrick M. and Maciejko, Joseph and Bzdu\v{s}ek, Tom\'{a}\v{s}},
  journal             = {Phys. Rev. Lett.},
  volume              = {131},
  issue               = {22},
  pages               = {226401},
  numpages            = {7},
  year                = {2023},
  month               = {Dec},
  publisher           = {American Physical Society},
  doi                 = {10.1103/PhysRevLett.131.226401}
}

@phdthesis{Lenggenhager:PhDThesis,
  title           = {Emerging avenues in band theory: multigap topology and hyperbolic lattices},
  author          = {Lenggenhager, Patrick M.}, 
  year            = {2023},
  school          = {ETH Zurich},
  doi             = {10.3929/ethz-b-000645370}
}
```
as well as the following reference for the database of quotients of triangle groups
with normal subgroups:
```BibTeX
@misc{Conder:2007,
  title           = {Quotients of triangle groups acting on surfaces of genus 2 to 101},
  author          = {Conder, Marston},
  year            = {2007},
  howpublished    = {\url{https://www.math.auckland.ac.nz/~conder/TriangleGroupQuotients101.txt}}
}
```

## Contact

To report issues, please use the issue tracker at
[https://github.com/patrick-lenggenhager/HyperCells/issues](https://github.com/patrick-lenggenhager/HyperCells/issues).

Maintainer:\
&ensp;&ensp;**Patrick M. Lenggenhager**\
&ensp;&ensp;Email: plengg@pks.mpg.de\
&ensp;&ensp;Homepage: [https://patrick-lenggenhager.github.io](https://patrick-lenggenhager.github.io)

## License and copyright

HyperCells is free software; you can redistribute and/or modify it under the
terms of the CC BY-SA 4.0 license as described below. HyperCells is distributed
in the hope that it will be useful, but WITHOUT ANY WARRANTY, see the CC BY-SA
4.0 license for more details.

This is a human-readable summary of (and not a substitute for) the license, see
the attached [LICENSE](LICENSE.txt) for the full legal text.

You are free to:
  Share — copy and redistribute the material in any medium or format for any purpose.
  Adapt — remix, transform, and build upon the material for any purpose.
  The licensor cannot revoke these freedoms as long as you follow the license terms.

Under the following terms:
  Attribution - You must give appropriate credit (see [AUTHORS](AUTHORS.md) and
    [How to cite](#how-to-cite) above), provide a link to the license, and
    indicate if changes were made. You may do so in any reasonable manner, but
    not in any way that suggests the licensor endorses you or your use.
  ShareAlike - If you remix, transform, or build upon the material, you must
    distribute your contributions under the same license as the original.
  No additional restrictions - You may not apply legal terms or technological
    measures that legally restrict others from doing anything the license permits.

Copyright 2023 Patrick M. Lenggenhager