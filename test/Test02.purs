module Test02 where

import Prelude

import Audio.WebAudio.AudioContext (connect, createGain, createMediaElementSource, currentTime, destination, makeAudioContext, sampleRate)
import Audio.WebAudio.AudioParam (setValue)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Types (WebAudio)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Timer (TIMER, setTimeout)
import DOM (DOM)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToNonElementParentNode)
import DOM.HTML.Window (document)
import DOM.Node.NonElementParentNode (getElementById)
import DOM.Node.Types (ElementId(..))
import Data.Maybe (fromJust)
import Partial.Unsafe (unsafePartial)

main :: forall eff. (Eff (wau :: WebAudio, dom :: DOM, console :: CONSOLE, timer :: TIMER | eff) Unit)
main = do
  globalWindow <- window
  doc <- htmlDocumentToNonElementParentNode <$> document globalWindow
  elt <- unsafePartial $ fromJust <$> getElementById (ElementId "noise") doc
  cx <- makeAudioContext
  src <- createMediaElementSource cx elt
  gainNode <- createGain cx
  dest <- destination cx
  connect src gainNode
  connect gainNode dest
  gainValue <- gain gainNode
  _ <- setTimeout 1000 $ setValue 0.5 gainValue
  sr <- sampleRate cx
  logShow sr
  t <- currentTime cx
  logShow t
  pure unit
