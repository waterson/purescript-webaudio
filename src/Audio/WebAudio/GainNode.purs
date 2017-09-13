module Audio.WebAudio.GainNode (gain) where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, GainNode, WebAudio)


foreign import gain
  :: forall eff. GainNode -> (Eff (wau :: WebAudio | eff) AudioParam)
