# frozen_string_literal: true

class ParticipantesController < ApplicationController
  before_action :set_participante, only: %i[show edit update destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Participante.ransack(params[:q])
    @pagy, @participantes = pagy(@q.result)
  end

  def new
    @participante = Participante.new
  end

  def edit
  end

  def create
    @participante = Participante.new(participante_params)

    if @participante.save
      redirect_to participantes_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @participante.update(participante_params)
      redirect_to participantes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @participante.destroy
      redirect_to participantes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to participantes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  def search
    query = params[:q].to_s.strip

    participantes = if query.length >= 3
    Participante.where("nome LIKE :q OR cpf LIKE :q", q: "%#{query}%").limit(20)
    else
      Participante.none
    end

    render json: participantes.map { |p| { id: p.id, text: p.nome } }    
  end


  def qr_code
   participante = Participante.find(params[:id])
   qrcode = RQRCode::QRCode.new(participante.codigo_qr)

   png = qrcode.as_png(
     bit_depth: 1,
     border_modules: 4,
     color_mode: ChunkyPNG::COLOR_GRAYSCALE,
     color: "black",
     file: nil,
     fill: "white",
     module_px_size: 6,
     resize_gte_to: false,
     resize_exactly_to: false,
     size: 200
   )

   send_data png.to_s, type: 'image/png', disposition: 'inline'
  end
    

  def qr_codes_pdf
    participantes = Participante.all

    pdf = Prawn::Document.new
    participantes.each do |p|
     qrcode = RQRCode::QRCode.new(p.codigo_qr)
     png = qrcode.as_png(size: 120)
     file = Tempfile.new(["qr", ".png"])
     IO.binwrite(file.path, png.to_s)

     pdf.text "Nome: #{p.nome}"
     pdf.text "CPF: #{p.cpf}"
     pdf.image file.path, width: 100, height: 100
     pdf.move_down 20

     file.close
     file.unlink
    end

    send_data pdf.render,
            filename: "qrcodes_participantes.pdf",
            type: "application/pdf",
            disposition: "inline"
   end




  private

  def set_participante
    @participante = Participante.find_by(id: params[:id])
    return redirect_to participantes_path, alert: t('messages.not_found') unless @participante
  end

  def participante_params
    permitted_attributes = Participante.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:participante).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to participantes_path, alert: t('messages.not_found')
  end
end
