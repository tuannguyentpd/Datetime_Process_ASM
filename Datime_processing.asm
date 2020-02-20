main:
	.data
		c0: .asciiz "\n----------Ban hay chon 1 trong cac thao tac duoi day----------\n"
		c1: .asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
		c2: .asciiz "2. Chuyen doi chuoi TIME thanh mot trong cac dinh dang sau:\n"
		c2a: .asciiz "\tA. MM/DD/YYYY\n"
		c2b: .asciiz "\tB. Month DD, YYYY\n"
		c2c: .asciiz "\tC. DD Month, YYYY\n"
		c3: .asciiz "3. Cho biet ngay vua nhap la ngay thu may trong tuan:\n"
		c4: .asciiz "4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
		c5: .asciiz "5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
		c6: .asciiz "6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi time\n"
		c7: .asciiz "7. Thoat chuong trinh\n"
		strChoose: .asciiz "\nLua chon: "
		strResult: .asciiz "\nKet qua: "
		errorChoose: .asciiz "\nLua chon sai cu phap! Vui long nhap lai lua chon: \n"
		str: .space 40
		#choose: .space 1
	.text
		la $a0, str
		jal input
		add $t0,$v0,$0
		j menu
menu: 
	la $a0,c0
	addi $v0,$0,4
	syscall
	
	la $a0,c1
	addi $v0,$0,4
	syscall
	
	la $a0,c2
	addi $v0,$0,4
	syscall
	
	la $a0,c2a
	addi $v0,$0,4
	syscall
	
	la $a0,c2b
	addi $v0,$0,4
	syscall
	
	la $a0,c2c
	addi $v0,$0,4
	syscall
	
	la $a0,c3
	addi $v0,$0,4
	syscall
	
	la $a0,c4
	addi $v0,$0,4
	syscall
	
	la $a0,c5
	addi $v0,$0,4
	syscall
	
	la $a0,c6
	addi $v0,$0,4
	syscall
	
	la $a0,c7
	addi $v0,$0,4
	syscall
	
	la $a0,strChoose
	addi $v0,$0,4
	syscall	
loopChoose:
	#la $a0,choose
	#addi $a1,$0,1
	addi $v0,$0,12
	syscall
	
	addi $t1,$0,49
	beq $v0,$t1,C1
	
	addi $t1,$0,50
	beq $v0,$t1,C2
	
	addi $t1,$0,51
	beq $v0,$t1,C3
	
	addi $t1,$0,52
	beq $v0,$t1,C4
	
	addi $t1,$0,53
	beq $v0,$t1,C5
	
	addi $t1,$0,54
	beq $v0,$t1,C6
	
	addi $t1,$0,55
	beq $v0,$t1,C7
	
	la $a0,errorChoose
	addi $v0,$0,4
	syscall
	j loopChoose
#=================================
C1: 
	la $a0,strResult
	addi $v0,$0,4
	syscall
	
	add $a0,$t0,$0
	syscall
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	j menu
C2:	
	addi $a0,$0,10
	addi $v0,$0,11
	syscall
	
	la $a0,c2a
	addi $v0,$0,4
	syscall
	
	la $a0,c2b
	syscall
	
	la $a0,c2c
	syscall

loopC2:
	la $a0,strChoose
	addi $v0,$0,4
	syscall
	
	addi $v0,$0,12#nhap ki tu
	syscall
	
	addi $t1,$0,65#A
	beq $v0,$t1, continueC2
	
	addi $t1,$0,66#B
	beq $v0,$t1, continueC2
	
	addi $t1,$0,67#C
	beq $v0,$t1, continueC2
	
	j loopC2
continueC2:
	la $a0,strResult
	addi $v0,$0,4
	syscall
	#######
	add $a0,$t0,$0
	add $a1,$t1,$0### gan gia tri choose
	
	jal Convert
	
	add $a0,$v0,$0
	addi $v0,$0,4
	syscall
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	j menu
C3:
	.data
		strIs: .asciiz ": is "
	.text
	
	addi $a0,$0,10
	addi $v0,$0,11
	syscall
	
	add $a0,$t0,$0
	addi $v0,$0,4
	syscall
	
	la $a0,strIs
	addi $v0,$0,4
	syscall
	
	add $a0,$t0,$0
	jal Weekday
	
	add $a0,$v0,$0
	add $v0,$0,4
	syscall
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	j menu
C4:
	.data
		strLeapYear: .asciiz ": La nam nhuan.\n"
		strNotLeapYear: .asciiz ": Khong phai nam nhuan.\n"
	.text
	
	addi $a0,$0,10
	addi $v0,$0,11
	syscall
	
	add $a0,$t0,$0
	addi $v0,$0,4
	syscall
	
	add $a0,$t0,$0
	jal LeapYear
	beq $v0,$0,printNotStrLeapYear
	la $a0,strLeapYear
	addi $v0,$0,4
	syscall
	j end_C2
printNotStrLeapYear:
	la $a0,strNotLeapYear
	addi $v0,$0,4
	syscall
end_C2:
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	j menu
C5:
	.data
		strDate2: .asciiz "\nMoi ban nhap Date thu 2: "
		str2: .space 40
		strDistance: .asciiz "\nKhoang cach so nam la: "
	.text
	
	addi $sp,$sp,-4
	sw $t1,0($sp)
	
	la $a0,strDate2
	addi $v0,$0,4
	syscall
	
	la $a0,str2
	jal input
	add $t1,$v0,$0
	
	la $a0,strDistance
	addi $v0,$0,4
	syscall
	
	#t0: time1, t1: time2
	
	add $a0,$t0,$0
	add $a1,$t1,$0
	jal GetTime
	
	add $a0,$v0,$0
	addi $v0,$0,1
	syscall
	
	lw $t1,0($sp)
	addi $sp,$sp,4
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	j menu
C6:
	
	.data
		strNext: .asciiz ": Co 2 nam nhuan gan nhat la: "
	.text
	addi $a0,$0,10
	addi $v0,$0,11
	syscall
	
	add $a0,$t0,$0
	addi $v0,$0,4
	syscall
	
	la $a0,strNext
	addi $v0,$0,4
	syscall
	
	add $a0,$t0,$0
	jal twoNearestLeapYear
	
	addi $a0,$0,2000
	addi $v0,$0,32
	syscall
	
	j menu
C7:
	addi $v0,$0,10
	syscall
#=======================================================
input:
	.data
		strDay: .asciiz "\nNhap ngay DAY: "
		strMonth: .asciiz "Nhap thang MONTH: "
		strYear: .asciiz "Nhap nam YEAR: "
		strAgain: .asciiz "\nNhap sai! Moi ban nhap lai: \n"
		temp: .space 40
	.text
		addi $sp,$sp,-36
		sw $ra,0($sp)
		sw $a0,4($sp)
		sw $a1,8($sp)
		sw $t0,12($sp)
		sw $t1,16($sp)
		sw $t2,20($sp)
		sw $t3,24($sp)
		sw $t4,28($sp)
		sw $t5,32($sp)
		
inputDay:
	la $a0,strDay
	addi $v0,$0,4
	syscall
	
	la $a0,temp
	addi $a1,$0,10
	addi $v0,$0,8
	syscall
		
	add $t0,$a0,$0	#$t0: Day
loopDay:
	lb $t1,0($a0)
	addi $t2,$0,10 # endline
	beq $t1,$t2,outDay
	slti $t3,$t1,48
	bne $t3,$0,errorDay
	slti $t3,$t1,58
	beq $t3,$0,errorDay
	addi $a0,$a0,1
	j loopDay
errorDay:
	la $a0,strAgain
	addi $v0,$0,4
	syscall
	j inputDay
outDay:
	add $a0,$t0,$0
	jal atoi
	add $t4,$v0,$0 #$t4: int(Day)
inputMonth:
	la $a0,strMonth
	addi $v0,$0,4
	syscall
	
	la $a0,temp
	addi $a1,$0,10
	addi $v0,$0,8
	syscall
	
	add $t0,$a0,$0 #t0: Month
loopMonth:
	lb $t1,0($a0)
	addi $t2,$0,10 # endline
	beq $t1,$t2,outMonth
	slti $t3,$t1,48
	bne $t3,$0,errorMonth
	slti $t3,$t1,58
	beq $t3,$0,errorMonth
	addi $a0,$a0,1
	j loopMonth
errorMonth:
	la $a0,strAgain
	addi $v0,$0,4
	syscall
	j inputMonth
outMonth:
	add $a0,$t0,$0
	jal atoi
	add $t5,$v0,$0 #$t5: int(Month)
#=========================================
inputYear:
	la $a0,strYear
	addi $v0,$0,4
	syscall
	
	la $a0,temp
	addi $a1,$0,10
	addi $v0,$0,8
	syscall
	
	add $t0,$a0,$0 #t0: Year
loopYear:
	lb $t1,0($a0)
	addi $t2,$0,10 # endline
	beq $t1,$t2,outYear
	slti $t3,$t1,48
	bne $t3,$0,errorYear
	slti $t3,$t1,58
	beq $t3,$0,errorYear
	addi $a0,$a0,1
	j loopYear
errorYear:
	la $a0,strAgain
	addi $v0,$0,4
	syscall
	j inputYear
outYear:
	add $a0,$t0,$0
	jal atoi
	
	.data
		string: .space 20
	.text 
		#
		add $a0,$t4,$0
		add $a1,$t5,$0
		add $a2,$v0,$0
		
		jal checkDate
		
		beq $v0,$0,errorDay
		
		#
		lw $a3,4($sp)
		
		jal Date
		
		lw $ra,0($sp)
		lw $a0,4($sp)
		lw $a1,8($sp)
		lw $t0,12($sp)
		lw $t1,16($sp)
		lw $t2,20($sp)
		lw $t3,24($sp)
		lw $t4,28($sp)
		lw $t5,32($sp)
		addi $sp,$sp,36
		jr $ra
#=======================================================
#char* Date(int day,int month,int year,char* time)
#output: DD/MM/YYYY or "\0"
Date:
	addi $sp,$sp,-24
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $t0,12($sp)
	sw $t1,16($sp)
	sw $t2,20($sp)
	
	addi $t0,$0,10 #so chia
	addi $t1,$0,47 #'/'
	
	div $a0,$t0
	mflo $t2
	addi $t2,$t2,48
	sb $t2,0($a3)
	mfhi $t2
	addi $t2,$t2,48
	sb $t2,1($a3)
	sb $t1,2($a3)#DD/
	
	div $a1,$t0
	mflo $t2
	addi $t2,$t2,48
	sb $t2,3($a3)
	mfhi $t2
	add $t2,$t2,48
	sb $t2,4($a3)
	sb $t1,5($a3)#DD/MM/
	
	add $t0,$a3,$0
	addi $a3,$a3,6#...YYYY
.data
	tmp: .space 10
.text
	la $a0,tmp
	add $a1,$a2,$0
	jal itoa# chuyen year -> str
loopDate:
	lb $t1,0($v0)
	beq $t1,$0,out_loopDate
	sb $t1,0($a3)
	addi $v0,$v0,1
	addi $a3,$a3,1
	j loopDate
out_loopDate:
	sb $0,0($a3)# ghi ki tu '\0' vao $a3
	add $v0,$t0,$0
end_Date:
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $t0,12($sp)
	lw $t1,16($sp)
	lw $t2,20($sp)
	addi $sp,$sp,24
	jr $ra
#=======================================================
#int checkDate(int,int,int)
#input: day, month, year
#output: 1/0
checkDate:
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $a0,12($sp)
	
	#slt $t0,$0,$a0
	#beq $t0,$0,errorDate				

	#slt $t0,$0,$a1
	#beq $t0,$0,errorDate	
	
	beq $a0,$0,errorDate
	beq $a1,$0,errorDate
	
	slti $t0,$a1,13
	beq $t0,$0,errorDate
	
	add $t1,$a0,$0
	add $a0,$a2,$0 			#$a2: year
	
	jal numDayOfMonth
	
	slt $t0,$v0,$t1
	bne $t0,$0,errorDate
	
	addi $v0,$0,1
	j end_CheckDate
errorDate:
	add $v0,$0,$0
end_CheckDate:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $a0,12($sp)
	addi $sp,$sp,16
	jr $ra
#=======================================================
#=======================================================
#int numDayOfMonth(year, month)
#tra ve so ngay cua thang
numDayOfMonth:
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $a1,8($sp)
	
	addi $t0,$0,1
	beq $a1,$t0, Day31
	
	addi $t0,$0,2
	beq $a1,$t0, Day28or29
	
	addi $t0,$0,3
	beq $a1,$t0, Day31
	
	addi $t0,$0,4
	beq $a1,$t0, Day30
	
	addi $t0,$0,5
	beq $a1,$t0, Day31
	
	addi $t0,$0,6
	beq $a1,$t0, Day30
	
	addi $t0,$0,7
	beq $a1,$t0, Day31
	
	addi $t0,$0,8
	beq $a1,$t0, Day31
	
	addi $t0,$0,9
	beq $a1,$t0, Day30
	
	addi $t0,$0,10
	beq $a1,$t0, Day31
	
	addi $t0,$0,11
	beq $a1,$t0, Day30
	
	addi $t0,$0,12
	beq $a1,$t0, Day31
Day31:
	addi $v0,$0,31
	j end_numDayOfMonth
Day30:
	addi $v0,$0,30
	j end_numDayOfMonth
Day28or29:
	jal isLeapYear
	addi $v0,$v0,28
end_numDayOfMonth:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $a1,8($sp)
	addi $sp,$sp,12
	jr $ra
#=======================================================
# int isLeapYear(int year)
# ouput: 1 neu la nam nhuan, 0 neu ko nhuan
isLeapYear:
	addi $sp,$sp,-8
	sw $t0,0($sp)
	sw $t1,4($sp)
	
	addi $t0,$0,400
	div $a0,$t0
	mfhi $t1
	beq $t1,$0,trueLeapYear
	
	addi $t0,$0,100
	div $a0,$t0
	mfhi $t1
	beq $t1,$0,falseLeapYear
	
	addi $t0,$0,4
	div $a0,$t0
	mfhi $t1
	bne $t1,$0,falseLeapYear
trueLeapYear:
	addi $v0,$0,1
	j end_isLeapYear
falseLeapYear:
	add $v0,$0,$0
end_isLeapYear:
	lw $t0,0($sp)
	lw $t1,4($sp)
	addi $sp,$sp,8
	jr $ra
#=======================================================
#int LeapYear(char* TIME)
#output: 1 neu la nam nhuan /0 neu nam khong nhuan
LeapYear:
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $a0,4($sp)
	
	jal Year
	
	add $a0,$v0,$0
	
	jal isLeapYear
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	addi $sp,$sp,8
	jr $ra
#=======================================================
#char* Convert(char* dd/mm/yy, char A/B/C)
#output: MM/DD/YYYY if A
#	 Month DD, YYYY if B
#	 DD Month, YYYY if C
Convert:
	addi $sp,$sp,-24
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $a1,8($sp)
	sw $t0,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
	
	addi $t0,$0,65
	beq $a1,$t0,C2A#bug t1#a1
	
	addi $t0,$0,66
	beq $a1,$t0,C2B
	
	addi $t0,$0,67
	beq $a1,$t0,C2C

C2A:
.data 
	adate: .space 30
.text	
	la $v0,adate
	
	lb $t0,3($a0)
	sb $t0,0($v0)
	
	lb $t0,4($a0)
	sb $t0,1($v0)
	
	lb $t0,2($a0)
	sb $t0,2($v0)
	
	lb $t0,0($a0)
	sb $t0,3($v0)
	
	lb $t0,1($a0)
	sb $t0,4($v0)
	
	lb $t0,5($a0)
	sb $t0,5($v0)
	
	add $t1,$v0,$0
	addi $a0,$a0,6
	addi $v0,$v0,6
	j getYear
C2B:
.data 
	bdate: .space 10
.text	
	jal Month
	add $a0,$v0,$0
	jal textMonth
	add $t0,$v0,$0
	
	la $v0,bdate
	add $t1,$v0,$0
loop_C2B:
	lb $t2,0($t0)
	beq $t2,$0,out_loop_C2B
	sb $t2,0($v0)
	addi $t0,$t0,1
	addi $v0,$v0,1
	j loop_C2B
out_loop_C2B:
	lw $a0,4($sp)
	
	addi $t3,$0,32
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	lb $t3,0($a0)
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	lb $t3,1($a0)
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $t3,$0,44
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $t3,$0,32
	sb $t3,0($v0)
	
	addi $v0,$v0,1
	addi $a0,$a0,6
	j getYear	
C2C:
.data 
	cdate: .space 10
.text	
	jal Month
	add $a0,$v0,$0
	jal textMonth
	add $t0,$v0,$0
	
	la $v0,cdate
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	lb $t2,0($a0)
	sb $t2,0($v0)
	
	lb $t2,1($a0)
	sb $t2,1($v0)
	
	addi $t2,$0,32
	sb $t2,2($v0)
	
	addi $v0,$v0,3
loop_C2C:
	lb $t2,0($t0)
	beq $t2,$0,out_loop_C2C
	sb $t2,0($v0)
	addi $t0,$t0,1
	addi $v0,$v0,1
	j loop_C2C
out_loop_C2C:
	addi $t2,$0,44
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $t2,$0,32
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $a0,$a0,6
getYear:
	lb $t2,0($a0)
	beq $t2,$0,end_Convert
	sb $t2,0($v0)
	addi $v0,$v0,1
	addi $a0,$a0,1
	j getYear
end_Convert:
	sb $0,0($v0)
	add $v0,$t1,$0

	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $a1,8($sp)
	lw $t0,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	
	addi $sp,$sp,24
	jr $ra
#======================================================
#int Day(char* DD/MM/YYYY)
#output: tra ve int(Day)
Day:	
.data
	day: .space 10
.text
	addi $sp,$sp,-8
	sw $ra,0($sp)
	sw $a0,4($sp)
	
	add $t0,$a0,$0
	la $v0,day
	
	lb $t1,0($t0)
	sb $t1,0($v0)
	
	lb $t1,1($t0)
	sb $t1,1($v0)
	
	#sb $0,2($v0) 

	add $a0,$v0,$0
	jal atoi
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	addi $sp,$sp,8
	jr $ra
#int Month(char* DD/MM/YYYY)
#output: tra ve int(Month)
Month:
.data
	month: .space 10
.text
	addi $sp,$sp,-12
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $t1,8($sp)
	
	add $t0,$a0,$0
	la $v0,month
	
	lb $t1,3($t0)
	sb $t1,0($v0)
	
	lb $t1,4($t0)
	sb $t1,1($v0) 

	add $a0,$v0,$0
	jal atoi
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $t1,8($sp)
	addi $sp,$sp,12
	jr $ra
#int Year(char* DD/MM/YYYY)
#output: tra ve int(Year)
Year: 
.data
	year: .space 10
.text
	addi $sp,$sp,-24
	sw $ra,0($sp)
	sw $a0,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)

	add $t0,$a0,$0
	la $a0,year
	add $t1,$a0,$0
	addi $t2,$0,10
	addi $t0,$t0,6
loop_Year:
	lb $t3,0($t0)
	beq $t3,$0,outLoopYear
	beq $t3,$t2,outLoopYear
	sb $t3,0($a0)
	addi $t0,$t0,1
	addi $a0,$a0,1
	j loop_Year	
outLoopYear:
	sb $0,0($a0)
	add $a0,$t1,$0
	jal atoi
	
	lw $ra,0($sp)
	lw $a0,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	addi $sp,$sp,24
	jr $ra
#========================================================
#char* textMonth(int month)
#output: ten cua thang bang tieng anh
textMonth:
	addi $sp,$sp,-8
	sw $t0,0($sp)
	sw $a0,4($sp)
	
	add $t0,$0,1
	beq $a0,$t0,January
	
	add $t0,$0,2
	beq $a0,$t0,February
	
	add $t0,$0,3
	beq $a0,$t0,March
	
	add $t0,$0,4
	beq $a0,$t0,April
	
	add $t0,$0,5
	beq $a0,$t0,May
	
	add $t0,$0,6
	beq $a0,$t0,June
	
	add $t0,$0,7
	beq $a0,$t0,July
	
	add $t0,$0,8
	beq $a0,$t0,August
	
	add $t0,$0,9
	beq $a0,$t0,September
	
	add $t0,$0,10
	beq $a0,$t0,October
	
	add $t0,$0,11
	beq $a0,$t0,November
	
	add $t0,$0,12
	beq $a0,$t0,December
	
January:
	.data
		jan: .asciiz "January"
	.text
		la $v0,jan
		j endTextMonth	
February:
	.data
		feb: .asciiz "February"
	.text
		la $v0,feb
		j endTextMonth
March:
	.data
		mar: .asciiz "March"
	.text
		la $v0,mar
		j endTextMonth
April:
	.data
		apr: .asciiz "April"
	.text
		la $v0,apr
		j endTextMonth
May:
	.data
		may: .asciiz "May"
	.text
		la $v0,may
		j endTextMonth
June:
	.data
		jun: .asciiz "June"
	.text
		la $v0,jun
		j endTextMonth
July:
	.data
		jul: .asciiz "July"
	.text
		la $v0,jul
		j endTextMonth
August:
	.data
		aug: .asciiz "August"
	.text
		la $v0,aug
		j endTextMonth
September:
	.data
		sep: .asciiz "September"
	.text
		la $v0,sep
		j endTextMonth
October:
	.data
		oct: .asciiz "October"
	.text
		la $v0,oct
		j endTextMonth
November:
	.data
		nov: .asciiz "November"
	.text
		la $v0,nov
		j endTextMonth
December:
	.data
		dec: .asciiz "December"
	.text
		la $v0,dec
		j endTextMonth
endTextMonth:
	lw $t0,0($sp)
	lw $a0,4($sp)
	addi $sp,$sp,8
	jr $ra
#=======================================================
#char* Weekday (char* TIME)
Weekday:
	addi $sp,$sp,-36
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	sw $t4,20($sp)
	sw $t5,24($sp)
	sw $t6,28($sp)
	sw $a0,32($sp)
	
	jal Month
	add $t2,$v0,$0
	
	jal Year
	add $t3,$v0,$0
	
	jal Day
	add $t1,$v0,$0
	
	slti $t4,$t2,3
	beq $t4,$0,cal_Weekday
	addi $t3,$t3,-1
	addi $t2,$t2,12
cal_Weekday:	
	add $t4,$0,$0
	add $t4,$t4,$t1 #thu += ngay
	
	addi $t5,$0,2
	mult $t5,$t2
	mflo $t5
	
	add $t4,$t4,$t5 #thu+=2*thang
	
	addi $t5,$0,3
	mult $t5,$t2
	mflo $t5 #t5=3*thang
	addi $t5,$t5,3 #t5+=3
	
	addi $t6,$0,5
	div $t5,$t6
	mflo $t5
	add $t4,$t4,$t5 #thu+=(3*thang+3)/5
	
	add $t4,$t4,$t3 #thu+=nam
	
	addi $t6,$0,4
	div $t3,$t6
	mflo $t5
	add $t4,$t4,$t5 #thu+=nam/4
	
	addi $t6,$0,7
	div $t4,$t6
	mfhi $t5 #thu %= 7
	
	add $t6,$0,$0
	beq $t5,$t6,sunday
	
	addi $t6,$0,1
	beq $t5,$t6,monday
	
	addi $t6,$0,2
	beq $t5,$t6,tuesday
	
	addi $t6,$0,3
	beq $t5,$t6,wednesday
	
	addi $t6,$0,4
	beq $t5,$t6,thursday
	
	addi $t6,$0,5
	beq $t5,$t6,friday
	
	addi $t6,$0,6
	beq $t5,$t6,saturday
	
sunday:
	.data
		sun: .asciiz "Sunday"
	.text
		la $v0,sun
		j end_Weekday
		
monday:
	.data
		mon: .asciiz "Monday"
	.text
		la $v0,mon
		j end_Weekday
		
tuesday:
	.data
		tue: .asciiz "Tuesday"
	.text
		la $v0,tue
		j end_Weekday
		
wednesday:
	.data
		wed: .asciiz "Wednesday"
	.text
		la $v0,wed
		j end_Weekday
		
thursday:
	.data
		thu: .asciiz "Thursday"
	.text
		la $v0,thu
		j end_Weekday
		
friday:
	.data
		fri: .asciiz "Friday"
	.text
		la $v0,fri
		j end_Weekday
		
saturday:
	.data
		sat: .asciiz "Saturday"
	.text
		la $v0,sat
		j end_Weekday
		
end_Weekday:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	lw $t4,20($sp)
	lw $t5,24($sp)
	lw $t6,28($sp)
	lw $a0,32($sp)
	addi $sp,$sp,36
	
	jr $ra
	
#=======================================================
#void twoNearestLeapYear(char* TIME)
twoNearestLeapYear:
	addi $sp,$sp,-32
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $a0,16($sp)
	sw $a1,20($sp)
	sw $a2,24($sp)
	sw $a3,28($sp)
.data
	tempYear: .space 40
.text 
	jal Year
	
	addi $t2,$0,3
	add $t1,$0,$0
	add $t0,$v0,$0
loop_twoNearestLeapYear:
	addi $t0,$t0,1
	
	#add $a0,$t0,$0
	#jal isLeapYear
	addi $a0,$0,1
	addi $a1,$0,1
	add $a2,$t0,$0
	la $a3,tempYear
	jal Date
	add $a0,$v0,$0	
	jal LeapYear
	
	bne $v0,$0,print_nearestLeapYear
	j loop_twoNearestLeapYear
print_nearestLeapYear:
	addi $t1,$t1,1
	beq $t1,$t2,end_twoNearestLeapYear
	add $a0,$t0,$0
	addi $v0,$0,1
	syscall
	
	#khoang trang
	addi $a0,$0,32
	addi $v0,$0,11
	syscall
	
	j loop_twoNearestLeapYear
end_twoNearestLeapYear:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $a0,16($sp)
	lw $a1,20($sp)
	lw $a2,24($sp)
	lw $a3,28($sp)
	addi $sp,$sp,32
	
	jr $ra
#=======================================================
#int GetTime (char* TIME1, char* TIME2)
#tra ve khoang cach so nam giua TIME1 va TIME2
GetTime:
	addi $sp,$sp,-32
	sw $a0,0($sp)
	sw $a1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	sw $t2,16($sp)
	sw $t3,20($sp)
	sw $t4,24($sp)
	sw $ra,28($sp)
	
	
	add $t4,$0,$0#count=0
	
	jal Year
	add $t1,$v0,$0 #t1: nam1
	
	add $a0,$a1,$0
	jal Year
	add $t2,$v0,$0#t2: nam2
	
	sub $t3,$t1,$t2
	beq $t3,$0,end_GetTime
	
	slt $t3,$t1,$t2
	bne $t3,$0,if_GetTime
	
	sub $t4,$t1,$t2
	
	lw $a0,0($sp)
	jal Month
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	jal Month
	add $t2,$v0,$0
	
	slt $t3,$t1,$t2
	bne $t3,$0,count_sub_1
	
	sub $t3,$t1,$t2
	bne $t3,$0,end_GetTime
	
	lw $a0,0($sp)
	jal Day
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	jal Day
	add $t2,$v0,$0

	slt $t3,$t1,$t2
	bne $t3,$0,count_sub_1
	
	j end_GetTime
if_GetTime:
	sub $t4,$t2,$t1
	
	lw $a0,0($sp)
	jal Month
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	jal Month
	add $t2,$v0,$0
	
	slt $t3,$t2,$t1
	bne $t3,$0,count_sub_1
	sub $t3,$t1,$t2
	bne $t3,$0,end_GetTime
	
	lw $a0,0($sp)
	jal Day
	add $t1,$v0,$0
	
	lw $a0,4($sp)
	jal Day
	add $t2,$v0,$0

	slt $t3,$t2,$t1
	bne $t3,$0,count_sub_1
	
	j end_GetTime
count_sub_1:
	addi $t4,$t4,-1
end_GetTime:
	add $v0,$t4,$0
	
	lw $a0,0($sp)
	lw $a1,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	lw $t2,16($sp)
	lw $t3,20($sp)
	lw $t4,24($sp)
	lw $ra,28($sp)
	addi $sp,$sp,32
	
	jr $ra
#=======================================================	
# int atoi(char*)
# input: $a0 la chuoi can chuyen	
# output: $v0 la gia tri nguyen cua chuoi sau khi chuyen
atoi:
	addi $sp,$sp,-20
	sw $ra,0($sp)
	sw $t0,4($sp)
	sw $t1,8($sp)
	sw $t2,12($sp)
	sw $t3,16($sp)
	
	add $v0,$0,$0
	add $t0,$a0,$0
	
	lb $t1,0($t0)

loop_atoi:
	slti $t2,$t1,48
	bne $t2,$0,end_atoi #
	slti $t2,$t1,58
	beq $t2,$0,end_atoi #
	
	addi $t1,$t1,-48
	addi $t3,$0,10
	mult $v0,$t3
	mflo $v0
	add $v0,$v0,$t1
	addi $t0,$t0,1
	lb $t1,0($t0)
	j loop_atoi
end_atoi:
	lw $ra,0($sp)
	lw $t0,4($sp)
	lw $t1,8($sp)
	lw $t2,12($sp)
	lw $t3,16($sp)
	addi $sp,$sp,20
	jr $ra	
#=========================
# char* itoa(char*, int)
itoa:
	addi $sp,$sp,-16
	sw $ra,0($sp)
	sw $a1,4($sp)
	sw $t0,8($sp)
	sw $t1,12($sp)
	
	add $t0,$a0,$0
loop_itoa:
	beq $a1,$0,end_loop_itoa
	addi $t1,$0,10
	div $a1,$t1
	mfhi $t1
	addi $t1,$t1,48
	sb $t1,0($t0)
	mflo $a1
	addi $t0,$t0,1
	j loop_itoa	
end_loop_itoa:
	jal reverse

end_itoa:
	lw $ra,0($sp)
	lw $a1,4($sp)
	lw $t0,8($sp)
	lw $t1,12($sp)
	addi $sp,$sp,16
	jr $ra
	
reverse:
	add $t0,$a0,$0
	lb $t1,0($t0)
loop_reverse_1:
	beq $t1,$0,end_loop_reverse_1
	addi $t0,$t0,1
	lb $t1,0($t0)
	j loop_reverse_1
end_loop_reverse_1:
	addi $t0,$t0,-1
	add $t1,$a0,$0
loop_reverse_2:
	slt $t2,$t1,$t0
	beq $t2,$0,end_reverse_2
	lb $t3,0($t0)
	lb $t4,0($t1)
	sb $t4,0($t0)
	sb $t3,0($t1)
	addi $t0,$t0,-1
	addi $t1,$t1,1
	j loop_reverse_2
end_reverse_2:
	add $v0,$a0,$0
	jr $ra		
