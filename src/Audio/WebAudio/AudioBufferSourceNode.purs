module Audio.WebAudio.AudioBufferSourceNode
  ( setBuffer, startBufferSource, stopBufferSource
  , loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd  ) where

import Prelude
import Effect (Effect)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  :: AudioBuffer
  -> AudioBufferSourceNode
  -> Effect Unit

foreign import startBufferSource
  :: Number
  -> AudioBufferSourceNode
  -> Effect Unit

foreign import stopBufferSource
  :: Number
  -> AudioBufferSourceNode
  -> Effect Unit

loop :: AudioBufferSourceNode -> Effect Boolean
loop = unsafeGetProp "loop"

setLoop :: Boolean -> AudioBufferSourceNode -> Effect Unit
setLoop l n = unsafeSetProp "loop" n l

loopStart :: AudioBufferSourceNode -> Effect Number
loopStart = unsafeGetProp "loopStart"

setLoopStart :: Number -> AudioBufferSourceNode -> Effect Unit
setLoopStart l n = unsafeSetProp "loopStart" n l

loopEnd :: AudioBufferSourceNode -> Effect Number
loopEnd = unsafeGetProp "loopEnd"

setLoopEnd :: Number -> AudioBufferSourceNode -> Effect Unit
setLoopEnd l n = unsafeSetProp "loopEnd" n l
