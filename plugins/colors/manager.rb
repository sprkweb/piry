# coding: utf-8

# Manager for colorizing console output in ANSI colors
class Dialog
  module IO
    class ColorsManager
      include Singleton

      END_ESC_CODE = "\e[0m"

      # Colors for all text except specially colorized
      def default
        @default_colors ||= {
          :mode => :default, :text => :default_text, :bg => :default_bg
          }
      end

      # Color scheme is a custom predefined set of
      # color mode + text color + background color.
      def color_schemes
        @color_schemes ||= {}
      end

      # The method changes color and style (bold etc) of the `text` string.
      # Example:
      #
      #   colorize 'Hello!', :phrase
      #
      def colorize(text, color_scheme)
        esc_code(parse_color_scheme color_scheme) + text + esc_code
      end

      private

      def parse_color_scheme(scheme)
        if color_schemes.key? scheme
          color_schemes[scheme]
        elsif scheme.class == ColorScheme
          scheme
        else
          ColorScheme.new
        end
      end

      def codes_of_modes
        {
          :default      =>  0, :bold         =>  1, :underline    =>  4,
          :blink        =>  5, :shift        =>  7, :hide         =>  8
        }
      end

      def text_color_codes
        {
          :black        => 30, :red          => 31, :green        => 32,
          :yellow       => 33, :blue         => 34, :magenta      => 35,
          :cyan         => 36, :white        => 37, :default_text => 39
        }
      end

      def bg_color_codes
        {
          :black_bg     => 40, :red_bg       => 41, :green_bg     => 42,
          :yellow_bg    => 43, :blue_bg      => 44, :magenta_bg   => 45,
          :cyan_bg      => 46, :white_bg     => 47, :default_bg   => 49
        }
      end

      def esc_code(scheme)
        "\e[" +
        codes_of_modes(scheme.mode   ? scheme.mode : default[:mode]).to_s +
        ";" +
        text_color_codes(scheme.text ? scheme.text : default[:text]).to_s +
        ";" +
        bg_color_codes(scheme.bg     ? scheme.bg   : default[:bg]).to_s   +
        "m"
      end
    end

    Colors = ColorsManager.instance
  end
end
