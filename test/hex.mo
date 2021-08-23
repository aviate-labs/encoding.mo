import Hex "../src/Hex";

let xs : [Nat8] = [255, 0];
let cs : Text   = "FF00";

assert(Hex.encode(xs) == cs);
switch (Hex.decode(cs)) {
    case (#ok(x))  assert(x == xs);
    case (#err(m)) assert(false);
};

switch (Hex.decode("FF0")) {
    case (#ok(x))  assert(x == [15, 240]);
    case (#err(m)) assert(false);
};
