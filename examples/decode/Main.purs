module DecodeAudio where

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (setBuffer, startBufferSource)
import Audio.WebAudio.AudioContext (connect, createBufferSource, decodeAudioData, destination, makeAudioContext)
import Audio.WebAudio.Types (AudioBuffer, AudioBufferSourceNode, AUDIO)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (warn)
import DOM (DOM)
import Data.ArrayBuffer.Types (ArrayBuffer)
import Partial.Unsafe (unsafePartial)
import SimpleDom (DOMEvent, HttpData(..), HttpMethod(..), ProgressEventType(..), XMLHttpRequest, addProgressEventListener, makeXMLHttpRequest, open, response, send, setResponseType)

toArrayBuffer :: forall a. (HttpData a) -> ArrayBuffer
toArrayBuffer hd =
  unsafePartial
    case hd of
      (ArrayBufferData a) -> a

main :: forall eff. (Eff (audio :: AUDIO, dom :: DOM | eff) Unit)
main = do
  req <- makeXMLHttpRequest
  open GET "decode-audio.wav" req
  setResponseType "arraybuffer" req
  addProgressEventListener ProgressLoadEvent (play req) req
  send NoData req
  pure unit

play :: forall eff. XMLHttpRequest -- |^ the request object
     -> DOMEvent -- |^ the load event
     -> (Eff (audio :: AUDIO, dom :: DOM | eff) Unit)
play req ev = do
  ctx <- makeAudioContext
  src <- createBufferSource ctx
  dst <- destination ctx
  connect src dst
  audioData <- response req
  decodeAudioData ctx (toArrayBuffer audioData) (play0 src) warn

play0 :: forall eff. AudioBufferSourceNode
      -> AudioBuffer
      -> (Eff (audio :: AUDIO, dom :: DOM | eff) Unit)
play0 src buf = do
  setBuffer buf src
  startBufferSource 0.0 src
