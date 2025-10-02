class PdfsController < ApplicationController
  def participantes_qrcodes
    @participantes = Participante.all.order(:municipio_id, :nome)

    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "qrcodes_participantes",
               template: "pdfs/participantes_qrcodes",
               layout: "pdf" # você pode criar um layout só para pdf
      end
    end
  end
end
