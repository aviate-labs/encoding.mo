import Base32 "../src/Base32";
import util "util";

assert (
    Base32.encode([102, 111, 111, 32, 98, 97, 114])
    == [77, 90, 88, 87, 54, 73, 68, 67, 77, 70, 90, 65]
); // "foo bar"

assert (
    Base32.decode([77, 90, 88, 87, 54, 73, 68, 67, 77, 70, 90, 65])
    == #ok([102, 111, 111, 32, 98, 97, 114])
); // "foo bar"

for ((text, encoded) in [
    ("", ""),
    ("f", "MY"),
    ("fo", "MZXQ"),
    ("foo", "MZXW6"),
    ("foo bar", "MZXW6IDCMFZA")
].vals()) {
    let e = Base32.encode(util.textToArray(text));
    assert(util.arrayToText(e) == encoded);
    switch (Base32.decode(e)) {
        case (#err(_)) { assert(false); };
        case (#ok(d)) { assert(util.arrayToText(d) == text); };
    };
};
