class HomeController < ApplicationController
  def index
  end

   def scan_test
    # pega participantes para o select de simulação (limitar se quiser)
    @participantes = Participante.order(:nome).limit(6000)
  end
end
