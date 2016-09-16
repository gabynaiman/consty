# Consty

[![Gem Version](https://badge.fury.io/rb/consty.svg)](https://rubygems.org/gems/consty)
[![Build Status](https://travis-ci.org/gabynaiman/consty.svg?branch=master)](https://travis-ci.org/gabynaiman/consty)
[![Coverage Status](https://coveralls.io/repos/github/gabynaiman/consty/badge.svg?branch=master)](https://coveralls.io/github/gabynaiman/consty?branch=master)
[![Code Climate](https://codeclimate.com/github/gabynaiman/consty.svg)](https://codeclimate.com/github/gabynaiman/consty)
[![Dependency Status](https://gemnasium.com/gabynaiman/consty.svg)](https://gemnasium.com/gabynaiman/consty)

Convert strings and symbols to constants in specific namespace

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'consty'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install consty

## Usage

```ruby
VAL = 0
module Foo
  VAL = 1
  class Bar
    VAL = 10
  end
end

Consty.get 'VAL'             # => VAL
Consty.get 'Foo::Bar'        # => Foo::Bar
Consty.get 'VAL', Foo        # => Foo::VAL
Consty.get 'Bar', Foo        # => Foo::Bar
Consty.get 'VAL', Foo::Bar   # => Foo::Bar::VAL
Consty.get '::VAL', Foo::Bar # => VAL
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/gabynaiman/consty.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

