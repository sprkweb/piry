# coding: utf-8

class ColorScheme
  attr_accessor :mode, :text, :bg

  def initialize(*params, &block)
    if block
      instance_eval(&block)
    else
      @mode = params[:mode]
      @text = params[:text]
      @bg   = params[:bg]
    end
  end
end
