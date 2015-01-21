Rails.application.config.after_initialize do
  begin
    Settings.docker.timeout? || Settings.docker.timeout = 10
    Settings.form.horizontal = {
      html: {class: 'form-horizontal'}, 
      wrapper: :horizontal_form, 
      wrapper_mappings: {
          check_boxes: :horizontal_radio_and_checkboxes, 
          radio_buttons: :horizontal_radio_and_checkboxes, 
          file: :horizontal_file_input, boolean: :horizontal_boolean 
      }
    }
  rescue
    Rails.logger.warn('Settings not defined')
  end
end