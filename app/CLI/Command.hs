
module CLI.Command 
  ( Command 
  , commandParser
  ) where


import Options.Applicative 


import qualified CLI.Command.Compile as Compile
  ( Command, parser, parserInfo
  )
import qualified CLI.Command.Run as Run
  ( Command, parser, parserInfo
  )



data Command = 
    Compile Compile.Command
  | Run Run.Command
  deriving (Eq, Show)


-- | Command Parser
commandParser :: Parser Command
commandParser = hsubparser ( 
     command "build" (info (Compile <$> Compile.parser) Compile.parserInfo)
  <> command "run" (info (Run <$> Run.parser) Run.parserInfo)
  )
  where
    htmlInfo =
         fullDesc
      <> progDesc "Generate HTML documenation for a schema."
      <> header    "HTML Generation"

