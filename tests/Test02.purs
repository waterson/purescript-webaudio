module Test02 where

import Control.Monad.Eff
import Audio.WebAudio.Types
import Audio.WebAudio.AudioContext
import Audio.WebAudio.MediaElementAudioSourceNode
import Audio.WebAudio.DestinationNode
import Data.DOM.Simple.Types
import Data.DOM.Simple.Document
import Data.DOM.Simple.Element
import Data.DOM.Simple.Window

import Data.Maybe.Unsafe

main :: forall wau eff. (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
main = do
  doc <- document globalWindow
  elt <- fromJust <$> getElementById "noise" doc
  cx <- makeAudioContext
  src <- createMediaElementSource cx elt
  dest <- destination cx
  connect src dest
  -- t <- currentTime cx
  return unit
