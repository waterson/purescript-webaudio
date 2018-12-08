module Audio.WebAudio.StereoPannerNode where

import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, StereoPannerNode)

foreign import pan
  :: StereoPannerNode -> Effect AudioParam
