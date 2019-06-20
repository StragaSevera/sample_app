# frozen_string_literal: true

require 'active_record/annotate'

if ActiveRecord.const_defined?(:Annotate)
  ActiveRecord::Annotate.configure do |config|
    # set this to true to wrap annotations in triple backticks (```)
    # so YARD documentation can process the annotation as a code block
    # config.yard = false
  end
end
