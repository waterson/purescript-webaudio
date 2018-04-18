module Gain where

import Prelude

import Audio.WebAudio.AudioContext (connect, createGain, createMediaElementSource, currentTime, destination, makeAudioContext, sampleRate)
import Audio.WebAudio.AudioParam (setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Types (WebAudio)
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

-- | 2 secs after the audio begins playing, set the value of the gain node to 0.5
main :: Eff ( dom :: DOM
            , wau :: WebAudio
            , console :: CONSOLE
            , exception :: EXCEPTION
            ) Unit
main = do
  doc <- map htmlDocumentToNonElementParentNode (document =<< window)
  noise <- getElementById (wrap "noise") doc
  case noise of
    Just el -> void do
      cx <- makeAudioContext
      src <- createMediaElementSource cx el
      gainNode <- createGain cx
      dest <- destination cx
      connect src gainNode
      connect gainNode dest
      gainValue <- gain gainNode
      _ <- setValueAtTime 0.1 3.0 gainValue
      sr <- sampleRate cx
      logShow sr
      t <- currentTime cx
      logShow t
    Nothing -> throw "No 'noise' node!"
