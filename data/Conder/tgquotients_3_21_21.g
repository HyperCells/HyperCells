dict := NewDictionary( [ 2, 1 ], true );
AddDictionary( dict, [7, 21], [[7, 21], [3, 21, 21], 21, "Action reflexible [m,n]", "[ x^3, x * y * z, x * z * y, y^-1 * z * y^-4 * z ]"] );
AddDictionary( dict, [19, 59], [[19, 59], [3, 21, 21], 63, "Action reflexible [m,n]", "[ x^3, x * y * z, x * z * y, y^-13 * z * y^-5 * z^2 ]"] );
AddDictionary( dict, [25, 75], [[25, 75], [3, 21, 21], 84, "Action reflexible [m,n]", "[ x^3, x * y * z, y^2 * x^-1 * z^2, (x * z * y)^2, y^-4 * z * y^-1 * z ]"] );
AddDictionary( dict, [43, 50], [[43, 50], [3, 21, 21], 147, "Action chiral", "[ x^3, x * y * z, y^2 * x^-1 * z^2, z^2 * y^-2 * x * y^-1 * z * y^-1 ]"] );
AddDictionary( dict, [55, 122], [[55, 122], [3, 21, 21], 189, "Action reflexible [m,n]", "[ x^3, x * y * z, y^2 * x^-1 * z^2, z^-1 * x^-1 * y^-1 * x * z * y, z^-4 * y * z^-2 * y^2 * z^-1 * y^6 * z^-1 * y * z^-1 * y^2 ]"] );
AddDictionary( dict, [73, 228], [[73, 228], [3, 21, 21], 252, "Action reflexible [m,n]", "[ x^3, x * y * z, y^2 * x^-1 * z^2, (x * z * y)^2, y^2 * z^-5 * y * z^-2 * y^2 * z^-2 * y^2 * z^-2 * y^2 * z^-1 ]"] );
AddDictionary( dict, [79, 61], [[79, 61], [3, 21, 21], 273, "Action chiral", "[ x^3, x * y * z, y^2 * x^-1 * z^2, z * y^-1 * z * y^-1 * x * y^-1 * z * y^-1 ]"] );
AddDictionary( dict, [97, 318], [[97, 318], [3, 21, 21], 336, "Action reflexible [m,n]", "[ x^3, x * y * z, y^2 * x^-1 * z^2, z * x^-1 * z * x^-1 * y^-1 * x * y^-1 * z^2  * y^-1 ]"] );
AddDictionary( TGQUOTS@, [ 3, 21, 21 ], dict );