module Audio.WebAudio.AudioBufferSourceNode
  (setBuffer, startBufferSource) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, AUDIO)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (wau :: AUDIO | eff) Unit)

foreign import startBufferSource
  :: ∀ eff. Number
  -> AudioBufferSourceNode
  -> (Eff (wau :: AUDIO | eff) Unit)
