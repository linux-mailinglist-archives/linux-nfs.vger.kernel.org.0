Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E919CEE2
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390366AbgDCDdv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 23:33:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:58738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388951AbgDCDdu (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 2 Apr 2020 23:33:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C6CDAAC84;
        Fri,  3 Apr 2020 03:33:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@netapp.com>
Date:   Fri, 03 Apr 2020 14:33:41 +1100
Subject: [PATCH] SUNRPC: defer slow parts of rpc_free_client() to a workqueue.
cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Message-ID: <87eet5xmy2.fsf@notabene.neil.brown.name>
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


The rpciod workqueue is on the write-out path for freeing dirty memory,
so it is important that it never block waiting for memory to be
allocated - this can lead to a deadlock.

rpc_execute() - which is often called by an rpciod work item - calls
rcp_task_release_client() which can lead to rpc_free_client().

rpc_free_client() makes two calls which could potentially block wating
for memory allocation.

rpc_clnt_debugfs_unregister() calls into debugfs and will block while
any of the debugfs files are being accessed.  In particular it can block
while any of the 'open' methods are being called and all of these use
malloc for one thing or another.  So this can deadlock if the memory
allocation waits for NFS to complete some writes via rpciod.

rpc_clnt_remove_pipedir() can take the inode_lock() and while it isn't
obvious that memory allocations can happen while the lock it held, it is
safer to assume they might and to not let rpciod call
rpc_clnt_remove_pipedir().

So this patch moves these two calls (together with the final kfree() and
rpciod_down()) into a work-item to be run from the system work-queue.
rpciod can continue its important work, and the final stages of the free
can happen whenever they happen.

I have seen this deadlock on a 4.12 based kernel where debugfs used
synchronize_srcu() when removing objects.  synchronize_srcu() requires a
workqueue and there were no free workther threads and none could be
allocated.  While debugsfs no longer uses SRCU, I believe the deadlock
is still possible.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 include/linux/sunrpc/clnt.h |  8 +++++++-
 net/sunrpc/clnt.c           | 21 +++++++++++++++++----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index ca7e108248e2..7bd124e06b36 100644
=2D-- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -71,7 +71,13 @@ struct rpc_clnt {
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 	struct dentry		*cl_debugfs;	/* debugfs directory */
 #endif
=2D	struct rpc_xprt_iter	cl_xpi;
+	/* cl_work is only needed after cl_xpi is no longer used,
+	 * and that are of similar size
+	 */
+	union {
+		struct rpc_xprt_iter	cl_xpi;
+		struct work_struct	cl_work;
+	};
 	const struct cred	*cl_cred;
 };
=20
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 7324b21f923e..a2c215a6980d 100644
=2D-- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -880,6 +880,20 @@ EXPORT_SYMBOL_GPL(rpc_shutdown_client);
 /*
  * Free an RPC client
  */
+static void rpc_free_client_work(struct work_struct *work)
+{
+	struct rpc_clnt *clnt =3D container_of(work, struct rpc_clnt, cl_work);
+
+	/* These might block on processes that might allocate memory,
+	 * so they cannot be called in rpciod, so they are handled separately
+	 * here.
+	 */
+	rpc_clnt_debugfs_unregister(clnt);
+	rpc_clnt_remove_pipedir(clnt);
+
+	kfree(clnt);
+	rpciod_down();
+}
 static struct rpc_clnt *
 rpc_free_client(struct rpc_clnt *clnt)
 {
@@ -890,17 +904,16 @@ rpc_free_client(struct rpc_clnt *clnt)
 			rcu_dereference(clnt->cl_xprt)->servername);
 	if (clnt->cl_parent !=3D clnt)
 		parent =3D clnt->cl_parent;
=2D	rpc_clnt_debugfs_unregister(clnt);
=2D	rpc_clnt_remove_pipedir(clnt);
 	rpc_unregister_client(clnt);
 	rpc_free_iostats(clnt->cl_metrics);
 	clnt->cl_metrics =3D NULL;
 	xprt_put(rcu_dereference_raw(clnt->cl_xprt));
 	xprt_iter_destroy(&clnt->cl_xpi);
=2D	rpciod_down();
 	put_cred(clnt->cl_cred);
 	rpc_free_clid(clnt);
=2D	kfree(clnt);
+
+	INIT_WORK(&clnt->cl_work, rpc_free_client_work);
+	schedule_work(&clnt->cl_work);
 	return parent;
 }
=20
=2D-=20
2.26.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6GrpUACgkQOeye3VZi
gbmZKg/+OBc2GanKvBbFfasuQUq2TxYQ67iCbgekrwrTiAJejs4nWwAtyuWyzhJo
1+v+l3BhvqQizK06L0KLDpXS6ajTDvZ4YdDqMBjqvJ5kTqK67le/jdNU/YfzINBi
ier80gzmUqnqnJuIGjRcZkgCiCmC/HMFGmS4uSplRJx+CeHBzuSQn1ZQiW5BiiBu
Uy2iIuCBAKZZwbMl5iqGq3Q+yv/+dQJfQTJhcaDlWMYcPb+0mWiG8anNpa0OI3c3
FSltmaUJSI4i7nqA1WdGegGasb77kndiQb8XFUMwnlf8uU+ctZ5MY6VDtFw3PFxu
6DJ5ljJ69q5R4/atVOi8NVeJ1aPYoJ4PelP8TlnvC4LlEv8S7J2Xs7WVRyD898OY
VMjDs1zWreSXmEl7FJ+Q7p/6at59dT2Wkl0zY6Rbn+OaOxmwxsms3/xyKJtsq5jP
mEXdg0duXxjmtH85xvogTKUZ8KI1chAyXiA71qFneNFroR0h8Lxm8Gewv1uulJ6Q
cX27o8rTeLsGLtCJ3dXXdbdwufI7uHNSM2Fq4Hd+lGbIG/F/pAd/iKsgwXTCgjSm
Clrj2xhcO96v4u2UENHy8vOGA06CMjMnwy+h4OM2MDCY4VFba69BspBLgoy5e0iI
tYIZtPZPdmB2UoEFo6wNcR46gMQHM3/qibei3bes4/mT2lb+wN0=
=s/jM
-----END PGP SIGNATURE-----
--=-=-=--
