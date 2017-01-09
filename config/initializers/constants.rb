module Constants
  # ClassRoom
  all_crass_rooms = ClassRoom.all
  CR_HASH = {}
  CR_LIST = []
  all_crass_rooms.each do |cr|
    CR_HASH[cr.id] = { name: cr.name, color: cr.color }
    CR_LIST << [cr.name, cr.id]
  end

  ALL_CODES = {}
  Code.all.each do |code|
  	(ALL_CODES[code.code_type] ||= {})[code.code_key] = { view_name: code.view_name, short_name: code.short_name, check_string: code.check_string }
  end

  DATE_CODE_COLLECTION = ALL_CODES['dairy'].each_with_object([]) do |(key, val), re|
    re << {key: key, val: val[:view_name]}
  end

  DATE_CODE_LIST = ALL_CODES['dairy'].each_with_object([]) do |(key, val), re|
    re << [val[:view_name], key]
  end

  DATE_CODE_SELECTABLE_LIST = ALL_CODES['dairy'].each_with_object([]) do |(key, val), re|
    re << [val[:view_name], key] if val[:check_string] == 'selectable'
  end

  DOW = ["日","月","火","水","木","金","土"]
end