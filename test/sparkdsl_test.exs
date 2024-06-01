defmodule SparkdslTest do
  use ExUnit.Case
  doctest Sparkdsl

  test "create a question" do
    # This is how you'd use your DSL

    defmodule Exam do
      use Sparkdsl

      quizzes do
        quiz "English end of term exam", :essay do
          question("Jane Eyre, discuss.")
          question("The Great Gatsby, discuss.")
        end
      end
    end

    _dsl_config = Exam.spark_dsl_config() |> dbg
    # * Run mix test to see the results
  end
end
