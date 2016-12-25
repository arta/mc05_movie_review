class ReviewsController < ApplicationController
  before_action :set_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :set_movie

  # GET /movies/:movie_id/reviews/new
  # =link_to .. new_movie_review_path( @movie )
  def new
    @review = current_user.reviews.new
  end
  # Automatically render 'new' (which renders _form)

  # POST /movies/:movie_id/reviews
  # =form_for [@movie, @review] ..       .new_record? == true => url: '/movies/:movie_id/reviews', method: :post
  def create
    @review = current_user.reviews.new( review_params )
    @review.movie = @movie

    if @review.save
      redirect_to @movie, notice:'Review was successfully created.'
    else
      render :new
    end
  end

  # GET /movies/:movie_id/reviews/:id/edit
  # =link_to .. edit_movie_review_path( @movie, @review )
  def edit
  end
  # Automaticall render 'edit' (which renders _form)

  # PATCH|PUT /movies/:movie_id/reviews/:id
  # =form_for [@movie, @review] ..       .new_record? == false => url: '/movies/:movie_id/reviews/:id', method: :patch
  def update
    if @review.update( review_params )
       redirect_to @movie, notice:'Review was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /movies/:movie_id/reviews/:id
  # =link_to .. movie_review_path( @movie, @review ), method: :delete
  def destroy
    @review.destroy
    redirect_to @movie, notice:'Review was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find( params[:id] )
    end

    def set_movie
      @movie = Movie.find( params[:movie_id] )
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require( :review ).permit( :rating, :comment )
    end
end
