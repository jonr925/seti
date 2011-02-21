class ObservationRangesController < ApplicationController
  # GET /observation_ranges
  # GET /observation_ranges.xml
  def index
    @observation_ranges = ObservationRange.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @observation_ranges }
    end
  end

  # GET /observation_ranges/1
  # GET /observation_ranges/1.xml
  def show
    @observation_range = ObservationRange.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @observation_range }
    end
  end

  # GET /observation_ranges/new
  # GET /observation_ranges/new.xml
  def new
    @observation_range = ObservationRange.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @observation_range }
    end
  end

  # GET /observation_ranges/1/edit
  def edit
    @observation_range = ObservationRange.find(params[:id])
  end

  # POST /observation_ranges
  # POST /observation_ranges.xml
  def create
    @observation = Observation.find(params[:observation_range][:observation])
    @observation_range = @observation.observation_ranges.create(:status => params[:observation_range][:status], :lo_mhz => params[:observation_range][:lo_mhz], :hi_mhz => params[:observation_range][:hi_mhz])
    #@observation_range = ObservationRange.new(params[:observation_range])

    respond_to do |format|
      if @observation_range.save
        format.html { redirect_to(@observation_range, :notice => 'Observation range was successfully created.') }
        format.xml  { render :xml => @observation_range, :status => :created, :location => @observation_range }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @observation_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /observation_ranges/1
  # PUT /observation_ranges/1.xml
  def update
    @observation_range = ObservationRange.find(params[:id])

    respond_to do |format|
      if @observation_range.update_attributes(params[:observation_range])
        format.html { redirect_to(@observation_range, :notice => 'Observation range was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @observation_range.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /observation_ranges/1
  # DELETE /observation_ranges/1.xml
  def destroy
    @observation_range = ObservationRange.find(params[:id])
    @observation_range.destroy

    respond_to do |format|
      format.html { redirect_to(observation_ranges_url) }
      format.xml  { head :ok }
    end
  end
end
