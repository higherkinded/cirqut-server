module Types.Row
  ( Row (..)
  ) where

import Types.EntityT
import Types.SingularT

data Row = Row deriving (Enum, Eq, Show)