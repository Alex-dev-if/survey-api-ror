# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :sign_in_user, mutation: Mutations::SignInUser
    
    field :create_form, mutation: Mutations::Forms::CreateForm
    field :update_form, mutation: Mutations::Forms::UpdateForm
    field :delete_form, mutation: Mutations::Forms::DeleteForm

    field :create_question, mutation: Mutations::Questions::CreateQuestion
    field :update_question, mutation: Mutations::Questions::UpdateQuestion
    field :delete_question, mutation: Mutations::Questions::DeleteQuestion

    field :create_form_and_questions, mutation: Mutations::CreateFormAndQuestions

    field :create_answer, mutation: Mutations::Answers::CreateAnswer

  end
end
