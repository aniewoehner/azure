# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Azure Data Lake Store Filesystem Client Library for Python"
HOMEPAGE="https://pypi.python.org/pypi/azure-datalake-store"
SRC_URI="mirror://pypi/a/azure-datalake-store/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="virtual/python-cffi[${PYTHON_USEDEP}]
	>=dev-python/msrest-0.4.8[${PYTHON_USEDEP}]
	>=dev-python/adal-0.4.5[${PYTHON_USEDEP}]
	virtual/python-futures[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/pathlib2[${PYTHON_USEDEP}]' python2_7)"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	# avoiding file collision with net-misc/azure-cli
	python_export PYTHON_SITEDIR
	rm "${D%/}${PYTHON_SITEDIR}/azure/__init__.py" || die
}
