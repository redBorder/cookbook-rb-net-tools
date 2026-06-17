Name: cookbook-rb-net-tools
Version: %{__version}
Release: %{__release}%{?dist}
BuildArch: noarch
Summary: Chef cookbook to install and configure rb-net-tools on redborder proxy nodes

License: AGPL 3.0
URL: https://github.com/redBorder/cookbook-rb-net-tools
Source0: %{name}-%{version}.tar.gz

%description
%{summary}

%prep
%setup -qn %{name}-%{version}

%build

%install
mkdir -p %{buildroot}/var/chef/cookbooks/rb-net-tools
cp -f -r resources/* %{buildroot}/var/chef/cookbooks/rb-net-tools/
chmod -R 0755 %{buildroot}/var/chef/cookbooks/rb-net-tools
install -D -m 0644 README.md %{buildroot}/var/chef/cookbooks/rb-net-tools/README.md

%pre
if [ -d /var/chef/cookbooks/rb-net-tools ]; then
    rm -rf /var/chef/cookbooks/rb-net-tools
fi

%post
case "$1" in
  1)
    # initial install
    :
  ;;
  2)
    # upgrade — re-upload cookbook to Chef server
    su - -s /bin/bash -c 'source /etc/profile && rvm gemset use default && env knife cookbook upload rb_net_tools'
  ;;
esac

%postun
if [ "$1" = 0 ] && [ -d /var/chef/cookbooks/rb-net-tools ]; then
  rm -rf /var/chef/cookbooks/rb-net-tools
fi

%files
%defattr(0644,root,root)
%attr(0755,root,root)
/var/chef/cookbooks/rb-net-tools
%defattr(0644,root,root)
/var/chef/cookbooks/rb-net-tools/README.md

%doc

%changelog
* Tue Jun 17 2026 Miguel Negrón <manegron@redborder.com> - 0.0.1
- First spec version
