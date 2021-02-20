# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${PN}2-${PV}

DESCRIPTION="Static HTML image gallery generator"
HOMEPAGE="https://igal.trexler.at"
SRC_URI="https://github.com/solbu/igal2/archive/v2.4.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND="
	dev-lang/perl
	virtual/imagemagick-tools
	virtual/jpeg"
DEPEND=""

S="${WORKDIR}/${MY_P}"

${FILESDIR}/igal-2.4.patch

src_prepare() {
	default
	eapply ${FILESDIR}/igal-2.4.patch
	sed -e "s:/usr/local/lib/igal2:/usr/share/igal2:g" \
		-i igal2 -i igal2.1 || die
	sed -i -e "s:/usr/local/bin/igal2:/usr/bin/igal2:" \
		utilities/igal2.sh || die
}

src_compile() { :; }

src_install() {
	dobin igal2 utilities/igal2.sh
	dosym igal2 /usr/bin/igal
	doman igal2.1
	dodoc ChangeLog README
	insinto /usr/share/igal2
	doins *.html tile.png igal2.css
}
