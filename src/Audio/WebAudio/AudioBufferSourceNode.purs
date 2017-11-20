module Audio.WebAudio.AudioBufferSourceNode
  ( setBuffer, startBufferSource
  , loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd  ) where

import Prelude
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, WebAudio)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)

foreign import startBufferSource
  :: ∀ eff. Number
  -> AudioBufferSourceNode
  -> (Eff (wau :: WebAudio | eff) Unit)

loop :: ∀ eff. AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Boolean)
loop = unsafeGetProp "loop"

setLoop :: ∀ eff. Boolean -> AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Unit)
setLoop l n = unsafeSetProp "loop" n l

loopStart :: ∀ eff. AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Number)
loopStart = unsafeGetProp "loopStart"

setLoopStart :: ∀ eff. Number -> AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Unit)
setLoopStart l n = unsafeSetProp "loopStart" n l

loopEnd :: ∀ eff. AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Number)
loopEnd = unsafeGetProp "loopEnd"

setLoopEnd :: ∀ eff. Number -> AudioBufferSourceNode -> (Eff (wau :: WebAudio | eff) Unit)
setLoopEnd l n = unsafeSetProp "loopEnd" n l
