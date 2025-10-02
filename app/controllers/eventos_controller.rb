# frozen_string_literal: true
class EventosController < ApplicationController
  before_action :set_evento, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Evento.ransack(params[:q])
    @pagy, @eventos = pagy(@q.result)
  end

  def new
    @evento = Evento.new
  end

  def edit
  end

  def create
    @evento = Evento.new(evento_params)

    if @evento.save
      redirect_to eventos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @evento.update(evento_params)
      redirect_to eventos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @evento.destroy
      redirect_to eventos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to eventos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_evento
    @evento = Evento.find_by(id: params[:id])
    return redirect_to eventos_path, alert: t('messages.not_found') unless @evento
  end

  def evento_params
    permitted_attributes = Evento.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:evento).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to eventos_path, alert: t('messages.not_found')
  end
end
