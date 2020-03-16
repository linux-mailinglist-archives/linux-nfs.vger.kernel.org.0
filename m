Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69E41860AB
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2020 01:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbgCPAFq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 15 Mar 2020 20:05:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729065AbgCPAFq (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 15 Mar 2020 20:05:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ED0AEAD82;
        Mon, 16 Mar 2020 00:05:42 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Mon, 16 Mar 2020 11:05:36 +1100
Subject: [PATCH/RFC] NFS: Minimize COMMIT calls during writeback.
cc:     linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <87y2s1rwof.fsf@notabene.neil.brown.name>
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


Since 4.13 (see Fixes: commit) NFS has sent a COMMIT request for every
.writepages() call it received - when the writes submitted for that call
have all completed.

This works well enough when COMMIT is fast, but if COMMIT is slow these
calls can overlap each other, overload the server, and substantially
reduce throughput.

I looked at this due to a report of regression when writing to a Ganesha
NFS server with tracing showing multiple overlapping COMMITs, and
individual commits typically taking 200ms to 300ms.  This resulted in 2
orders of magnitude slow down when writing 1000x1M from /dev/zero with dd.
This is easily reproduced by adding 'msleep(300)' to nfsd_commit() in the
Linux NFS server.

This patch changes the details of when COMMIT is sent without changing
the general approach.

Where previously the writes from a single .writepages() call were
accounted together in a nfs_io_completion, now the writes from multiple
writepages() calls are accounted together.  The set of writepages calls
that are grouped together are all those from when one COMMIT call ends
to when the next COMMIT call ends.  This automatically reduces the rate
of COMMIT requests when COMMIT itself is slow.
(If there are no COMMIT calls pending, the first .writepages will get
 an nfs_io_completion to itself, then subsequenct writepages requests
 until the first COMMIT completes will go in the next nfs_io_completion)

There are typically at most two nfs_io_completion structures allocated
for writeback to a given inode.

=2D If there was been any writepages calls since the last time a COMMIT
  completed, there will be an nfs_io_completion stored in the inode (in
  nfs_mds_commit_info) which new writepages requests are accounted it.

=2D If there is no pending COMMIT request, but there are pending writeback
  WRITES, there will be another nfs_io_completion which is not attached
  and which is draining.  When it fully drains a COMMIT will be sent.
  When that COMMIT completes, the attached nfs_io_completion will be
  detached and allowed to drain.

The rpcs_out counter now counts the unattached nfs_io_completion as well
as any pending COMMIT requests.  As an unattached nfs_io_completion will
soon turn into a COMMIT request, this seems reasonable.  It allows us to
clearly detect when there are no longer any COMMITs expected to
complete, so we know to detach any nfs_io_completion from the inode and
allow it to drain.

As we use atomic accesses (e.g.  xchg and kref_get_unless_zero()) to
access the attached nfs_io_completion, we now use kfree_rcu() to free
it, to ensure it is not accessed after it is freed.

With 300ms commits, this improves throught of a 1G dd by 2 orders of
magnitude.  Even without the 300ms delay, this noticeably improves
throughput to a Linux NFS server is a simple VM.

Fixes: 919e3bd9a875 ("NFS: Ensure we commit after writeback is complete")
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 fs/nfs/inode.c          |  1 +
 fs/nfs/write.c          | 50 ++++++++++++++++++++++++++++++++++++-----
 include/linux/nfs_xdr.h |  7 ++++++
 3 files changed, 53 insertions(+), 5 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 11bf15800ac9..c00b54491949 100644
=2D-- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -2110,6 +2110,7 @@ static void init_once(void *foo)
 	INIT_LIST_HEAD(&nfsi->commit_info.list);
 	atomic_long_set(&nfsi->nrequests, 0);
 	atomic_long_set(&nfsi->commit_info.ncommit, 0);
+	nfsi->commit_info.ioc =3D NULL;
 	atomic_set(&nfsi->commit_info.rpcs_out, 0);
 	init_rwsem(&nfsi->rmdir_sem);
 	mutex_init(&nfsi->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c478b772cc49..57e209f964e4 100644
=2D-- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -47,6 +47,7 @@ struct nfs_io_completion {
 	void (*complete)(void *data);
 	void *data;
 	struct kref refcount;
+	struct rcu_head rcu;
 };
=20
 /*
@@ -134,7 +135,7 @@ static void nfs_io_completion_release(struct kref *kref)
 	struct nfs_io_completion *ioc =3D container_of(kref,
 			struct nfs_io_completion, refcount);
 	ioc->complete(ioc->data);
=2D	kfree(ioc);
+	kfree_rcu(ioc, rcu);
 }
=20
 static void nfs_io_completion_get(struct nfs_io_completion *ioc)
@@ -720,6 +721,8 @@ static void nfs_io_completion_commit(void *inode)
 	nfs_commit_inode(inode, 0);
 }
=20
+static void nfs_commit_end(struct nfs_mds_commit_info *cinfo);
+
 int nfs_writepages(struct address_space *mapping, struct writeback_control=
 *wbc)
 {
 	struct inode *inode =3D mapping->host;
@@ -729,9 +732,37 @@ int nfs_writepages(struct address_space *mapping, stru=
ct writeback_control *wbc)
=20
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
=20
=2D	ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
=2D	if (ioc)
=2D		nfs_io_completion_init(ioc, nfs_io_completion_commit, inode);
+	rcu_read_lock();
+	ioc =3D rcu_dereference(NFS_I(inode)->commit_info.ioc);
+	if (ioc && kref_get_unless_zero(&ioc->refcount)) {
+		rcu_read_unlock();
+		/* We've successfully piggybacked on the attached ioc */
+	} else {
+		rcu_read_unlock();
+		ioc =3D nfs_io_completion_alloc(GFP_KERNEL);
+		if (ioc) {
+			struct nfs_io_completion *ioc_prev;
+
+			nfs_io_completion_init(ioc, nfs_io_completion_commit,
+					       inode);
+			/* Temporarily elevate rpcs_out to ensure a commit
+			 * completion *will* happen after we attach this ioc,
+			 * so it *will* get a chance to drain.
+			 */
+			atomic_inc(&NFS_I(inode)->commit_info.rpcs_out);
+			nfs_io_completion_get(ioc);
+			ioc_prev =3D xchg(&NFS_I(inode)->commit_info.ioc,
+				    ioc);
+			/* ioc_prev is normally NULL, but racing writepages
+			 * calls might result in it being non-NULL.
+			 * In either case it is safe to put it - worst case
+			 * we get an extra COMMIT.
+			 */
+			nfs_io_completion_put(ioc_prev);
+			/* release temporary ref on rpcs_out */
+			nfs_commit_end(&NFS_I(inode)->commit_info);
+		}
+	}
=20
 	nfs_pageio_init_write(&pgio, inode, wb_priority(wbc), false,
 				&nfs_async_write_completion_ops);
@@ -1677,8 +1708,17 @@ static void nfs_commit_begin(struct nfs_mds_commit_i=
nfo *cinfo)
=20
 static void nfs_commit_end(struct nfs_mds_commit_info *cinfo)
 {
=2D	if (atomic_dec_and_test(&cinfo->rpcs_out))
+	if (atomic_dec_and_test(&cinfo->rpcs_out)) {
+		/* When a commit finishes, we must release any attached
+		 * nfs_io_completion so that it can drain and then request
+		 * another commit.
+		 */
+		struct nfs_io_completion *ioc;
+		ioc =3D xchg(&cinfo->ioc, NULL);
+		nfs_io_completion_put(ioc);
+
 		wake_up_var(&cinfo->rpcs_out);
+	}
 }
=20
 void nfs_commitdata_release(struct nfs_commit_data *data)
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 94c77ed55ce1..89db1e9d461d 100644
=2D-- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1557,9 +1557,16 @@ struct nfs_pgio_header {
 };
=20
 struct nfs_mds_commit_info {
+	/* rpcs_out counts pending COMMIT rpcs plus pendng nfs_io_completions
+	 * which are *not* attached at 'ioc' below.  Such nfs_io_compleions
+	 * (normally at most one) will drain as writes complete and then trigger
+	 * a COMMIT, so they can be considered as pending COMMITs which haven't
+	 * been sent yet
+	 */
 	atomic_t rpcs_out;
 	atomic_long_t		ncommit;
 	struct list_head	list;
+	struct nfs_io_completion *ioc;
 };
=20
 struct nfs_commit_info;
=2D-=20
2.25.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl5uwtAACgkQOeye3VZi
gbkB5g/+KaX8DPXXfR5g2s14cdpN3Exxdl864SAWcIhiweRYjNgJPeEjf5GigGIK
OGb05hFbok3aT4cxsP9o1TTu4whkEXVID9cg3vo8rx7W0EEN3f4QjmH7E0/yBQ3U
vp3Z3aSS1Bt5iiBhefM5s8DAqdj9iFPIk5uXvvhs79UoObeDCdE+0FRjTIy6shb9
ubs3NMNa8feJ6VDgeCHNGJqqexeVwi9aXDs2ASVmD2b8JEzuU1ykEjNdsWEs5gyY
dx16gO9SgwikWlHTPBBr3b5lIYQ+MJWdF7B379mjYczVuYPPP9OujeWrVWQPjMgm
1l20j781se6Ti4UAm0HNEQIeoc1WhHNTeCVjIBto2mJQwbNtWm4yGXhICScGxld9
6jd9KlAzWqUTIlRE57uIl3Pc83+i/CRIGJvLBQDonUpfJqs0Ku8ghaVMUEQip9Sz
oLMNigGmvAI15JHryA2BygC2r/aPiTxW1RqrAlNu0fjIdRduSP+ZtzBZmu92Scsv
BIcX4VY69cySjwV3AqlgAs3y7wl4ymEmZDNn/Funsxqenyy2vFxYMTG4S4GyVZcO
9lMaW0dGfdCpLrea3liu6JvXTlkKFba5YBDmilcMLZE6bI5SWdQ4VpMPJgJIKtc8
xSJrT5P9gjbcuri+EsQF1DwLej71D62BM09wBriZedaaKtmyvkA=
=WLDm
-----END PGP SIGNATURE-----
--=-=-=--
