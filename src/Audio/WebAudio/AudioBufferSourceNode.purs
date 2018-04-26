module Audio.WebAudio.AudioBufferSourceNode
  ( setBuffer, startBufferSource, stopBufferSource
  , loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

foreign import startBufferSource
  :: ∀ eff. Number
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

foreign import stopBufferSource
  :: ∀ eff. Number
  -> AudioBufferSourceNode
  -> (Eff (audio :: AUDIO | eff) Unit)

loop :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Boolean)
loop = unsafeGetProp "loop"

setLoop :: ∀ eff. Boolean -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoop l n = unsafeSetProp "loop" n l

loopStart :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Number)
loopStart = unsafeGetProp "loopStart"

setLoopStart :: ∀ eff. Number -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoopStart l n = unsafeSetProp "loopStart" n l

loopEnd :: ∀ eff. AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Number)
loopEnd = unsafeGetProp "loopEnd"

setLoopEnd :: ∀ eff. Number -> AudioBufferSourceNode -> (Eff (audio :: AUDIO | eff) Unit)
setLoopEnd l n = unsafeSetProp "loopEnd" n l
