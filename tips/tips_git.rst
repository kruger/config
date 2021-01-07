
Diff with master::

      git diff master:foo foo

Apply a diff patch from git diff::

  git apply --reject --whitespace=fix change.diff

Equivalent to `svn cat`::

  git show HEAD:CMakeLists.txt

Previous version::

  git show HEAD~1:CMakeLists.txt

Show version at particular hash::

  git show <hash>:CMakeLists.txt

Show diff with particular hash::

  git show <hash> CMakeLists.txt

Show current hash::

  git rev-parse HEAD

Show the files change in a revision::

  git show --pretty="" --name-only <hashtag>

Show which files are different between master and branch::

  git diff --name-status master..scott/ksp-ksp-tutorials

Remove files that are not part of repo::

  git clean -f -d -x

Set another upstream repo::

  git remote add upstream https://bitbucket.org/petsc/petsc


Git stash workflow::

  git stash list — list the available stashes
  git stash show  — inspect the different stashes  
  git stash apply  —  restore (potentially on top of a different commit) with
  git stash without any arguments is equivalent to git stash save. 
          A stash is by default listed as "WIP on branchname …", but you can g


Workflow - Remove file from previous commit::

         git reset --soft HEAD~1               # move all committed files back to the staging area from the previous commit, without cancelling the changes done to them.
         git reset HEAD path/to/unwanted_file  # Then reset the unwanted file(s) in order to leave them out from the commit
         git checkout -- path/to/file          # OPTIONAL:  If you want to fix it up
         git commit -c ORIG_HEAD               # commit again, you can even re-use the same commit message
         https://stackoverflow.com/questions/12481639/remove-files-from-git-commit

