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
> **Key Points**

> - Save commands in files (usually called shell scripts) for re-use.
> - bash [filename] runs the commands saved in a file.
> - $@ refers to all of a shell script’s command-line arguments.
> - $1, $2, etc., refer to the first command-line argument, the second command-line argument, etc.
> - Place variables in quotes if the values might have spaces in them.
> - Letting users decide what files to process is more flexible and more consistent with built-in Unix commands.

# Finding things
---

> Objectives

> - Use grep to select lines from text files that match simple patterns.
> - Use find to find files and directories whose names match simple patterns.
> - Use the output of one command as the command-line argument(s) to another command.
> - Explain what is meant by ‘text’ and ‘binary’ files, and why many common tools don’t handle the latter well.

`‘grep’ is a contraction of ‘global/regular expression/print’, a common sequence of operations in early Unix text editors. It is also the name of a very useful command-line program.`

The syntax 

```
grep {sometext} {somefile}
```
OR
```
grep {pattern} {file}
```

To find the word "not" in haiku.txt

```
grep not haiku.txt

---
Is not the true Tao, until
"My Thesis" not found.
Today it is not working

`By default, grep searches for a pattern in a case-sensitive way. In addition, the search pattern we have selected does not have to form a complete word`

> To restrict matches to lines containing the word ‘The’ on its own, we can give grep the `-w` option. This will limit matches to word boundaries.

```
grep -w The haiku.txt

.....................
The Tao that is seen
```

`Note that a ‘word boundary’ includes the start and end of a line, so not just letters surrounded by spaces. Sometimes we don’t want to search for a single word, but a phrase. We can also do this with grep by putting the phrase in quotes.`

```
grep -w "is not" haiku.txt

.....................
Today it is not working
```

> Another useful option is `-n`, which numbers the lines that match:

```
grep -n "it" haiku.txt

.....................
5:With searching comes loss
9:Yesterday it worked
10:Today it is not working
```

> We can combine flags
Eg. Find the lines that contain the word ‘the’. We can combine the option -w to find the lines that contain the word ‘the’ and -n to number the lines that match:

```
grep -n -w "the" haiku.txt

.....................
2:Is not the true Tao, until
6:and the presence of absence:
```

This could have also been combined with the pipe command
```
grep -n "the" haiku.txt | grep -w "the"

```

> To make the search case sensitive, we can use the flag `i`

```
grep -n -w -i "the" haiku.txt

.....................
1:The Tao that is seen
2:Is not the true Tao, until
6:and the presence of absence:
```

This can also be written as

```
grep -nwi "the" haiku.txt
```

> We can use the `v` flag to invert the search, the lines that donot contain the word "the"

```
grep -nwv "the" haiku.txt
.....................

1:The Tao that is seen
3:You bring fresh toner.
4:
5:With searching comes loss
7:"My Thesis" not found.
8:
9:Yesterday it worked
10:Today it is not working
11:Software is like that.
```

> Using the `-r` (recursive) option, grep can search for a pattern recursively through a set of files in subdirectories.

```
grep {-r} {sometext} {somedirectoty}
```

```
grep -r Yesterday . 
.....................

./haiku.txt:Yesterday it worked
./LittleWomen.txt:"Yesterday, when Aunt was asleep and I was trying to be as still as a
./LittleWomen.txt:Yesterday at dinner, when an Austrian officer stared at us and then
./LittleWomen.txt:Yesterday was a quiet day spent in teaching, sewing, and writing in my
```

> WildCards or [[Regular Expressions]]
Regular expressions are both complex and powerful; if you want to do complex searches, please look at the lesson on our [website](https://librarycarpentry.org/lc-data-intro/01-regular-expressions.html) 

As a taster, we can find lines that have an ‘o’ in the second position like this:

```
grep -E "^.o" haiku.txt

.....................
You bring fresh toner.
Today it is not working
Software is like that.
```

## The Find Command
The `find` command finds files. 

```
find {directory} {something}
```

> The first option in our list is `-type` `d` that means ‘things that are directories’

```
find . -type d
```

```.
./creatures
./alkanes
./animal-counts
./writing
```

> The option `f` is for files

```
find . -type f
```

> matching by name

```
find . -name *.txt
```
```
./numbers.txt
```
**NOTE:** shell expands wildcard characters like `*` before commands run, so the actual command that run was 

```
find . -name numbers.txt
```

The actual command should be:

```
find . -name "*.txt"
```
```
./numbers.txt
./writing/haiku.txt
./writing/LittleWomen.txt
```

> Key Points
> - find finds files with specific properties that match patterns.
> - grep selects lines in files that match patterns.
> - --help is an option supported by many bash commands, and programs that can be run from within Bash, to display more information on how to use these commands or programs.
> - man [command] displays the manual page for a given command.
> - $([command]) inserts a command’s output in place