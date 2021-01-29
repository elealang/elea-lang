
{-# OPTIONS_GHC -F -pgmF=record-dot-preprocessor #-}

module CLI
  ( run 
  ) where


import Options.Applicative 


import CLI.Command
  ( Command (..)
  , commandParser
  )
import qualified CLI.Command as C
  ( build
  )



-- | Top-level command line parser
run :: IO ()
run = execParser opts >>= runCommand
  where
  opts =
    info (helper <*> commandParser) (
         fullDesc
      <> progDesc "Command Line Interface for the Elea Programming Language"
      <> header "Elea" )


runCommand :: Command -> IO ()
runCommand (Compile cmd) = C.build cmd
    

