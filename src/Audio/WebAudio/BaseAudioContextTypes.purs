module Audio.WebAudio.BaseAudioContextTypes
  ( AudioContextState(..), AudioContextPlaybackCategory(..)) where

import Prelude

-- | Type synonym for possible values for AudioContextState

data AudioContextState = SUSPENDED | RUNNING | CLOSED

derive instance eqAudioContextState :: Eq AudioContextState
instance showAudioContextState :: Show AudioContextState where
  show SUSPENDED = "suspended"
  show RUNNING = "running"
  show CLOSED = "closed"


data AudioContextPlaybackCategory = BALANCED | INTERACTIVE | PLAYBACK
derive instance eqAudioPlaybackCategory :: Eq AudioContextPlaybackCategory
instance showAudioContextPlaybackCategory :: Show AudioContextPlaybackCategory where
  show BALANCED = "balanced"
  show INTERACTIVE = "interactive"
  show PLAYBACK = "playback"
