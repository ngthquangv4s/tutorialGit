@echo off

set MY_COMMENT=Add batch file
set answer_add=y
set answer_commit=y

echo.
echo ####################################### STATUS #######################################
call git status
echo ####################################### STATUS #######################################
echo.
echo.
echo.
echo ######################################## ADD #########################################
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
				echo ######################################## ADD #########################################
			)
		)
	)
)

EXIT /B %ERRORLEVEL%

:AddChanges
	echo #  Adding all changes...........
	call git add .
	REM call git restore --staged
	echo ######################################## ADD #########################################
	echo.
	echo.
	echo ####################################### STATUS #######################################
	call git status
	echo ####################################### STATUS #######################################
	echo.
	echo.
	echo ###################################### COMMIT ########################################
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
					echo Not COMMIT all changes
					echo ###################################### COMMIT ########################################
				)
			)
		)
	)
EXIT /B 0

:CommitChanges
	call git commit -m "%MY_COMMENT%"
	echo ###################################### COMMIT ########################################
	echo.
	echo.
	echo ####################################### PUSH #########################################
	call git push
	echo ####################################### PUSH #########################################
	echo.
	echo.
EXIT /B 0