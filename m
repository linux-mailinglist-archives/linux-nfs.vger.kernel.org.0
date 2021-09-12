Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086BB407C05
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Sep 2021 08:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhILGOD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 12 Sep 2021 02:14:03 -0400
Received: from luckmann.name ([213.239.213.133]:45595 "EHLO
        static.213-239-213-133.clients.your-server.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229512AbhILGOC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 12 Sep 2021 02:14:02 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Sep 2021 02:14:02 EDT
Received: from localhost (localhost [127.0.0.1])
  (uid 502)
  by static.213-239-213-133.clients.your-server.de with local
  id 0000000000E54040.00000000613D9932.00006829; Sun, 12 Sep 2021 08:07:46 +0200
Date:   Sun, 12 Sep 2021 08:07:46 +0200
From:   Helge Kreutzmann <debian@helgefjell.de>
To:     linux-nfs@vger.kernel.org
Subject: Errors in NFS man pages
Message-ID: <20210912060745.GA26295@Debian-50-lenny-64-minimal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="=_luckmann.name-26665-1631426866-0001-2"
Content-Disposition: inline
X-Public-Key-URL: http://www.helgefjell.de/data/debian_neu.asc
X-homepage: http://www.helgefjell.de/debian
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_luckmann.name-26665-1631426866-0001-2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear NFS maintainer,
the manpage-l10n project maintains a large number of translations of
man pages both from a large variety of sources (including NFS) as
well for a large variety of target languages.

During their work translators notice different possible issues in the
original (english) man pages. Sometimes this is a straightforward
typo, sometimes a hard to read sentence, sometimes this is a
convention not held up and sometimes we simply do not understand the
original.

We use several distributions as sources and update regularly (at
least every 2 month). This means we are fairly recent (some
distributions like archlinux also update frequently) but might miss
the latest upstream version once in a while, so the error might be
already fixed. We apologize and ask you to close the issue immediately
if this should be the case, but given the huge volume of projects and
the very limited number of volunteers we are not able to double check
each and every issue.

Secondly we translators see the manpages in the neutral po format,
i.e. converted and harmonized, but not the original source (be it man,
groff, xml or other). So we cannot provide a true patch (where
possible), but only an approximation which you need to convert into
your source format.

Finally the issues I'm reporting have accumulated over time and are
not always discovered by me, so sometimes my description of the
problem my be a bit limited - do not hesitate to ask so we can clarify
them.

I'm now reporting the errors for your project. I'm not repeating the
errors reported 2020-05-16, 2021-05-29, if you would like a full
report, please let me know. If future reports should use another
channel, please let me know as well.


Man page: nfs.5
Issue: B<nfsmount.conf(5)> =E2=86=92 B<nfsmount.conf>(5)

"If the mount command is configured to do so, all of the mount options "
"described in the previous section can also be configured in the I</etc/"
"nfsmount.conf> file. See B<nfsmount.conf(5)> for details."
msgstr ""
"Falls der Befehl =C2=BBmount=C2=AB entsprechend konfiguriert ist, k=C3=B6n=
nen alle in den "
"vorhergehenden Kapiteln beschriebenen Einh=C3=A4ngeoptionen auch in der Da=
tei I</"
--
Man page: nfs.5
Issue: Why is the word "option" in bold?

"The B<sloppy> option is an alternative to specifying B<mount.nfs> -s "
"B<option.>"

--=20
      Dr. Helge Kreutzmann                     debian@helgefjell.de
           Dipl.-Phys.                   http://www.helgefjell.de/debian.php
        64bit GNU powered                     gpg signed mail preferred
           Help keep free software "libre": http://www.ffii.de/

--=_luckmann.name-26665-1631426866-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbZZfteMW0gNUynuwQbqlJmgq5nAFAmE9mSsACgkQQbqlJmgq
5nBxpg//a7LrktR2Tuj/LWlupWsO99cjzd1C4wru7efRq4YDoPCrQRAMhwryq3QN
6rjhzgstclKaia39hNEllpZTbov0Fy6FLOQ+AfLpA2vgfpJ3sb6MR7/pU6F0sSnS
GwzllESDwRz8yTz/RXiCtdV4WeG8sMbJLqXYqYJxgacjhU5fBSgbgH5d8t7OYFko
Z3DvEza3+GCclc8n8gFUJADRS9gl9x688gDpKIacVgpxDNnIpA8IgD7XEaWoVOIT
mVNIYue99u0xOkJ51P0VuB0mKHpeneiOiMRcycu+DVkNDn9C8O9PV/+1DJ1Lqcn3
P6cuQAnDuid3Dt7WUrZGFk2j3StyjfGXU1g0ucvfJ10oFz4Q9c/P/jzIl6G/u7S2
qc//McDT7WcYvQR2zk5SNXurpQ8vb0b506F7ZvtrPOE1oUQCqwqtusa1SFc8CvUh
yfD3hOeeV/w9pwXnmuOhpLsfHSzgLRHRi2IA1EFlq+SOfligH9TJmRZWzyFIT1DS
frYU8r3HISErEVu7pDIH4BjwCGUIARh91uSiubqMtSA33savOXsybZ3Tv3ldUeXc
QonLsDKh4anDg8dfLYn9SwU/UEh7iAJ29xxswDW0PRe6jBp+l/Vdrgc+3IAzqrO9
/V3d+KkiitbHo93nS9txNQEWPeK5j69kfJFSt63uPWR9cxBynsI=
=CXyw
-----END PGP SIGNATURE-----

--=_luckmann.name-26665-1631426866-0001-2--
