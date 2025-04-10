# frozen_string_literal: true

module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice then "bg-green-100 text-green-800"
    when :alert  then "bg-red-100 text-red-800"
    else "bg-gray-100 text-gray-800"
    end
  end
end
