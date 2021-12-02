import Array "mo:base/Array";
import Char "mo:base/Char";
import Iter "mo:base/Iter";
import Nat8 "mo:base/Nat8";
import Nat32 "mo:base/Nat32";
import Text "mo:base/Text";

module {
    public func arrayToText(xs : [Nat8]) : Text {
        Text.fromIter(Iter.fromArray(
            Array.map<Nat8, Char>(
                xs,
                func (n : Nat8) : Char {
                    Char.fromNat32(Nat32.fromNat(Nat8.toNat(n)))
                },
            ),
        ));
    };

    public func textToArray(t : Text) : [Nat8] {
        Array.map<Char, Nat8>(
            Iter.toArray(t.chars()),
            func (c : Char) : Nat8 {
                Nat8.fromNat(Nat32.toNat(Char.toNat32(c)));
            },
        );
    };
};
