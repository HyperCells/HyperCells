dict := NewDictionary( [ 2, 1 ], true );
AddDictionary( dict, [8, 23], [[8, 23], [5, 6, 6], 30, "Action reflexible [m,n]", "[ x * y * z, y * x^-1 * z, x^-5, y^6 ]"] );
AddDictionary( dict, [29, 91], [[29, 91], [5, 6, 6], 120, "Action reflexible [m,n]", "[ x * y * z, x^-5, y^2 * x^-1 * z^2, x^-1 * y^-1 * x^2 * z * x^-1 ]"] );
AddDictionary( dict, [29, 92], [[29, 92], [5, 6, 6], 120, "Action reflexible [m,n]", "[ x * y * z, (y * z^-1)^2, x^-5, x^-1 * y^-1 * x^2 * z * x^-1, y^6 ]"] );
AddDictionary( dict, [36, 53], [[36, 53], [5, 6, 6], 150, "Action reflexible [m,n]", "[ x * y * z, x^-5, y^2 * x^-1 * z^2, y * x * y^-1 * x * y^-1 * z^-1, y^6 ]"] );
AddDictionary( dict, [36, 54], [[36, 54], [5, 6, 6], 150, "Action reflexible [m,n]", "[ x * y * z, x^-5, y * z^-1 * x^-1 * y^-1 * z, y * x^-1 * y^-1 * x * z * y, y^6 ]"] );
AddDictionary( dict, [57, 247], [[57, 247], [5, 6, 6], 240, "Action reflexible [m,n]", "[ x * y * z, x^-5, y^6, z^6, x^-1 * y * x^-2 * y^-1 * z^-2, y^-1 * z^-1 * x^-2 * z * x^-1 * y^-1 ]"] );
AddDictionary( dict, [57, 248], [[57, 248], [5, 6, 6], 240, "Action reflexible [m,n]", "[ x * y * z, x^-5, x^-1 * y^-1 * x^2 * z * x^-1, y^6, z^-1 * y * z^-1 * x^-1 * y^-1 * z * y^-1 ]"] );
AddDictionary( dict, [85, 244], [[85, 244], [5, 6, 6], 360, "Action reflexible [m]", "[ x * y * z, x^-5, z^-1 * y * x^-1 * y^-2, y^6, z^6, z^-3 * x^-1 * z^2 * y^-1 ]"] );
AddDictionary( dict, [85, 245], [[85, 245], [5, 6, 6], 360, "Action reflexible [m,n]", "[ x * y * z, x^-5, y^2 * x^-1 * z^2, y^6, (x * z * y * x)^2 ]"] );
AddDictionary( dict, [85, 246], [[85, 246], [5, 6, 6], 360, "Action reflexible [m]", "[ x * y * z, x^-5, z^-2 * x^-1 * z * y^-1, y^6, y^-1 * z^-1 * y * x * z * x^-1, z^6 ]"] );
AddDictionary( dict, [85, 247], [[85, 247], [5, 6, 6], 360, "Action reflexible [m,n]", "[ x * y * z, x^-5, y^6, (x^-1 * z * y)^2, z^6, y^2 * x^-2 * z^2 * x^-1 ]"] );
AddDictionary( TGQUOTS@, [ 5, 6, 6 ], dict );