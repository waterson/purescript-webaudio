module SquareWave where
-- Oscillator nodes and gain nodes.

import Prelude

import Audio.WebAudio.Types (AUDIO, AudioContext, GainNode, OscillatorNode, AudioContextState(..), connect)
import Audio.WebAudio.BaseAudioContext (createGain, createOscillator, currentTime, destination, newAudioContext, resume, state, suspend)
import Audio.WebAudio.AudioParam (getValue, setValue, setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Oscillator (OscillatorType(..), frequency, setOscillatorType, startOscillator)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception (EXCEPTION, throw)
import Control.Monad.Eff.Ref (REF, Ref, newRef, readRef, writeRef)
import Control.Monad.Eff.Timer (IntervalId, TIMER, clearInterval, setInterval)
import DOM (DOM)
import DOM.Event.EventTarget (addEventListener, eventListener)
import DOM.Event.Types (EventTarget)
import DOM.HTML (window)
import DOM.HTML.Types (htmlDocumentToParentNode)
import DOM.HTML.Window (document)
import DOM.Node.ParentNode (querySelector)
import Data.Maybe (Maybe(..))
import Data.Newtype (wrap)
import Unsafe.Coerce (unsafeCoerce)

beep :: ∀ e. AudioContext
     -> OscillatorNode
     -> GainNode
     -> Eff (audio :: AUDIO, timer :: TIMER | e) Unit
beep ctx osc g = do
  freqParam <- frequency osc
  f <- getValue freqParam
  setValue (if f == 55.0 then 53.0 else 55.0) freqParam

  t <- currentTime ctx
  gainParam <- gain g
  _ <- setValueAtTime 0.5 t gainParam
  _ <- setValueAtTime 0.001 (t + 0.2) gainParam
  pure unit

controls ::
     ∀ e. Ref IntervalId
     -> AudioContext
     -> OscillatorNode
     -> GainNode
     -> Eff (audio :: AUDIO, timer :: TIMER, ref :: REF | e) Unit
controls ref ctx osc g = do
  s <- state ctx
  if (s == SUSPENDED)
     then do
       resume ctx
       t <- setInterval 1000 $ beep ctx osc g
       writeRef ref t
     else do
       suspend ctx
       val <- readRef ref
       clearInterval val

main ::
  ∀ e. Eff ( audio :: AUDIO
           , dom :: DOM
           , exception :: EXCEPTION
           , timer :: TIMER
           , ref :: REF | e
           ) Unit
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

  let id = unsafeCoerce (newRef 0) :: Ref IntervalId

  doc <- map htmlDocumentToParentNode (window >>= document)
  play <- querySelector (wrap "#play") doc
  case play of
    Just e -> addEventListener (wrap "click") (eventListener \_ -> controls id ctx osc g) false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'play' button"
  stop <- querySelector (wrap "#stop") doc
  case stop of
    Just e -> addEventListener (wrap "click") (eventListener \_ -> controls id ctx osc g) false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'stop' button"
  pure unit
