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
	# struct Student
	.equ	number, 0
	.equ	name, 8								# number size is 4, but needs 8 byte alignment due to pointer
	.equ	grades, 16
	.equ	grades_size, 2
	.equ	student_size, 24
	# struct Class
	.equ	class_id, 0
	.equ	length, 4
	.equ	students, 8

	.text
	.global	get_student_grade
get_student_grade:
	mov		$-1, %rax							# short grade = -1
if_grade_idx:
	cmp		$4, %edx							# if (grade_idx < 4)
	jge		if_grade_idx_end
	mov 	$0, %ecx							# int i = 0
for:
	cmpl	length(%rdi), %ecx					# i < class->length
	jge		for_end
if_number:
	mov		%ecx, %r9d
	imul	student_size, %r9d					# i *= student_size, as it is not a valid scale factor
	movslq	%r9d, %r9							# index register must be quad-word
	mov		students(%rdi), %r8					# r8 = class->students pointer
	add		%r9, %r8							# r8 = students[i]
	cmpl	number(%r8), %esi					# if class->students[i].number == number
	jne		if_number_end
	movslq	%edx, %rdx							# index register must be quad-word
	movswl	grades(%r8, %rdx, grades_size), %eax	# grade = class‐>students[i].grades[grade_idx]
	movslq	%eax, %rax
	jmp		for_end								# break
if_number_end:
	inc		%ecx								# i++
	jmp		for
for_end:
if_grade_idx_end:
	ret

	.section	.note.GNU-stack
