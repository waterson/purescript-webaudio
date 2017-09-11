module Test03 where

import Control.Monad.Eff
import Audio.WebAudio.Types
import Audio.WebAudio.AudioContext
import Audio.WebAudio.AudioBufferSourceNode
import Audio.WebAudio.DestinationNode
-- import Data.DOM.Simple.Types
-- import Data.DOM.Simple.Ajax
-- import Data.DOM.Simple.Events
import Data.Maybe (fromJust)

main :: forall eff. (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
main = do
  req <- makeXMLHttpRequest
  open "GET" "/html/siren.wav" req
  setResponseType "arraybuffer" req
  addProgressEventListener ProgressLoadEvent (play req) req
  send req

play :: forall eff. XMLHttpRequest -- |^ the request object
     -> DOMEvent -- |^ the load event
     -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
play req ev = do
  ctx <- makeAudioContext
  src <- createBufferSource ctx
  dst <- destination ctx
  connect src dst
  audioData <- response req
  decodeAudioData ctx audioData $ play0 src

play0 :: forall eff. AudioBufferSourceNode
      -> (Maybe AudioBuffer)
      -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
play0 src (Just buf) = do
  setBuffer buf src
  startBufferSource 0 src

play0 _ Nothing = return unit
