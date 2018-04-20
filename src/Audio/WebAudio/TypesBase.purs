module Audio.WebAudio.BaseAudioContext.Types ( AudioContextState(..)) where

import Prelude

-- | Type synonym for possible values for AudioContextState

data AudioContextState = SUSPENDED | RUNNING | CLOSED

derive instance eqAudioContextState :: Eq AudioContextState
instance showAudioContextState :: Show AudioContextState where
  show SUSPENDED = "suspended"
  show RUNNING = "running"
  show CLOSED = "closed"
