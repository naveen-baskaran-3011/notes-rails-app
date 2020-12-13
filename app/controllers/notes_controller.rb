class NotesController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
        @notes = Note.all
        render(json: { status: 'success', notes: @notes })
    end

    def create
        @note = Note.new(model_params)
        if @note.valid?
            @note.save
            render(json: {status: 'success', note: @note})
        else
            render(json: {status: 'error', messages: ['Error while saving'].concat(@note.errors.full_messages)})
        end
    end

    def update
        update_attributes = model_params.clone
        @note = Note.find(params[:id])

        if @note.present?
            @note.name = update_attributes[:name] if update_attributes[:name].present?
            @note.description = update_attributes[:description] if update_attributes[:description].present?
            if @note.valid?
                @note.save
                render(json: {status: 'success', note: @note})
            else
                render(json: {status: 'error', messages: ['Error while saving'].concat(@note.errors.full_messages)})
            end
        else
            render(json: {status: 'error', messages: ['Note not found']})
        end
    end

    def show
        begin
            @note = Note.find(params[:id])
            render(json: { status: 'success', note: @note })
        rescue => e
            render(json: { status: 'error', messages: ['Note not found'] })
        end
    end

    def destroy
        @note = Note.find(params[:id])

        if @note.present?
            @note.destroy

            render(json: {status: 'success', messages: ['Deleted successfully']})
        else
            render(json: {status: 'error', messages: ['Note not found']})
        end
    end

    private

    def model_params
        params.require(:note).permit(:name, :description)
    end
end
