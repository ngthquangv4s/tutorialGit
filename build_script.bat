@echo off

set MY_COMMENT=Add batch file

call git status

echo.
echo.
echo ###############################################
echo #  Do you want to ADD all changes?
set /p answer_add=#  [Y/n]: 
echo ###############################################
echo.
echo.
	
if [%answer_add%] == [] (
	echo Is emty in add
	call :AddChanges 
) else (
	if %answer_add% == y (
		call :AddChanges 
	) else (
		if %answer_add% == Y (
			call :AddChanges 
		) else (
			if %answer_add% == Yes (
				call :AddChanges 
			) else (
				echo Not add all changes
			)
		)
	)
)

:AddChanges
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

	if %answer_commit% == y (
		call :CommitChanges 
	) else (
		if %answer_commit% == Y (
			call :CommitChanges
		) else (
			if %answer_commit% == Yes (
				call :CommitChanges
			) else (
				if [%answer_commit%] == [] (
					echo Is emty in commit
					call :CommitChanges
				) else (
					echo Not commit all changes
				)
			)
		)
	)
EXIT /B 0

:CommitChanges
	call git commit -m "%MY_COMMENT%"
	call git push
EXIT /B 0

