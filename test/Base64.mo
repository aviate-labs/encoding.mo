import Base64 "../src/Base64";
import util "util";

assert (
    Base64.encode([102, 111, 111, 32, 98, 97, 114])
    == [90, 109, 57, 118, 73, 71, 74, 104, 99, 103]
); // "foo bar"

