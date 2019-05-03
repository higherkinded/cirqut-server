module Typeclasses.Entity
  ( Entity (..)
  ) where


import Data.Text
import Types.Meta


class Entity a where
  id        :: a -> Text
  namespace :: a -> Text
  name      :: a -> Text
  meta      :: a -> [RawMeta]
