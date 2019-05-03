module Types.Realm
  ( Realm (..)
  ) where

import Types.EntityT
import Types.SingularT

data Realm = Realm deriving (Enum, Eq, Show)
