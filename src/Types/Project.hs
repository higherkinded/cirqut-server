module Types.Project
  ( Project (..)
  ) where

import Types.EntityT
import Types.SingularT

data Project = Project deriving (Enum, Eq, Show)
