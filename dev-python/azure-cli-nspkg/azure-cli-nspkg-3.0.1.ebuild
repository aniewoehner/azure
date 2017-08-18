# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure CLI Namespace Package"
HOMEPAGE="https://pypi.python.org/pypi/azure-cli-nspkg"
SRC_URI="mirror://pypi/a/azure-cli-nspkg/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
LICENSE="MIT"
SLOT="0"

# https://pypi.python.org/pypi/azure
AZUREDEPEND="dev-python/azure-servicemanagement-legacy[${PYTHON_USEDEP}]
	dev-python/azure-servicebus[${PYTHON_USEDEP}]"

# https://pypi.python.org/pypi/azure-mgmt
AZUREMGMTDEPEND="
	dev-python/azure-mgmt-scheduler[${PYTHON_USEDEP}]
	dev-python/azure-mgmt-logic[${PYTHON_USEDEP}]"

RDEPEND="${AZUREDEPEND}
	${AZUREMGMTDEPEND}"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
