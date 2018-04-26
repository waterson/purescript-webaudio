module Audio.WebAudio.StereoPannerNode where

import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, StereoPannerNode, AUDIO)

foreign import pan
  :: forall eff. StereoPannerNode -> (Eff (audio :: AUDIO | eff) AudioParam)
