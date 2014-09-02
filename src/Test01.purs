module Test01 where
-- Use an oscillator to play a square wave for a second.

import Control.Monad.Eff
import Audio.WebAudio

main :: forall wau eff. (Eff (wau :: WebAudio | eff) Unit)
main = do
  cx <- makeWebAudioContext
  osc <- createOscillator cx
  dest <- destination cx
  t <- currentTime cx
  connect osc dest
  setFrequency osc 440
  setOscillatorType osc Square
  startOscillator osc t
  stopOscillator osc (t + 1)
