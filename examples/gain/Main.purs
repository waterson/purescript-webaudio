module Gain where

import Prelude

import Audio.WebAudio.BaseAudioContext (createGain, currentTime, destination, newAudioContext, sampleRate)
import Audio.WebAudio.AudioContext (createMediaElementSource)
import Audio.WebAudio.AudioParam (setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Types (connect, AUDIO)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION, throw)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import Data.Maybe (Maybe(..))
import Data.Newtype (wrap)

-- | 3 secs after the audio begins playing, set the value (i.e., volume)
-- | of the gain node to 0.3 (i.e., a 70% reduction)

main :: Eff ( dom :: DOM
            , audio :: AUDIO
            , console :: CONSOLE
            , exception :: EXCEPTION
            ) Unit
main = do
  doc <- map htmlDocumentToNonElementParentNode (window >>= document)
  noise <- getElementById (wrap "noise") doc
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
