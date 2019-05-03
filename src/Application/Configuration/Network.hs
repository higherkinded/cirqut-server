{-# LANGUAGE OverloadedStrings #-}
module Application.Configuration.Network
  ( NetworkConfiguration (..)
  , defaultNC
  ) where

import Control.Applicative ((<$>))
import Data.Aeson


{-|
  Network options for the server to use.
  For defaults and schema, look for doc on 'defaultNC'.
-}
data NetworkConfiguration = NetConf
  { _port :: Int
  , _ssl  :: Bool
  } deriving (Eq, Show)


instance FromJSON NetworkConfiguration where
  parseJSON (Object a) = NetConf
    <$> a .:? "port" .!= 8100
    <*> a .:? "ssl"  .!= False


{-|
  Default 'NetworkConfiguration'.

  > {
  >   "port": 8100
  >   "ssl" : false
  > }

  Configuration file schema:

  > {
  >   "type": "object"
  >   "properties": {
  >     "port" :
  >
  >

-}
defaultNC :: NetworkConfiguration
defaultNC = NetConf
  { _port = 8100
  , _ssl  = False
  }
