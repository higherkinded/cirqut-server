module Util.Common.Identities
  ( newId
  ) where


import Data.Text
import Data.UUID
import Data.UUID.V4


newId :: IO Text
newId = toText <$> nextRandom
