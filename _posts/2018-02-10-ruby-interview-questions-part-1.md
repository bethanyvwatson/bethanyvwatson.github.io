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
2. [Explain how everything in Ruby is an object.](#2-explain-how-everything-in-ruby-is-an-object)
3. [What is a class?](#3-what-is-a-class)
4. [What is a module?](#4-what-is-a-module)
4. [What is the difference between a class and a module?](#5-what-is-the-difference-between-a-class-and-a-module)
5. [What is the difference between class variables and instance variables?](#6-what-is-the-difference-between-class-variables-and-instance-variables)
6. [Explain singleton methods.](#7-explain-singleton-methods)
7. [What is an eigan class?](#8-what-is-an-eigan-class)
8. [What is a Proc? What is a Lambda?](#9-what-is-a-proc-what-is-a-lambda)
9. [What is the difference between a Proc and a Lambda?](#10-what-is-the-difference-between-a-proc-and-a-lambda)
10. [Describe the Ruby method lookup path.](#11-describe-the-ruby-method-lookup-path)
12. [What is the difference between `extend`, `include`, and `prepend`?](#12-what-is-the-difference-between-extend-include-and-prepend)

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

### 5. What is the difference between a class and a module?
* Classes can be instantiated to create objects. Modules *cannot* be instantiated.
* A class's purpose is object creation. A module's purpose is to encapsulate and provide additional functionality/methods to classes.

### 6. What is the difference between class variables and instance variables?
* Class variables are shared by all instances of a single class. Instance variables are uniquely defined per each instance of a class.
* Class variables are declared with `@@`. Instance variables are declared with `@`.
 
### 7. Explain singleton methods.
Singleton methods are methods which belong to a specific object. They live in an object's *eigan class*. Other members of an object's class do not have access to that object's singleton methods.

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

### 8. What is an eigan class?
Every object comes with its own personal wrapper class called an eigan class. It is also known as a `metaclass` or `singleton class`. 

The eigan class serves as a personal storage space for an object. Data or methods defined in an object's eigan class belong only to that object; if we define a function on a single instance of an object, that function is not available to any other instances of the same class (unless you specifically define it on those other instances, too). 

For example, consider the code below where we define a function `loves_cheese?` only for `franks_dog`:


```ruby
class Dog
  def initialize(owner)
  end
end

bobs_dog = Dog.new("Bob")
franks_dog = Dog.new("Frank")

def franks_dog.loves_cheese?
  true
end

franks_dog.loves_cheese?
# => true
bobs_dog.loves_cheese?
# => NoMethodError: undefined method `loves_cheese?'
````
The `loves_cheese?` method only exists on the `franks_dog` object because it is only defined in `franks_dog`'s eigan class!

### 9. What is a Proc? What is a Lambda?
* [Procs and Lambdas are blocks of code](https://ruby-doc.org/core-2.2.0/Proc.html) that have been bound to some local variables. These blocks of code can be called in different contexts while still maintaining access to those local variables.
* `Proc` is a class that can be instantiated using `Proc.new(&block)`. It accepts a block of code as its parameter. 
* A Lambda is a Proc that follows slightly different rules for argument agreement and return behavior.

### 10. What is the difference between a Proc and a Lambda?

For a quick and easy comparison, you might say:

* All Lambdas are Procs, but not all Procs are Lambdas.
* Procs are defined using `Proc.new` or `proc {...}`. Lambdas are defined using `-> {...}` or `lambda {...}`.
* Procs don't care about argument arity; Lambdas do.
* Procs return immediately from their calling context; a Lambda returns from itself.

But [the difference between Procs and Lambdas](https://blog.newrelic.com/2015/04/30/weird-ruby-part-4-code-pods/) can be a bit finicky, so let's take a closer look at those last two points.

##### Argument Arity 
You can pass a Proc whatever arguments you like. The Proc will do its best with whatever arguments you give it and ignore the rest. Lambdas, however, are very strict when it comes to argument matching. A Lambda will return an ArgumentError if given an unexpected number of arguments.

##### Returning from a Proc or Lambda
When a Proc explicitly "returns," it returns immediately from its calling context; if you use a Proc inside of a method, the Proc will cause that method to immediately return when the Proc evaluates its own `return`, thus ignoring any code that may have been written below the call to the Proc. A Lambda only returns from itself; using a Lambda in the middle of a method will allow any code written after the Lambda call to be executed normally. We illustrate this behavior in the code below.

```ruby
class Dog
  def sniff_all_the_things
    sniff_the_proc
    sniff_the_lambda
  end
  
  def sniff_the_lambda
    -> { puts "Sniffing the Lambda"; return }.call
    puts "Lambdas smell good!"
  end

  def sniff_the_proc
    Proc.new { puts "Sniffing the Proc"; return }.call
    puts "Procs smell good!" # won't get printed!
  end
end

Dog.new.sniff_all_the_things
# => Sniffing the Proc
# => Sniffing the Lambda
# => Lambdas smell good! 
```
### 11. Describe the Ruby method lookup path.
When you call a method on an object, Ruby first looks for a definition of that method. Between mix-ins, class inheritance, and eigan classes, there are several different places Ruby might find a method definition. Ruby uses the first definition that it finds. 

The method lookup path is the ordered list of all the places that Ruby will look for an object's method definition. Ruby typically looks in the most specific places first (like prepended modules or an object's eigan class) and searches in increasingly general locations (like the Kernel or BasicObject classes) until it finds a definition. 

A quick way to determine an object's method lookup path is to look at its class's ancestors.
```ruby
class Wolf
  def eats_meat?
    true
  end
end

class Dog < Wolf
end

Dog.ancestors
# => [Dog, Wolf, Object, Kernel, BasicObject]  
```
When calling any method on a Dog object, Ruby will first look for the definition inside the Dog class, then the Wolf class, Object class, Kernel class, and finally the BasicObject class. 

Calling `Dog.new.eats_meat?` returns true because Ruby finds `eats_meat?` defined on Dog's ancestor, Wolf.

Let's make things more complicated. Including a Vegetarian module inside the Dog class alters its ancestry.

```ruby
module Vegetarian
  def eats_meat?
    false
  end
end

class Wolf
  def eats_meat?
    true
  end
end

class Dog < Wolf
  include Vegetarian
end

Dog.ancestors
# => [Dog, Vegetarian, Wolf, Object, Kernel, BasicObject]  
```

Now Ruby will use the Vegetarian version of `eats_meat?` because Vegetarian comes before Wolf in the ancestors list. If we call `.eats_meat?` on a Dog, we'll get false. 

### 12. What is the difference between `extend`, `include`, and `prepend`?
[The difference between these mix-in techniques](http://leohetsch.com/include-vs-prepend-vs-extend/) is subtle. It all has to do with how each technique changes a class's ancestry list - and therefore, how it changes the method lookup path of a class's resulting objects.

##### Extend 
Using `extend` injects a module's methods into the target class as *class methods*. This has no affect on a class's ancestry and does not change the method lookup path.

Suppose we have a Dog class that produces dogs who chew shoes. We also have a WellTrained module which redefines `chews_shoes?` to return false.

```ruby
module WellTrained
  def chews_shoes?
    false
  end
end

class Dog
  def chews_shoes?
    true
  end
end

Dog.ancestors 
# => [Dog, Object, Kernel, BasicObject]
```
We've also printed the plain Dog's ancestry as a baseline for future comparison.

We'd prefer to have dogs that *don't* chew shoes. Can we achieve this by `extend`-ing the WellTrained class?

```ruby
module WellTrained
  def chews_shoes?
    false
  end
end

class Dog
  extend WellTrained
  
  def chews_shoes?
    true
  end
end

Dog.ancestors 
# => [Dog, Object, Kernel, BasicObject]
 
Dog.new.chews_shoes?
# true
 
Dog.chews_shoes?
# false
```

As demonstrated, instances of Dog still chew shoes and Ruby still looks for methods in all the same places (and in the same order). Note that there is a new class method available in the Dog class. 

##### Include
When we `include` a module in a class, that module enters the method lookup path behind the target class. If the target class defines a function that is also defined by the module, Ruby will use the definition found in the *target class*.

Let's take another look at those shoe-chewing dogs. This time, we'll `include` the WellTrained module instead.
```ruby
module WellTrained
  def chews_shoes?
    false
  end
end

class Dog
  include WellTrained
  
  def chews_shoes?
    true
  end
end

Dog.ancestors 
# => [Dog, WellTrained, Object, Kernel, BasicObject]
 
Dog.new.chews_shoes?
# true
```

Our dogs still chew shoes!

This is because `include` inserts the WellTrained module *after* the Dog class in the method lookup path. Since Dog already has `chews_shoes?` defined, and Dog appears sooner in the ancestry chain, Ruby uses Dog's implementation.

##### Prepend
If we want to ensure that a module's method definitions take priority over any of a target class's method definitions, we need to `prepend` the module. This places the module *before* the target class in the method lookup path.

To produce a well-trained dog, we need to `prepend` the WellTrained module into the Dog class. This ensures that Ruby will look inside the WellTrained module *first* when asked whether a Dog object `chews_shoes?`.

```ruby
module WellTrained
  def chews_shoes?
    false
  end
end

class Dog
  prepend WellTrained
  
  def chews_shoes?
    true
  end
end

Dog.ancestors 
# => [WellTrained, Dog, Object, Kernel, BasicObject]
 
Dog.new.chews_shoes?
# false
```