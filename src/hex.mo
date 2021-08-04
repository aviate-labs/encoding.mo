import A "mo:base/Array";
import C "mo:base/Char";
import I "mo:base/Iter";
import N "mo:base/Nat8";
import R "mo:base/Result";

module {
    private let base : Nat8   = 16;
    private let hex  : [Char] = [
        '0', '1', '2', '3', 
        '4', '5', '6', '7', 
        '8', '9', 'A', 'B', 
        'C', 'D', 'E', 'F',
    ];

    // encodeByte converts a byte to its corresponding hexidecimal format.
    public func encodeByte(n : Nat8) : Text {
        let c0 = hex[N.toNat(n / base)];
        let c1 = hex[N.toNat(n % base)];
        C.toText(c0) # C.toText(c1);
    };

    // encode converts an array of bytes to their corresponding hexidecimal format.
    public func encode(ns : [Nat8]) : Text {
        A.foldRight<Nat8, Text>(
            ns, 
            "", 
            func(n : Nat8, acc : Text) : Text {
                encodeByte(n) # acc;
            },
        );
    };

    // decodeChar converts the given hexadecimal character to its corresponding binary format.
    // NOTE: a hexadecimal char is just an 4-bit natural number.
    public func decodeChar(c : Char) : R.Result<Nat8,Text> {
        for (i in hex.keys()) {
            if (hex[i] == c) {
                return #ok(N.fromNat(i));
            }
        };
        #err("Unexpected character: " # C.toText(c));
    };

    // decode converts the given hexidecimal text to its corresponding binary format.
    public func decode(t : Text) : R.Result<[Nat8],Text> {
        let cs = I.toArray(t.chars());
        if (cs.size() % 2 != 0) {
            return #err("Cannot decode text: uneven length.");
        };
        let ns = A.init<Nat8>(cs.size() / 2, 0);
        for (i in I.range(0, ns.size() - 1)) {
            let j : Nat = i * 2;
            switch (decodeChar(cs[j])) {
                case (#err(e)) { return #err(e); };
                case (#ok(x0)) {
                    switch (decodeChar(cs[j+1])) {
                        case (#err(e)) { return #err(e); };
                        case (#ok(x1)) {
                            ns[i] := x0 * base + x1;
                        };
                    };
                };
            };
        };
        #ok(A.freeze(ns));
    };
};
