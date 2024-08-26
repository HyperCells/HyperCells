dict := NewDictionary( [ 2, 1 ], true );
AddDictionary( dict, [8, 20], [[8, 20], [4, 4, 9], 36, "Action reflexible [m,n]", "[ x * y * z, z * x^-1 * y^-1, x^4, z^5 * y^-1 * x^-1 * z^3 ]"] );
AddDictionary( dict, [15, 37], [[15, 37], [4, 4, 9], 72, "Action reflexible [m,n]", "[ x * y * z, x^4, y^4, (x * z^-1)^2, (y * z^-1)^2, z^-5 * x * y * z^-3 ]"] );
AddDictionary( dict, [29, 57], [[29, 57], [4, 4, 9], 144, "Action reflexible [m,n]", "[ x * y * z, x^4, y^4, y^-1 * z^-1 * x^2 * z * y^-1, y * x^-1 * y^-1 * x * z^-2, (x * z^-1 * y)^2, z^4 * y^-1 * x^-1 * z^4 ]"] );
AddDictionary( dict, [29, 58], [[29, 58], [4, 4, 9], 144, "Action reflexible [m]", "[ x * y * z, x^4, y^4, y * x^-2 * z * x^-1, y^-1 * z^-1 * y * x^-1 * z * y^-1 * z, z^-2 * x * z^3 * y * z^-3 ]"] );
AddDictionary( dict, [57, 112], [[57, 112], [4, 4, 9], 288, "Action reflexible [m,n]", "[ x * y * z, x^4, y^4, (x * z^-1 * y)^2, z^3 * x^-1 * z^2 * y^-1, y * x^-1 * y * x^2 * z^2 * x^-1, z^4 * y^-1 * x^-1 * z^4 ]"] );
AddDictionary( dict, [57, 113], [[57, 113], [4, 4, 9], 288, "Action reflexible [m,n]", "[ x * y * z, x^4, y^4, x^-1 * y * x^-2 * y^-1 * z^-1 * y, z * x^-1 * y * x^-1 * y^2 * x, z^9 ]"] );
AddDictionary( dict, [64, 130], [[64, 130], [4, 4, 9], 324, "Action reflexible [m,n]", "[ x * y * z, x^4, (x * y^-1)^2, y^4, z^-9 ]"] );
AddDictionary( dict, [64, 131], [[64, 131], [4, 4, 9], 324, "Action reflexible [m,n]", "[ x * y * z, x^4, y^4, y^-1 * z^-1 * y * x * z * x^-1, z^3 * x^-1 * z^2 * y^-1, z^4 * y^-1 * x^-1 * z^4 ]"] );
AddDictionary( TGQUOTS@, [ 4, 4, 9 ], dict );