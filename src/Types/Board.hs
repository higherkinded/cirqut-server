module Types.Board
  ( Board (..)
  ) where

import Types.EntityT
import Types.SingularT

data Board = Board deriving (Enum, Eq, Show)
