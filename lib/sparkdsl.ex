defmodule Sparkdsl do
  @moduledoc """
  Documentation for `Sparkdsl`.
  ## Example

  ```
  quiz "English end of term exam", :essay do

    question "Jane Eyre, discuss."

  end

  quiz "English end of term exam", :essay do

    question "1 + 1", "2"
    multi_choice_question "3 * 9" do
      answer :a
      choice :a
      choice :b
      choice :c
      choice :d
    end
  end
  ```

  """

  defmodule Quiz do
    defstruct [:name, :type, :questions]

    def introspect(quiz) do
      """
      #{quiz.name} (#{quiz.type})

      Question(s):
      #{Enum.map_join(quiz.questions, "\n", & &1.title)}

      """
    end
  end

  defmodule Question do
    defstruct [:title]
  end

  defmodule Dsl do
    @question %Spark.Dsl.Entity{
      name: :question,
      describe: "Define a question in a quiz"
    }
  end
end
