# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools SQL Command Module"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-sql"
SRC_URI="mirror://pypi/a/azure-cli-sql/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-storage-1.5.0[${PYTHON_USEDEP}]
	>=dev-python/azure-mgmt-sql-0.8.4[${PYTHON_USEDEP}]
	dev-python/azure-cli-core[${PYTHON_USEDEP}]
	>=dev-python/azure-cli-command-modules-nspkg-2.0.0[${PYTHON_USEDEP}]"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# The proper __init__.py is provided by net-misc/azure-cli
	rm "${D%/}${PYTHON_SITEDIR}/azure/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-nspkg
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/__init__.py" || die
	# The proper __init__.py is provided by dev-python/azure-cli-command-modules-nspkg	
	rm "${D%/}${PYTHON_SITEDIR}/azure/cli/command_modules/__init__.py" || die
}
