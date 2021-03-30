@echo off

set MY_COMMENT=Add batch file

call git status

set answer_add=y
set answer_commit=y

echo.
echo.
echo ###############################################
echo #  Do you want to ADD all changes?
set /p answer_add=#  [Y/n]: 
echo ###############################################
echo.
echo.

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
				echo Not ADD all changes
			)
		)
	)
)
EXIT /B %ERRORLEVEL%

:AddChanges
	echo Adding all changes...........
	call git add .
	REM call git restore --staged
	echo.
	echo.
	call git status
	echo.
	echo.
	echo ###############################################
	echo #  Do you want to COMMIT all changes?
	set /p answer_commit=#  [Y/n]: 
	echo ###############################################
	echo.
	echo.
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
				)
			)
		)
	)
EXIT /B 0

:CommitChanges
	call git commit -m "%MY_COMMENT%"
	call git push
EXIT /B 0