require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutSymbols < Neo::Koan
  def test_symbols_are_symbols
    symbol = :ruby
    assert_equal true, symbol.is_a?(Symbol)
  end

  def test_symbols_can_be_compared
    symbol1 = :a_symbol
    symbol2 = :a_symbol
    symbol3 = :something_else

    assert_equal true, symbol1 == symbol2
    assert_equal false, symbol1 == symbol3
  end

  def test_identical_symbols_are_a_single_internal_object
    symbol1 = :a_symbol
    symbol2 = :a_symbol

    assert_equal true, symbol1           == symbol2
    assert_equal true, symbol1.object_id == symbol2.object_id
  end

  def test_method_names_become_symbols
    symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }
    assert_equal true, symbols_as_strings.include?("test_method_names_become_symbols")
  end

  # THINK ABOUT IT:
  #
  # Why do we convert the list of symbols to strings and then compare
  # against the string value rather than against symbols?
  # - Because the list of symbols is a list of symbols, not strings.
  # We can create symbols using def?
  # - No, we can't. Symbols are created by using the colon (:) operator.
  # what does symbol.all_symbols do?
  # - It returns an array of all the symbols in the program.
  # are there default symbols?
  # - Yes, there are. For example, :test_method_names_become_symbols is a default symbol.
  # so that's something baked into ruby?
  # - Yes, it is.
  # what is the difference between a symbol and a string?
  # - A symbol is immutable, whereas a string is mutable.
  # is there a comparable version of let/const in javascript for ruby?
  # - Yes, there is. It's called a constant.
  # what is a constant?
  # - A constant is a variable that cannot be changed.
  # how do you create a constant?
  # - You create a constant by using the capital letter at the beginning of the variable name.
  # what does def do?
  # - It defines a method.
  # methods exist on classes?
  # - Yes, they do.
  # what does the below do?
  # but what about in_ruby_version?
  # - It checks if the current ruby version is the same as the one specified.
  # "mri" is the current ruby version?
  # - Yes, it is.

  in_ruby_version("mri") do
    RubyConstant = "What is the sound of one hand clapping?"
    def test_constants_become_symbols
      all_symbols_as_strings = Symbol.all_symbols.map { |x| x.to_s }

      assert_equal false, all_symbols_as_strings.include?("What is the sound of one hand clapping?")
    end
  end

  def test_symbols_can_be_made_from_strings
    string = "catsAndDogs"
    assert_equal :catsAndDogs, string.to_sym
  end

  def test_symbols_with_spaces_can_be_built
    symbol = :"cats and dogs"

    assert_equal "cats and dogs".to_sym, symbol
  end

  def test_symbols_with_interpolation_can_be_built
    value = "and"
    symbol = :"cats #{value} dogs"

    assert_equal "cats and dogs".to_sym, symbol
  end

  def test_to_s_is_called_on_interpolated_symbols
    symbol = :cats
    string = "It is raining #{symbol} and dogs."

    assert_equal "It is raining cats and dogs.", string
  end

  def test_symbols_are_not_strings
    symbol = :ruby
    assert_equal false, symbol.is_a?(String)
    assert_equal false, symbol.eql?("ruby")
  end

  def test_symbols_do_not_have_string_methods
    symbol = :not_a_string
    assert_equal false, symbol.respond_to?(:each_char)
    assert_equal false, symbol.respond_to?(:reverse)
  end

  # It's important to realize that symbols are not "immutable
  # strings", though they are immutable. None of the
  # interesting string operations are available on symbols.

  def test_symbols_cannot_be_concatenated
    # Exceptions will be pondered further down the path
    # give me a hint on the below
    # - It's a method that raises an exception.
    # what is an exception?
    # - An exception is an error that is raised when something goes wrong.
    # how do i make it pass?
    #
    assert_raise(NoMethodError) do
      :cats + :dogs
    end
  end

  def test_symbols_can_be_dynamically_created
    assert_equal :catsdogs, ("cats" + "dogs").to_sym
  end

  # THINK ABOUT IT:
  #
  # Why is it not a good idea to dynamically create a lot of symbols?
end
