# History, Bang, and FC

---

See history of run commands.

```
history
```

Bang {!}
To run the Nth command.

```
!N 
```

FC command

The fc command also displays the command in the history.

```
fc -l 10 
```

displays the 10th command run onwards

```
fc -l 10 20 
```

displays the 10th to the 20th commands run

The history, bang, and fc commands can save you from having to repeatedly retype very long
commands

To clear history, eg when you accidentally type in your password in the shell prompt

```
history -c
```

# Directories and files

---
touch
output direction
> The `cat` command with no args echos the standard outpt stream. This can be redirected with the `>` operator

```
cat > my_text.txt
```

> if an error arrises during the outpot stream. The errors doesnt go into the stream,. but into the standard error stream. To redirect the standard error stream into a file, its identifier, 2, needs to be used with the output redirection operator. For example

```
ls *.cfg 2> output.txt
```

> The default stream of `>` has an identifier of 1

```
cat 1> mytext.txt
```

> Both the standard output and standard error streams can be captured together.

```
ls *.cfg *.sh *.png > output.txt 2>&1
```

# Input Re-Direction

---
sometimes programs ask for input interactively

![](<Programing Skills/Programming-Skills-git/shell/interactive.sh>)

```
bash interactive.sh
```
> To provide the inputs without needing to type them interactively, standard input stream redirection can be used. The values to be entered can be put in a file, for example `settings.config`

``` 
nano settings.config
``` 
[[settings.config]]

```
something
4 
dogecoin
```
```
bash interactive.sh < setting.config
Enter host name:
Enter number of processors:
Enter executable:
Submitting dogecoin to run on 4 processors on something
```
> This can be combined with redirection and capture of the standard output and error streams.

```
interactive.sh < setting.config > output.txt 2>&1
cat output.txt
----
Enter host name:
Enter number of processors:
Enter executable:
Submitting dogecoin to run on 4 processors on something
```