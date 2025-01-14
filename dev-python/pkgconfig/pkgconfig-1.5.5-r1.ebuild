# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1

DESCRIPTION="Interface Python with pkg-config"
HOMEPAGE="
	https://github.com/matze/pkgconfig/
	https://pypi.org/project/pkgconfig/
"
SRC_URI="
	https://github.com/matze/pkgconfig/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ppc64 ~riscv x86 ~amd64-linux ~x86-linux ~x64-macos"

RDEPEND="
	virtual/pkgconfig
"

distutils_enable_tests pytest
