# frozen_string_literal: true

RSpec.describe RuboCop::Cop::GraphQL::LongFieldDescription, :config do
  context "when description is passed as argument" do
    it "not registers an offense" do
      expect_no_offenses(<<~RUBY)
        class UserType < BaseType
          field :first_name, String, "First name", null: true
        end
      RUBY
    end
  end

  context "when description is passed as kwarg" do
    it "registers an offense" do
      expect_offense(<<~RUBY)
        class FooType < BaseType
          field :first_name, String, "I am reaaaaaaaaaaaaaaaaallllllllllllllllllllllllllllllllllyyyyyyyyyyyyy long", null: true
          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ Long field description
        end
      RUBY
    end
  end
end
