class Api::V1::ContactsController < ApplicationController
  before_action :autorize_request
  before_action :user_autenticated
  rescue_from ActiveRecord::RecordNotFound, with: :contact_not_foud

  def index
    @contacts = Contact.where(user_id: @user.id).page(params[:page])
    render json: {
      data: @contacts,
      per_page: 1,
      total_record: @contacts.total_count
    }, status: :ok
  end

  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      render json: @contact, status: :created
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @contact = Contact.where(user_id: @user.id).find(params[:id])
    render json: @contact, status: :ok
  end

  def update
    @contact = Contact.where(user_id: @user.id).find(params[:id])
    if @contact.update(contacts_params)
      render json: @contact, status: :ok
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.where(user_id: @user.id).find(params[:id])
    unless @contact.destroy!
      render json: { message: "Não foi possivel remover o contato" }, status: :bad_request
    end
    render json: { message: "Contato removido com sucesso" }, status: :ok
  end

  private
  def contacts_params
    params.permit(:name, :last_name, :email).merge(user_id: @user.id)
  end

  def contact_not_foud
    render json: { message: "Recurso não econtrado" }, status: :not_found
  end


end
