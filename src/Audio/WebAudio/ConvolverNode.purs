module Audio.WebAudio.ConvolverNode (setBuffer, normalize, isNormalized) where

import Prelude (Unit)
import Control.Monad.Eff (Eff)
import Audio.WebAudio.Types (AudioBuffer, ConvolverNode, AUDIO)
import Audio.WebAudio.Utils (unsafeGetProp, unsafeSetProp)

foreign import setBuffer
  :: ∀ eff. AudioBuffer
  -> ConvolverNode
  -> (Eff (audio :: AUDIO | eff) Unit)

normalize :: ∀ eff. Boolean -> ConvolverNode -> (Eff (audio :: AUDIO | eff) Unit)
normalize l n = unsafeSetProp "normalize" n l

isNormalized :: ∀ eff. ConvolverNode -> (Eff (audio :: AUDIO | eff) Boolean)
isNormalized = unsafeGetProp "normalize"
