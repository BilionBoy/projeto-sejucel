class RelatoriosController < ApplicationController
  def index
    @participantes_count = Participante.count
    @municipios_count    = Municipio.count
    @modalidades_count   = Modalidade.count
  end
end
