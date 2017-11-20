module TestProps where

-- | just test some basic getters and setters

import Prelude

import Audio.WebAudio.AudioBufferSourceNode (loop, setLoop, loopStart, setLoopStart, loopEnd, setLoopEnd)
import Audio.WebAudio.AudioContext (createBufferSource, makeAudioContext)
import Audio.WebAudio.Types (WebAudio)
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Test.Assert (ASSERT, assert')


main :: ∀ eff.(Eff (wau :: WebAudio, console :: CONSOLE, assert :: ASSERT | eff) Unit)
main = do
  sourceBufferTests

sourceBufferTests :: ∀ eff.(Eff (wau :: WebAudio, console :: CONSOLE, assert :: ASSERT | eff) Unit)
sourceBufferTests = do
  ctx <- makeAudioContext
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
