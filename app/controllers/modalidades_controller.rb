# frozen_string_literal: true
class ModalidadesController < ApplicationController
  before_action :set_modalidade, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

  def index
    @q = Modalidade.ransack(params[:q])
    @pagy, @modalidades = pagy(@q.result)
  end

  def new
    @modalidade = Modalidade.new
  end

  def edit
  end

  def create
    @modalidade = Modalidade.new(modalidade_params)

    if @modalidade.save
      redirect_to modalidades_path, notice: t('messages.created_successfully')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @modalidade.update(modalidade_params)
      redirect_to modalidades_path, notice: t('messages.updated_successfully'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @modalidade.destroy
      redirect_to modalidades_url, notice: t('messages.deleted_successfully')
    else
      redirect_to modalidades_url, alert: t('messages.delete_failed_due_to_dependencies')
    end   
  end

  private

  def set_modalidade
    @modalidade = Modalidade.find_by(id: params[:id])
    return redirect_to modalidades_path, alert: t('messages.not_found') unless @modalidade
  end

  def modalidade_params
    permitted_attributes = Modalidade.column_names.reject { |col| ['deleted_at', 'created_by', 'updated_by'].include?(col) }
    params.require(:modalidade).permit(permitted_attributes.map(&:to_sym))
  end

  def handle_not_found
    redirect_to modalidades_path, alert: t('messages.not_found')
  end
end
