# -*- encoding: utf-8 -*-
# stub: simple_form 3.1.0.rc2 ruby lib

Gem::Specification.new do |s|
  s.name = "simple_form"
  s.version = "3.1.0.rc2"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jos\u{e9} Valim", "Carlos Ant\u{f4}nio", "Rafael Fran\u{e7}a"]
  s.date = "2014-09-20"
  s.description = "Forms made easy!"
  s.email = "opensource@plataformatec.com.br"
  s.files = ["CHANGELOG.md", "MIT-LICENSE", "README.md", "lib/generators", "lib/generators/simple_form", "lib/generators/simple_form/USAGE", "lib/generators/simple_form/install_generator.rb", "lib/generators/simple_form/templates", "lib/generators/simple_form/templates/README", "lib/generators/simple_form/templates/_form.html.erb", "lib/generators/simple_form/templates/_form.html.haml", "lib/generators/simple_form/templates/_form.html.slim", "lib/generators/simple_form/templates/config", "lib/generators/simple_form/templates/config/initializers", "lib/generators/simple_form/templates/config/initializers/simple_form.rb", "lib/generators/simple_form/templates/config/initializers/simple_form_bootstrap.rb", "lib/generators/simple_form/templates/config/initializers/simple_form_foundation.rb", "lib/generators/simple_form/templates/config/locales", "lib/generators/simple_form/templates/config/locales/simple_form.en.yml", "lib/simple_form", "lib/simple_form.rb", "lib/simple_form/action_view_extensions", "lib/simple_form/action_view_extensions/builder.rb", "lib/simple_form/action_view_extensions/form_helper.rb", "lib/simple_form/components", "lib/simple_form/components.rb", "lib/simple_form/components/errors.rb", "lib/simple_form/components/hints.rb", "lib/simple_form/components/html5.rb", "lib/simple_form/components/label_input.rb", "lib/simple_form/components/labels.rb", "lib/simple_form/components/maxlength.rb", "lib/simple_form/components/min_max.rb", "lib/simple_form/components/pattern.rb", "lib/simple_form/components/placeholders.rb", "lib/simple_form/components/readonly.rb", "lib/simple_form/error_notification.rb", "lib/simple_form/form_builder.rb", "lib/simple_form/helpers", "lib/simple_form/helpers.rb", "lib/simple_form/helpers/autofocus.rb", "lib/simple_form/helpers/disabled.rb", "lib/simple_form/helpers/readonly.rb", "lib/simple_form/helpers/required.rb", "lib/simple_form/helpers/validators.rb", "lib/simple_form/i18n_cache.rb", "lib/simple_form/inputs", "lib/simple_form/inputs.rb", "lib/simple_form/inputs/base.rb", "lib/simple_form/inputs/block_input.rb", "lib/simple_form/inputs/boolean_input.rb", "lib/simple_form/inputs/collection_check_boxes_input.rb", "lib/simple_form/inputs/collection_input.rb", "lib/simple_form/inputs/collection_radio_buttons_input.rb", "lib/simple_form/inputs/collection_select_input.rb", "lib/simple_form/inputs/date_time_input.rb", "lib/simple_form/inputs/file_input.rb", "lib/simple_form/inputs/grouped_collection_select_input.rb", "lib/simple_form/inputs/hidden_input.rb", "lib/simple_form/inputs/numeric_input.rb", "lib/simple_form/inputs/password_input.rb", "lib/simple_form/inputs/priority_input.rb", "lib/simple_form/inputs/range_input.rb", "lib/simple_form/inputs/string_input.rb", "lib/simple_form/inputs/text_input.rb", "lib/simple_form/map_type.rb", "lib/simple_form/railtie.rb", "lib/simple_form/tags.rb", "lib/simple_form/version.rb", "lib/simple_form/wrappers", "lib/simple_form/wrappers.rb", "lib/simple_form/wrappers/builder.rb", "lib/simple_form/wrappers/leaf.rb", "lib/simple_form/wrappers/many.rb", "lib/simple_form/wrappers/root.rb", "lib/simple_form/wrappers/single.rb", "test/action_view_extensions/builder_test.rb", "test/action_view_extensions/form_helper_test.rb", "test/components/label_test.rb", "test/form_builder/association_test.rb", "test/form_builder/button_test.rb", "test/form_builder/error_notification_test.rb", "test/form_builder/error_test.rb", "test/form_builder/general_test.rb", "test/form_builder/hint_test.rb", "test/form_builder/input_field_test.rb", "test/form_builder/label_test.rb", "test/form_builder/wrapper_test.rb", "test/generators/simple_form_generator_test.rb", "test/inputs/boolean_input_test.rb", "test/inputs/collection_check_boxes_input_test.rb", "test/inputs/collection_radio_buttons_input_test.rb", "test/inputs/collection_select_input_test.rb", "test/inputs/datetime_input_test.rb", "test/inputs/disabled_test.rb", "test/inputs/discovery_test.rb", "test/inputs/file_input_test.rb", "test/inputs/general_test.rb", "test/inputs/grouped_collection_select_input_test.rb", "test/inputs/hidden_input_test.rb", "test/inputs/numeric_input_test.rb", "test/inputs/priority_input_test.rb", "test/inputs/readonly_test.rb", "test/inputs/required_test.rb", "test/inputs/string_input_test.rb", "test/inputs/text_input_test.rb", "test/simple_form_test.rb", "test/support/discovery_inputs.rb", "test/support/misc_helpers.rb", "test/support/mock_controller.rb", "test/support/models.rb", "test/test_helper.rb"]
  s.homepage = "https://github.com/plataformatec/simple_form"
  s.licenses = ["MIT"]
  s.rubyforge_project = "simple_form"
  s.rubygems_version = "2.2.2"
  s.summary = "Forms made easy!"
  s.test_files = ["test/action_view_extensions/builder_test.rb", "test/action_view_extensions/form_helper_test.rb", "test/components/label_test.rb", "test/form_builder/association_test.rb", "test/form_builder/button_test.rb", "test/form_builder/error_notification_test.rb", "test/form_builder/error_test.rb", "test/form_builder/general_test.rb", "test/form_builder/hint_test.rb", "test/form_builder/input_field_test.rb", "test/form_builder/label_test.rb", "test/form_builder/wrapper_test.rb", "test/generators/simple_form_generator_test.rb", "test/inputs/boolean_input_test.rb", "test/inputs/collection_check_boxes_input_test.rb", "test/inputs/collection_radio_buttons_input_test.rb", "test/inputs/collection_select_input_test.rb", "test/inputs/datetime_input_test.rb", "test/inputs/disabled_test.rb", "test/inputs/discovery_test.rb", "test/inputs/file_input_test.rb", "test/inputs/general_test.rb", "test/inputs/grouped_collection_select_input_test.rb", "test/inputs/hidden_input_test.rb", "test/inputs/numeric_input_test.rb", "test/inputs/priority_input_test.rb", "test/inputs/readonly_test.rb", "test/inputs/required_test.rb", "test/inputs/string_input_test.rb", "test/inputs/text_input_test.rb", "test/simple_form_test.rb", "test/support/discovery_inputs.rb", "test/support/misc_helpers.rb", "test/support/mock_controller.rb", "test/support/models.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_runtime_dependency(%q<actionpack>, ["~> 4.0"])
    else
      s.add_dependency(%q<activemodel>, ["~> 4.0"])
      s.add_dependency(%q<actionpack>, ["~> 4.0"])
    end
  else
    s.add_dependency(%q<activemodel>, ["~> 4.0"])
    s.add_dependency(%q<actionpack>, ["~> 4.0"])
  end
end
