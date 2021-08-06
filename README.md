# Hex

<a href="https://sdk.dfinity.org/docs/"><img src="https://img.shields.io/badge/dfx-0.8.0-yellow"/></a>

This package provides hexadecimal encoding and decoding methods for Motoko.

## Usage

Encode an array of unsigned 8-bit integers in hexadecimal format.
```motoko
encode(ns : [Nat8]) : Text
```

Decode an array of unsigned 8-bit integers in hexadecimal format.
```motoko
decode(t : Text) : Result<[Nat8],Text>
```
