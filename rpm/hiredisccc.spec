Name:			  hiredisccc
Summary:		Redis cluster c client based on hiredis-vip
Version:		1.0.0
Release:		1%{?dist}
License:		CPL
Group:			DX
URL:			https://github.com/soft-way/libhiredisccc
Source:			https://github.com/soft-way/%{name}/archive/v%{version}.tar.gz#/%{name}-%{version}.tar.gz

BuildRequires:		libevent libevent-devel
BuildRequires:		autoconf automake libtool
%ifarch s390 s390x
BuildRequires:
%endif

Requires: 		    libevent

%description
Hiredisccc is for Redis cluster c language client based on hiredis-vip

%package devel
Group:			Development
Summary:		 header files

%description devel

%package examples
Group:			Development
Summary:		 example  files

%description examples

%package libs
Group:			Libraries
Summary:		The run-time libraries for the Redis cluster client

%description libs

%prep
%setup -q -n %{name}-%{version}

%build
./bootstrap.sh

%configure
make %{?_smp_mflags}

%install
rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT


%clean
rm -rf $RPM_BUILD_ROOT

%preun

%post

%pre

%postun

%files libs
%dir %attr(755, root, root)
%{_libdir}/*.*

%files examples
%dir %attr(755, root, root)
%{_bindir}/*

%files devel
%dir %attr(755, root, root)
%{_includedir}/*
%{_mandir}/man1/*.*

%changelog
* Sat Mar 23 2019 Samuel Chen
- initial file created
