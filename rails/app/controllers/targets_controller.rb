# Copyright 2011 Adobe Systems Incorporated. All Rights Reserved.
# NOTICE: Adobe permits you to use, modify, and distribute this file
#  in accordance with the terms of the Mozilla Public License (MPL) v1.1.
#

class TargetsController < ApplicationController

  
  # Enable Cross-Site Forgery protection at the individual controller level on everything except Session
  # The AIR app does its own cookie management, and isn't handling the hidden form elements correctly during Google OpenID authentication.

  protect_from_forgery

  
  
  load_and_authorize_resource
  
  # GET /targets
  # GET /targets.xml
  def index
    @targets = Target.page(params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @targets }
    end
  end

  # GET /targets/1
  # GET /targets/1.xml
  def show
    @target = Target.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @target }
    end
  end

  # GET /targets/new
  # GET /targets/new.xml
  def new
    @target = Target.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @target }
    end
  end

  # GET /targets/1/edit
  def edit
    @target = Target.find(params[:id])
  end

  # POST /targets
  # POST /targets.xml
  def create
    @target = Target.new(params[:target])

    respond_to do |format|
      if @target.save
        format.html { redirect_to(@target, :notice => 'Target was successfully created.') }
        format.xml  { render :xml => @target, :status => :created, :location => @target }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @target.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /targets/1
  # PUT /targets/1.xml
  def update
    @target = Target.find(params[:id])

    respond_to do |format|
      if @target.update_attributes(params[:target])
        format.html { redirect_to(@target, :notice => 'Target was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @target.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /targets/1
  # DELETE /targets/1.xml
  def destroy
    @target = Target.find(params[:id])
    @target.destroy

    respond_to do |format|
      format.html { redirect_to(targets_url) }
      format.xml  { head :ok }
    end
  end
end
