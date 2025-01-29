%define debug_package %{nil}

Name:		linbit-keyring
Version:	2025.01.29
Release:	1
Summary:	LINBIT keyring
BuildArch:	noarch

License:	GPL-2.0-or-later
URL:		https://www.github.com/LINBIT/linbit-keyring
Source0:	https://pkg.linbit.com/downloads/%{name}-%{version}.tar.gz

%description
The GnuPG keyring LINBIT uses to sign its repository meta data and rpm files.

%prep
%setup -q


%build
make %{?_smp_mflags}


%install
install -D -m644 %{_builddir}/%{name}-%{version}/output/keyrings/linbit-keyring.asc %{buildroot}/etc/pki/rpm-gpg/RPM-GPG-KEY-linbit


%files
/etc/pki/rpm-gpg/RPM-GPG-KEY-linbit


%changelog
* Wed Jan 29 2025 Roland Kammerer <roland.kammerer@linbit.com> - 2025.01.29-1
- New upstream release

* Tue Jun 18 2024 Roland Kammerer <roland.kammerer@linbit.com> - 2024.06.18-1
- New upstream release
