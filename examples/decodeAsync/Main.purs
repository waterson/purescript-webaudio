module DecodeAsync where

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (setBuffer, startBufferSource)
import Audio.WebAudio.BaseAudioContext (createBufferSource, currentTime, decodeAudioDataAsync, destination, newAudioContext)
import Audio.WebAudio.Types (AudioContext, AudioBuffer, AUDIO, connect)
import Control.Monad.Aff (Aff, Fiber, launchAff)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Class (liftEff)
import Control.Parallel (parallel, sequential)
import Data.Either (Either(..))
import Data.HTTP.Method (Method(..))
import Data.Traversable (traverse)
import Data.Maybe (Maybe(..))
import Data.Array ((!!))
import Network.HTTP.Affjax (AJAX, affjax, defaultRequest)

type ElapsedTime = Number

-- | load a single sound buffer resource and decode it
loadSoundBuffer :: ∀ eff.
  AudioContext
  -> String
  -> Aff
     ( ajax :: AJAX
     , audio :: AUDIO
     | eff
     )
     AudioBuffer
loadSoundBuffer ctx fileName = do
  res <- affjax $ defaultRequest { url = fileName, method = Left GET }
  buffer <- decodeAudioDataAsync ctx res.response
  pure buffer

-- | load and decode an array of audio buffers from a set of resources
loadSoundBuffers :: ∀ e.
  AudioContext
  -> (Array String)
  -> Aff
     ( ajax :: AJAX
     , audio :: AUDIO
     | e
     )
     (Array AudioBuffer)
loadSoundBuffers ctx fileNames =
  sequential $ traverse (\name -> parallel (loadSoundBuffer ctx name)) fileNames

-- | Play a sound at a sepcified elapsed time
playSoundAt  :: ∀ eff.
     AudioContext
  -> Maybe AudioBuffer
  -> ElapsedTime
  -> Eff
      ( audio :: AUDIO
      | eff )
      Unit
playSoundAt ctx mbuffer elapsedTime =
  case mbuffer of
    Just buffer ->
      do
        startTime <- currentTime ctx
        src <- createBufferSource ctx
        dst <- destination ctx
        _ <- connect src dst
        _ <- setBuffer buffer src
        -- // We'll start playing the sound 100 milliseconds from "now"
        startBufferSource (startTime + elapsedTime + 0.1) src
    _ ->
      pure unit

main :: ∀ eff.
  Eff
    ( ajax :: AJAX
    , audio :: AUDIO
    | eff
    )
    (Fiber
       ( ajax :: AJAX
       , audio :: AUDIO
       | eff
       )
       Unit
    )
main = launchAff $ do
  ctx <- liftEff newAudioContext
  buffers <- loadSoundBuffers ctx ["hihat.wav", "kick.wav", "snare.wav"]
  _ <- liftEff $ playSoundAt ctx (buffers !! 0) 0.0
  _ <- liftEff $ playSoundAt ctx (buffers !! 1) 0.5
  _ <- liftEff $ playSoundAt ctx (buffers !! 2) 1.0
  _ <- liftEff $ playSoundAt ctx (buffers !! 0) 1.5
  _ <- liftEff $ playSoundAt ctx (buffers !! 1) 2.0
  _ <- liftEff $ playSoundAt ctx (buffers !! 2) 2.5
  pure unit
