# swift-gyb

Evaluates and runs a [Swift GYB](https://nshipster.com/swift-gyb/) script.

## Installation

Install `swift-gyb` with [Homebrew](https://brew.sh)
using the following command:

```terminal
$ brew install nshipster/formulae/swift-gyb
```

## Usage

```python
// hello.swift.gyb
%{ names = ['Johnny', 'Jane'] }%
% for name in names:
print("Hello, ${name}!")
% end
```

```terminal
$ swift gyb ./hello.swift.gyb
Hello, Johnny!
Hello, Jane!
```

## License

MIT

## Contact

NSHipster ([@NSHipster](https://twitter.com/NSHipster))
