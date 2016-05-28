module Audio.WebAudio.AudioBufferSourceNode where

import Prelude
import Control.Monad.Eff
import Audio.WebAudio.Types

foreign import setBuffer
  :: forall eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  :: forall eff. Number
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)