# Module Documentation

## Module Audio.WebAudio.AudioBufferSourceNode

### Type Class Instances

    instance audioNodeAudioBufferSourceNode :: AudioNode AudioBufferSourceNode


### Values

    setBuffer :: forall wau eff. AudioBuffer -> AudioBufferSourceNode -> Eff (wau :: WebAudio | eff) Unit

    startBufferSource :: forall wau eff. Number -> AudioBufferSourceNode -> Eff (wau :: WebAudio | eff) Unit


## Module Audio.WebAudio.AudioContext

### Values

    connect :: forall m n wau eff. (AudioNode m, AudioNode n) => m -> n -> Eff (wau :: WebAudio | eff) Unit

    createBufferSource :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) AudioBufferSourceNode

    createGain :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) GainNode

    createMediaElementSource :: forall elt wau dom eff. AudioContext -> elt -> Eff (wau :: WebAudio | eff) MediaElementAudioSourceNode

    createOscillator :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) OscillatorNode

    currentTime :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) Number

    decodeAudioData :: forall wau e f
                     . AudioContext
                    -> String
                    -> (AudioBuffer -> Eff (wau :: WebAudio | e) Unit)  -- success
                    -> (String -> Eff (console :: CONSOLE | e) Unit) -- failure (warn, log, etc.)
                    -> Eff (wau :: WebAudio | f) Unit

    destination :: forall wau eff. AudioContext -> Eff (wau :: WebAudio | eff) DestinationNode

    makeAudioContext :: forall wau eff. Eff (wau :: WebAudio | eff) AudioContext


## Module Audio.WebAudio.AudioParam

### Values

    cancelScheduledValues :: forall wau eff. Number -> AudioParam -> Eff (wau :: WebAudio | eff) Number

    exponentialRampToValueAtTime :: forall wau eff. Number -> Number -> AudioParam -> Eff (wau :: WebAudio | eff) Number

    getValue :: forall wau eff. AudioParam -> Eff (wau :: WebAudio | eff) Number

    linearRampToValueAtTime :: forall wau eff. Number -> Number -> AudioParam -> Eff (wau :: WebAudio | eff) Number

    setValue :: forall wau eff. Number -> AudioParam -> Eff (wau :: WebAudio | eff) Unit

    setValueAtTime :: forall wau eff. Number -> Number -> AudioParam -> Eff (wau :: WebAudio | eff) Number


## Module Audio.WebAudio.DestinationNode

### Type Class Instances

    instance audioNodeDestinationNode :: AudioNode DestinationNode


## Module Audio.WebAudio.GainNode

### Type Class Instances

    instance audioNodeGainNode :: AudioNode GainNode


### Values

    gain :: forall wau eff. GainNode -> Eff (wau :: WebAudio | eff) AudioParam


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

    frequency :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) AudioParam

    oscillatorType :: forall wau eff. OscillatorNode -> Eff (wau :: WebAudio | eff) OscillatorType

    readOscillatorType :: String -> OscillatorType

    setOscillatorType :: forall wau eff. OscillatorType -> OscillatorNode -> Eff (wau :: WebAudio | eff) Unit

    startOscillator :: forall wau eff. Number -> OscillatorNode -> Eff (wau :: WebAudio | eff) Unit

    stopOscillator :: forall wau eff. Number -> OscillatorNode -> Eff (wau :: WebAudio | eff) Unit


## Module Audio.WebAudio.Types

### Types

    data AudioBuffer :: *

    data AudioBufferSourceNode :: *

    data AudioContext :: *

    data AudioParam :: *

    data DestinationNode :: *

    data GainNode :: *

    data MediaElementAudioSourceNode :: *

    data OscillatorNode :: *

    data WebAudio :: !


### Type Classes

    class AudioNode n where


## Module Audio.WebAudio.Utils

### Values

    unsafeGetProp :: forall obj val eff. String -> obj -> Eff eff val

    unsafeSetProp :: forall obj val eff. String -> obj -> val -> Eff eff Unit
