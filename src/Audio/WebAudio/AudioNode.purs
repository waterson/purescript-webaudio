module Audio.WebAudio.AudioNode (connect, disconnect) where

import Prelude (Unit)
import Audio.WebAudio.Types (AUDIO, class AudioNode)
import Control.Monad.Eff (Eff)

foreign import connect
  :: ∀ m n eff
  .  AudioNode m
  => AudioNode n
  => m
  -> n
  -> (Eff (audio :: AUDIO | eff) Unit)

foreign import disconnect
  :: ∀ m n eff
  . AudioNode m
  => AudioNode n
  => m
  -> n
  -> (Eff (audio :: AUDIO | eff) Unit)
