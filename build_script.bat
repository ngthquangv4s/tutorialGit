@echo off

set MY_COMMENT =Add batch file
set /A TIME_OUT=30				REM Time to wait for CI build success
REM #####################
REM #   Main function   #
REM #####################
call :Git_CI

exit /B %ERRORLEVEL% 
REM End of main function

REM #####################
REM #  Git_CI function  #
REM #####################
:Git_CI
	set answer_add=y
	set answer_commit=y
	echo.
	echo [STATUS Before adding]
	echo ####################################### [STATUS] #######################################
	call git status
	echo ####################################### [STATUS] #######################################
	echo.
	echo.
	echo.
	echo [ADD]
	echo ######################################## [ADD] #########################################
	echo #  Do you want to ADD all changes?
	set /p answer_add=#  [Y/n]: 

	if %answer_add%==y (
		call :AddChanges 
	) else (
		if %answer_add%==Y (
			call :AddChanges 
		) else (
			if %answer_add%==yes (
				call :AddChanges 
			) else (
				if %answer_add%==Yes (
					call :AddChanges 
				) else (
					echo #  Not ADD all changes
					echo ######################################## [ADD] #########################################
				)
			)
		)
	)
EXIT /B 0

REM #########################
REM #  AddChanges function  #
REM #########################
:AddChanges
	echo #  Adding all changes...........
	call git add .
	REM call git restore --staged
	echo ######################################## [ADD] #########################################
	echo.
	echo.
	echo [STATUS After adding]
	echo ####################################### [STATUS] #######################################
	call git status
	echo ####################################### [STATUS] #######################################
	echo.
	echo.
	echo [COMMIT]
	echo ###################################### [COMMIT] ########################################
	echo #  Do you want to COMMIT all changes?
	set /p answer_commit=#  [Y/n]: 

	if %answer_commit%==y (
		call :CommitChanges 
	) else (
		if %answer_commit%==Y (
			call :CommitChanges
		) else (
			if %answer_commit%==yes (
				call :CommitChanges
			) else (
				if %answer_commit%==Yes (
					call :CommitChanges
				) else (
					echo #  Not COMMIT all changes
					echo ###################################### [COMMIT] ########################################
				)
			)
		)
	)
EXIT /B 0

REM ############################
REM #  CommitChanges function  #
REM ############################
:CommitChanges
	echo #  Your comment: %MY_COMMENT%
	call git commit -m "%MY_COMMENT%"
	echo ###################################### [COMMIT] ########################################
	echo.
	echo.
	echo [PUSH]
	echo ####################################### [PUSH] #########################################
	call git push
	echo ####################################### [PUSH] #########################################
	call timeout /t %TIME_OUT% /nobreak
	echo.
EXIT /B 0