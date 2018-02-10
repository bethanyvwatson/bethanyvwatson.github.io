---
layout: post
title: "12 High-Level Ruby Interview Questions" 
date: 2018-02-10
tags:
  - software-development
  - ruby
categories:
  - software-development
---

Here are 12 high-level, conceptual Ruby questions to help bolster your confidence for your next interview. Quiz yourself, then check out the answers below! 

Some questions have multiple valid answers. The answers provided are by no means exhaustive.

# Questions
___
1. [What is an object?](#1-what-is-an-object)
2. Explain how everything in Ruby is an object.
3. What is a class?
4. What is a module?
4. What is the difference between a class and a module?
5. What is the difference between class variables and instance variables?
6. Explain singleton methods.
7. What is an eigan class?
8. What is a Proc? What is a Lambda?
9. What is the difference between a Proc and a Lambda?
10. Describe the Ruby method lookup path.
12. What is the difference between `extend`, `include`, and `prepend`?

# Answers
___
### 1. What is an object?
* An object is an instance of a class.
* An object is a collection of specifically related data structures, methods, and state-information.

*Possible bonus points if you mention that almost everything in Ruby is an object!*
### 2. Explain how everything in Ruby is an object.
It's not!

Everything in Ruby *evaluates* to an object, but only *most* things in Ruby actually *are* objects. Because almost everything in Ruby behaves as an object, developers can expect (and enjoy!) consistent behavior when manipulating diverse parts of a Ruby program. Classes and modules are objects. Methods are objects. Strings, numbers, and hashes are objects.

But there are some structures - like argument lists, blocks, and `if` statements - that by necessity are *not* objects.

To illustrate this necessity, let's pretend for a moment that argument lists are objects. They come from the `ArgumentList` class. Given the code below, how might you instantiate an instance of the `Dog` class?

```ruby
class ArgumentList
  def initialize(args)
    # stuff
  end
end

class Dog
  def initialize(breed, gender)
    # stuff
  end
end
``` 

Normally, we could just do something like:

```ruby
Dog.new("Collie", "male")
```

But since argument lists are now objects that need to be instantiated, we get:

```ruby
Dog.new(ArgumentList.new(ArgumentList.new(ArgumentList.new(...))))
```

Yikes.

To read more about how/why only *almost* everything in Ruby is an object, check out [David Black's excellent blog post](http://rubylearning.com/blog/2010/09/27/almost-everything-is-an-object-and-everything-is-almost-an-object/) on the subject.

### 3. What is a class?
* A class is a [first-class object](http://ruby-doc.org/core-2.2.0/Class.html), an instance of class `Class`.
* A class is a blueprint for instantiating objects.
* A class is an object that defines the rules for instantiating another object.

### 4. What is a module?
* A module is a [collection of methods and constants](http://ruby-doc.org/core-2.2.0/Module.html). 
* A module can be mixed-in to classes to extend their functionality.
* A module provides namespacing capabilities for organizing and encapsulating different functionalities.

### 4. What is the difference between a class and a module?
* Classes can be instantiated to create objects. Modules *cannot* be instantiated.
* A class's purpose is object creation. A module's purpose is to encapsulate and provide additional functionality/methods to classes.

### 5. What is the difference between class variables and instance variables?
* Class variables are shared by all instances of a single class. Instance variables are uniquely defined per each instance of a class.
* Class variables are declared with `@@`. Instance variables are declared with `@`.
 
### 6. Explain singleton methods.
Singleton methods are methods which belong to a specific object. They live in an object's *eigan class* (also referred to as the object's *metaclass* or *singleton class*). Other embers of an object's class do not have access to that object's singleton methods.

You've probably written a singleton method before! Have you ever written a method definition using `def self.method_name`?  If so, you were defining a singleton method on the class object.

Here's another example. Imagine we have two instances of the class `Dog` as defined below. In this scenario, Bob and Frank both have dogs.

```ruby
class Dog
  def initialize(owner)
  end
  
  def is_good_boy?
    true
  end
end

bobs_dog = Dog.new("Bob")
franks_dog = Dog.new("Frank")
```
Both dogs have access to the `is_good_boy?` method.

```ruby
bobs_dog.is_good_boy?
# => true
franks_dog.is_good_boy?
# => true 
```
Now suppose Frank gives his dog some cheese for a treat. Bob doesn't want his dog to start begging for human food though, so his dog never learns that cheese exists. 

We'll define the singleton method `loves_cheese?` on `franks_dog` to illustrate this.

```ruby
def franks_dog.loves_cheese?
  true
end

franks_dog.loves_cheese?
# => true
bobs_dog.loves_cheese?
# => NoMethodError: undefined method `loves_cheese?'
 
```
Now `franks_dog` knows he likes cheese, and `bobs_dog` doesn't have a clue!

### 7. What is an eigan class?
An eigan class is also known as a `metaclass` or `singleton class`. Every object has its own eigan class. Data or methods defined in an object's eigan class belong only to that object; other objects of the same class remain unchanged.

I like to think of an eigan class as
### 8. What is a Proc? What is a Lambda?
### 9. What is the difference between a Proc and a Lambda?
### 10. Describe the Ruby method lookup path.
### 12. What is the difference between `extend`, `include`, and `prepend`?
