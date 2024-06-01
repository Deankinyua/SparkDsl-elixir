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
      describe: "Define a question in a quiz",
      examples: [
        "question \"Why now\"?"
      ],
      target: Question,
      args: [:title],
      schema: [
        title: [
          type: :string,
          required: true,
          doc: "The question itself"
        ]
      ]
    }

    @quiz %Spark.Dsl.Entity{
      name: :quiz,
      describe: "Define a quiz with questions",
      examples: [
        "quiz \"Pop quiz!\", :multiple_choice"
      ],
      target: Quiz,
      args: [:name, :type],
      entities: [questions: [@question]],
      schema: [
        name: [
          type: :string,
          required: true,
          doc: "The quiz title"
        ],
        type: [
          type: :atom,
          required: true,
          doc: "The type of quiz"
        ]
      ]
    }

    @toplevel_section %Spark.Dsl.Section{
      name: :quizzes,
      # top_level: true,
      entities: [@quiz]
    }

    use Spark.Dsl.Extension, sections: [@toplevel_section]
  end

  use Spark.Dsl, default_extensions: [extensions: [Dsl]]
end
