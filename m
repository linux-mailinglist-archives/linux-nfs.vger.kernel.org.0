Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D9C34138A
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 04:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbhCSDiA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Mar 2021 23:38:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:32968 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233560AbhCSDhs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 18 Mar 2021 23:37:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E816DAC2E;
        Fri, 19 Mar 2021 03:37:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Date:   Fri, 19 Mar 2021 14:37:42 +1100
Cc:     Steve Dickson <SteveD@RedHat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Subject: [PATCH] nfsd: report client confirmation status in "info" file
In-Reply-To: <87y2ejerwn.fsf@notabene.neil.brown.name>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
Message-ID: <87v99neruh.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


mountd can now monitor clients appearing and disappearing in
/proc/fs/nfsd/clients, and will log these events, in liu of the logging
of mount/unmount events for NFSv3.

Currently it cannot distinguish between unconfirmed clients (which might
be transient and totally uninteresting) and confirmed clients.

So add a "status: " line to the "info" file which reports either
"confirmed" or "unconfirmed".

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfsd/nfs4state.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 97447a64bad0..98d9fe5a2ec5 100644
=2D-- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2352,6 +2352,10 @@ static int client_info_show(struct seq_file *m, void=
 *v)
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: 0x%llx\n", clid);
 	seq_printf(m, "address: \"%pISpc\"\n", (struct sockaddr *)&clp->cl_addr);
+	if (test_bit(NFSD4_CLIENT_CONFIRMED, &clp->cl_flags))
+		seq_puts(m, "status: confirmed\n");
+	else
+		seq_puts(m, "status: unconfirmed\n");
 	seq_printf(m, "name: ");
 	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
 	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
=2D-=20
2.30.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAmBUHIYOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmAGRAAlkiKIUJGz1M1s97jAeJ+dWwCVpkeHx9AW0S8
zYxudsaJdpsOKUOS7mFezQgbNnCX+Q5svITgIwngSezHfQmd2BUSBfXFzZ0sE4qG
lyfddWbPrWGXoR0WeEANmnQqs+seGW29jhlqHX0BoKIW/Fwy+FcKhRNNwswr2gBV
lPBOYrj6u7kgmUk6verRWsreUV1IttUu/dq8RYptn1Li1B0lqnzvdrcHuvDRYbJ3
yOTXHG6sAUDQqfM4aZLG9kBLTwEsDGdTCDKMiC7KQg1Rqqt7oDp0XRk56mWkCpVV
f1rw1v/eKOPLtj2CRrQBRukRjuzkBgVI8fR2BE9OO8AOSGBgaNQbeJtgeanAagUt
vNf9GUBbAr7tFt9YMGZ0Am6SAWjBWjcc7gO8ZjbVEkT6QsOY078VelXIZJXOXOMp
evnVUZ4Ai31TrvD2G90L0niIcBUmMRFMQDqRMDtE2VVyi+7aYfgoA4N4lhmhuk0r
7alvb0978QWSNObdEzvsAG26wrEn5ctPjEgf+/OgvO7+W/tnSdO8kB6DJc5yhhRQ
87SOFpk4a5RSq/P62Uz2KsTCIPbGR6TXzDqGv35vuBgbdWaKHayo0bZgCXiHGVD9
JcDeJESRXAbvyUDYpM0ylmyqBMda3GeUdCWu1BE4BtTWP6c7f35Qt5J2pVCRpcha
nd/Hqqc=
=tgfz
-----END PGP SIGNATURE-----
--=-=-=--
