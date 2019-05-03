{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections     #-}
module Application.Configuration.Discover
  ( discover
  , load
  , loadConfig
  , getStatus
  , getPath
  , getResult
  ) where

import Control.Exception
import Data.Aeson
import Data.List            (intercalate)
import Data.List.Split      (splitOn)
import Data.Monoid          ((<>))
import Data.Text            (pack)
import System.Directory     (doesFileExist)
import System.Environment   (getExecutablePath, getEnv)
import Util.Sugar           (if')
import Util.Log

import qualified Data.ByteString.Lazy as BS


-- | @ResolutionStatus@ denotes the result of configuration resolution attempt.
data ResolutionStatus = NoFile
                      | CantReadFile
                      | MalformedFile
                      | SuccessfulResolution
                      deriving (Show, Eq)


{-|
  @Resolution@ contains 'ResolutionStatus', searched configuration file name
  and the result of computation of variable type @a@.
-}
data Resolution a = MkR ResolutionStatus FilePath a
  deriving (Show, Eq)


{-|
  Tries to discover a configuration file given the name/relative location.
  Initially tries to search in the location pointed at by CIRQUT_HOME
  environment variable. If it isn't set, assumes that app is using dense
  configuration scheme and searches relative to executable.
-}
discover :: FilePath -> IO (Maybe FilePath)
discover path = do
  prefix <- catch
    (getEnv "CIRQUT_HOME")
    (const $ getExecutablePath :: IOException -> IO FilePath)
  let location = ("/" <>)
        . intercalate "/"
        . (<> [path])
        . init
        . filter (/="")
        . splitOn "/"
        $ prefix
  logEvent $ "Trying to resolve configuration at path " <> (pack$show location)
  res <- (\x -> if' x (Just location) Nothing) <$> doesFileExist location
  if' (res == Nothing)
    (warnEvent "Can't find configuration file")
    (logEvent  "Successfully resolved configuration file")
  return res


{-|
  Tries to load the contents of configuration file given the name/relative
  location. Uses @discover@ to find the files, tries to read the file, returs
  the result of this attempt.
-}
load :: FilePath -> IO (Resolution BS.ByteString)
load confPath = do
  loc <- maybe "" id <$> discover confPath
  if loc /= ""
    then catch
         (MkR SuccessfulResolution confPath <$> BS.readFile loc)
         (const $ do { warnEvent "Cannot read configuration file!"
                     ; pure $ MkR CantReadFile loc ""
                     } :: IOException
                       -> IO (Resolution BS.ByteString))
    else return $ MkR NoFile confPath ""


{-|
  @load@s a configuration file and tries to parse it. If it fails, configuration
  payload is substituted by a default value.
-} 
loadConfig :: FromJSON a => a -> FilePath -> IO (Resolution a)
loadConfig defaultValue confPath = do
  confRes <- load confPath
  case confRes of
    MkR NoFile p _ ->
      warnEvent "Can't find configuration file" >>
      (return $ MkR NoFile p defaultValue)
    MkR CantReadFile p _ ->
      warnEvent "Can't read configuration file" >>
      (return $ MkR CantReadFile p defaultValue)
    MkR SuccessfulResolution p a -> do
      let val = decode a
      case val of
        Just b ->
          logEvent "Successfully loaded configuration file" >>
          (return $ MkR SuccessfulResolution p b)
        Nothing ->
          warnEvent ( "Can't load configuration file: " <>
                      "malformed configuration" ) >>
          (return $ MkR MalformedFile p defaultValue)
    _ -> return $ MkR MalformedFile confPath defaultValue
        

getStatus :: Resolution a -> ResolutionStatus
getStatus (MkR s _ _) = s

getPath :: Resolution a -> FilePath
getPath   (MkR _ p _) = p

getResult :: Resolution a -> a
getResult (MkR _ _ r) = r
