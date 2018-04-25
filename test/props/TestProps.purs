module TestProps where

-- | just test some basic getters and setters

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd)
import Audio.WebAudio.BaseAudioContext (createBufferSource, createBiquadFilter, createDelay, createGain,
     createOscillator, createAnalyser, createStereoPanner, createDynamicsCompressor,
     createConvolver, newAudioContext, destination)
import Audio.WebAudio.Types (AUDIO, AudioContext, AudioNode(..), connect, connectParam)
import Audio.WebAudio.BiquadFilterNode (BiquadFilterType(..), filterFrequency, filterType, setFilterType, quality)
import Audio.WebAudio.GainNode (gain, setGain)
import Audio.WebAudio.DelayNode (delayTime)
import Audio.WebAudio.StereoPannerNode (pan)
import Audio.WebAudio.DynamicsCompressorNode (threshold, knee, ratio, attack, release, reduction)
import Audio.WebAudio.ConvolverNode (normalize, isNormalized)
import Audio.WebAudio.AnalyserNode (fftSize, getByteTimeDomainData, minDecibels, setMinDecibels,
       smoothingTimeConstant, setSmoothingTimeConstant)
import Audio.WebAudio.AudioParam (setValue, getValue)
import Audio.WebAudio.Utils (createUint8Buffer)
import Control.Monad.Eff (Eff)
import Data.ArrayBuffer.ArrayBuffer (ARRAY_BUFFER)
import Control.Monad.Eff.Console (CONSOLE, log)
import Test.Assert (ASSERT, assert')

main :: ∀ eff.(Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT, arrayBuffer :: ARRAY_BUFFER | eff) Unit)
main = do
  ctx <- newAudioContext
  _ <- sourceBufferTests ctx
  _ <- biquadFilterTests ctx
  _ <- delayNodeTests ctx
  _ <- gainNodeTests ctx
  _ <- analyserNodeTests ctx
  _ <- stereoPannerNodeTests ctx
  _ <- dynamicsCompressorNodeTests ctx
  _ <- convolverNodeTests ctx
  connectionTests ctx

sourceBufferTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
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


biquadFilterTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
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

delayNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
delayNodeTests ctx = do
  delayNode <- createDelay ctx
  delayParam <- delayTime delayNode
  -- by default we're restricted to values between 0 and 1 second
  _ <- setValue 0.75 delayParam
  delay <- getValue delayParam
  _ <- assert' ("incorrect delay time: " <> (show delay)) (delay == 0.75)
  log "delay node tests passed"

gainNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
gainNodeTests ctx = do
  gainNode <- createGain ctx
  _ <- setGain 30.0 gainNode
  gainParam <- gain gainNode
  gain <- getValue gainParam
  _ <- assert' ("shorthand set gain failure: ") (gain == 30.0)
  log "gain node tests passed"

analyserNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT, arrayBuffer :: ARRAY_BUFFER | eff) Unit)
analyserNodeTests ctx = do
  analyser <- createAnalyser ctx
  size <- fftSize analyser
  _ <- assert' ("default fft buffer size failure: ") (size == 2048)
  _ <- setMinDecibels (-140.0) analyser
  minDB <- minDecibels analyser
  _ <- assert' ("minDecibels failure: ") (minDB == (-140.0))
  _ <- setSmoothingTimeConstant (0.8) analyser
  tc <- smoothingTimeConstant analyser
  _ <- assert' ("smoothingTimeConstant failure: ") (tc == (0.8))
  -- these next 2 lines just test that nothing crashes
  buffer <- createUint8Buffer size
  _ <- getByteTimeDomainData analyser buffer
  log "analyser node tests passed"

stereoPannerNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
stereoPannerNodeTests ctx = do
  stereoPannerNode <- createStereoPanner ctx
  panParam <- pan stereoPannerNode
  -- by default we're restricted to values between -1 and +1
  _ <- setValue (-0.75) panParam
  panVal <- getValue panParam
  _ <- assert' ("incorrect pan value: " <> (show panVal)) (panVal == -0.75)
  log "stereo panner node tests passed"

dynamicsCompressorNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
dynamicsCompressorNodeTests ctx = do
  compressorNode <- createDynamicsCompressor ctx
  thresholdParam <- threshold compressorNode
  -- by default we're restricted to values between -100 and 0
  _ <- setValue (-50.0) thresholdParam
  thresholdVal <- getValue thresholdParam
  _ <- assert' ("incorrect threshold value: " <> (show thresholdVal)) (thresholdVal == -50.0)
  kneeParam <- knee compressorNode
  _ <- setValue (30.0) kneeParam
  kneeVal <- getValue kneeParam
  _ <- assert' ("incorrect knee value: " <> (show kneeVal)) (kneeVal == 30.0)
  ratioParam <- ratio compressorNode
  -- by default we're restricted to values between 1 and 20
  _ <- setValue (20.0) ratioParam
  ratioVal <- getValue ratioParam
  _ <- assert' ("incorrect ratio value: " <> (show ratioVal)) (ratioVal == 20.0)
  attackParam <- attack compressorNode
  -- by default we're restricted to values between 0 and 1
  _ <- setValue (0.5) attackParam
  attackVal <- getValue attackParam
  _ <- assert' ("incorrect attack value: " <> (show attackVal)) (attackVal == 0.5)
  releaseParam <- release compressorNode
  -- by default we're restricted to values between 0 and 1
  _ <- setValue (0.5) releaseParam
  releaseVal <- getValue releaseParam
  _ <- assert' ("incorrect release value: " <> (show releaseVal)) (releaseVal == 0.5)
  -- 0.0 is the default
  reduction' <- reduction compressorNode
  _ <- assert' ("get reduction failure" <> (show reduction')) (reduction' == 0.0)
  log "dynamics compressor node tests passed"

convolverNodeTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
convolverNodeTests ctx = do
  convolverNode <- createConvolver ctx
  _ <- normalize true convolverNode
  normalized <- isNormalized convolverNode
  _ <- assert' "normalize failed" (normalized == true)
  log "convolver node tests passed"

connectionTests :: ∀ eff. AudioContext -> (Eff (audio :: AUDIO, console :: CONSOLE, assert :: ASSERT | eff) Unit)
connectionTests ctx = do
  modulator <- createOscillator ctx
  modGainNode <- createGain ctx
  _ <- connectParam modGainNode modulator "frequency"
  -- simple connect
  osc1 <- createOscillator ctx
  gain1 <- createGain ctx
  dest <- destination ctx
  _ <- connect gain1 dest
  _ <- connect osc1 gain1
  -- audio node connect
  osc2 <- createOscillator ctx
  gain2 <- createGain ctx
  _ <- connect gain2 (Destination dest)
  _ <- connect osc2 (Gain gain2)
  log "connection tests passed"
