# KAIST CS220: Programming Principles

## Logistics

- Instructor: [Jeehoon Kang](https://cp.kaist.ac.kr/jeehoon.kang)
- Time: Tue & Thu 10:30am-11:45am, 2021 Fall
- Place
  + ~~Terman Hall, Bldg. E11~~
  + [Zoom room](https://kaist.zoom.us/my/jeehoon.kang) (the passcode is announced at [chat](https://cp-cs220.kaist.ac.kr/#narrow/stream/15-cs220-announcement))
- Website
  + Course: https://cp-git.kaist.ac.kr/cs220/cs220
  + Chat: https://cp-cs220.kaist.ac.kr
  + Assignment: https://gg.kaist.ac.kr/course/8
- Announcement: in [issue tracker](https://cp-git.kaist.ac.kr/cs220/cs220/-/issues?label_name%5B%5D=announcement) or in [chat](https://cp-cs220.kaist.ac.kr/#narrow/stream/15-cs220-announcement)
  + We assume you read each announcement within 24 hours.
  + We strongly recommend you to watch the repository and use desktop/mobile Zulip client for prompt access to the announcements.
- TA: [Chunmyong Park](https://cp.kaist.ac.kr/chunmyong.park/) (head), [Sungsoo Han](https://cp.kaist.ac.kr/sungsoo.han/), [Jaemin Choi](https://cp.kaist.ac.kr/jaemin.choi/)
  + Office Hour: Fri 9:00am-12:00pm, Online. The URL is announced in chat. Attendance is not mandatory, but if you want to come, do so by 9:15am. See [below](#communication) for office hour policy.


### Online sessions

Due to COVID-19, we're going to conduct online sessions for this semester.
Please see the [announcement](https://cp-cs220.kaist.ac.kr/#narrow/stream/15-cs220-announcement) for more details.



## Course description

Refer to the Section 1 of the [Lecture Note](https://drive.google.com/file/d/1LQOz55myxe_cpnQyhqrsmN1dBSovNCqH/view).


### Course materials

- [Lecture Note](https://drive.google.com/file/d/1LQOz55myxe_cpnQyhqrsmN1dBSovNCqH/view):
  You're going to read the entirety of this lecture note (WIP).

- [Real-World Haskell](http://book.realworldhaskell.org/read/):
  You're going to read a significant portion of this book (Chapters 1-15, approximately).

  The book is slightly outdated, and there's [an unofficial revision](https://github.com/tssm/up-to-date-real-world-haskell).


### Prerequisites

- It is **required** that students already took courses on:

  + Basic understanding of programming (CS101)
    * You should be able to write a few programs in at least one programming language.
  + Basic understanding of mathematics (MAS101)
    * You should know what is proof and how to do it. Though you don't need to be familiar with Calculus.

  Without a proper understanding of these topics, you will highly likely struggle in this course.


## Grading & honor code

The grading scheme is ABCDF.

#### Cheating

**IMPORTANT: PAY CLOSE ATTENTION. VERY SERIOUS.**

- Cheating is including, but not limited to, the following activities:

  + *Sharing*: code, document, or any products by copying, retyping, **looking at**, or supplying a file​
  + *Describing*: verbal description of code from one person to another
  + *Coaching*: helping your friend to write a lab, line by line​
  + *Searching*: **the Web for solutions​**
  + *Copying*: code from a previous course or online solution​ (you are only allowed to use code we supply)

- Cheating doesn't include the following activities:

  + Explaining how to use systems or tools​
  + Helping others with high-level design issues

- **Cheating will be harshly punished.**

  + I will raise an issue to the School of Computing Student Committee.
  + Ignorance is no excuse.
  + So don't cheat and start working on assignments early.

- We will use sophisticated tools for detecting code plagiarism​.

  + [Google "code plagiarism detector" for images](https://www.google.com/search?q=code+plagiarism+detector&tbm=isch) and see how these tools can detect "sophisticated" plagiarisms.
    You really cannot escape my catch. Don't try plagiarism in any form.


### Programming assignments (60%)

| Number    | Due                       | Checker                      | Submission                            |                                                                      |
|-----------|---------------------------|------------------------------|---------------------------------------|----------------------------------------------------------------------|
| 1         | 2021/10/04 23:59:59 (KST) | `stack test cs220:a01-check` | https://gg.kaist.ac.kr/assignment/35/ | submit `src/A01.hs`.                                                 |
| 2         | 2021/11/12 23:59:59 (KST) | `stack test cs220:a02-check` | https://gg.kaist.ac.kr/assignment/37/ | submit `src/A02.hs`.                                                 |
| 3         | 2021/11/19 23:59:59 (KST) | `stack test cs220:a03-check` | https://gg.kaist.ac.kr/assignment/38/ | `./scripts/make-submission.sh`, and submit `target/a03.zip`.         |
| 4         | 2021/11/26 23:59:59 (KST) | `stack test cs220:a04-check` | https://gg.kaist.ac.kr/assignment/39/ | `./scripts/make-submission.sh`, and submit `target/a04.zip`.         |
| 5         | 2021/12/20 23:59:59 (KST) | `stack test cs220:a05-check` | https://gg.kaist.ac.kr/assignment/42/ | submit `src/A05.hs`.                                                 |
| 6         | 2021/12/20 23:59:59 (KST) | `stack test cs220:a06-check` | https://gg.kaist.ac.kr/assignment/43/ | `./scripts/make-submission.sh`, and submit `target/a06.zip`.         |
| ... (TBA) |                           |                              |                                       |                                                                      |

If you want to test specific test case, run commands like `stack test cs220:a02-check --test-arguments "-p unary"`.


#### Tools

Make sure you're capable of using the following development tools:

- You can connect to server by `ssh s<student-id>@cp-service.kaist.ac.kr -p13000`, e.g., `ssh s20071163@cp-service.kaist.ac.kr -p13000`.

  + **IMPORTANT: Don't try to hack. Don't try to freeze the server. Please be nice.**

  + Your initial password is `123454321`. IMPORTANT: you should change it ASAP.

  + I require you to register public SSH keys to the server. (In mid-September, we'll expire your password so that you can log in only via SSH keys.)
    See [this tutorial](https://serverpilot.io/docs/how-to-use-ssh-public-key-authentication/) for more information on SSH public key authentication.
    Use `ed25519`.

  + In your client, you may want to set your `~/.ssh/config` as follows for easier SSH access:

    ```
    Host cs220
      Hostname cp-service.kaist.ac.kr
      Port 13000
      User s20071163
    ```

    Then you can connect to the server by `ssh cs220`.

    + If you are using Visual Studio Code as your editor, you can find the location of your config file by following these steps:

      1. Installing the `Remote - SSH` extension
      1. Clicking the lower left green button on Visual Studio Code -> 'Open SSH Configuration File...'

- [Visual Studio Code](https://code.visualstudio.com/) (optional). If you prefer other editors, you're good to go.

  + Install [Haskell plugin](https://marketplace.visualstudio.com/items?itemName=haskell.haskell).

  + You can use the provided SSH server as [a remote VSCode server as described in this video](https://www.youtube.com/watch?v=TTVuUIhdn_g&list=PL5aMzERQ_OZ8RWqn-XiZLXm1IJuaQbXp0&index=3).

- [Git](https://git-scm.com/): for downloading the homework skeleton and version-controlling your
  development. If you're not familiar with Git, walk through [this
  tutorial](https://www.atlassian.com/git/tutorials).

  + **IMPORTANT**: you should not expose your work to others.
    For this purpose, you will be provided with a [Gitlab](https://cp-git.kaist.ac.kr) account (see [below](#communication)).

  + Fork this repository to your private namespace in <https://cp-git.kaist.ac.kr>; make it private; and then clone it.
    * Forking a project: https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html#creating-a-fork
    * Making the project private: https://docs.gitlab.com/ee/public_access/public_access.html#how-to-change-project-visibility
    * Cloning the project: https://docs.gitlab.com/ee/gitlab-basics/start-using-git.html

  + To get updates from the upstream, fetch and merge `upstream/main`.

    ```bash
    $ git remote add upstream ssh://git@cp-git.kaist.ac.kr:9001/cs220/cs220.git
    $ git remote -v
    origin	 ssh://git@cp-git.kaist.ac.kr:9001/<your-id>/cs220.git (fetch)
    origin	 ssh://git@cp-git.kaist.ac.kr:9001/<your-id>/cs220.git (push)
    upstream ssh://git@cp-git.kaist.ac.kr:9001/cs220/cs220.git (fetch)
    upstream ssh://git@cp-git.kaist.ac.kr:9001/cs220/cs220.git (push)
    $ git fetch upstream
    $ git merge upstream/main
    ```

  + You may push your local development to the Gitlab server.

    ```bash
    $ git push -u origin main
    ```

- [Haskell](https://www.haskell.org/): as the language of homework implementation. We chose Haskell
  because its resemblence with Mathematics greatly simplifies the theoretical development for this
  course. Read [document](https://docs.haskellstack.org/en/stable/README/) to learn how to install
  and build Haskell projects.

  + Installation (Ubuntu 20.04)

    ```bash
    curl -sSL https://get.haskellstack.org/ | sh
    stack install hlint apply-refact brittany
    ```

  + Build

    ```bash
    cd ~/Works/cs220/ # forked and cloned from <ssh://git@cp-git.kaist.ac.kr:9001/cs220/cs220.git>
    stack build
    ```

  + Documentation

    ```bash
    stack build --haddock  --open # opening web browser
    ```

  + Format

    ```bash
    ./scripts/format-refactor.sh # format source code.
    ./scripts/format-check.sh    # check if source code is formatted.
    ```

  + Downloading doc from the server
    * In the server, build the doc as instructed.
    * In the log, find out the doc directory, e.g., `/root/cs220/.stack-work/install/x86_64-linux-tinfo6/7c83cb5de22facc3f519a25aef0b48179e5d4660c6bf174acd35e18f82ab7f6b/8.10.4/doc/all`.
    * In vscode, you can browse to the doc directory, right-click it, and click "Download".
    * After downloading the directory, you can open the directory's `index.html`.

### Midterm and final exams (40%)

- Date & Time: October 21st (midterm) and December 16th (final), 09:00am-11:45am (or shorter, TBA)

- Place: online

  + You need to set up a separate camera that shows you, your hand, pencil and paper, and monitor, as in [this picture](https://user-images.githubusercontent.com/1201316/95432855-28d33800-098a-11eb-9b18-b515c34bb2e9.jpg).
    If you cannot do so, you will not be able to take this course.


### Attendance (?%)

- You should solve a quiz at the [Course Management](https://gg.kaist.ac.kr/course/8) website for each session. **You should answer to the quiz by the end of the day.**

- If you miss a significant number of sessions, you'll automatically get an F.



## Communication

### Registration

- Make sure you can log in the [chat website](https://cp-cs220.kaist.ac.kr).
  If you cannot, please see KLMS/email announcements first, and then send an email to the head TA.

- Retrieve Zoom session information at chat's [announcement stream](https://cp-cs220.kaist.ac.kr/#narrow/stream/15-cs220-announcement).

- Make sure you can log in [Gitlab](https://cp-git.kaist.ac.kr).

  + An email should have been sent to your `@kaist.ac.kr` email address for confirming the address. Please do so.
    If not, please contact the head TA in the chat.

  + Reset your password by clicking "Forgot your password?" [here](https://cp-git.kaist.ac.kr/users/sign_in).

  + Log in with your email address and the new password.
    If you cannot, please contact the head TA in the chat.

  + Assignments will be hosted here: https://cp-git.kaist.ac.kr/cs220/cs220

- Make sure you can log in the [lab submission website](https://gg.kaist.ac.kr).

  + Reset your password here: https://gg.kaist.ac.kr/accounts/password_reset/
    The email address is your `@kaist.ac.kr` address.

  + The id is your student id (e.g., 20071163).

  + Log in with your email address and the new password.
    If you cannot, please contact the head TA in the chat.

  + Sign [the honor code](https://gg.kaist.ac.kr/quiz/72/) by September 10th.
    Otherwise, you will be expelled from the class.


### Rules

- Course-related announcements and information will be posted on the
  [website](https://cp-git.kaist.ac.kr/cs220/cs220) or on the
  [Zulip announcement](https://cp-cs220.kaist.ac.kr/#narrow/stream/15-cs220-announcement).
  You are expected to read all announcements within 24 hours of their being posted. It is highly
  recommended to watch the repository so that new announcements will automatically be delivered to
  you email address.

- TBA ~~Ask questions on lab assignments in the dedicated streams ([example](https://cp-cs220.kaist.ac.kr/#narrow/stream/138-cs220-questions-homework-1))~~.
  + Don't DM to the instructor or TAs.
  + Before asking a question, search for similar ones in Zulip and Google.
  + Describe your question as detailed as possible. It should include following things:
    * Environment (OS, gcc, g++ version, and any other related program information). You can just say provided server if you use it without any changes.
    * Command(s) that you used and the result. Any logs should be formatted in code. Refer to [this](https://zulip.com/help/format-your-message-using-markdown#code).
    * Any directory or file changes you've made. If it is solution file, just describe which part of the code is modified.
    * Googling result. Search before asking, and share the keyword used for searching and what you've learned from it.
  + Properly Name your question as the topic.
  + Read [this](https://cp-git.kaist.ac.kr/cs220/cs220#communication) for more instructions.

- Ask questions on lectures in the dedicated stream (e.g., https://cp-cs220.kaist.ac.kr/#narrow/stream/4-cs220-lecture).
  + The instructions for lab assignment questions apply also to lecture questions.

- Ask your questions via [Zulip](https://cp-cs220.kaist.ac.kr/) private messages to
  [the instructor](https://cp.kaist.ac.kr/jeehoon.kang) or [the head TA](https://cp.kaist.ac.kr/chunmyong.park)
  **only if** they are either confidential or personal. Otherwise, ask questions in the
  appropriate stream. Unless otherwise specified, don't send emails to the instructor or TAs.
  Any questions failing to do so (e.g. email questions on course materials) will not be answered.

  + I'm requiring you to ask questions online first for two reasons. First, clearly writing a
    question is the first step to reach an answer. Second, you can benefit from questions and
    answers of other students.

- We are NOT going to discuss *new* questions during the office hour. Before coming to the office
  hour, please check if there is a similar question on Zulip. If there isn't, start discussion there. The agenda of the office hour will be the issues that are not
  resolved yet.

- Emails to the instructor or the head TA should begin with "CS220:" in the subject line, followed
  by a brief description of the purpose of your email. The content should at least contain your name
  and student number. Any emails failing to do so (e.g. emails without student number) will not be
  answered.

- Your Zoom name should be `<your student number> <your name>` (e.g., 20071163 강지훈).
  Change your name by referring to [this](https://support.zoom.us/hc/en-us/articles/201363203-Customizing-your-profile).

- This course is conducted in English. But you may ask questions in Korean. Then I will translate it to English.
