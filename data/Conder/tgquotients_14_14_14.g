dict := NewDictionary( [ 2, 1 ], true );
AddDictionary( dict, [12, 52], [[12, 52], [14, 14, 14], 28, "Action reflexible [m,n]", "[ x * y * z, x * z * y, y^-1 * x^2 * y^-1, z^-3 * x^2 * z^-3 ]"] );
AddDictionary( dict, [12, 53], [[12, 53], [14, 14, 14], 28, "Action reflexible [m]", "[ x * y * z, x * z * y, x^4 * z^-2, y^-2 * x^2 * y^-2 ]"] );
AddDictionary( dict, [78, 98], [[78, 98], [14, 14, 14], 196, "Action reflexible [m,n]", "[ x * y * z, z^-1 * x^2 * z^-1, (x * y^-3)^2, y^-2 * z * y * x^-1 * y^-1 * z^-1  * y^5 * x * y^-3 ]"] );
AddDictionary( dict, [78, 99], [[78, 99], [14, 14, 14], 196, "Action reflexible [m]", "[ x * y * z, z^-1 * x^-2 * y^-1 * x, z^-2 * x^-1 * z * y^-1, x^4 * z^-2, (x * y^-2)^2, y * x * y^-1 * z * y^3 * x^-1 * y^-4 * z * y * x * z^-1 * y ]"] );
AddDictionary( dict, [78, 100], [[78, 100], [14, 14, 14], 196, "Action reflexible [m]", "[ x * y * z, (y * z^-1)^2, z^-1 * x^-2 * y^-1 * x, z^-2 * x^-1 * y * z^-1, x^6 * z^-2, y^3 * x * y^-5 * z^-1 * y^5 ]"] );
AddDictionary( dict, [78, 101], [[78, 101], [14, 14, 14], 196, "Action reflexible [m,n]", "[ x * y * z, z^-1 * x^-1 * y, (x^-4 * z * x^-1 * z)^2, y^-5 * z * x^-1 * z * y^2 * x * y^-2 * z^-1 * x * y^-2 ]"] );
AddDictionary( dict, [78, 102], [[78, 102], [14, 14, 14], 196, "Action reflexible [m,n]", "[ x * y * z, x * z * y, z^-9 * x * y * z^-4, x^5 * z^-3 * x^4 * y^-3 * x^2 ]"] );
AddDictionary( dict, [89, 462], [[89, 462], [14, 14, 14], 224, "Action chiral", "[ x * y * z, (x * z^-1)^2, (x * z * y)^2, y * x^-3 * y^-2 * z, (x * y^-3)^2 ]"] );
AddDictionary( dict, [89, 463], [[89, 463], [14, 14, 14], 224, "Action chiral", "[ x * y * z, (x * y^-1 * x)^2, y^2 * x^2 * z^2, (y * z^-1 * y)^2 ]"] );
AddDictionary( TGQUOTS@, [ 14, 14, 14 ], dict );