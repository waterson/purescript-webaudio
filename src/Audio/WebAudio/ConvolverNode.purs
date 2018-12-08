module Audio.WebAudio.ConvolverNode (setBuffer, normalize, isNormalized) where

import Prelude (Unit)
import Effect (Effect)
import Audio.WebAudio.Types (AudioBuffer, ConvolverNode)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  ::  AudioBuffer
  -> ConvolverNode
  -> Effect Unit

normalize :: Boolean -> ConvolverNode -> Effect Unit
normalize l n = unsafeSetProp "normalize" n l

isNormalized :: ConvolverNode -> Effect Boolean
isNormalized = unsafeGetProp "normalize"
