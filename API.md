# Module Documentation

## Module Audio.WebAudio

### Types

    data AudioBuffer :: *

    data AudioBufferSourceNode :: *

    data DestinationNode :: *

    data MediaElementAudioSourceNode :: *

    data OscillatorNode :: *

    data OscillatorType where
      Sine :: OscillatorType
      Square :: OscillatorType
      Sawtooth :: OscillatorType
      Triangle :: OscillatorType
      Custom :: OscillatorType

    data WebAudio :: !

    data WebAudioContext :: *


### Type Classes

    class AudioNode n where


### Type Class Instances

    instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode

    instance audioNodeDestinationNode :: AudioNode DestinationNode

    instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode

    instance audioNodeOscillatorNode :: AudioNode OscillatorNode

    instance oscillatorTypeShow :: Show OscillatorType


### Values

    connect :: forall m n wau eff. (AudioNode m, AudioNode n) => m -> n -> Eff (wau :: WebAudio | eff) Unit

    createBufferSource :: forall wau eff. WebAudioContext -> Eff (wau :: WebAudio | eff) AudioBufferSourceNode

    createMediaElementSource :: forall wau dom eff. WebAudioContext -> HTMLElement -> Eff (dom :: DOM, wau :: WebAudio | eff) MediaElementAudioSourceNode

    createOscillator :: forall wau eff. WebAudioContext -> Eff (wau :: WebAudio | eff) OscillatorNode

    currentTime :: forall wau eff. WebAudioContext -> Eff (wau :: WebAudio | eff) Number

    decodeAudioData :: forall wau e f. WebAudioContext -> String -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit) -> Eff (wau :: WebAudio | f) Unit

    destination :: forall wau eff. WebAudioContext -> Eff (wau :: WebAudio | eff) DestinationNode

    frequency :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) Number

    makeWebAudioContext :: forall wau eff. Eff (wau :: WebAudio | eff) WebAudioContext

    oscillatorType :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) OscillatorType

    readOscillatorType :: String -> OscillatorType

    setBuffer :: forall wau eff. AudioBufferSourceNode -> AudioBuffer -> Eff (wau :: WebAudio | eff) Unit

    setFrequency :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    setOscillatorType :: forall wau eff. OscillatorNode -> OscillatorType -> Eff (wau :: WebAudio | eff) Unit

    startBufferSource :: forall wau eff. AudioBufferSourceNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    startOscillator :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    stopOscillator :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    unsafeGetAudioParamValue :: forall obj val eff. String -> obj -> Eff eff val

    unsafeGetProp :: forall obj val eff. String -> obj -> Eff eff val

    unsafeSetAudioParamValue :: forall obj val eff. String -> obj -> val -> Eff eff Unit

    unsafeSetProp :: forall obj val eff. String -> obj -> val -> Eff eff Unit