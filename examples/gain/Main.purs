module Gain where

import Prelude

import Audio.WebAudio.BaseAudioContext (createGain, currentTime, destination, newAudioContext, sampleRate)
import Audio.WebAudio.AudioContext (createMediaElementSource)
import Audio.WebAudio.AudioParam (setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Types (connect)
import Effect (Effect)
import Effect.Console (logShow)
import Effect.Exception (throw)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode) as HTMLDocument
import Web.HTML.Window (document)
import Web.DOM.NonElementParentNode (getElementById)
import Data.Maybe (Maybe(..))

-- | 3 secs after the audio begins playing, set the value (i.e., volume)
-- | of the gain node to 0.3 (i.e., a 70% reduction)

main :: Effect Unit
main = do
  doc <- map HTMLDocument.toNonElementParentNode (window >>= document)
  noise <- getElementById "noise" doc
  case noise of
    Just el -> void do
      cx <- newAudioContext
      src <- createMediaElementSource cx el
      gainNode <- createGain cx
      dest <- destination cx
      connect src gainNode
      connect gainNode dest
      gainParam <- gain gainNode
      _ <- setValueAtTime 0.3 3.0 gainParam
      sr <- sampleRate cx
      logShow sr
      t <- currentTime cx
      logShow t
    Nothing -> throw "No 'noise' node!"
