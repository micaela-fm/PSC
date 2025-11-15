/*
typedef struct student { int number; char *name; short grades[4]; } Student;

typedef struct { int class_id; int length; Student *students; } Class;

short get_student_grade(Class *class, int number, int grade_idx) {
	short grade = -1;
		if (grade_idx < 4)
		for (int i = 0; i < class->length; i++)
			if (class->students[i].number == number) {
				grade = class->students[i].grades[grade_idx];
				break;
			}
	return grade;
}
*/
	.text
	.global	get_student_grade
get_student_grade:

	ret

	.section	.note.GNU-stack
