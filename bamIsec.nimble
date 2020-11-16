# Package

version       = "0.1.0"
author        = "Busk"
description   = "Simple bam intersection"
license       = "LGPL-3.0"
srcDir        = "src"
bin           = @["bamIsec"]
installExt    = @["nim"]

# Dependencies

requires "nim >= 1.0.4", "hts >= 0.3.2",  "argparse"
