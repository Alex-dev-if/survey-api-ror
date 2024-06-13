module Resolvers
  class Results < BaseResolver
    description 'Get results from a form'

    argument :form_id, ID, required: true

    type [Types::ResultType], null: false

    def resolve(form_id:)

      result = []
      form = Form.find form_id

      form.questions.map do |question|
        if question.text?
          result.push({question_title: question.title, content: question.answers.pluck(:content)})
        else
          hash = {}

          for x in 0..question.options.size-1
            count = question.answers.where("content @> ?", (x+1).to_json).count
            hash["#{question.options[x]}"] = count
          end
          
          result.push({question_title: question.title, content: hash })
        end
      end

      result
    end
  end
end
