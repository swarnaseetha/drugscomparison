class DrugsController < ApplicationController
  before_filter :get_average, :only=>:show

  def get_average
    @drug = Drug.find(params[:id])
    @avg_effectivness=@drug.avg_eff
    @avg_ease_of_use=@drug.avg_eou
    @avg_satisfactory=@drug.avg_sat
  end
  # GET /drugs
  # GET /drugs.json
  def index
    @drugs = Drug.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @drugs }
    end
  end

  # GET /drugs/1
  # GET /drugs/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @drug }
      format.js
    end
  end

  # GET /drugs/new
  # GET /drugs/new.json
  def new
    @drug = Drug.new
    3.times {@drug.reviews.build}
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @drug }
    end
  end

  # GET /drugs/1/edit
  def edit
    @drug = Drug.find(params[:id])
  end

  # POST /drugs
  # POST /drugs.json
  def create
    @drug = Drug.new(params[:drug])

    respond_to do |format|
      if @drug.save
        format.html { redirect_to @drug, notice: 'Drug was successfully created.' }
        format.json { render json: @drug, status: :created, location: @drug }
      else
        format.html { render action: "new" }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /drugs/1
  # PUT /drugs/1.json
  def update
    @drug = Drug.find(params[:id])

    respond_to do |format|
      if @drug.update_attributes(params[:drug])
        format.html { redirect_to @drug, notice: 'Drug was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @drug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drugs/1
  # DELETE /drugs/1.json
  def destroy
    @drug = Drug.find(params[:id])
    @drug.destroy

    respond_to do |format|
      format.html { redirect_to drugs_url }
      format.json { head :no_content }
    end
  end


  ## Hoi's defined method goes below
def search
    @drug = Drug.find(params[:id])
    @review_options=params
    @review_options[:for_drug_id]=params[:id]
     @reviews=@drug.get_all_reviews(@review_options).order("created_at DESC").page(params[:page]).per(5)
    @for_counts=@reviews.count
  respond_to do |format|
    format.js
  end
end

  def effectiveness_view
    @drug = Drug.find(params[:id])
    @generate_colors=Array.new
    @generate_colors.push('#C11B17','#EE9A4D' , '#DDDF00','#CCFB5D' , '#5EFB6E')
    @review_options=params
    @update_values = Hash.new{|hash, key| hash[key] = Array.new}
    @review_options[:for_drug_id]=@drug.id
    @related_reviews=@drug.get_all_reviews(@review_options)
    (@update_values[@drug.brand_name]).push(Condition.first.eff_score1(@related_reviews).round(2), Condition.first.eff_score2(@related_reviews).round(2) ,Condition.first.eff_score3(@related_reviews).round(2),Condition.first.eff_score4(@related_reviews).round(2),Condition.first.eff_score5(@related_reviews).round(2))

    respond_to do |format|
      #format.html
      format.js
    end
  end

  def eou_view
    @drug = Drug.find(params[:id])
    @generate_colors=Array.new
    @generate_colors.push('#C11B17','#EE9A4D' , '#DDDF00','#CCFB5D' , '#5EFB6E')
    @review_options=params
    @update_values = Hash.new{|hash, key| hash[key] = Array.new}
    @review_options[:for_drug_id]=@drug.id
    @related_reviews=@drug.get_all_reviews(@review_options)
    (@update_values[@drug.brand_name]).push(Condition.first.eou_score1(@related_reviews).round(2), Condition.first.eou_score2(@related_reviews).round(2) ,Condition.first.eou_score3(@related_reviews).round(2),Condition.first.eou_score4(@related_reviews).round(2),Condition.first.eou_score5(@related_reviews).round(2))

    respond_to do |format|
      #format.html
      format.js
    end
  end
  def satisfactory_view
    @drug = Drug.find(params[:id])
    @generate_colors=Array.new
    @generate_colors.push('#C11B17','#EE9A4D' , '#DDDF00','#CCFB5D' , '#5EFB6E')
    @review_options=params
    @update_values = Hash.new{|hash, key| hash[key] = Array.new}
    @review_options[:for_drug_id]=@drug.id
    @related_reviews=@drug.get_all_reviews(@review_options)
    (@update_values[@drug.brand_name]).push(Condition.first.sat_score1(@related_reviews).round(2), Condition.first.sat_score2(@related_reviews).round(2) ,Condition.first.sat_score3(@related_reviews).round(2),Condition.first.sat_score4(@related_reviews).round(2),Condition.first.sat_score5(@related_reviews).round(2))

    respond_to do |format|
      #format.html
      format.js
    end
  end


end
