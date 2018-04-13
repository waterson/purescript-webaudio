module Audio.WebAudio.StereoPannerNode where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, StereoPannerNode, WebAudio)

foreign import pan
  :: forall eff. StereoPannerNode -> (Eff (wau :: WebAudio | eff) AudioParam)
