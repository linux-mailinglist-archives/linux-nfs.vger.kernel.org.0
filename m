Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3581EE40FD
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 03:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfJYBWs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Oct 2019 21:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:41630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388701AbfJYBWs (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 24 Oct 2019 21:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 82D1EB2DC;
        Fri, 25 Oct 2019 01:22:46 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@redhat.com>
Date:   Fri, 25 Oct 2019 12:22:36 +1100
Subject: uncollected nfsd open owners
cc:     linux-nfs@vger.kernel.org
Message-ID: <87mudpfwkj.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain


Hi,
 I have a coredump from a machine that was running as an NFS server.
 nfs4_laundromat was trying to expire a client, and in particular was
 cleaning up the ->cl_openowners.
 As there were 6.5 million of these, it took rather longer than the
 softlockup timer thought was acceptable, and hence the core dump.

 Those open owners that I looked at had empty so_stateids lists, so I
 would normally expect them to be on the close_lru and to be removed
 fairly soon.  But they weren't (only 32 openowners on close_lru).

 The only explanation I can think of for this is that maybe an OPEN
 request successfully got through nfs4_process_open1(), thus creating an
 open owner, but failed to get to or through nfs4_process_open2(), and
 so didn't add a stateid.  I *think* this can leave an openowner that is
 unused but will never be cleaned up (until the client is expired, which
 might be too late).

 Is this possible?  If so, how should we handle those openowners which
 never had a stateid?
 In 3.0 (which it the kernel were I saw this) I could probably just put
 the openowner on the close_lru when it is created.
 In more recent kernels, it seems to be assumed that openowners are only
 on close_lru if they have a oo_last_closed_stid.  Would we need a
 separate "never used lru", or should they just be destroyed as soon as
 the open fails?

 Also, should we put a cond_resched() in some or all of those loops in
 __destroy_client() ??

Thanks for your help,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl2yTl0ACgkQOeye3VZi
gbko8RAAj6AYx2imKdC+lalM0I5ee5bnEnEzyPeke5KrYAgf0D7sk4pjsMYfvPDk
7XzQpTJiX5nq+MSdSa9Cg3fwvqmbG/3KYq4hTjI5Fuh8DOAqYs7jHBECjwRnxr/q
njqxofOFJX55nNLPoudB2cWyqT9JVWb+/FUEMRxDhVW7Pj6D+anjTk0Tfn81Klkv
KCYwG1Lj9NgcARyW+8NIx09ffNsrBNEZdJol94vWih8XK0mMQcZEyDuu5xXShoPa
iKe92Ube91I5mRD4+MsXx2aWpTE0pUtF1JyOr31mTcl8GEs7iOsahASfXcgnPnAF
kJdh3X/i5Ej8PsKluEHrhgEaFzRX682yvEZmW8sQilP/9FHDCjZu79MKYtyQtJvB
V+NRW2AMtKHIKditMnZ0Lv8Wt9mcimG4+sI4C9+SVrpAILGTuQjU4WF98QOCrnMn
Y+dfvs7tHlAuDXU2onRiwE0CVk8u2E5UOJhW6e/QP2SLo3oQsANPFm/FPlBpa74Z
uO9fTKtMWaoTgCulgWUYBk7b0M1Nuq7F1qVHncYubniDSeC5X4KsBJx5lc3q0ddh
+/dRGbcSdaoAQjQaKMTvziFVDUiHLYVgmqUvMbYXOcm/LxF9nt2xg2c7MgysIkZ4
fbpUa+TcGp69Wqg0Wdc9O4Nhw18dCi31VOuogToCLsjXMkDObBA=
=1bck
-----END PGP SIGNATURE-----
--=-=-=--
