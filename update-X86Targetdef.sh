#!/usr/bin/env bash

# Old:
curl -O https://raw.githubusercontent.com/llvm-mirror/clang/master/include/clang/Basic/X86Target.def

# Note: as of this commit: https://github.com/llvm/llvm-project/commit/d5c28c4094324e94f6eee403022ca21c8d76998e
# llvm moved the nice feature flags from X86Target into X86Target and X86TargetParser.

# If we want to support ongoing llvm development past cooperlake, we need to refactor
# the definition parser to use the new file formats (which looks like it'll require
# maintaining more state details since we have to sync both files now?).

# For now we're just using the old format (which won't be updated anymore), but
# new CPUs aren't being added at such a huge rate of advancement where it
# matters at the moment.

# New:
#curl -O https://raw.githubusercontent.com/llvm/llvm-project/main/clang/include/clang/Basic/X86Target.def
#curl -O https://raw.githubusercontent.com/llvm/llvm-project/main/llvm/include/llvm/Support/X86TargetParser.def
