module Audio.WebAudio.AudioBufferSourceNode where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, WebAudio)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  :: ∀ eff. Number
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)
