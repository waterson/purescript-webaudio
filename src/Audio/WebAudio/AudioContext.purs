module Audio.WebAudio.AudioContext
  ( createMediaElementSource
  ) where

import Audio.WebAudio.Types (AudioContext, MediaElementAudioSourceNode)
import Effect (Effect)

-- | Creates a MediaElementAudioSourceNode given an HTMLMediaElement. As a consequence of
-- | calling this method, audio playback from the HTMLMediaElement will be re-routed into
-- | the processing graph of the AudioContext.
foreign import createMediaElementSource
  :: ∀ elt. AudioContext
  -> elt -- |^ a DOM element from which to construct the source node. todo: HTML?
  -> Effect MediaElementAudioSourceNode
