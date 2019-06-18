# frozen_string_literal: true

if defined?(::Rails::Generators)
  require 'rails/generators/migration'

  module AddFrozenStringLiteralComment
    def add_comment(dist)
      return unless File.exist?(dist) && File.extname(dist) == '.rb'

      File.open(dist, 'r') do |f|
        body = f.read

        File.open(dist, 'w') do |new_f|
          new_f.write("# frozen_string_literal: true\n\n" + body)
        end
      end
    end
  end

  module GeneratorPrepend
    include AddFrozenStringLiteralComment

    def invoke!
      res = super
      add_comment(existing_migration)
      res
    end
  end

  module TemplatePrepend
    include AddFrozenStringLiteralComment

    def template(source, *args, &block)
      res = super
      add_comment(args.first)
      res
    end
  end

  Rails::Generators::Actions::CreateMigration.send :prepend, GeneratorPrepend
  Rails::Generators::NamedBase.send :prepend, TemplatePrepend
end
