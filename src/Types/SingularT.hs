{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Types.SingularT
  ( SingularT (..)
  , s'
  ) where


import qualified Data.Aeson as Aeson
import Data.Aeson ((.=))
import Data.Text (pack)
import GHC.Generics
import Text.Printf (printf)


newtype SingularT a = Singular a deriving (Generic)

s' :: a -> SingularT a
s' = Singular

instance Show a => Show (SingularT a) where
  show (Singular a) = printf "(s' %s)" $ show a

instance Show a => Aeson.ToJSON (SingularT a) where
  toJSON (Singular a) = Aeson.object ["type" .= (pack . show $ a)]

instance Enum a => Aeson.FromJSON (SingularT a) where
  parseJSON _ = pure . Singular $ (toEnum 0)
