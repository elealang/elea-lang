
{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

module CLI.Command.Run
  ( Command
  , parser, parserInfo
  ) where


import Data.Text (Text)


import Options.Applicative 



newtype Command = Command Parameters
  deriving (Eq, Show)


data Parameters = Parameters
  { from :: Text
  , to   :: Text
  }
  deriving (Eq, Show)


-- | Parser the parameters from the command line
parser :: Parser Command
parser = Command <$> params
  where
    params = Parameters
      <$> strOption
          (  long "from"
          <> help "Directory of the build files" )
      <*> strOption
          (  long "to" 
          <> help "Directory to place output files" )

    
parserInfo =
     fullDesc
  <> progDesc "Run stuff"
  <> header    "Run"


