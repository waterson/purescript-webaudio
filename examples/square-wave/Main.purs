module SquareWave where
-- Oscillator nodes and gain nodes.

import Prelude

import Audio.WebAudio.AudioContext (connect, createGain, createOscillator, currentTime, destination, disconnect, makeAudioContext, state, resume, suspend)
import Audio.WebAudio.AudioParam (getValue, setValue, setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Oscillator (OscillatorType(..), frequency, setOscillatorType, startOscillator)
import Audio.WebAudio.Types (AUDIO, AudioContext, GainNode, OscillatorNode, AudioContextState(..))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, error, log)
import Control.Monad.Eff.Exception (EXCEPTION, throw)
import Control.Monad.Eff.Timer (TIMER, setTimeout)
import DOM (DOM)
import DOM.Event.Event (currentTarget)
import DOM.Event.EventTarget (addEventListener, eventListener)
import DOM.Event.Types (Event, EventTarget)
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
  _ <- setTimeout 1000 $ beep ctx osc g
  pure unit

playBeep :: ∀ e. AudioContext
         -> OscillatorNode
         -> GainNode
         -> Eff (audio :: AUDIO, timer :: TIMER, console :: CONSOLE | e) Unit
playBeep ctx osc g = do
  s <- state ctx
  if (s == SUSPENDED)
    then do
      resume ctx
      beep ctx osc g
    else error "Press STOP before pressing PLAY again"
  pure unit
     

stopBeep :: ∀ e. AudioContext -> Eff (audio :: AUDIO | e) Unit
stopBeep ctx = do 
  suspend ctx
  pure unit


main ::
  ∀ e. Eff ( console :: CONSOLE
           , audio :: AUDIO
           , dom :: DOM
           , exception :: EXCEPTION
           , timer :: TIMER | e
           ) Unit
main = do
  ctx <- makeAudioContext

  osc <- createOscillator ctx
  setOscillatorType Square osc
  startOscillator 0.0 osc

  g <- createGain ctx
  setValue 0.0 =<< gain g

  connect osc g
  connect g =<< destination ctx

  suspend ctx
  
  doc <- map htmlDocumentToParentNode (window >>= document)
  play <- querySelector (wrap "#play") doc
  case play of 
    Just e -> addEventListener (wrap "click") (eventListener \_ ->  playBeep ctx osc g) false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'play' button"
  stop <- querySelector (wrap "#stop") doc
  case stop of 
    Just e -> addEventListener (wrap "click") (eventListener \_ -> stopBeep ctx) false (unsafeCoerce e :: EventTarget)
    Nothing -> throw "No 'stop' button"
  pure unit

