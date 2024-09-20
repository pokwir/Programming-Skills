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

# Exit Codes
Commands run via bash produce exit codes, which are saved into a shell variable, `$?`:

```
ls *.sh
echo $?
---
0
```
> An exit-code of 0 means that the command exited without an error.

```
ls nosuchfile.txt
echo $?
---
2
```
> `$?` only stores the exit code of the most recently run command

# Capturing Command Output in Varriables
The standard output stream of a command can be assigned to a varriable 
```
FILES=`ls *sh`
echo $FILES

---
count.sh interactive.sh variables.sh wordcount.sh
```
```
for FILE in $FILES; do echo $FILE; done
---
count.sh
interactive.sh
variables.sh
wordcount.s
```
> 👉 The command in the back ticks, `...`, is executed before the enclosing assignment command. Newer versions of bash and other shells support a clearer syntax, `$(...)`.

# Jobs and Processes

Kill a job by pressing Ctrl+C
Suspend by pressing Ctrl+Z

Unlike Ctrl-C Ctrl-Z doesnt cancel the command, suspends it. A suspended command can be restarted using the `fg (foreground)` command. 
[[count.sh]]

```
bash count.sh
---
9
10

Ctrl-Z
---
[1]+  Stopped                 bash count.sh

fg
---
11
12
```

## Passing output to another command[](https://swcarpentry.github.io/shell-novice/04-pipefilter.html#passing-output-to-another-command)

The Pipe `|` command is used to tell the shell that you would like to pass the output of the first command to the second command
```
$ sort -n lengths.txt | head -n 1

-----

9  methane.pdb
```

## Combining multiple commands
Same idea using the pipe command. We can chain multiple commands using the pipe command. We’ll start by using a pipe to send the output of `wc` to `sort`

```
$ wc -l *.sh | sort -n

----
	7 count.sh
	8 variables.sh
	10 interactive.sh
	40 wordcount.sh
	65 total
```

```
wc -l *.sh | sort -n | head -n 1
----

7 count.sh
```

![Redirects and Pipes of different commands: "wc -l *.pdb" will direct theoutput to the shell. "wc -l *.pdb > lengths" will direct output to the file"lengths". "wc -l *.pdb | sort -n | head -n 1" will build a pipeline where theoutput of the "wc" command is the input to the "sort" command, the output ofthe "sort" command is the input to the "head" command and the output of the"head" command is directed to the shell](https://swcarpentry.github.io/shell-novice/fig/redirects-and-pipes.svg)

## Tools designed to work together[](https://swcarpentry.github.io/shell-novice/04-pipefilter.html#tools-designed-to-work-together)
The key is that any program that reads lines of text from standard input and writes lines of text to standard output can be combined with every other program that behaves this way as well. 
`You can _and should_ write your programs this way so that you and other people can put those programs into pipes to multiply their power.`

> **Pipe Reading Comprehension**
>
```
$ cat animals.csv | head -n 5 | tail -n 3 | sort -r > final.txt

---
2012-11-06,rabbit,19
2012-11-06,deer,2
2012-11-05,raccoon,7
``` 

> **Pipe Construction**
> 

__Consider the list of animals in the file animals.csv as__
deer
rabbit
raccoon
rabbit
deer
fox
rabbit
bear

The `uniq` command filters out adjacent matching lines in a file. How could you extend this pipeline (using `uniq` and another command) to find out what animals the file contains (without any duplicates in their names)?
```
cut -d , -f 2 animals.csv | sort -b | uniq

---
bear
deer
fox
rabbit
raccoon
```

---
# Loops

```
# The word "for" indicates the start of a "For-loop" command
for thing in list_of_things 
#The word "do" indicates the start of job execution list
do 
    # Indentation within the loop is not required, but aids legibility
    operation_using/command $thing 
# The word "done" indicates the end of a loop
done 
```

>  **Key Points**

> - A `for` loop repeats commands once for every thing in a list.
> - Every `for` loop needs a variable to refer to the thing it is currently operating on.
> - Use `$name` to expand a variable (i.e., get its value). `${name}` can also be used.
> - Do not use spaces, quotes, or wildcard characters such as ‘*’ or ‘?’ in filenames, as it complicates variable expansion.
> - Give files consistent names that are easy to match with wildcard patterns to make it easy to select them for looping.
> - Use the up-arrow key to scroll up through previous commands to edit and repeat them.
> - Use Ctrl+R to search through the previously entered commands.
> - Use `history` to display recent commands, and `![number]` to repeat a command by number.

# Shell Scripts
---
