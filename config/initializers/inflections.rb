# config/initializers/inflections.rb

ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.irregular 'evento',     'eventos'
  inflect.irregular 'modalidade', 'modalidades'

end
