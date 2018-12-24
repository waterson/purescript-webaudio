module DecodeAsync where

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (setBuffer, startBufferSource)
import Audio.WebAudio.BaseAudioContext (createBufferSource, currentTime, decodeAudioDataAsync, destination, newAudioContext)
import Audio.WebAudio.Types (AudioContext, AudioBuffer, connect)
import Effect.Aff (Aff, Fiber, launchAff)
import Effect (Effect)
import Effect.Class (liftEffect)
import Control.Parallel (parallel, sequential)
import Data.Either (Either(..))
import Data.Traversable (traverse)
import Data.Maybe (Maybe(..))
import Data.Array ((!!))
import Affjax (get)
import Affjax.ResponseFormat (arrayBuffer, ResponseFormatError)

type ElapsedTime = Number

-- | load a single sound buffer resource and decode it
loadSoundBuffer :: AudioContext
                -> String
                -> Aff (Either ResponseFormatError AudioBuffer)
loadSoundBuffer ctx fileName = do
  res <- get arrayBuffer fileName
  traverse (decodeAudioDataAsync ctx) res.body

-- | load and decode an array of audio buffers from a set of resources
loadSoundBuffers :: AudioContext
                 -> Array String
                 -> Aff (Array (Either ResponseFormatError AudioBuffer))
loadSoundBuffers ctx fileNames =
  sequential $ traverse (\name -> parallel (loadSoundBuffer ctx name)) fileNames

-- | Play a sound at a sepcified elapsed time
playSoundAt :: AudioContext
            -> Maybe (Either ResponseFormatError AudioBuffer)
            -> ElapsedTime
            -> Effect Unit
playSoundAt ctx mbuffer elapsedTime =
  case mbuffer of
    Just (Right buffer) ->
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

main :: Effect (Fiber Unit)
main = launchAff $ do
  ctx <- liftEffect newAudioContext
  buffers <- loadSoundBuffers ctx ["hihat.wav", "kick.wav", "snare.wav"]
  _ <- liftEffect $ playSoundAt ctx (buffers !! 0) 0.0
  _ <- liftEffect $ playSoundAt ctx (buffers !! 1) 0.5
  _ <- liftEffect $ playSoundAt ctx (buffers !! 2) 1.0
  _ <- liftEffect $ playSoundAt ctx (buffers !! 0) 1.5
  _ <- liftEffect $ playSoundAt ctx (buffers !! 1) 2.0
  _ <- liftEffect $ playSoundAt ctx (buffers !! 2) 2.5
  pure unit
