module Audio.WebAudio.GainNode (gain, setGain) where

import Prelude (Unit, (=<<))
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, GainNode, AUDIO)
import Audio.WebAudio.AudioParam (setValue)

foreign import gain
  :: forall eff. GainNode -> (Eff (audio :: AUDIO | eff) AudioParam)

setGain :: ∀ eff. Number -> GainNode -> (Eff (audio :: AUDIO | eff) Unit)
setGain num node =
  setValue num =<< gain node
