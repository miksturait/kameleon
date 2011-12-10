module Kameleon
  module Dsl
    module See
      def see(*content)
        options = extract_options(content)

        case options.class.name
          when 'String'
            session.should rspec_world.have_content(options)
          when 'Array'
            options.each do |content_part|
              session.should rspec_world.have_content(content_part)
            end
          when 'Hash'
            options.each_pair do |value, locator|
              case value
                when :empty
                  one_or_all(locator).each do |selector|
                    session.should rspec_world.have_field(selector)
                    session.find_field(selector).value.should == ""
                  end
                when :checked, :selected
                  one_or_all(locator).each do |selector|
                    session.should rspec_world.have_checked_field(selector)
                  end
                when :unchecked, :unselected
                  one_or_all(locator).each do |selector|
                    session.should rspec_world.have_unchecked_field(selector)
                  end
                else
                  session.should rspec_world.have_field(locator, :with => value)
              end
            end
          else
            raise "Not Implemented Structure #{options} :: #{options.class}"
        end
      end

      def not_see(*content)
        options = extract_options(content)

        case options.class.name
          when 'String'
            session.should_not rspec_world.have_content(options)
          when 'Array'
            options.each do |content_part|
              session.should_not rspec_world.have_content(content_part)
            end
          when 'Hash'
            options.each_pair do |value, locator|
              session.should_not rspec_world.have_field(locator, :with => value)
            end
          else
            raise "Not Implemented Structure #{options} :: #{options.class}"
        end
      end
    end
  end
end