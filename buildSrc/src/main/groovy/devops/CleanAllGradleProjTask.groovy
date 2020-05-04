package devops
/*
 *  @author Laurent Krishnathas
 */

import groovy.transform.CompileStatic
import groovy.transform.TypeChecked
import groovy.transform.TypeCheckingMode
import org.gradle.api.DefaultTask
import org.gradle.api.tasks.TaskAction
import org.gradle.api.tasks.Input
import org.gradle.api.tasks.InputDirectory
import org.gradle.api.tasks.OutputDirectory
import org.gradle.api.tasks.incremental.IncrementalTaskInputs

@CompileStatic
class CleanAllGradleProjTask extends DefaultTask {
	final List<File>projectList=[]



	@TaskAction
	@CompileStatic(TypeCheckingMode.SKIP)
	private void executeAction() {
		project.exec{
			executable "gradle"
			args '-v'
		}

		projectList.each{dir->
			dir.eachDir{projDir->
				execute(projDir)
			}
		}
	}

	@CompileStatic(TypeCheckingMode.SKIP)
	execute(File dir){
		if(!new File(dir, "gradlew").exists()){
			project.logger.warn "$dir not gradle proj"
			return
		}

		try{
			project.logger.lifecycle "cleaning $dir ..."
			execute(dir, "gradle")
		}catch(e){
			project.logger.error e.message
			executeQuiet(dir, 'gradlew')
		}
	}

	@CompileStatic(TypeCheckingMode.SKIP)
	executeQuiet(File dir, String executable_){
		try{
			execute(dir, executable_)
		}catch(e){
			project.logger.error e.message
		}
	}

	@CompileStatic(TypeCheckingMode.SKIP)
	execute(File dir, String executable_){
		project.exec{
			workingDir dir
			executable executable_
			args 'clean'
			project.logger.lifecycle "/> $executable ${args.join(' ')}"
		}
	}

	void addDir(String dir){
		File tmpDir=dir as File
		addDir(tmpDir)
	}

	void addDir(File dir){
		assert dir.exists(): "$dir must exists"
		projectList<<dir
	}
}
