# frozen_string_literal: true
class MunicipiosController < ApplicationController
  before_action :set_municipio, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Municipio.ransack(params[:q])
    @pagy, @municipios = pagy(@q.result)
  end

  def new
    @municipio = Municipio.new
  end

  def edit
  end

  def create
    @municipio = Municipio.new(municipio_params)

    if @municipio.save
      redirect_to municipios_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @municipio.update(municipio_params)
      redirect_to municipios_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @municipio.destroy
      redirect_to municipios_url, notice: t('messages.deleted_successfully')
    else
      redirect_to municipios_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_municipio
    @municipio = Municipio.find_by(id: params[:id])
    return redirect_to municipios_path, alert: t('messages.not_found') unless @municipio
  end

  def municipio_params
    permitted_attributes = Municipio.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:municipio).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to municipios_path, alert: t('messages.not_found')
  end
end
