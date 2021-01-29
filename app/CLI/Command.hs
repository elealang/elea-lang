
module CLI.Command 
  ( Command  (..)
  , commandParser
  , Build.build
  ) where


import Options.Applicative 


import qualified CLI.Command.Build as Build
  ( Command
  , parser, parserInfo
  , build
  )
import qualified CLI.Command.Run as Run
  ( Command, parser, parserInfo
  )



data Command = 
    Compile Build.Command
  | Run Run.Command
  deriving (Eq, Show)


-- | Command Parser
commandParser :: Parser Command
commandParser = hsubparser ( 
     command "build" (info (Compile <$> Build.parser) Build.parserInfo)
  <> command "run" (info (Run <$> Run.parser) Run.parserInfo)
  )
  where
    htmlInfo =
         fullDesc
      <> progDesc "Generate HTML documenation for a schema."
      <> header    "HTML Generation"

