module Audio.WebAudio.GainNode where

import Control.Monad.Eff
import Audio.WebAudio.Types


foreign import gain
  :: forall wau eff. GainNode -> (Eff (wau :: WebAudio | eff) AudioParam)

