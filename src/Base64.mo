import Array "mo:base/Array";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Result "mo:base/Result";

import Debug "mo:base/Debug";

module Base64 {
    private let encodeStd = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

    private let encodeMap : [Nat8] = [
         65,  66,  67,  68,  69,  70,  71,  72,
         73,  74,  75,  76,  77,  78,  79,  80,
         81,  82,  83,  84,  85,  86,  87,  88,
         89,  90,  97,  98,  99, 100, 101, 102,
        103, 104, 105, 106, 107, 108, 109, 110,
        111, 112, 113, 114, 115, 116, 117, 118,
        119, 120, 121, 122,  48,  49,  50,  51,
         52,  53,  54,  55,  56,  57,  43,  47,
    ];

    // public func encodeMap() : [Nat8] {
    //     Array.map<Char, Nat8>(
    //         Iter.toArray(encodeStd.chars()),
    //         func (c : Char) : Nat8 {
    //             Nat8.fromNat(Nat32.toNat(Char.toNat32(c)));
    //         },
    //     );
    // };

    private func encodeLen(n : Nat) : Nat {
        (n * 8 + 5) / 6;
    };

    public func encode(data : [Nat8]) : [Nat8] {
        if (data.size() == 0) { return []; };

        var i = 0;
        var s = 0;
        let n = (data.size() / 3) * 3;
        let dst = Array.init<Nat8>(encodeLen(data.size()), 0);
        while (s < n) {
            let v = nat8to32(data[s]) << 16 | nat8to32(data[s+1]) << 8 | nat8to32(data[s+2]);
            dst[i  ] := encodeMap[Nat32.toNat(v >> 18 & 0x3F)];
            dst[i+1] := encodeMap[Nat32.toNat(v >> 12 & 0x3F)];
            dst[i+2] := encodeMap[Nat32.toNat(v >> 6  & 0x3F)];
            dst[i+3] := encodeMap[Nat32.toNat(v       & 0x3F)];
            i += 4; s += 3;
        };

        let r : Nat = data.size() - s;
        if (r == 0) return Array.freeze(dst);
        var v = nat8to32(data[s]) << 16;
        if (r == 2) v |= nat8to32(data[s+1]) << 8;
        dst[i  ] := encodeMap[Nat32.toNat(v >> 18 & 0x3F)];
        dst[i+1] := encodeMap[Nat32.toNat(v >> 12 & 0x3F)];
        if (r == 2) dst[i+2] := encodeMap[Nat32.toNat(v >> 6  & 0x3F)];
        Array.freeze(dst);
    };

    private func nat8to32(n : Nat8) : Nat32 {
        Nat32.fromNat(Nat8.toNat(n));
    };

    private let decodeMap : [Nat8] = [
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,  62, 255, 255, 255,  63,
         52,  53,  54,  55,  56,  57,  58,  59,  60,  61, 255, 255, 255, 255, 255, 255,
        255,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
         15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25, 255, 255, 255, 255, 255,
        255,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
         41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
        255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255,
    ];

    // public func decodeMap() : [Nat8] {
    //     let map = Array.init<Nat8>(256, 0xFF);
    //     for (i in encodeMap.keys()) {
    //         map[Nat8.toNat(encodeMap[i])] := Nat8.fromNat(i);
    //     };
    //     Array.freeze(map);
    // };

    private func decodeLen(n : Nat) : Nat {
        n * 6 / 8;
    };

    // public func decode(data : [Nat8]) : Result.Result<[Nat8], Text> {
    //     if (data.size() == 0) { return #ok([]); };

    //     // TODO

    //     #ok(data);
    // };
};
