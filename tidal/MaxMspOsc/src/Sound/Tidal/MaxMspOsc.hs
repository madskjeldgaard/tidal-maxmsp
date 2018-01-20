module Sound.Tidal.MaxMspOsc where

import Sound.Tidal.Context
import Sound.Tidal.Scales
import Sound.Tidal.Chords
import Sound.Tidal.OscStream
--
-- Send OSC via TIDAL
-- taken from: http://ask.tidalcycles.org/question/367/how-to-define-a-custom-osc-message/
-- 

maxmspShape = Shape {
  -- Define the parameters. The first bit is the type - S for
  -- string, F for float, I for integer. The second part is the
  -- name of the parameter. The third is the default value for the
  -- parameter (only used if 'namedParams' defined below is set to
  -- 'False', so set to Nothing here).
  params = [
            I "note" Nothing,
            F "param1" Nothing,
            F "velocity" (Just 1),
            F "param2" Nothing,
            F "param3" Nothing,
            F "param4" Nothing,
            F "param5" Nothing,
            F "param6" Nothing,
            F "param7" Nothing,
            F "param8" Nothing,
            F "warp" Nothing,
            F "fold" Nothing,
            F "filterenv" Nothing,
            F "pitchenv" Nothing,
            F "lfo1" Nothing,
            F "lfo2" Nothing,
            F "lfo3" Nothing
           ],
  -- Whether to add the current cycles per second to the message
  cpsStamp = True,
  -- How far ahead of time to send the message 
  latency = 0
  }
  --
maxmspSlang streamNo = OscSlang {
  -- the OSC 'path'
  path = "/fromTidal/" ++ (show streamNo), -- Will become something like /fromTidal/1 or /fromTidal/2 etc
  -- Whether to timestamp the message with
  -- its logical time - can be 'BundleStamp'
  -- (put in a timestamped bundle),
  -- 'MessageStamp' (put in the message
  -- parameters), or 'NoStamp' (don't timestamp)
  timestamp = NoStamp,
  -- Whether to interleave the parameter
  -- names in the message. If this isn't
  -- set, all parameters will be sent, using
  -- defaults set above if they're not
  -- given in a tidal pattern
  namedParams = True,
  -- Parameters to stick on the beginning of
  -- a message
  preamble = []
  }
-- a function to start your OSC stream, where "127.0.0.1" is the
-- target host and 7000 the port number
maxmspStream targetip targetport streamNo = do
    s <- makeConnection targetip targetport (maxmspSlang streamNo)
    stream (Backend s $ (\_ _ _ -> return ())) maxmspShape
-- pattern parameter functions, where makeS is for string, makeF for floats, and so on.
-- Many parameter functions are already defined and don't need re-defining, see here:
-- https://github.com/tidalcycles/Tidal/blob/master/Sound/Tidal/Params.hs
--
warp = makeF maxmspShape "warp"
fold = makeF maxmspShape "fold"
filterenv = makeF maxmspShape "filterenv"
pitchenv = makeF maxmspShape "pitchenv"
lfo1 = makeF maxmspShape "lfo1"
lfo2 = makeF maxmspShape "lfo2"
lfo3 = makeF maxmspShape "lfo3"
--
param1 = makeF maxmspShape "param1"
param2 = makeF maxmspShape "param2"
param3 = makeF maxmspShape "param3"
param4 = makeF maxmspShape "param4"
param5 = makeF maxmspShape "param5"
param6 = makeF maxmspShape "param6"
param7 = makeF maxmspShape "param7"
param8 = makeF maxmspShape "param8"
