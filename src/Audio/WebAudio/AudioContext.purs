module Audio.WebAudio.AudioContext
  ( createMediaElementSource
  ) where

import Audio.WebAudio.Types (AUDIO, AudioContext, MediaElementAudioSourceNode)
import Control.Monad.Eff (Eff)

-- | Creates a MediaElementAudioSourceNode given an HTMLMediaElement. As a consequence of
-- | calling this method, audio playback from the HTMLMediaElement will be re-routed into
-- | the processing graph of the AudioContext.
foreign import createMediaElementSource
  :: ∀ elt eff. AudioContext
  -> elt -- |^ a DOM element from which to construct the source node. todo: HTML?
  -> (Eff (audio :: AUDIO | eff) MediaElementAudioSourceNode)
