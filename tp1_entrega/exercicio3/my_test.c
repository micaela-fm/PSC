#include <stdio.h>
#include <stdlib.h>

typedef struct student { 
    int number; 
    char *name; 
    short grades[4]; 
} Student;

typedef struct class { 
    int class_id; 
    int length; 
    Student *students; 
} Class;

short get_student_grade(Class *class, int number, int grade_idx);

int main() {
    Student students[3] = {
        {123, "André", {18, 17, 16, 15}},
        {456, "Bruno", {10, 11, 12, 13}},
        {789, "Carla", {14, 15, 16, 17}}
    };

    Class class = {
        .class_id = 1,
        .length = 3,
        .students = students
    };

    int failures = 0;
    for (size_t i = 0; i < 5; i++)
    {
        int grade_idx = random() % 4; 
        for (size_t i = 0; i < class.length; i++)
        {
            short grade = get_student_grade(&class, class.students[i].number, grade_idx);
            if (grade != class.students[i].grades[grade_idx]) {
                printf("Test failed for student %s (number %d) for grade index %d: expected %d, got %d\n",
                class.students[i].name, class.students[i].number, grade_idx,
                class.students[i].grades[grade_idx], grade);
                failures++;
            }
        }
    }
    
    if (!failures) {
        printf("All tests passed!\n");
    }
}
