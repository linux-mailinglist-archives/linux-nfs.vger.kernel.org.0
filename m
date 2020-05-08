Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E944A1CB9BF
	for <lists+linux-nfs@lfdr.de>; Fri,  8 May 2020 23:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEHVZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 May 2020 17:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:34058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgEHVZX (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 8 May 2020 17:25:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 77347AF37;
        Fri,  8 May 2020 21:25:24 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     syzbot <syzbot+22b5ef302c7c40d94ea8@syzkaller.appspotmail.com>,
        anna.schumaker@netapp.com, bfields@fieldses.org,
        chuck.lever@oracle.com, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        trond.myklebust@hammerspace.com
Date:   Sat, 09 May 2020 07:25:11 +1000
Subject: [PATCH] SUNRPC: fix use-after-free in rpc_free_client_work()
In-Reply-To: <000000000000925dda05a50b9c13@google.com>
References: <000000000000925dda05a50b9c13@google.com>
Message-ID: <87r1vuazm0.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Parts of rpc_free_client() were recently moved to
a separate rpc_free_clent_work().  This introduced
a use-after-free as rpc_clnt_remove_pipedir() calls
rpc_net_ns(), and that uses clnt->cl_xprt which has already
been freed.
So move the call to xprt_put() after the call to
rpc_clnt_remove_pipedir().

Reported-by: syzbot+22b5ef302c7c40d94ea8@syzkaller.appspotmail.com
Fixes: 7c4310ff5642 ("SUNRPC: defer slow parts of rpc_free_client() to a wo=
rkqueue.")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 net/sunrpc/clnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 8350d3a2e9a7..8d3972ea688b 100644
=2D-- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -890,6 +890,7 @@ static void rpc_free_client_work(struct work_struct *wo=
rk)
 	 */
 	rpc_clnt_debugfs_unregister(clnt);
 	rpc_clnt_remove_pipedir(clnt);
+	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
=20
 	kfree(clnt);
 	rpciod_down();
@@ -907,7 +908,6 @@ rpc_free_client(struct rpc_clnt *clnt)
 	rpc_unregister_client(clnt);
 	rpc_free_iostats(clnt->cl_metrics);
 	clnt->cl_metrics =3D NULL;
=2D	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
 	xprt_iter_destroy(&clnt->cl_xpi);
 	put_cred(clnt->cl_cred);
 	rpc_free_clid(clnt);
=2D-=20
2.26.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl61zjgACgkQOeye3VZi
gblVlw/8CCtC/Q5JSGk4ecudVzz/GotzZtcL+ayh2Qx3YDzyCOkvqaSIiDF1s88m
8Tz+KYodZvdxFt157sv3JZ4SK5kIvNgy2UaCMhO3VqBc//9DOsGaRfWlT0kq6LWA
0hzwEiYLpIHjw2zBmC8Y2tMdoU2rg/OVXphuNXfESOWHFTdeQ8Scj5n4wer0E2/n
RG/Glj3kKWBa6W7bjYhR+LHuF+7ufmqqCkd20t/iYGkfwQB+kI9qMpS7N7SAI3zX
Csx7TZaYnEeENKC8igA+8IUcq3smlh9j6BnF+F3YI+5gAHqis+9bOSbpAIVoBKHm
xkQLc+r+QP7OP+3diZZwptwWqB2oS4Slk/BtM2F4K53PUjnv4HnEjFal4Yo2MXRW
rDrL0YLdJuVebiYoxzm/Wqcnn9xQxizAfn6RpTLMabGiHzjQeg7CKRzAPcY7Stv3
PfZ6T2ojmS4Xy8B0Ba4vtpzKdzC3o4IYYvtyAbr+pjw8OyEw8qSo9BPAvINS2ELE
bV5NSzAVUCToOMNzuPUUlZEf2MeZvRfrMXUaKSwX79y8okDm7CHKgE5+tE+PKaic
xFUh3wLhKIbAuM8CREMv98zCba8WIsrjPYCaoJQkE1e+lY2wtzmMmCZzXzHkhTWq
o4Q65yrtHCV5anwW72GjUPCDp089jOpKWXsnulhPUVDjSlJ/ERA=
=mg24
-----END PGP SIGNATURE-----
--=-=-=--
