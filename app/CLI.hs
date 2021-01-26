
module CLI
  ( run 
  ) where


import Options.Applicative 


import CLI.Command (Command, commandParser)



-- | Top-level command line parser
run :: IO ()
run = execParser opts >>= runCommand
  where
  opts =
    info (helper <*> commandParser) (
         fullDesc
      <> progDesc "Parse and display Lulo specifications."
      <> header "Lulo" )


runCommand :: Command -> IO ()
runCommand _ = return ()

