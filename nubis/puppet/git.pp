# Ensure that git is installed

package { 'git':
  ensure => latest,
  name   =>  'git'
}
