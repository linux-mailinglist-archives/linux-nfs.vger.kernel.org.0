Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F140CCAA
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 20:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhIOSjJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 14:39:09 -0400
Received: from luckmann.name ([213.239.213.133]:52479 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhIOSjJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 14:39:09 -0400
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E5E16A.0000000061423D7C.00006746; Wed, 15 Sep 2021 20:37:48 +0200
Date:   Wed, 15 Sep 2021 20:37:48 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Errors in NFS man pages
Message-ID: <20210915183748.GA26324@Debian-50-lenny-64-minimal>
References: <20210912060745.GA26295@Debian-50-lenny-64-minimal>
 <20210915183321.GA10712@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-26438-1631731068-0001-2"
Content-Disposition: inline
In-Reply-To: <20210915183321.GA10712@fieldses.org>
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-26438-1631731068-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Bruce,
On Wed, Sep 15, 2021 at 02:33:21PM -0400, J. Bruce Fields wrote:
> On Sun, Sep 12, 2021 at 08:07:46AM +0200, Helge Kreutzmann wrote:
> > Dear NFS maintainer,
> > the manpage-l10n project maintains a large number of translations of
> > man pages both from a large variety of sources (including NFS) as
> > well for a large variety of target languages.
> >=20
> > During their work translators notice different possible issues in the
> > original (english) man pages. Sometimes this is a straightforward
> > typo, sometimes a hard to read sentence, sometimes this is a
> > convention not held up and sometimes we simply do not understand the
> > original.
> >=20
> > We use several distributions as sources and update regularly (at
> > least every 2 month). This means we are fairly recent (some
> > distributions like archlinux also update frequently) but might miss
> > the latest upstream version once in a while, so the error might be
> > already fixed. We apologize and ask you to close the issue immediately
> > if this should be the case, but given the huge volume of projects and
> > the very limited number of volunteers we are not able to double check
> > each and every issue.
> >=20
> > Secondly we translators see the manpages in the neutral po format,
> > i.e. converted and harmonized, but not the original source (be it man,
> > groff, xml or other). So we cannot provide a true patch (where
> > possible), but only an approximation which you need to convert into
> > your source format.
> >=20
> > Finally the issues I'm reporting have accumulated over time and are
> > not always discovered by me, so sometimes my description of the
> > problem my be a bit limited - do not hesitate to ask so we can clarify
> > them.
> >=20
> > I'm now reporting the errors for your project. I'm not repeating the
> > errors reported 2020-05-16, 2021-05-29, if you would like a full
> > report, please let me know. If future reports should use another
> > channel, please let me know as well.
>=20
> This is probably fine.
>=20
> But if it's possible to make these into patches against nfs-utils
> (http://git.linux-nfs.org/?p=3Dsteved/nfs-utils.git;a=3Dsummary), and send
> them to steved@redhat.com, cc'd to this list--that would probably get
> the fastest response.

Sorry, given more than > 100 upstreams and very limited man power this
is not possible. I would be really glad if you could handle them, even
if this takes more time (better late than never).

Thanks for taking care!

Greetings

         Helge

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-26438-1631731068-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmFCPXwACgkQQbqlJmgq
5nB4CBAAgG15hJokckJZZgyWKRB7eJuQhUT+NcVynz0W80ju7komLax8N9voXWSj
8rG8Axc0dwfu0IOO7XJgontatsFjSd0QHU/oFpEZnK+qVfNJZZK1fmbRaFGFR4hp
xWiK/VJfUJeiYmNsp09RtUM7wADtXPDEdW/e5b314LyQWuCVFNyKgvI5uRV+yUVF
4WyIqkH18Zib4Rglup0zgMaMFMMWpVFcluN0JSIZO7qvzC1fVyBDxlfnasXro9zt
oXUFxV4ubZpmevrjdY9jOibBT8nOkwDSYnwrz71EWILbNRGhEZh55UI5tBpOnc+z
IWSGzMxqIZqt/6kTY4y40x0RUzNXNlF/rjwVuAj1HFltr6YgbnJuATBaSNbFJEYp
4ZEcad3sm35lWLZf4fXNxlQZ3GhsWYaaz5MtcnKzMEKtno6B7w9TBQJHyR8YQyh2
gUWPncu9yZQsymXnv01FcSQyWd0Dk2AQm9fdaVbLsRupqcAkLJWBHtIe7W0mpW/j
eVFa069rNbYiJAFjvtwWiuhCgzWvz0bsp9LCz8H7MyfZmJeiDG6Hk9fPyNiU2mb5
2tvOXDWr/eqBGq59Kg8bnAYfOzwPh/h5Z+qk+sk9O6CeIgaZtfgo/85neQQPUL2F
siRPrNrmNb4VAZL0VnG2GZUcpepfZGr1U8m+W+JapBf7wXfCdNQ=
=qplB
-----END PGP SIGNATURE-----

--=_luckmann.name-26438-1631731068-0001-2--
