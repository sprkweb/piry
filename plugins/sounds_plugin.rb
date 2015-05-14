# coding: utf-8

require 'vendor/sfml/system'
require 'vendor/sfml/audio'

module AudioExtension
  def play_while(loop = true)
    play
    yield
    stop if status == Playing
  end
end

class Music < SFML::Music
  include AudioExtension
end

class Sound < SFML::Sound
  include AudioExtension
end

SoundBuffer = SFML::SoundBuffer
