{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types.Role
  ( RoleT (..)
  ) where


import Data.Aeson    (ToJSON, FromJSON)
import Data.Text
import Database.Beam
import GHC.Generics
import Typeclasses.Entity
import Types.Permissions
import Types.Meta


data RoleT = RoleT
  { _id          :: Text
  , _ns          :: Text
  , _name        :: Text
  , _meta        :: [RawMeta]
  , _permissions :: [PermissionId]
  , _enabled     :: Bool
  } deriving (Generic, Eq, Show)


instance ToJSON   RoleT
instance FromJSON RoleT
