from pathlib import Path
import sys

# To obtain modules from LowLevel
if Path(__file__).resolve().parents[3].exists():
    sys.path.append(str(Path(__file__).resolve().parents[3]))
