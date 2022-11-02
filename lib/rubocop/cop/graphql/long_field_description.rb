# frozen_string_literal: true
require "pry"

module RuboCop
  module Cop
    module GraphQL
      #  This cop checks if each field has a long description.
      #
      # @example
      #   # good
      #
      #   class UserType < BaseType
      #     field :name, String, "Name of the user", null: true
      #   end
      #
      #   # bad
      #
      #   class UserType < BaseType
      #     field :name, String, "I am a really longggggggggggggggggggggggggggggggggggggggggggggggggggggggg", null: true
      #   end
      #
      class LongFieldDescription < Base
        include RuboCop::GraphQL::NodePattern

        MSG = "Long field description"

        def on_send(node)
          return unless field_definition?(node)

          field = RuboCop::GraphQL::Field.new(node)

          return unless field.description

          add_offense(node) if field.description.length > 60
        end
      end
    end
  end
end
