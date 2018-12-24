module SquareWave where
-- Oscillator nodes and gain nodes.

import Prelude

import Audio.WebAudio.Types (AudioContext, GainNode, OscillatorNode, AudioContextState(..), connect)
import Audio.WebAudio.BaseAudioContext (createGain, createOscillator, currentTime, destination, newAudioContext, resume, state, suspend)
import Audio.WebAudio.AudioParam (getValue, setValue, setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Oscillator (OscillatorType(..), frequency, setOscillatorType, startOscillator)
import Effect (Effect)
import Effect.Exception (throw)
import Effect.Ref (Ref)
import Effect.Ref (new, read, write) as Ref
import Effect.Timer (IntervalId, clearInterval, setInterval)
import Web.Event.EventTarget (EventTarget, addEventListener, eventListener)
--import Web.Event.Types (EventTarget)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toParentNode) as HTMLDocument
import Web.HTML.Window (document)
import Web.DOM.ParentNode (querySelector)
import Data.Maybe (Maybe(..))
import Data.Newtype (wrap)
import Unsafe.Coerce (unsafeCoerce)

beep :: AudioContext
     -> OscillatorNode
     -> GainNode
     -> Effect Unit
beep ctx osc g = do
  freqParam <- frequency osc
  f <- getValue freqParam
  setValue (if f == 55.0 then 53.0 else 55.0) freqParam

  t <- currentTime ctx
  gainParam <- gain g
  _ <- setValueAtTime 0.5 t gainParam
  _ <- setValueAtTime 0.001 (t + 0.2) gainParam
  pure unit

controls :: Ref IntervalId
         -> AudioContext
         -> OscillatorNode
         -> GainNode
         -> Effect Unit
controls ref ctx osc g = do
  s <- state ctx
  if (s == SUSPENDED)
     then do
       resume ctx
       t <- setInterval 1000 $ beep ctx osc g
       Ref.write t ref
     else do
       suspend ctx
       val <- Ref.read ref
       clearInterval val

main :: Effect Unit
main = do
  ctx <- newAudioContext

  osc <- createOscillator ctx
  setOscillatorType Square osc
  startOscillator 0.0 osc

  g <- createGain ctx
  setValue 0.0 =<< gain g

  connect osc g
  connect g =<< destination ctx

  suspend ctx

  let id = unsafeCoerce (Ref.new 0) :: Ref IntervalId

  doc <- map HTMLDocument.toParentNode (window >>= document)
  play <- querySelector (wrap "#play") doc
  case play of
    Just e -> do
      listener <- eventListener \_ -> controls id ctx osc g
      addEventListener (wrap "click") listener false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'play' button"
  stop <- querySelector (wrap "#stop") doc
  case stop of
    Just e -> do
      listener <- eventListener \_ -> controls id ctx osc g
      addEventListener (wrap "click") listener false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'stop' button"
  pure unit
