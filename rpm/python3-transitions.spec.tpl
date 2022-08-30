%global pypi_name transitions
%global pypi_version @VERSION@
%global release @RELEASE@
%global date @DATE@

Name:           python3-%{pypi_name}
Version:        %{pypi_version}
Release:        1%{?dist}
Summary:        A lightweight, object-oriented Python state machine implementation with many extensions

License:        MIT
URL:            http://github.com/pytransitions/transitions
Source0:        %{pypi_source}

BuildArch:      noarch
BuildRequires:  python3-devel
BuildRequires:  python3-setuptools

%description
A lightweight, object-oriented Python state machine implementation with many extensions

Requires:  python3-six

%prep
%autosetup -n %{pypi_name}-%{pypi_version}
# Remove bundled egg-info
rm -rf %{pypi_name}.egg-info

%build
%py3_build

%install
%py3_install

%files -n python3-%{pypi_name}
%license LICENSE
%doc README.md
%{python3_sitelib}/*

%changelog
* %{date} Alexander Neumann <aleneum@gmail.com>
- Release %{version}-${release}
