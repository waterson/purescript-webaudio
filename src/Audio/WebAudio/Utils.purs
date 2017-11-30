module Audio.WebAudio.Utils
  ( createUint8Buffer, createFloat32Buffer, unsafeGetProp, unsafeSetProp, unsafeConnectParam) where

import Prelude
import Control.Monad.Eff (Eff)
import Data.ArrayBuffer.Types (ByteLength, Uint8Array, Float32Array)
import Data.ArrayBuffer.ArrayBuffer (ARRAY_BUFFER, create) as ArrayBuffer
import Data.ArrayBuffer.DataView (whole)
import Data.ArrayBuffer.Typed (asUint8Array, asFloat32Array)
import Audio.WebAudio.Types (class AudioNode, WebAudio)

foreign import unsafeSetProp :: forall obj val eff. String -> obj -> val -> (Eff eff Unit)
foreign import unsafeGetProp :: forall obj val eff. String -> obj -> (Eff eff val)

-- | experimental
-- | the String parameter names an audio parameter on the target node, n
-- | this function connects this audio parameter to node m
-- |
-- | it seems we need to do this as an atomic operation
-- | If we have separate monadic functions to get the audio parameter
-- | and to connect a node to it, then it fails to work.
-- | The Web-Audio JavaScript requires the original parameter, not a copy
-- |
-- | This is very unsafe.  The parameter must exist on the target.
foreign import unsafeConnectParam  :: ∀ m n eff. AudioNode m => AudioNode n => m
  -> n
  -> String
  -> (Eff (wau :: WebAudio | eff) Unit)

-- | create an unsigned 8-bit integer buffer for use with an analyser node
createUint8Buffer :: ∀ e. ByteLength -> Eff (arrayBuffer :: ArrayBuffer.ARRAY_BUFFER | e) Uint8Array
createUint8Buffer len =
  map (whole >>> asUint8Array) $ ArrayBuffer.create len

-- | create a Float 32 buffer for use with an analyser node
createFloat32Buffer :: ∀ e. ByteLength -> Eff (arrayBuffer :: ArrayBuffer.ARRAY_BUFFER | e) Float32Array
createFloat32Buffer len =
  map (whole >>> asFloat32Array) $ ArrayBuffer.create len
