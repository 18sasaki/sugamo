module Constants
  CR_HASH = {}
  ClassRoom.all.each do |cr|
    CR_HASH[cr.id] = { name: cr.name, color: cr.color }
  end

  ALL_CODES = {}
  Code.all.each do |code|
  	(ALL_CODES[code.code_type] ||= {})[code.code_key] = { view_name: code.view_name, short_name: code.short_name }
  end
  p ALL_CODES
end