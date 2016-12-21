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
  	(ALL_CODES[code.code_type] ||= {})[code.code_key] = { view_name: code.view_name, short_name: code.short_name }
  end
end