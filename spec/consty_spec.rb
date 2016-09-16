require 'minitest_helper'

VAL = 0

module Foo
  VAL = 1

  class Bar
    VAL = 10

    def self.const_missing(name)
      name.to_s == 'Const' ? Baz : super
    end
  end

  class Baz < Bar; end

  def self.const_missing(name)
    name.to_s == 'Autoloaded' ? Bar : super
  end
end

describe Consty do

  describe 'Unscoped' do
  
    it 'Get from string' do
      Consty.get('VAL').must_equal VAL
      Consty.get('Foo').must_equal Foo
      Consty.get('Foo::VAL').must_equal Foo::VAL
      Consty.get('Foo::Bar').must_equal Foo::Bar
      Consty.get('Foo::Bar::VAL').must_equal Foo::Bar::VAL
    end

    it 'Get from symbol' do
      Consty.get('VAL'.to_sym).must_equal VAL
      Consty.get('Foo'.to_sym).must_equal Foo
      Consty.get('Foo::VAL'.to_sym).must_equal Foo::VAL
      Consty.get('Foo::Bar'.to_sym).must_equal Foo::Bar
      Consty.get('Foo::Bar::VAL'.to_sym).must_equal Foo::Bar::VAL
    end

    it 'Explicit :: prefix (::SomeClass)' do
      Consty.get('::Foo').must_equal Foo
      Consty.get('::Foo::Bar').must_equal Foo::Bar
      Consty.get('::Foo::Bar::VAL').must_equal Foo::Bar::VAL
    end

    it 'NameError for undefined constant' do
      proc { Consty.get '' }.must_raise NameError
      proc { Consty.get 'UndefinedConstant' }.must_raise NameError
    end

    it 'Search in ancestors' do
      Consty.get('Foo::Baz::VAL').must_equal Foo::Baz::VAL
    end

    it 'Searches in const_missing (autoload support)' do
      Consty.get('Foo::Autoloaded::Const').must_equal Foo::Baz
      Consty.get('Foo::Bar::Const').must_equal Foo::Baz
      proc { Consty.get 'Foo::UndefinedConstant' }.must_raise NameError
      proc { Consty.get 'Foo::Bar::UndefinedConstant' }.must_raise NameError
    end

  end

  describe 'Namespace scoped' do

    it 'Get closest constant' do
      Consty.get('VAL', Foo).must_equal Foo::VAL
      Consty.get('Bar', Foo).must_equal Foo::Bar
      Consty.get('Bar::VAL', Foo).must_equal Foo::Bar::VAL
      Consty.get('VAL', Foo::Bar).must_equal Foo::Bar::VAL
      Consty.get('Bar', Foo::Baz).must_equal Foo::Bar
    end

    it 'Explicit :: prefix (::SomeClass)' do
      Consty.get('::VAL', Foo).must_equal VAL
      Consty.get('::VAL', Foo::Bar).must_equal VAL
    end

  end

end