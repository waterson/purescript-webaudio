module Audio.WebAudio.GainNode (gain, setGain) where

import Prelude (Unit, (=<<))
import Effect (Effect)
import Audio.WebAudio.Types (AudioParam, GainNode)
import Audio.WebAudio.AudioParam (setValue)

foreign import gain
  :: GainNode -> Effect AudioParam

setGain :: Number -> GainNode -> Effect Unit
setGain num node =
  setValue num =<< gain node
