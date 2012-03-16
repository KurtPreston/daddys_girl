# Daddy's Girl

Daddy's Girl is a Ruby gem to provide object_daddy-like syntax for factory_girl

## Installation

Add this line to your application's Gemfile:

    gem 'daddys_girl'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install daddys_girl

## Usage
First, you must add a class definition to the Factory Girl factories file (normally spec/factories.rb)

Methods:
1. ```ClassName.spawn(params)```: creates an object, but does not save it
2. ```ClassName.generate(params)```: creates an object and attempts to save it
3. ```ClassName.generate!(params)```: creates an object, and throws an error if it can not save it

Daddy's Girl also works with associations. For example:
```object.has_many_association.generate!(params)``` will generate the associated object, and bind it to the calling object.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
