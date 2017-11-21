module TestProps where

-- | just test some basic getters and setters

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd)
import Audio.WebAudio.AudioContext (createBufferSource, createBiquadFilter, makeAudioContext)
import Audio.WebAudio.Types (WebAudio, AudioContext)
import Audio.WebAudio.BiquadFilterNode (BiquadFilterType(..), filterFrequency, filterType, setFilterType, quality)
import Audio.WebAudio.AudioParam (setValue, getValue)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Test.Assert (ASSERT, assert')


main :: ∀ eff.(Eff (wau :: WebAudio, console :: CONSOLE, assert :: ASSERT | eff) Unit)
main = do
  ctx <- makeAudioContext
  _ <- sourceBufferTests ctx
  biquadFilterTests ctx

sourceBufferTests :: ∀ eff. AudioContext -> (Eff (wau :: WebAudio, console :: CONSOLE, assert :: ASSERT | eff) Unit)
sourceBufferTests ctx = do
  src <- createBufferSource ctx
  _ <- setLoop true src
  isLoop <- loop src
  _ <- assert' "setLoop failed" (isLoop == true)
  _ <- setLoopStart 2.0 src
  loops <- loopStart src
  _ <- assert' "setLoopStart failed" (loops == 2.0)
  _ <- setLoopEnd 4.0 src
  loope <- loopEnd src
  _ <- assert' "setLoopEnd failed" (loope == 4.0)
  log "source buffer tests passed"


biquadFilterTests :: ∀ eff. AudioContext -> (Eff (wau :: WebAudio, console :: CONSOLE, assert :: ASSERT | eff) Unit)
biquadFilterTests ctx = do
  filter <- createBiquadFilter ctx
  fType <- filterType filter
  _ <- assert' "incorrect biquad filter type" (fType == Lowpass)
  _ <- setFilterType Highpass filter
  fType' <- filterType filter
  _ <- assert' "set filter type failure" (fType' == Highpass)
  freqParam <- filterFrequency filter
  frequency <- getValue freqParam
  _ <- assert' "incorrect filter frequency" (frequency == 350.0)
  _ <- setValue 400.0 freqParam
  freqParam' <- filterFrequency filter
  frequency' <- getValue freqParam'
  _ <- assert' "incorrect set filter frequency" (frequency' == 400.0)
  qParam <- quality filter
  q <- getValue qParam
  _ <- assert' "incorrect filter quality" (q == 1.0)
  _ <- setValue 30.0 qParam
  qParam' <- quality filter
  q' <- getValue qParam'
  _ <- assert' "incorrect set filter quality" (q' == 30.0)
  log "biquad filter tests passed"
