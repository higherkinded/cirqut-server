{-# LANGUAGE
    DeriveAnyClass, DeriveGeneric #-}
module Types.EntityStore
  ( EntityStore (..)
  ) where


import Database.Beam
import Types.Permissions
import Types.Meta


data EntityStore f = EntityStore
  { _permissions :: f (TableEntity PermissionT)
  , _meta        :: f (TableEntity MetafieldT)
  } deriving (Generic, Database be)
