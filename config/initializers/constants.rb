module Constants
  # #toyeard
  # today = Date.today
  # year = today.year
  # # 1/1～3/31の間なら、年度は１年前
  # TOYEARD = today.between?('0101'.to_date, '0331'.to_date) ? year - 1 : year
  # sugamoの段階では、ここで決め打ちしてしまう
  TOYEARD = 2016
  
  # ClassRoom
  all_crass_rooms = ClassRoom.all
  CR_ALL_HASH = {}
  CR_ALL_LIST = []
  all_crass_rooms.each do |cr|
    CR_ALL_HASH[cr.id] = { name: cr.name, color: cr.color }
    CR_ALL_LIST << [cr.name, cr.id]
  end

  # ClassRoom
  toyeard_crass_rooms = ClassRoom.where(yeard: TOYEARD)
  CR_HASH = {}
  CR_LIST = []
  toyeard_crass_rooms.each do |cr|
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

  # [[1, うさぎ号１コース（水色）],...]
  BUS_COURSE_LIST = BusCourse.includes(:bus)
                             .pluck(:id, :name, :number, :color_name)
                             .each_with_object([]) do |data, re|
                               re << [ "#{data[1]}#{data[2]}コース（#{data[3]}）", data[0] ]
                             end

  # {1: {name:うさ１, color_name:黄緑, color: 7fff00},...}
  BUS_COURSE_HASH = BusCourse.includes(:bus)
                             .pluck(:id, :view_name, :number, :color_name, :color)
                             .each_with_object({}) do |data, re|
                               re[data[0]] = {name: "#{data[1]}#{data[2]}", color_name: "#{data[3]}", color: "#{data[4]}"}
                             end

  # JSで「未定」を「平常保育」に変更するために、平常保育のindexを持っておく。
  # TODO: 'full'決め打ちが少し気になる。check_string使う？
  ALL_CODES['dairy'].each_with_index do |(key, val), i|
    if key == 'full'
      FULL_INDEX = i
      break
    end
  end

  DATE_CODE_SELECTABLE_LIST = ALL_CODES['dairy'].each_with_object([]) do |(key, val), re|
    re << [val[:view_name], key] if val[:check_string] == 'selectable'
  end

  DOW = ["日","月","火","水","木","金","土"]
end