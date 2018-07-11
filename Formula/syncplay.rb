class Syncplay < Formula
  include Language::Python::Virtualenv

  desc     "Client/server to synchronize media playback on many computers"
  homepage "http://syncplay.pl/"
  url      "https://github.com/Syncplay/syncplay/archive/v1.5.5.tar.gz"
  sha256   "19f266665daa297794dd6857319da9bb14274c8c804aca6b960e11465085223c"
  head     "https://github.com/Syncplay/syncplay.git"

  depends_on "python@2" if MacOS.version <= :snow_leopard

  resource "twisted" do
    url "https://files.pythonhosted.org/packages/12/2a/e9e4fb2e6b2f7a75577e0614926819a472934b0b85f205ba5d5d2add54d0/Twisted-18.4.0.tar.bz2"
    sha256 "a4cc164a781859c74de47f17f0e85f4bce8a3321a9d0892c015c8f80c4158ad9"
  end

  resource "incremental" do
    url "https://files.pythonhosted.org/packages/8f/26/02c4016aa95f45479eea37c90c34f8fab6775732ae62587a874b619ca097/incremental-17.5.0.tar.gz"
    sha256 "7b751696aaf36eebfab537e458929e194460051ccad279c72b755a167eebd4b3"
  end

  resource "zope.interface" do
    url "https://files.pythonhosted.org/packages/ac/8a/657532df378c2cd2a1fe6b12be3b4097521570769d4852ec02c24bd3594e/zope.interface-4.5.0.tar.gz"
    sha256 "57c38470d9f57e37afb460c399eb254e7193ac7fb8042bd09bdc001981a9c74c"
  end

  resource "constantly" do
    url "https://files.pythonhosted.org/packages/95/f1/207a0a478c4bb34b1b49d5915e2db574cadc415c9ac3a7ef17e29b2e8951/constantly-15.1.0.tar.gz"
    sha256 "586372eb92059873e29eba4f9dec8381541b4d3834660707faf8ba59146dfc35"
  end

  def install
    venv = virtualenv_create(libexec)
    venv.pip_install resources
    system "make", "install", "PREFIX=#{prefix}"
    rm Dir["#{bin}/*-e"]

    Dir["#{bin}/*"].each do |f|
      inreplace f, %r{^#!/usr/bin/env python2$}, "#!#{libexec}/bin/python2"
    end
  end

  # TODO
  # test do
  # end
end
