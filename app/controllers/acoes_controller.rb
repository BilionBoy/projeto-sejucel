# frozen_string_literal: true
class AcoesController < ApplicationController
  before_action :set_acao, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Acao.ransack(params[:q])
    @pagy, @acoes = pagy(@q.result)
  end

 def new
  @acao = Acao.new(evento_id: 1, data: Date.today)

  if params[:cpf].present?
    participante = Participante.find_by(cpf: params[:cpf])
    return redirect_to new_acao_path(participante_id: participante.id) if participante
  elsif params[:participante_id].present?
    participante = Participante.find_by(id: params[:participante_id])
    @acao.participante = participante if participante
  end
end



  def edit
  end

  def create
   @acao = Acao.new(acao_params)
   @acao.evento_id = 1       # Evento fixo
   @acao.data = Date.today   # Data do dia

   if @acao.save
     redirect_to acoes_path, notice: t('messages.created_successfully')
   else
     render :new, status: :unprocessable_entity
   end
 end


  def update
    if @acao.update(acao_params)
      redirect_to acoes_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @acao.destroy
      redirect_to acoes_url, notice: t('messages.deleted_successfully')
    else
      redirect_to acoes_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_acao
    @acao = Acao.find_by(id: params[:id])
    return redirect_to acoes_path, alert: t('messages.not_found') unless @acao
  end

  def acao_params
    permitted_attributes = Acao.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:acao).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to acoes_path, alert: t('messages.not_found')
  end
end
