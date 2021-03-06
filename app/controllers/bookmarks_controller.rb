class BookmarksController < ApplicationController
    before_action :set_bookmark, only: [:show, :edit, :update, :destroy]

    def index
        @bookmarks = Bookmark.order(:created_at).reverse_order
    end

    def show   
    end

    def new
        @bookmark = Bookmark.new
        @type = Type.new
        @category = Category.new
        @types = Type.all
        @categories = Category.all
    end

    def edit
        @types = Type.all
        @categories = Category.all
    end

    def create
        @bookmark = Bookmark.new(bookmark_params)
        sleep 2
        respond_to do |format|
            if @bookmark.save!
                format.js { render nothing: true }
                flash.now[:notice] = 'Bookmark created!'
            else
                flash.now[:notice] = 'Bookmark could not be created'
            end
        end
    end

    def update
        respond_to do |format|
            if @bookmark.update!(bookmark_params)
                format.js { render layout: false }
                flash.now[:notice] = 'Bookmark updated!'
            else
                flash.now[:notice] = 'Bookmark could not be updated'
            end
        end
    end

    def destroy
        respond_to do |format|
            if @bookmark.destroy!
                format.js { render nothing: false }
                flash.now[:notice] = 'Bookmark deleted!'
            else
                flash.now[:notice] = 'Bookmark could not be deleted'
            end
        end
    end    

    private

    def set_bookmark
        @bookmark = Bookmark.find(params[:id])
    end

    def bookmark_params
        params.require(:bookmark).permit(:title, :url, :type_id, :category_id )
    end
end
