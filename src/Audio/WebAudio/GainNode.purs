module Audio.WebAudio.GainNode where

import Control.Monad.Eff
import Audio.WebAudio.Types

instance audioNodeGainNode :: AudioNode GainNode

foreign import gain
  "function gain(node) { \n\
  \  return function() { \n\
  \    return node.gain; \n\
  \  }; \n\
  \}" :: forall wau eff. GainNode -> (Eff (wau :: WebAudio | eff) AudioParam)

