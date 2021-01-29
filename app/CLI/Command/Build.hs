
{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

{-# LANGUAGE OverloadedStrings #-}

module CLI.Command.Build
  ( Command
  , parser, parserInfo
  , build
  ) where


import Control.Monad.Except
  ( ExceptT
  , runExceptT, throwError
  )
import Data.Text (Text)
import qualified Data.Text as T
  ( toLower
  , unpack
  )


import Options.Applicative 



-- | Build command
-- Branches based on artifact type
build :: Command -> IO ()
build cmd = case cmd.artifact of
  Database -> buildDatabase cmd
  Process -> return ()


data Artifact = 
    Database
  | Process
  deriving (Eq, Show)

instance Read Artifact where
  readsPrec d s = case s of
    "db" -> [(Database, "")]
    "process" -> [(Process, "")]


data Target = 
    Source
  | Executable
  | Image
  deriving (Eq, Show)

instance Read Target where
  readsPrec d s = case s of
    "source" -> [(Source, "")]
    "exe"    -> [(Executable, "")]
    "image"  -> [(Image, "")]


data Command = Command
  { artifact      :: Artifact
  , target        :: Target
  , typesFilepath :: FilePath
  , language      :: Text
  , outputDir     :: Maybe FilePath
  }
  deriving (Eq, Show)


-- | Parser the parameters from the command line
parser :: Parser Command
parser = Command
      <$> argument auto (metavar "ARTIFACT")
      <*> option auto
          (  long "target"
          <> help "Format to compile to" )
      <*> strOption
          (  long "types"
          <> help "Path to the .proto types file" )
      <*> strOption
          (  long "lang"
          <> help "Programming language to target" )
      <*> optional (strOption
          (  long "output-dir" 
          <> help "Directory to place generated files" ))

    
parserInfo =
     fullDesc
  <> progDesc "Compile stuff"
  <> header    "Compile"



-- BUILD: DATABASE
----------------------------------------------------------------------------------------------------

buildDatabase :: Command -> IO ()
buildDatabase cmd = do
  eRes <- runExceptT $ do
    lang <- getLanguage cmd.language
    let x = lang
    return lang
  case eRes of
    Left err -> return ()
    Right lang  -> do
      putStrLn $ T.unpack lang
      putStrLn cmd.typesFilepath
      putStrLn "Success!"


-- Langauge
----------------------------------------------------------------------------------------------------

supportedLangauges :: [Text]
supportedLangauges = ["golang"]

getLanguage :: Text -> ExceptT BuildDatabaseError IO Text
getLanguage "" = throwError ErrMustSpecifyLanguage
getLanguage lang = do
  if T.toLower lang `elem` supportedLangauges
    then return lang
    else throwError $ ErrLangNotSupported lang




data BuildDatabaseError =
    ErrMustSpecifyLanguage
  | ErrMustSpecifyLanguageX
  | ErrLangNotSupported Text
