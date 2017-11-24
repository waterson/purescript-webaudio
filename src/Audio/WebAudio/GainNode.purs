module Audio.WebAudio.GainNode (gain, setGain) where

import Prelude (Unit, (=<<))
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioParam, GainNode, WebAudio)
import Audio.WebAudio.AudioParam (setValue)

foreign import gain
  :: forall eff. GainNode -> (Eff (wau :: WebAudio | eff) AudioParam)

setGain :: ∀ eff. Number -> GainNode -> (Eff (wau :: WebAudio | eff) Unit)
setGain num node =
  setValue num =<< gain node
