module Test03 where

import Control.Monad.Eff
import Audio.WebAudio
import Data.DOM.Simple.Types
import Data.DOM.Simple.Ajax
import Data.DOM.Simple.Events
import Data.Maybe

main :: forall wau eff. (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
main = do
  req <- makeXMLHttpRequest
  open "GET" "/html/siren.wav" req
  setResponseType "arraybuffer" req
  addProgressEventListener ProgressLoadEvent (play req) req
  send req

play :: forall ev wau eff. XMLHttpRequest -- |^ the request object
     -> DOMEvent -- |^ the load event
     -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
play req ev = do
  ctx <- makeWebAudioContext
  src <- createBufferSource ctx
  dst <- destination ctx
  connect src dst
  audioData <- response req
  decodeAudioData ctx audioData $ play0 src

play0 :: forall wau eff. AudioBufferSourceNode
      -> (Maybe AudioBuffer)
      -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
play0 src (Just buf) = do
  setBuffer src buf
  startBufferSource src 0

play0 _ Nothing = return unit
