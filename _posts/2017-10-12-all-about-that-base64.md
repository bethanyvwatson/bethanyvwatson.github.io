---
layout: post
title: "All About that Base(64)"
date: 2017-10-12
tags: ruby
categories:
  - software-development
---

Base64 encoding is a strategy used in computing to transform raw data into readily-decodable, transmission-safe strings of text. Encoding results in bloated-but-perfect obfuscations of the original data.

For example, when we Base64 encode the string

> "A human-readable string with a smiley :)"

it turns into:

> "QSBodW1hbi1yZWFkYWJsZSBzdHJpbmcgd2l0aCBhIHNtaWxleSA6KQ==\n"

## Why Bother?

Not all computer systems can correctly process all printable characters. Data loss occurs when one system sends information containing special characters -- say, a smile emoji :) - to a system which cannot process those characters.

Base64 encoding attempts to prevent the loss or corruption of data when transmitting information between systems. It accomplishes this by translating source content into a format which ONLY uses a subset of 64 basic ASCII characters. *Base16* and *Base32* encoding strategies behave similarly, but employ smaller subsets of characters.

The base set of ASCII characters that are used for translation [varies](https://en.wikipedia.org/wiki/Base64#Implementations_and_history) between different implementations.


### Encoding Bloats Your Data

When encoded, a single character gets represented as multiple "base" characters -- even if that character exists in the base set. As a result, Base64 encoded strings always grow to about 133% of their original data size (plus a little extra for the termination characters).

We can demonstrate this using Ruby's Base64 module. Don't forget to require the module in irb!

```ruby
src_str = "The longer the source, the closer to an encoded size of 133% of the original!"
src_bytes = src_str.bytesize.to_f 
# => 77.0 bytes

enc_str = Base64.encode64(src_str)
enc_bytes = enc_str.strip.gsub('=','').bytesize.to_f 
# => 104.0 bytes

enc_bytes / src_bytes * 100 
# => 135 (percent)
 
```

In the above example, we've stripped the termination characters `==\n` from the end of the encoded string before calculating its bytesize.


### Base64 Encoding is NOT Encryption

Encoding a string results in something that looks like a jumbled mess of nonesense. But encoding a string is _not_ the same as encrypting it! 

Encoding only ensures data integrity. It does nothing for data _security_.

## Decoding all that Insecure, Bloated Data

Encoding and decoding strings into Base64 is systematic; a patient, focused person could do both by hand if given a table of character translations. And enough time.

But the whole point of encoding data is to make it easily (quickly!) transmissable. Most programming languages have built-in functionality to deal with encoded strings. 

Check out [this blog post](http://blog.bethanywatson.me/ruby/javascript/2017/10/12/decoding-base64-ruby-javascript.html) for examples of how to work with Base64 in Ruby.



 






