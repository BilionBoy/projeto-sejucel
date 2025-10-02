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
