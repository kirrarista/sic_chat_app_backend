class BlogEntriesController < ApplicationController
  before_action :set_blog_entry, only: [:show, :edit, :update, :destroy]
  def index
    @blog_entries = BlogEntry.all
  end
  def show
  end
  def new
    @blog_entry = BlogEntry.new
  end
  def create
    @blog_entry = BlogEntry.new(blog_entry_params)
    if @blog_entry.save
      redirect_to @blog_entry, notice: 'Blog entry was created successfully.'
    else
      render :new
    end
  end
  private
  def set_blog_entry
    @blog_entry = BlogEntry.find(params[:id])
  end
  def blog_entry_params
    params.require(:blog_entry).permit(:title, :content, :author)
  end
end
