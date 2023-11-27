CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

file_path="./student-submission"

if [ -e "$file_path" ]; then
    echo "File exists at $file_path"
else
    echo "File does not exist at $file_path"
    exit 1
fi

cp ./student-submission/ListExamples.java ./grading-area
cp ./TestListExamples.java ./grading-area

cd ./grading-area

javac -cp ".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar" *.java
java -cp ".;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > ./junitOutput.txt
if [ $? -eq 0 ]; then
    echo Success
else
    echo Failure
    grep -oE "Tests run: [0-9]+" junitOutput.txt 
    grep -oE "Failures: [0-9]+" junitOutput.txt 
fi
# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
