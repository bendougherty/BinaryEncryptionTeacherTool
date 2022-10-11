# BinaryEncryptionTeacherTool

Here is a link to a video demonstrating what this script is designed to do and how a teacher can use it to simplify their workflow: https://screencast-o-matic.com/watch/c36XXJVtagF

This is a small script that teachers can use in implementing a binary xor encrypting lab with their students. Instructions for students and teacher provided.

The assignment has 2 parts, each part has its own section of the script:

Part 1: Students convert their name (or part of it) into binary using utf-8 encoding, generate a random binary string equal in length to their name-string, xor the two strings together, and send the teacher a file with the result of the xor operation and the random binary string.

Part 2: Students receive an encrypted binary string (encoded in hexadecimal) and the associated random key (also encoded in hexadecimal). Students then xor the key string and the encrypted string to get a word, which they then send back to the teacher in a text document.

The script will give the user an option screen with two choices: 1) Generate encrypted words to send to students, and 2) Check files students submitted.

The script draws upon a text file called words which is a text file that contains a list of random 4 letter words which will be randomly assigned to students and encrypted. There are 100 words in the words file; users can add or edit the file to suit their own purposes. The words file must be in the same directory as the script.

The script takes one argument which is a file. The contents of the input file depends on whether the user is generating files or checking student submissions.

First the user should create a text file that has the name of each student in the class (one name per line). Names do not have to be used, any unique identifier would suffice. If two students have the same first name, the user should differentiate them by adding a last initial or numeric index (e.g. Ben1 and Ben2 or BenS and BenQ).

When the first option of the script is run using this name file as input, the script will assign each name in the name file a random word from the words file, convert the word into a 32-bit string according to its unicode value, generate a random 32-bit binary key string, xor the two strings together and create a file that is named after the student and contains the random key string and the output of the xor operation. These individual student files will be in a directory called studentfiles. This script will also generate a file in the same directory as the script called wordindex which will have each name from the name file next to the random word from the words file that was assigned to it.

The user can then email each individual file to the correct student, or compress the directory and post the compressed directory to a learning management system (LMS) and students can find their own file within the directory after they download and decompress it. The files are all small text files, so unless a user has a very large class, the directory shouldn't be that large.

Once the student receives their unique file, they have two tasks to complete: 1) decrypt the encrypted word they've been sent, and 2) generate a random binary key and use it to encrypt their own name using the xor function. The student should create a file that has the same name as the one you sent them, and in that file the student should put the plaintext decrypted word that you sent them on the first line, the random key-string they generated on the second line (encoded in hexadecimal), and the result string from encrypting their name (encoded in hexadecimal) on the third line. Then the student should send their file to the teacher. The teacher should download all files into a directory in the same directory as the script called studentsubmissions.

Once the teacher has collected the student files, the teacher can run the script with option 2 (submission checking option). The input file here should be the wordindex file that was generated when the script was run with the generation option. The script will check each student submission and generate a report that gives the student name (or other identifier chosen) and will indicate whether the word they decrypted matched the word you sent them, and whether or not their encrypted message correctly decrypted to their name.

EXAMPLES (to be added...)
