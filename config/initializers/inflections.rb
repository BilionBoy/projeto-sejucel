# config/initializers/inflections.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'evento',     'eventos'
  inflect.irregular 'modalidade', 'modalidades'
  inflect.irregular 'municipio',   'municipios'
end
