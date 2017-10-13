---
layout: post
title: "Base64 Encoded Strings in Ruby"
date: 2017-10-12
---

## Working with Base64 in Ruby
There are several options for encoding and decoding Base64 strings in Ruby. Here are a couple that I've worked with in professional and personal projects.

### The Base64 module
A [Base64 module](https://apidock.com/ruby/Base64) exists in Ruby to encode and decode Base64 strings. Open up irb and try it out:

```ruby
require 'base64'

source_str = "A human-readable string with a smiley :)"
encoded_str = Base64.encode64(source_str)
```

Encoded, the string looks like this:
> QSBodW1hbi1yZWFkYWJsZSBzdHJpbmcgd2l0aCBhIHNtaWxleSA6KQ==\n


The decoded version of the string should equal `source_str` exactly.
```ruby
decoded_str = Base64.decode64(encoded_str)
source_str == decoded_str
# true
```

### Decoding with String#unpack

The Ruby [string method](http://ruby-doc.org/core-2.2.0/String.html#method-i-unpack) `unpack` decodes a string according to whatever formatting option you pass as a parameter. It returns an array of values, the length of which depends on how you decode the string.

To use this method for Base64 decoding, pass `'m*'` as the parameter. We can expect an array of size 1.

Let's try this on the encoded string we created above.

```ruby
unpacked_str = encoded_str.unpack('m*')
```
The returned value should be:

> ["A human-readable string with a smiley :)"]

Yup, that's an array! Grabbing the first element should give us our original string.

```ruby
decoded_str = unpacked_str[0]
decoded_str == source_str 
# => true
```

### Encoding with Array#pack

To _encode_ a string, we use the [array method](http://ruby-doc.org/core-2.2.0/Array.html) `pack`. It also accepts `'m*'` as the directive to use Base64 encoding. This method will return the Base64 encoded string.

Here's the slightly inconvenient part. Because `pack` is a method on `Array`, it will only work if the string we want to encode in Base64 is wrapped in an array.

```ruby
source_str.pack('m*')
# => NoMethodError: undefined method `pack' for ...:String

[source_str].pack('m*')
# => "QSBodW1hbi1yZWFkYWJsZSBzdHJpbmcgd2l0aCBhIHNtaWxleSA6KQ==\n" 

unpacked_str.pack('m*')
# => "QSBodW1hbi1yZWFkYWJsZSBzdHJpbmcgd2l0aCBhIHNtaWxleSA6KQ==\n"
```

## Bonus: Decoding Base64 in Javascript
[Many browsers](http://caniuse.com/#feat=atob-btoa) have built-in support for Base64 encoding/decoding in Javascript.

Open up a JS console and test it out. To encode a string, use the window function `btoa` ("b to a").

```javascript
var sourceStr = "A human-readable string with a smiley :)";

var encodedStr = btoa(sourceStr);
encodedStr
// < "QSBodW1hbi1yZWFkYWJsZSBzdHJpbmcgd2l0aCBhIHNtaWxleSA6KQ=="
```

And to decode that string, use `atob`.

```javascript
var decodedStr = atob(encodedStr);
decodedStr
// < "A human-readable string with a smiley :)"
```

