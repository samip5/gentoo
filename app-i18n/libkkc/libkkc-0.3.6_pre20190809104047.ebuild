# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{7..9} )

inherit autotools python-any-r1 vala

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/ueno/libkkc"
elif [[ "${PV}" == *_pre* ]]; then
	inherit vcs-snapshot

	EGIT_COMMIT="b2e5a152980ee627c39ca8a49082e6df7694b8fc"
fi

DESCRIPTION="Japanese Kana Kanji conversion input method library"
HOMEPAGE="https://github.com/ueno/libkkc"
if [[ "${PV}" == "9999" ]]; then
	SRC_URI=""
elif [[ "${PV}" == *_pre* ]]; then
	SRC_URI="https://github.com/ueno/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
else
	SRC_URI="https://github.com/ueno/${PN}/releases/download/v${PV}/${P}.tar.gz"
fi

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/libgee:0.8
	dev-libs/marisa
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}"
BDEPEND="$(python_gen_any_dep 'dev-libs/marisa[python,${PYTHON_USEDEP}]')
	$(vala_depend)
	dev-libs/gobject-introspection
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

python_check_deps() {
	has_version -b "dev-libs/marisa[python,${PYTHON_USEDEP}]"
}

src_prepare() {
	default
	eautoreconf
	vala_src_prepare
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable static-libs static)
}

src_install() {
	default
	find "${ED}" -name "*.la" -delete || die
}
