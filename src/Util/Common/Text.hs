module Util.Common.Text
  ( pshow
  ) where

import Data.Text

pshow :: Show a => a -> Text
pshow = pack . show
