Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8FB2C5E77
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Nov 2020 01:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392055AbgK0AYl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Nov 2020 19:24:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:59514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392053AbgK0AYk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 26 Nov 2020 19:24:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E423FAC65;
        Fri, 27 Nov 2020 00:24:38 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Date:   Fri, 27 Nov 2020 11:24:33 +1100
Subject: [PATCH] NFS: switch nfsiod to be an UNBOUND workqueue.
In-Reply-To: <87k0uzqqn7.fsf@notabene.neil.brown.name>
References: <87sg9or794.fsf@notabene.neil.brown.name>
 <37ec02047951a5d61cf9f9f5b4dc7151cd877772.camel@hammerspace.com>
 <87k0uzqqn7.fsf@notabene.neil.brown.name>
cc:     TJ <tj@kernel.org>
Message-ID: <87pn3zlk8u.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


nfsiod is currently a concurrency-managed workqueue (CMWQ).
This means that workitems scheduled to nfsiod on a given CPU are queued
behind all other work items queued on any CMWQ on the same CPU.  This
can introduce unexpected latency.

Occaionally nfsiod can even cause excessive latency.  If the work item
to complete a CLOSE request calls the final iput() on an inode, the
address_space of that inode will be dismantled.  This takes time
proportional to the number of in-memory pages, which on a large host
working on large files (e.g..  5TB), can be a large number of pages
resulting in a noticable number of seconds.

We can avoid these latency problems by switching nfsiod to WQ_UNBOUND.
This causes each concurrent work item to gets a dedicated thread which
can be scheduled to an idle CPU.

There is precedent for this as several other filesystems use WQ_UNBOUND
workqueue for handling various async events.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index aa6493905bbe..43af053f467a 100644
=2D-- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2180,7 +2180,7 @@ static int nfsiod_start(void)
 {
 	struct workqueue_struct *wq;
 	dprintk("RPC:       creating workqueue nfsiod\n");
=2D	wq =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM, 0);
+	wq =3D alloc_workqueue("nfsiod", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	if (wq =3D=3D NULL)
 		return -ENOMEM;
 	nfsiod_workqueue =3D wq;
=2D-=20
2.29.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/AR0EOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbliUw//XfMub60GzM3zr/mNTulcvC+bwAizfbI/9S7D
V/Z7aMI8LRFQyl071M2bkymz+Qgj66JTF0hkM68KygcmP3A+pvPayhrrZkpfDUzM
QNSzzYrMQtOFCepVn2qCZ0k6TFayaCqSX4ws0CP0rArUt9ZMZY7TS3GYAIyXBjQ2
1nxxChjZRpDusmKpu9X2/EM1FjCJrH6XPXQU8n3HsG1eZ+jmykhQexZCo6NQdXLP
Ypsc3o03cW5Xwy2klQw5gCF9yt1LVqeqwWoRRAcv5b4LWNcmWTfvtLFG8CSeLRCz
aJl7Oz1UiG1LrNFSyH2NZiJMgDdoN80KrJliIzGvOatiM33i+bHmNWHmDIO8XMr1
N3kGXmKsGtcyu1mbgvtKebfY8XVTFkUdBtzLZ6eu0gDzDksqiY9vUlp47Wgce7sO
DRHlRTmMav5cf+fRvS3gfNxKmJxFoTtPZOvLi4gM1QPgsc1QMxOp9w32cKJX98xQ
97TQQOpCAvPSZM+rz0ZqUQAMlDZH5ptCNcAyPRTq6DdFYyuo4tQUWSPLJccBfLIy
e8+zf9u65j8DK88v8u661WNKRB+HH5/MH572Dcr7LiFvInGwgKNXzQP2NXQGmg5s
oquIsXmhwl7FO2oK5Yr6YSHnMrTnJ2VFLsdkABYO/563ZatN82vmfWhDIHzAo7WA
0w+pltc=
=RkKv
-----END PGP SIGNATURE-----
--=-=-=--
