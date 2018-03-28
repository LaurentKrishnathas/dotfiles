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
class CheckGitSSHKeyTask extends DefaultTask {
	private final List<String>urlList=[]
	
	File destinationDir

	@TaskAction
	@CompileStatic(TypeCheckingMode.SKIP)
	private void executeAction() {
		project.delete(destinationDir)
		project.mkdir(destinationDir)

		def workDir="$destinationDir/work" as File
		project.mkdir(workDir)

		urlList.eachWithIndex{url, index->
			project.logger.lifecycle "checking $url ..."
			def checkoutDir="$workDir/$index" as File
			project.project.exec{
				workingDir workDir
				executable 'git'
				args 'clone', url, checkoutDir.name
				logger.lifecycle "/> $executable ${args.join(' ')}"
			}

			assert workDir.exists(): "$workDir must exists"
			assert workDir.listFiles().size()>0: "$workDir must exists"
			project.exec{
				workingDir checkoutDir
				executable 'git'
				args 'status'
				logger.lifecycle "/> $executable ${args.join(' ')}"
			}
			project.exec{
				workingDir checkoutDir
				executable 'git'
				args 'branch', '-r'
				logger.lifecycle "/> $executable ${args.join(' ')}"
			}

			new File(destinationDir, "$index").text="$url done"
			project.delete(checkoutDir)
		}
		project.delete(workDir)	
	}

	void addUrl(String url){
		urlList<<url
	}
}
