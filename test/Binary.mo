import Binary "../src/Binary";

import Debug "mo:base/Debug";

let n : Nat64 = 1_000_000_000_000;

let n_be = Binary.BigEndian.fromNat64(n);
assert(n == Binary.BigEndian.toNat64(n_be));

let n_le = Binary.LittleEndian.fromNat64(n);
assert(n == Binary.LittleEndian.toNat64(n_le));
