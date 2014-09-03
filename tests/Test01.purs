module Test01 where
-- Oscillator nodes and gain nodes.

import Control.Bind
import Control.Monad.Eff

import Data.DOM.Simple.Types
import Data.DOM.Simple.Window

import Audio.WebAudio.Types
import Audio.WebAudio.AudioContext
import Audio.WebAudio.AudioParam
import Audio.WebAudio.OscillatorNode
import Audio.WebAudio.DestinationNode
import Audio.WebAudio.GainNode

main :: forall wau dom eff. (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
main = do
  ctx <- makeAudioContext

  osc <- createOscillator ctx
  setOscillatorType Square osc
  startOscillator 0.0 osc

  g <- createGain ctx
  setValue 0.0 =<< gain g

  connect osc g
  connect g =<< destination ctx

  setTimeout globalWindow 250 $ beep ctx osc g
  return unit

beep :: forall wau dom eff. AudioContext
     -> OscillatorNode
     -> GainNode
     -> (Eff (wau :: WebAudio, dom :: DOM | eff) Unit)
beep ctx osc g = do
  freqParam <- frequency osc
  f <- getValue freqParam
  setValue (if f == 55 then 53 else 55) freqParam

  t <- currentTime ctx
  gainParam <- gain g
  setValueAtTime 1.000 t gainParam
  setValueAtTime 0.001 (t + 0.2) gainParam

  setTimeout globalWindow 1000 $ beep ctx osc g
  return unit
