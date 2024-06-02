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
    # Examine the standard data structure generated from your DSL.
    quizzes = Spark.Dsl.Extension.get_entities(Exam, [:quizzes])

    assert quizzes ==
             [
               %Sparkdsl.Quiz{
                 name: "English end of term exam",
                 type: :essay,
                 questions: [
                   %Sparkdsl.Question{
                     title: "Jane Eyre, discuss."
                   },
                   %Sparkdsl.Question{
                     title: "The Great Gatsby, discuss."
                   }
                 ]
               }
             ]

    #  Simple introspection example

    assert Enum.map_join(quizzes, &Sparkdsl.Quiz.introspect/1)

    """
    English end of term exam (essay)

    Question(s):
    Jane Eyre, discuss.
    The Great Gatsby, discuss.
    """
  end
end
