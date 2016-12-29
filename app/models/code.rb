class Code < ApplicationRecord
  validates :code_type, :code_key, :view_name, presence: true
end
