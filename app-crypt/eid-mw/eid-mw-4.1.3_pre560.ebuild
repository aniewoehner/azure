# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils autotools mozextension multilib

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/Fedict/${PN}.git
		https://github.com/Fedict/${PN}.git"
	inherit git-2
	SRC_URI=""
else
	MY_P="${PN}-${PV/_pre560/-v4.1.0.560.g32b77ce}"
	SRC_URI="https://dist.eid.belgium.be/continuous/sources/${MY_P}.tar.gz"
	KEYWORDS="~x86 ~amd64 ~arm"
	S="${WORKDIR}/${MY_P}"
fi

SLOT="0"
LICENSE="LGPL-3"
DESCRIPTION="Belgian Electronic Identity Card middleware supplied by the Belgian Federal Government"

HOMEPAGE="http://eid.belgium.be"

IUSE="+gtk +xpi +dialogs"

REQUIRED_USE="
	dialogs? ( gtk )"

RDEPEND="gtk? ( x11-libs/gtk+:* )
	>=sys-apps/pcsc-lite-1.2.9
	xpi? ( || ( >=www-client/firefox-bin-3.6.24
		>=www-client/firefox-3.6.20 ) )
	!app-misc/beid-runtime"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	use gtk || epatch "${FILESDIR}"/gtk_not_required_${PV}.patch

	sed -i -e 's:/beid/rsaref220:/rsaref220:' configure.ac
	sed -i -e 's:/beid::' cardcomm/pkcs11/src/libbeidpkcs11.pc.in

	eautoreconf
}

src_configure() {
	econf $(use_enable dialogs) --disable-static
}

src_install() {
	emake DESTDIR="${D}" install
	if use xpi; then
		declare MOZILLA_FIVE_HOME
		if has_version '>=www-client/firefox-3.6.20'; then
			MOZILLA_FIVE_HOME="/usr/$(get_libdir)/firefox"
			xpi_install	"${D}/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/belgiumeid@eid.belgium.be"
		fi
		if has_version '>=www-client/firefox-bin-3.6.24'; then
			MOZILLA_FIVE_HOME="/opt/firefox"
			xpi_install	"${D}/usr/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/belgiumeid@eid.belgium.be"
		fi
	fi
	rm -r "${D}/usr/share" "${D}"/usr/lib*/*.la

	use gtk || warn "-gtk configuration is not officially managed by Fedict"
}
