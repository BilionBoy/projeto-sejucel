# frozen_string_literal: true
class TiposController < ApplicationController
  before_action :set_tipo, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Tipo.ransack(params[:q])
    @pagy, @tipos = pagy(@q.result)
  end

  def new
    @tipo = Tipo.new
  end

  def edit
  end

  def create
    @tipo = Tipo.new(tipo_params)

    if @tipo.save
      redirect_to tipos_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @tipo.update(tipo_params)
      redirect_to tipos_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @tipo.destroy
      redirect_to tipos_url, notice: t('messages.deleted_successfully')
    else
      redirect_to tipos_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_tipo
    @tipo = Tipo.find_by(id: params[:id])
    return redirect_to tipos_path, alert: t('messages.not_found') unless @tipo
  end

  def tipo_params
    permitted_attributes = Tipo.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:tipo).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to tipos_path, alert: t('messages.not_found')
  end
end
