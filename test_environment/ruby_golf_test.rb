# encoding: UTF-8
require "minitest/autorun"
require "ruby_golf"

class RubyGolfTest < Minitest::Test

  i_suck_and_my_tests_are_order_dependent!


  ##############################################################################
  # Hole 1: RubyGolf.x_out_numbers                                             #
  ##############################################################################

  def test_hole_1_x_out_numbers_1
    assert_equal "xxxxx678", RubyGolf.x_out_numbers("12345678", 3)
  end

  def test_hole_1_x_out_numbers_2
    assert_equal "4783", RubyGolf.x_out_numbers("4783", 4)
  end

  def test_hole_1_x_out_numbers_3
    assert_equal "394", RubyGolf.x_out_numbers("394", 5)
  end


  ##############################################################################
  # Hole 2: RubyGolf.underscore                                                #
  ##############################################################################

  def test_hole_2_underscore_1
    assert_equal "", RubyGolf.underscore("")
  end

  def test_hole_2_underscore_2
    assert_equal 'camel_case', RubyGolf.underscore('camelCase')
    assert_equal 'abstract_bean_converter_vistor_factory_service', RubyGolf.underscore('AbstractBeanConverterVistorFactoryService')
  end

  def test_hole_2_underscore_3
    assert_equal 'mumbo_jambo', RubyGolf.underscore('Mumbo-Jambo')
  end


  ##############################################################################
  # Hole 3: RubyGolf.symbolize_keys                                            #
  ##############################################################################

  def test_hole_3_symbolize_keys_1
    input = {
      'foo' => 42,
      'bar' => 'Schinken',
      'baz' => nil
    }
    expected = {
      foo: 42,
      bar: 'Schinken',
      baz: nil
    }
    assert_equal expected, RubyGolf.symbolize_keys(input)
  end

  def test_hole_3_symbolize_keys_2
    input = {
      'foo' => 42,
      'childhash1' => {
        'luke' => 'Skywalker',
        'Obi-Wan'  => 'Kenobi'
      },
      'childhash2' => {}
    }
    expected = {
      foo: 42,
      childhash1: {
        luke: 'Skywalker',
        :'Obi-Wan' => 'Kenobi'
      },
      childhash2: {}
    }
    assert_equal expected, RubyGolf.symbolize_keys(input)
  end


  ##############################################################################
  # Hole 4: RubyGolf.grid_computing                                            #
  ##############################################################################

  def test_hole_4_grid_computing
    assert_equal 14,  RubyGolf.grid_computing("14\n"), "1x1"
    assert_equal 35,  RubyGolf.grid_computing("14 20\n10 15\n"), "2x2 col"
    assert_equal 124, RubyGolf.grid_computing("25 99\n10 18"), "2x2 row"
    assert_equal 550, RubyGolf.grid_computing("01 34 46 31 55 21 16 88 87 87\n32 40 82 40 43 96 08 82 41 86\n"), "10x2"
    ten_by_ten = <<EOG
01 34 46 31 55 21 16 88 87 87
32 40 82 40 43 96 08 82 41 86
30 16 24 18 04 54 65 96 38 48
32 00 99 90 24 75 89 41 04 01
11 80 31 83 08 93 37 96 27 64
09 81 28 41 48 23 68 55 86 72
64 61 14 55 33 39 40 18 57 59
49 34 50 81 85 12 22 54 80 76
18 45 50 26 81 95 25 14 46 75
22 52 37 50 37 40 16 71 52 17
EOG
    assert_equal 615, RubyGolf.grid_computing(ten_by_ten), "10x10"
  end


  ##############################################################################
  # Hole 5: RubyGolf.reformat_hash                                             #
  ##############################################################################

  def test_hole_5_reformat_hash_1
    assert_equal '{}', RubyGolf.reformat_hash('{}')
    assert_equal '{  }', RubyGolf.reformat_hash('{  }')
  end

  def test_hole_5_reformat_hash_2
    assert_equal '{elf: 11}', RubyGolf.reformat_hash('{:elf => 11}')
    assert_equal '{key: :key}', RubyGolf.reformat_hash('{:key => :key}')
    assert_equal '{style: "display: none"}', RubyGolf.reformat_hash('{:style => "display: none"}')
  end

  def test_hole_5_reformat_hash_3
    assert_equal '{:"data-value" => "alt", new: "neu"}', RubyGolf.reformat_hash('{:"data-value" => "alt", :new => "neu"}')
  end


  ##############################################################################
  # Hole 6: RubyGolf.pretty_hash                                               #
  ##############################################################################

  def test_hole_6_pretty_hash_1
    input = {"wodka" => %w(energy cranberry orange), "whiskey" => %w(cola lime)}
    expected = <<EOS
wodka:
- energy
- cranberry
- orange
whiskey:
- cola
- lime
EOS
    assert_equal expected, RubyGolf.pretty_hash(input)
  end

  def test_hole_6_pretty_hash_2
    input = {
      "dwarves" => %w(Gimli Oin Gloin),
      "elves"   =>{
        :"full-elves" => :Galadriel,
        "half-elves"  => %w(Arwen Elrond)
      }
    }
    expected = <<EOS
dwarves:
- Gimli
- Oin
- Gloin
elves:
  full-elves:
  - Galadriel
  half-elves:
  - Arwen
  - Elrond
EOS
    assert_equal expected, RubyGolf.pretty_hash(input)
  end


  ##############################################################################
  # Hole 7: RubyGolf.word_letter_sum                                           #
  ##############################################################################

  def test_hole_7_word_letter_sum_1
    assert_equal 9, RubyGolf.word_letter_sum("CCC")
    assert_equal 9, RubyGolf.word_letter_sum("cCc")
    assert_equal 9, RubyGolf.word_letter_sum("ccc")
  end

  def test_hole_7_word_letter_sum_2
    assert_equal 10, RubyGolf.word_letter_sum("A B C")
    assert_equal 10, RubyGolf.word_letter_sum("C B A")
    assert_equal 10, RubyGolf.word_letter_sum("B A C")
    assert_equal 10, RubyGolf.word_letter_sum("b a C")
    assert_equal 10, RubyGolf.word_letter_sum("c b a")
    assert_equal 10, RubyGolf.word_letter_sum("A b C")
  end

  def test_hole_7_word_letter_sum_3
    assert_equal 1720, RubyGolf.word_letter_sum("Consider me As one who loved poetry And persimmons")
    assert_equal 1720, RubyGolf.word_letter_sum("consider me as one who loved poetry and persimmons")
    assert_equal 1720, RubyGolf.word_letter_sum("CONSIDER ME AS ONE WHO LOVED POETRY AND PERSIMMONS")
  end


  ##############################################################################
  # Hole 8: RubyGolf.bob_ross                                                  #
  ##############################################################################

  def test_hole_8_bob_ross_1
    input = <<EOS
1 0 65
2 1 66
1 1 67
0 1 68
EOS
    expected = <<EOS
 A
DCB
EOS
    assert_equal expected, RubyGolf.bob_ross(input)
  end

  def test_hole_8_bob_ross_2
    input = "18 22 126\n20 0 95\n15 22 94\n15 18 73\n6 1 59\n2 12 126\n20 18 73\n17 11 92\n21 18 73\n18 8 126\n13 16 33\n4 18 124\n3 14 95\n0 8 124\n30 8 124\n30 6 59\n8 13 45\n6 7 95\n16 16 95\n25 11 33\n18 12 34\n19 13 96\n5 8 126\n25 10 124\n29 13 124\n4 17 124\n9 19 96\n20 16 95\n9 13 45\n3 2 44\n28 4 39\n21 13 45\n18 16 95\n22 13 45\n15 9 124\n29 12 46\n7 1 126\n4 8 47\n19 7 95\n17 8 34\n1 12 46\n7 12 95\n15 21 94\n14 19 126\n26 14 95\n19 0 44\n14 22 126\n12 19 126\n11 18 73\n25 8 126\n6 16 124\n27 9 126\n6 17 124\n21 17 73\n27 15 86\n8 1 39\n24 9 44\n6 9 44\n14 16 95\n16 17 95\n22 16 126\n18 19 126\n20 9 126\n11 9 94\n3 15 86\n23 7 95\n24 15 47\n15 19 126\n9 17 73\n19 9 94\n6 12 95\n12 22 126\n29 5 59\n12 16 95\n20 21 46\n14 17 95\n5 19 92\n14 12 46\n7 16 84\n12 12 34\n0 7 124\n2 3 59\n21 12 46\n22 7 95\n13 8 34\n24 8 34\n6 8 34\n15 0 45\n9 18 73\n15 10 58\n7 20 92\n5 10 124\n26 8 92\n20 19 39\n19 16 95\n15 17 73\n30 7 124\n28 3 59\n7 18 92\n30 5 44\n18 9 126\n13 0 45\n16 12 46\n21 7 95\n13 11 47\n24 1 59\n28 6 59\n8 17 73\n10 9 126\n2 4 39\n17 0 45\n10 13 59\n17 13 92\n10 7 95\n17 16 33\n10 19 126\n3 9 126\n11 17 73\n26 18 124\n15 11 124\n4 16 124\n20 17 73\n16 22 126\n14 10 125\n0 6 59\n11 7 95\n5 1 44\n12 8 126\n8 18 44\n17 9 44\n7 7 95\n20 13 59\n23 12 95\n13 9 44\n11 16 95\n10 16 95\n1 11 124\n4 14 95\n19 12 45\n8 9 126\n22 17 73\n28 7 59\n5 12 40\n29 10 124\n7 17 96\n16 10 123\n28 12 126\n10 17 73\n30 9 124\n8 7 95\n26 15 124\n23 18 47\n13 19 126\n23 20 47\n23 17 39\n9 21 92\n9 6 46\n10 12 45\n13 13 47\n22 18 44\n19 17 73\n10 18 73\n15 8 46\n2 14 92\n21 9 126\n9 9 126\n17 22 126\n17 19 126\n21 6 46\n8 16 126\n14 0 45\n12 17 95\n10 0 46\n13 14 92\n24 12 95\n23 16 84\n7 13 45\n0 5 44\n24 17 124\n5 14 46\n29 11 124\n11 12 45\n5 11 108\n22 9 126\n8 0 95\n0 9 124\n13 22 126\n27 14 95\n18 17 95\n16 19 126\n16 0 45\n25 19 47\n17 18 73\n1 4 44\n15 16 95\n21 16 47\n2 7 59\n25 14 46\n11 13 39\n1 13 124\n9 0 44\n26 16 124\n15 12 94\n24 16 124\n9 16 92\n22 1 39\n22 12 44\n19 19 126\n15 14 94\n4 2 59\n12 9 126\n25 1 44\n26 17 124\n29 4 44\n21 21 47\n7 9 45\n11 20 46\n10 21 46\n11 0 45\n19 20 46\n1 5 59\n27 8 39\n18 0 46\n13 18 73\n23 13 45\n17 14 47\n27 2 44\n12 0 45\n11 19 126\n6 15 92\n8 12 44\n23 9 45\n15 13 124\n17 17 73\n25 12 41\n28 14 47\n24 7 95\n14 14 47\n9 7 95\n13 17 73\n26 2 59\n1 10 124\n20 7 95\n19 18 73\n19 22 94\n3 8 96\n2 6 59\n9 12 46\n11 22 94\n16 14 92\n20 12 45\n4 15 124\n23 1 126\n"
    expected = "        _,.-------.,_\n     ,;~'             '~;,\n   ,;                     ;,\n  ;                         ;\n ,'                         ',\n,;                           ;,\n; ;      .           .      ; ;\n| ;   ______       ______   ; |\n|  `/~\"     ~\" . \"~     \"~\\'  |\n|  ~  ,-~~~^~, | ,~^~~~-,  ~  |\n |   |        }:{        |   |\n |   l       / | \\       !   |\n .~  (__,.--\" .^. \"--.,__)  ~.\n |     ---;' / | \\ `;---     |\n  \\__.       \\/^\\/       .__/\n   V| \\                 / |V\n    | |T~\\___!___!___/~T| |\n    | |`IIII_I_I_I_IIII'| |\n    |  \\,III I I I III,/  |\n     \\   `~~~~~~~~~~'    /\n       \\   .       .   /\n         \\.    ^    ./\n           ^~~~^~~~^\n"
    got = RubyGolf.bob_ross(input)
    assert expected == got
    puts "\nYou've mastered the last hole!", got
  end

end
