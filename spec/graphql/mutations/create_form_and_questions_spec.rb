require 'rails_helper'
require 'graphql'


RSpec.describe "#CreateFormAndQuestion mutation" do
  let(:form) { build(:form) }
  let(:user) { build(:user) }
  let(:question) { build(:question) }
  
  it "is successful with correct data" do
    User.create!(user.attributes.to_h)

    result = SurveyApiSchema.execute(query, variables: {
      title: form.title,
      opened:  form.opened,
      respond_until: form.respond_until.iso8601,

      title_question: question.title,
      form_id:  form.id,
      options: question.options,
      order: question.order,
      question_type: question.question_type,
      required: question.required
    },
    context: {current_user: user}
    )

    expect(result.dig("data", "createFormAndQuestions", "form", "title")).to eq(form.title)    
    expect(result.dig("data", "createFormAndQuestions", "form", "opened")).to eq(form.opened)    
    expect(result.dig("data", "createFormAndQuestions", "form", "respondUntil")).to eq(form.respond_until.iso8601)    
    expect(result.dig("data", "createFormAndQuestions", "form", "userId")).to eq(user.id)    

    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "title")).to eq(question.title)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "required")).to eq(question.required)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "formId")).to eq(question.form_id)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "options")).to eq(question.options)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "order")).to eq(question.order)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 0, "questionType")).to eq(question.question_type)
    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "title")).to eq(question.title)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "required")).to eq(question.required)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "formId")).to eq(question.form_id)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "options")).to eq(question.options)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "order")).to eq(question.order)    
    expect(result.dig("data", "createFormAndQuestions", "questions", 1, "questionType")).to eq(question.question_type)

    puts result.inspect

  end


  def query
    <<~GQL
      mutation CreateFormAndQuestions ($title: String!, $opened: Boolean!, 
      $respond_until: ISO8601DateTime, $title_question: String!, $required: Boolean!,
      $options: [String!], $order: Int!, $question_type: String!) {
        createFormAndQuestions(
            input: { form: { title: $title, opened: $opened, respondUntil: $respond_until }, 
              questions: [
                  {title: $title_question, order: $order, 
                  required: $required, questionType: $question_type, 
                  options: $options},
                  {title: $title_question, order: $order, 
                  required: $required, questionType: $question_type, 
                  options: $options}
              ]
            }
        ) {
            errors
            form {
                createdAt
                id
                opened
                respondUntil
                title
                updatedAt
                userId
            }
            questions {
                createdAt
                formId
                id
                options
                order
                questionType
                required
                title
                updatedAt
            }
        }
    }

    GQL
  end
end