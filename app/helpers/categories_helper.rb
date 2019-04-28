module CategoriesHelper

  def siblings parent
    Category.siblings(parent)
  end

  def helper_field_type_text key,value
    "<div class='field-type-text form-group'><label>Field type: #{value['field_type']}</label></div>
    <label>Field name</label>
    <input name='category[category_details][#{key}][field_name]' value='#{value['field_name']}' type='text' class='form-control' />
    <div>"
  end

  def helper_field_type_select(key,value,i)
    elem = "<div id='#{key}_options_wrapper' class='field-data-option-wrapper'><label>Options</label><br/>"
    i = 0
    value['field_data'].each do |x|
      elem = elem + 
      "<div id='#{key}_#{i}'><span class='drag-handler'><i class='ion-android-menu'></i></span>
        <input name='category[category_details][#{key}][field_data][]' class='form-input-tp' value='#{x}' />
        <button type='button' class=' select-option-remove btn-blue-text' data-id='#{key}_#{i}'>Remove option</button>
      </div>"
      i = i+1
    end
    elem = elem + "</div><button type='button' class='select-option-add' data-id='#{key}'>Add new option</button>"
    return elem
  end

  def helper_field_type_integer key,value
    "<label>Min</label><br/><input name='category[category_details][#{key}][min]' type='number' class='form-control' value='#{value['min']}' step='#{value["field_type"] == 'integer' ? 1 : 0.01 }' />
    <label>Max</label><br/><input name='category[category_details][#{key}][max]' type='number' class='form-control' value='#{value['max']}' step='#{value["field_type"] == 'integer' ? 1 : 0.01 }' />"
  end

  def helper_field_type_hidden key,value
    "<input type='hidden' name='category[category_details][#{key}][field_type]' value='#{value['field_type']}' />"
  end

  def helper_select_options
    "<select id='add_category_details_field_type_select' class='select-input'>
      <option value='text'>Text</option>
      <option value='select'>Select</option>
      <option value='mulitselect'>Multi-Select</option>
      <option value='checkbox'>Checkbox</option>
      <option value='integer'>Integer</option>
      <option value='decimal'>Decimal</option>
    </select>"
  end
end
