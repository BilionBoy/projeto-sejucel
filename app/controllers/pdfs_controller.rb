class PdfsController < ApplicationController
  layout "pdf"

  def participantes_qrcodes
    @participantes = Participante.completo.ordenado

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "qrcodes_participantes",
               template: "pdfs/participantes_qrcodes",
                encoding: "UTF-8",
               formats: [:html]   # <<< importante: força lookup do template .html.erb
      end
    end
  end
end
