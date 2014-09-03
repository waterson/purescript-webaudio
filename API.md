# Module Documentation

## Module Audio.WebAudio.AudioBufferSourceNode

### Type Class Instances

    instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode


### Values

    setBuffer :: forall wau eff. AudioBufferSourceNode -> AudioBuffer -> Eff (wau :: WebAudio | eff) Unit

    startBufferSource :: forall wau eff. AudioBufferSourceNode -> Number -> Eff (wau :: WebAudio | eff) Unit


## Module Audio.WebAudio.AudioContext

### Values

    connect :: forall m n wau eff. (AudioNode m, AudioNode n) => m -> n -> Eff (wau :: WebAudio | eff) Unit

    createBufferSource :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) AudioBufferSourceNode

    createMediaElementSource :: forall elt wau dom eff. AudioContext -> elt -> Eff (wau :: WebAudio | eff) MediaElementAudioSourceNode

    createOscillator :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) OscillatorNode

    currentTime :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) Number

    decodeAudioData :: forall wau e f. AudioContext -> String -> (Maybe AudioBuffer -> Eff (wau :: WebAudio | e) Unit) -> Eff (wau :: WebAudio | f) Unit

    destination :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) DestinationNode

    makeAudioContext :: forall wau eff. Eff (wau :: WebAudio | eff) AudioContext


## Module Audio.WebAudio.DestinationNode

### Type Class Instances

    instance audioNodeDestinationNode :: AudioNode DestinationNode


## Module Audio.WebAudio.MediaElementAudioSourceNode

### Type Class Instances

    instance audioNodeMediaElementAudioSourceNode :: AudioNode MediaElementAudioSourceNode


## Module Audio.WebAudio.OscillatorNode

### Types

    data OscillatorType where
      Sine :: OscillatorType
      Square :: OscillatorType
      Sawtooth :: OscillatorType
      Triangle :: OscillatorType
      Custom :: OscillatorType


### Type Class Instances

    instance audioNodeOscillatorNode :: AudioNode OscillatorNode

    instance oscillatorTypeShow :: Show OscillatorType


### Values

    frequency :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) Number

    oscillatorType :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) OscillatorType

    readOscillatorType :: String -> OscillatorType

    setFrequency :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    setOscillatorType :: forall wau eff. OscillatorNode -> OscillatorType -> Eff (wau :: WebAudio | eff) Unit

    startOscillator :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit

    stopOscillator :: forall wau eff. OscillatorNode -> Number -> Eff (wau :: WebAudio | eff) Unit


## Module Audio.WebAudio.Types

### Types

    data AudioBuffer :: *

    data AudioBufferSourceNode :: *

    data AudioContext :: *

    data DestinationNode :: *

    data MediaElementAudioSourceNode :: *

    data OscillatorNode :: *

    data WebAudio :: !


### Type Classes

    class AudioNode n where


## Module Audio.WebAudio.Utils

### Values

    unsafeGetAudioParamValue :: forall obj val eff. String -> obj -> Eff eff val

    unsafeGetProp :: forall obj val eff. String -> obj -> Eff eff val

    unsafeSetAudioParamValue :: forall obj val eff. String -> obj -> val -> Eff eff Unit

    unsafeSetProp :: forall obj val eff. String -> obj -> val -> Eff eff Unit