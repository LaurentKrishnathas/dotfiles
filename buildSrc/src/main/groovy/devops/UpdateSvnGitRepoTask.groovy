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
class UpdateSvnGitRepoTask extends DefaultTask {
	private final List<File>projectDirList=[]

	private String pattern=System.properties.pattern

	@TaskAction
	private void executeAction() {
		project.logger.debug "projectDirList: $projectDirList, pattern=$pattern"
		Map<File, String> summaryMap=[:] as TreeMap

		projectDirList.each{File projDir->
			project.logger.lifecycle "checking projects from $projDir"

			projDir.eachDir{File dir->

				if(pattern!=null && !dir.name.contains(pattern)){
					project.logger.debug "IGNORED $dir,  not match $pattern .."
					return
				}

				project.logger.debug "checking $dir .."

				try{
					String text=getStatus(dir)
					if(isClean(dir, text)){
						project.logger.lifecycle "OK\t$dir"
						update(dir)
					}else{
						project.logger.warn "DIRTY\t$dir"
						summaryMap.put(dir, "DIRTY")
					}
				}catch(e){
					project.logger.error "FAILED $dir, $e.message"
					summaryMap.put(dir, "FAILED")
				}
			}
		}

		project.logger.lifecycle "\n---------------------------------------\n"
		project.logger.lifecycle "Summary."

		summaryMap.each{k,v->
			println "$v\t$k"
		}
	}

	private boolean isClean(File dir, String text){
		boolean ret=true
		if(isSvn(dir)){
			ret=text.trim()=='' || !text.contains("M       ")
		}else if(isGit(dir)){
			ret=text.contains('nothing to commit, working directory clean')
			ret=ret || text.contains('nothing to commit, working tree clean')
		}

		project.logger.info "isClean: $ret, $dir"
		return ret
	}

	private String getStatus(File dir){
		String text=''
		List list=[] as List
		def cmd
		if(isSvn(dir)){
			cmd='svn status'
		}else if(isGit(dir)){
			cmd='git status'
		}

		project.logger.debug "/> $cmd ..."
		text=cmd.execute(list, dir).text.trim()

		project.logger.debug "status: $text"
		return text
	}

	private void update(File dir){
		if(isSvn(dir)){
			updateSvn(dir)
		}else if(isGit(dir)){
			updateGit(dir)
		}
	}

	private isSvn(File dir){
		return new File(dir, '.svn').exists()
	}

	private isGit(File dir){
		return new File(dir, '.git').exists()
	}

	@CompileStatic(TypeCheckingMode.SKIP)
    private updateGit(File dir) {
    	List list=[] as List

    	project.logger.debug "git svn info .."
    	def text='git svn info'.execute(list, dir).text.trim()
    	if(text.contains('Last Changed Author')){
	    	project.logger.debug "git svn fetch .."
			project.exec{
				workingDir dir
				executable 'git'
				args 'svn', 'fetch'
			}

	    	project.logger.debug "git svn rebase .."
			project.exec{
				workingDir dir
				executable 'git'
				args 'svn', 'rebase'
			}
		}else{
	    	project.logger.debug "git fetch .."
			project.exec{
				workingDir dir
				executable 'git'
				args 'fetch'
			}

	    	project.logger.debug "git pull .."
			project.exec{
				workingDir dir
				executable 'git'
				args 'pull'
			}
		}
	}

	@CompileStatic(TypeCheckingMode.SKIP)
    private updateSvn(File dir) {
  //   	project.logger.debug "svn upgrade .."
		// project.exec{
		// 	workingDir dir
		// 	executable 'svn'
		// 	args 'upgrade'
		// }

    	project.logger.debug "svn update .."
		project.exec{
			workingDir dir
			executable 'svn'
			args 'update'
		}
    }

	void addDir(String dir){
		File tmpDir=dir as File
		addDir(tmpDir)
	}

	void addDir(File dir){
		assert dir.exists(): "$dir must exists"
		projectDirList<<dir
	}
}
