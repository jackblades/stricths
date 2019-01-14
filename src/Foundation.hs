module Foundation (module X, P.undefined, P.IO, String) where

import Prelude as P (undefined, IO)

-- APPLICATIONS pre-defined
import Application.RSMXT as X

-- IO stuff
import Data.Text.IO as X

-- STRING stuff
import Data.Text as X (Text)

import Data.ByteString as X (ByteString)
import Data.Text.Encoding as X 
    ( encodeUtf8
    , encodeUtf16LE
    , encodeUtf16BE
    , encodeUtf8Builder
    , encodeUtf8BuilderEscaped
    -- decoding functions
    , decodeUtf8  -- TODO this throws an exception, convert to reasonable failure
    , decodeUtf8With
    , decodeUtf16LE
    , decodeUtf16LEWith
    , decodeUtf16BE
    , decodeUtf16BEWith
    -- streaming decoding
    , streamDecodeUtf8With
    )

-- DATA stuff
import Data.Either as X
import Data.Tuple as X
import Data.List as X
import Data.Vector as X
import Data.Map as X

-- CONTROL stuff
import Class.Functor as X
import Class.Applicative as X
import Class.Monad as X

-- module declarations
type String = Text

id x = x