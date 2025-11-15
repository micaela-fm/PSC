/*
int64_t reverse(uint64_t value)
*/

	.text
	.global	reverse
reverse:
	xor		%rax, %rax	# initialize with 0
	mov		$64, %rcx	# counter
while:
	shl		$1, %rdi	# msb to carry
	rcr		$1, %rax	# carry to msb
	dec		%rcx
	jnz		while		# ends when rcx == 0
	ret

	.section	.note.GNU-stack
