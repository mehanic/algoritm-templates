if status is-interactive
    # Commands to run in interactive sessions can go here
    #

#
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.." 

alias untar='tar -zxvf $1'  
#    **Open a tar.gz formated folder.**  
alias tar='tar -czvf $1'  
#    **Compressing a folder in tar.gz format.**  
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"  
alias df="df -Tha --total"

#Get process name/pid and user id
alias netstat1="sudo netstat -nlpt"
#process name/pid its even more useful to get the username/uid owning that particular process.
alias netstat2="sudo netstat -ltpe"
#route statistic
alias netstat3="netstat -rn"
#network interface
alias netstat4="netstat -ie"
#sudo netstat -aple | grep ntp
alias netstat5="sudo netstat -aple | grep $1"

alias netstat6="sudo netstat -atnp | grep ESTA"
#tcp connections
alias netstat7="sudo netstat -at"
#udp connections
alias netstat8="sudo netstat -au"

alias netstat9="sudo netstat -an | grep :$1"
#rsync cpa remote:/data/big_recording.fif .
#selinux
alias netstat="netstat -naptZ"

alias cp='rsync -ae ssh'
alias cpv='rsync -vhae ssh – progress'
alias cpa='rsync -vhae ssh – progress – append'

alias rsync-copy='rsync -avzh – progress'
alias rsync-ssh='rsync -azP -e ssh'



alias k 'kubectl'
alias kd 'k describe'
alias kg 'k get'
alias kaf 'k apply -f'
alias kdel 'k delete'
alias ke 'k edit'
alias kccc 'k config current-context'
alias kcdc 'k config delete-context'
alias kcsc 'k config set-context'
alias kcuc 'k config use-context'
alias kdd 'kd deployment'
alias kdeld 'kdel deployment'
alias kdeli 'kdel ingress'
alias kdelp 'kdel pods'
alias kdels 'kdel svc'
alias kdelsec 'kdel secret'
alias kdi 'kd ingress'
alias kdp 'kd pods'
alias kds 'kd svc'
alias kdsec 'kd secret'
alias ked 'ke deployment'
alias kei 'ke ingress'
alias kep 'ke pods'
alias kes 'ke svc'
alias keti 'k exec -ti'
alias kgd 'kg deployment'
alias kgi 'kg ingress'
alias kgp 'kg pods'
alias kgrs 'kg rs'
alias kgs 'kg svc'
alias kgsec 'kg secret'
alias kl 'k logs'
alias klf 'k logs -f'
alias krh 'k rollout history'
alias krsd 'k rollout status deployment'
alias kru 'k rollout undo'
alias ksd 'k scale deployment'



end

# Generated for envman. Do not edit.
test -s ~/.config/envman/load.fish
source ~/.config/envman/load.fish
