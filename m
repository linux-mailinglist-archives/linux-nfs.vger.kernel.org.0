Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674791E9B0F
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2020 02:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbgFAAsX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 31 May 2020 20:48:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53570 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727915AbgFAAsW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sun, 31 May 2020 20:48:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66B46AD39;
        Mon,  1 Jun 2020 00:48:21 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Date:   Mon, 01 Jun 2020 10:48:12 +1000
Cc:     Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <87imgb7gus.fsf@notabene.neil.brown.name>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87ftdgw58w.fsf@notabene.neil.brown.name> <87wo6gs26e.fsf@notabene.neil.brown.name> <87tv1ks24t.fsf@notabene.neil.brown.name> <20200416151906.GQ23739@quack2.suse.cz> <87zhb5r30c.fsf@notabene.neil.brown.name> <20200422124600.GH8775@quack2.suse.cz> <871rnob8z3.fsf@notabene.neil.brown.name> <87y2pw9udb.fsf@notabene.neil.brown.name> <20200515111043.GK9569@quack2.suse.cz> <87imgb7gus.fsf@notabene.neil.brown.name>
Message-ID: <87ftbf7gs3.fsf@notabene.neil.brown.name>
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


PF_LESS_THROTTLE exists for loop-back nfsd (and a similar need in the
loop block driver and callers of prctl(PR_SET_IO_FLUSHER)), where a
daemon needs to write to one bdi (the final bdi) in order to free up
writes queued to another bdi (the client bdi).

The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
pages, so that it can still dirty pages after other processses have been
throttled.  The purpose of this is to avoid deadlock that happen when
the PF_LESS_THROTTLE process must write for any dirty pages to be freed,
but it is being thottled and cannot write.

This approach was designed when all threads were blocked equally,
independently on which device they were writing to, or how fast it was.
Since that time the writeback algorithm has changed substantially with
different threads getting different allowances based on non-trivial
heuristics.  This means the simple "add 25%" heuristic is no longer
reliable.

The important issue is not that the daemon needs a *larger* dirty page
allowance, but that it needs a *private* dirty page allowance, so that
dirty pages for the "client" bdi that it is helping to clear (the bdi for
an NFS filesystem or loop block device etc) do not affect the throttling
of the deamon writing to the "final" bdi.

This patch changes the heuristic so that the task is not throttled when
the bdi it is writing to has a dirty page count below below (or equal
to) the free-run threshold for that bdi.  This ensures it will always be
able to have some pages in flight, and so will not deadlock.

In a steady-state, it is expected that PF_LOCAL_THROTTLE tasks might
still be throttled by global threshold, but that is acceptable as it is
only the deadlock state that is interesting for this flag.

This approach of "only throttle when target bdi is busy" is consistent
with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
it causes attention to be focussed only on the target bdi.

So this patch
 - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
 - removes the 25% bonus that that flag gives, and
 - If PF_LOCAL_THROTTLE is set, don't delay at all unless the
   global and the local free-run thresholds are exceeded.

Note that previously realtime threads were treated the same as
PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
real-time threads, so it is now different from the behaviour of nfsd and
loop tasks.  I don't know what is wanted for realtime.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: Chuck Lever <chuck.lever@oracle.com> (for nfsd change)
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 drivers/block/loop.c  |  2 +-
 fs/nfsd/vfs.c         |  9 +++++----
 include/linux/sched.h |  3 ++-
 kernel/sys.c          |  2 +-
 mm/page-writeback.c   | 41 +++++++++++++++++++++++++++++++++--------
 mm/vmscan.c           |  4 ++--
 6 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index da693e6a834e..d89c25ba3b89 100644
=2D-- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -919,7 +919,7 @@ static void loop_unprepare_queue(struct loop_device *lo)
=20
 static int loop_kthread_worker_fn(void *worker_ptr)
 {
=2D	current->flags |=3D PF_LESS_THROTTLE | PF_MEMALLOC_NOIO;
+	current->flags |=3D PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
 	return kthread_worker_fn(worker_ptr);
 }
=20
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0aa02eb18bd3..c3fbab1753ec 100644
=2D-- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -979,12 +979,13 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp, struct nfsd_file *nf,
=20
 	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
 		/*
=2D		 * We want less throttling in balance_dirty_pages()
=2D		 * and shrink_inactive_list() so that nfs to
+		 * We want throttling in balance_dirty_pages()
+		 * and shrink_inactive_list() to only consider
+		 * the backingdev we are writing to, so that nfs to
 		 * localhost doesn't cause nfsd to lock up due to all
 		 * the client's dirty pages or its congested queue.
 		 */
=2D		current->flags |=3D PF_LESS_THROTTLE;
+		current->flags |=3D PF_LOCAL_THROTTLE;
=20
 	exp =3D fhp->fh_export;
 	use_wgather =3D (rqstp->rq_vers =3D=3D 2) && EX_WGATHER(exp);
@@ -1037,7 +1038,7 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh =
*fhp, struct nfsd_file *nf,
 		nfserr =3D nfserrno(host_err);
 	}
 	if (test_bit(RQ_LOCAL, &rqstp->rq_flags))
=2D		current_restore_flags(pflags, PF_LESS_THROTTLE);
+		current_restore_flags(pflags, PF_LOCAL_THROTTLE);
 	return nfserr;
 }
=20
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 4418f5cb8324..5955a089df32 100644
=2D-- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1481,7 +1481,8 @@ extern struct pid *cad_pid;
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inheri=
t GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inheri=
t GFP_NOIO */
=2D#define PF_LESS_THROTTLE	0x00100000	/* Throttle me less: I clean memory =
*/
+#define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only agasint the b=
di I write to,
+						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
diff --git a/kernel/sys.c b/kernel/sys.c
index d325f3ab624a..180a2fa33f7f 100644
=2D-- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2262,7 +2262,7 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struc=
t *t, unsigned long which,
 	return -EINVAL;
 }
=20
=2D#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LESS_THROTTLE)
+#define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
=20
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, ar=
g3,
 		unsigned long, arg4, unsigned long, arg5)
diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7326b54ab728..f02a71797781 100644
=2D-- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -387,8 +387,7 @@ static unsigned long global_dirtyable_memory(void)
  * Calculate @dtc->thresh and ->bg_thresh considering
  * vm_dirty_{bytes|ratio} and dirty_background_{bytes|ratio}.  The caller
  * must ensure that @dtc->avail is set before calling this function.  The
=2D * dirty limits will be lifted by 1/4 for PF_LESS_THROTTLE (ie. nfsd) and
=2D * real-time tasks.
+ * dirty limits will be lifted by 1/4 for real-time tasks.
  */
 static void domain_dirty_limits(struct dirty_throttle_control *dtc)
 {
@@ -436,7 +435,7 @@ static void domain_dirty_limits(struct dirty_throttle_c=
ontrol *dtc)
 	if (bg_thresh >=3D thresh)
 		bg_thresh =3D thresh / 2;
 	tsk =3D current;
=2D	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk)) {
+	if (rt_task(tsk)) {
 		bg_thresh +=3D bg_thresh / 4 + global_wb_domain.dirty_limit / 32;
 		thresh +=3D thresh / 4 + global_wb_domain.dirty_limit / 32;
 	}
@@ -486,7 +485,7 @@ static unsigned long node_dirty_limit(struct pglist_dat=
a *pgdat)
 	else
 		dirty =3D vm_dirty_ratio * node_memory / 100;
=20
=2D	if (tsk->flags & PF_LESS_THROTTLE || rt_task(tsk))
+	if (rt_task(tsk))
 		dirty +=3D dirty / 4;
=20
 	return dirty;
@@ -1653,8 +1652,12 @@ static void balance_dirty_pages(struct bdi_writeback=
 *wb,
 		if (dirty <=3D dirty_freerun_ceiling(thresh, bg_thresh) &&
 		    (!mdtc ||
 		     m_dirty <=3D dirty_freerun_ceiling(m_thresh, m_bg_thresh))) {
=2D			unsigned long intv =3D dirty_poll_interval(dirty, thresh);
=2D			unsigned long m_intv =3D ULONG_MAX;
+			unsigned long intv;
+			unsigned long m_intv;
+
+		free_running:
+			intv =3D dirty_poll_interval(dirty, thresh);
+			m_intv =3D ULONG_MAX;
=20
 			current->dirty_paused_when =3D now;
 			current->nr_dirtied =3D 0;
@@ -1673,9 +1676,20 @@ static void balance_dirty_pages(struct bdi_writeback=
 *wb,
 		 * Calculate global domain's pos_ratio and select the
 		 * global dtc by default.
 		 */
=2D		if (!strictlimit)
+		if (!strictlimit) {
 			wb_dirty_limits(gdtc);
=20
+			if ((current->flags & PF_LOCAL_THROTTLE) &&
+			    gdtc->wb_dirty <
+			    dirty_freerun_ceiling(gdtc->wb_thresh,
+						  gdtc->wb_bg_thresh))
+				/*
+				 * LOCAL_THROTTLE tasks must not be throttled
+				 * when below the per-wb freerun ceiling.
+				 */
+				goto free_running;
+		}
+
 		dirty_exceeded =3D (gdtc->wb_dirty > gdtc->wb_thresh) &&
 			((gdtc->dirty > gdtc->thresh) || strictlimit);
=20
@@ -1689,9 +1703,20 @@ static void balance_dirty_pages(struct bdi_writeback=
 *wb,
 			 * both global and memcg domains.  Choose the one
 			 * w/ lower pos_ratio.
 			 */
=2D			if (!strictlimit)
+			if (!strictlimit) {
 				wb_dirty_limits(mdtc);
=20
+				if ((current->flags & PF_LOCAL_THROTTLE) &&
+				    mdtc->wb_dirty <
+				    dirty_freerun_ceiling(mdtc->wb_thresh,
+							  mdtc->wb_bg_thresh))
+					/*
+					 * LOCAL_THROTTLE tasks must not be
+					 * throttled when below the per-wb
+					 * freerun ceiling.
+					 */
+					goto free_running;
+			}
 			dirty_exceeded |=3D (mdtc->wb_dirty > mdtc->wb_thresh) &&
 				((mdtc->dirty > mdtc->thresh) || strictlimit);
=20
diff --git a/mm/vmscan.c b/mm/vmscan.c
index a37c87b5aee2..b2f5deb3603c 100644
=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1878,13 +1878,13 @@ static unsigned noinline_for_stack move_pages_to_lr=
u(struct lruvec *lruvec,
=20
 /*
  * If a kernel thread (such as nfsd for loop-back mounts) services
=2D * a backing device by writing to the page cache it sets PF_LESS_THROTTL=
E.
+ * a backing device by writing to the page cache it sets PF_LOCAL_THROTTLE.
  * In that case we should only throttle if the backing device it is
  * writing to is congested.  In other cases it is safe to throttle.
  */
 static int current_may_throttle(void)
 {
=2D	return !(current->flags & PF_LESS_THROTTLE) ||
+	return !(current->flags & PF_LOCAL_THROTTLE) ||
 		current->backing_dev_info =3D=3D NULL ||
 		bdi_write_congested(current->backing_dev_info);
 }
=2D-=20
2.26.2


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl7UUEwACgkQOeye3VZi
gbkighAAm8tu0AovDhLW6rvgm2aOG5L5vFqBcs9KWbEucRwt4oiNQweEHWnwvUib
qDRtfl4qfXWE6jX3afzrNfPqkBNsRE/KMamB1ZUila6Hh1LqBwUZZyQnbmfKxz3e
5RkRI7MQIlWOv1Bhmi6twZYKf6QtjntjR53Fm3zj/LblPzCLjuBeQ+QDPZe5oNM1
D1QAWTQfuUlCUTMV2C+tcOmYLr4d9H5KVtR3dvM7OGIzw7w8yhTja5h0aHuf/N5I
4b36dsNMDuwCTPXV3sAJuXqTM/kI8MmWttuaywYVLGI9ncqo1rjraGJIKdvE0cbg
jFkAoClFgBimmnxs4ISYp8MKjKsXe00Yx2qKH04BEBuLV3cj7nbh+1QyaQwql+QU
gByYwwL8EijT5IeJFuMK5N/FK/h9T8HXL63iXQE4PAp1jDsw08VBGkEfKsfI9gho
NJu2SrdDp396+Y/nX3M0uIkSuple22VKUhrIzFFNJQBHwFvH1Fv2oSaPAJ4Cd5Nx
bZUar1IOCrP6hhh+Qr4Vz6ZkBJqRkEOfmGILOkbx08xYj3Hy+gx/poSbqaEDm4sZ
LNtnj8hoJBZcmeQXJDMCQ7G389yJwz1VTZwBs9EYzXdak4KSjjX0PPYEFwabNTcV
H44uYCYu8wwawyYQlUHxL4W2HOTfoInwqXlSNgyZq+0bcQ8oXUg=
=zurl
-----END PGP SIGNATURE-----
--=-=-=--
