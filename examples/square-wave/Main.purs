module SquareWave where
-- Oscillator nodes and gain nodes.

import Prelude

import Audio.WebAudio.AudioContext (connect, createGain, createOscillator, currentTime, destination, makeAudioContext)
import Audio.WebAudio.AudioParam (getValue, setTargetAtTime, setValue, setValueAtTime)
import Audio.WebAudio.GainNode (gain)
import Audio.WebAudio.Oscillator (OscillatorType(..), frequency, setOscillatorType, startOscillator)
import Audio.WebAudio.Types (AudioContext, OscillatorNode, GainNode, AUDIO)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Timer (TIMER, setTimeout)
import DOM (DOM)

beep :: ∀ eff. AudioContext
     -> OscillatorNode
     -> GainNode
     -> (Eff (wau :: AUDIO, dom :: DOM, timer :: TIMER | eff) Unit)
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

main :: ∀ eff. Eff (wau :: AUDIO, dom :: DOM, timer :: TIMER | eff) Unit
main = do
  ctx <- makeAudioContext

  osc <- createOscillator ctx
  setOscillatorType Square osc
  startOscillator 0.0 osc

  g <- createGain ctx
  setValue 0.0 =<< gain g

  connect osc g
  connect g =<< destination ctx

  _ <- setTimeout 250 $ beep ctx osc g
  pure unit

