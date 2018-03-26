class V1::ContactsController < ApplicationController
    def index
        @contacts = Fairfax.all
        render json: {status: 'SUCCESS', message: 'Contacts retrieved', data: @contacts}, status: :ok
    end

    def show
        @contact =  Fairfax.find(params[:id])
        render json: {status: 'SUCCESS', message: 'Contact retrieved', data: @contact}, status: :ok
    end

    def create
        @contact = Fairfax.new(contact_params)

        if @contact.save
            #deliver the contact email
            FairfaxMailer.send_mailgun_message(@contact).deliver            

            render json: {status: 'SUCCESS', message: 'Contact created', data: @contact}, status: :created
        else
            render json: {status: 'ERROR', message: 'Contacts NO created', data: @contact.errors}, status: :unprocessable_entity
        end
    end

    def destroy
        /@contact = Fairfax.where(id: params[:id]).first/
        @contact =  Fairfax.find(params[:id])
        
        if @contact.destroy
            render json: {status: 'SUCCESS', message: 'Contact deleted', data: @contact}, status: :ok
        else
            render json: {status: 'ERROR', message: 'Contacts could not be deleted', data: @contact.errors}, status: :unprocessable_entity
        end
    end

    private

    def contact_params
        params.require(:contact).permit(:first_name, :last_name, :email)
    end
end
