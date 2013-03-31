# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
  inflect.irregular 'grupa', 'grupe'
  inflect.irregular 'evaluare', 'evaluari'
  inflect.irregular 'activa', 'active'
  inflect.irregular 'profesor', 'profesori'
  inflect.irregular 'curs', 'cursuri'
  inflect.irregular 'disponibila', 'disponibile'
  inflect.irregular 'formular', 'formulare'
  inflect.irregular 'completata', 'completate'
#   inflect.uncountable %w( fish sheep )
end
#
# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.acronym 'RESTful'
# end
