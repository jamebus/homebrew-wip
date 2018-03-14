class Syncplay < Formula
  include Language::Python::Virtualenv

  desc     "Client/server to synchronize media playback on many computers"
  homepage "http://syncplay.pl/"
  url      "https://github.com/Syncplay/syncplay/archive/v1.5.2.tar.gz"
  sha256   "8a6a6e73b28e842230b4deef3b031f8ebeea5e30ffca393f2c4f8de207c6f428"
  head     "https://github.com/Syncplay/syncplay.git"

  depends_on :python if MacOS.version <= :snow_leopard

  resource "twisted" do
    url "https://files.pythonhosted.org/packages/a2/37/298f9547606c45d75aa9792369302cc63aa4bbcf7b5f607560180dd099d2/Twisted-17.9.0.tar.bz2"
    sha256 "0da1a7e35d5fcae37bc9c7978970b5feb3bc82822155b8654ec63925c05af75c"
  end

  resource "incremental" do
    url "https://files.pythonhosted.org/packages/8f/26/02c4016aa95f45479eea37c90c34f8fab6775732ae62587a874b619ca097/incremental-17.5.0.tar.gz"
    sha256 "7b751696aaf36eebfab537e458929e194460051ccad279c72b755a167eebd4b3"
  end

  resource "zope.interface" do
    url "https://files.pythonhosted.org/packages/bd/d2/25349ed41f9dcff7b3baf87bd88a4c82396cf6e02f1f42bb68657a3132af/zope.interface-4.4.3.tar.gz"
    sha256 "d6d26d5dfbfd60c65152938fcb82f949e8dada37c041f72916fef6621ba5c5ce"
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
