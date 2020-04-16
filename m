Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D381AB4CA
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 02:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404086AbgDPAaz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Apr 2020 20:30:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:43078 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403969AbgDPAaw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 Apr 2020 20:30:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E24C4AF62;
        Thu, 16 Apr 2020 00:30:48 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@kernel.org>
Date:   Thu, 16 Apr 2020 10:30:42 +1000
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2 V3] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <87wo6gs26e.fsf@notabene.neil.brown.name>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name> <87ftdgw58w.fsf@notabene.neil.brown.name> <87wo6gs26e.fsf@notabene.neil.brown.name>
Message-ID: <87tv1ks24t.fsf@notabene.neil.brown.name>
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
throttled.

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

This patch changes the heuristic so that the task is only throttled if
*both* the global threshhold *and* the per-wb threshold are exceeded.
This is similar to the effect of BDI_CAP_STRICTLIMIT which causes the
global limits to be ignored, but it isn't as strict.  A PF_LOCAL_THROTTLE
task will be allowed to proceed unthrottled if the global threshold is
not exceeded or if the local threshold is not exceeded.  They need to
both be exceeded before PF_LOCAL_THROTTLE tasks are throttled.

This approach of "only throttle when target bdi is busy" is consistent
with the other use of PF_LESS_THROTTLE in current_may_throttle(), were
it causes attention to be focussed only on the target bdi.

So this patch
 - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
 - removes the 25% bonus that that flag gives, and
 - If PF_LOCAL_THROTTLE is set, don't delay at all unless both
   thresholds are exceeded.

Note that previously realtime threads were treated the same as
PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
real-time threads, so it is now different from the behaviour of nfsd and
loop tasks.  I don't know what is wanted for realtime.

Acked-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 drivers/block/loop.c  |  2 +-
 fs/nfsd/vfs.c         |  9 +++++----
 include/linux/sched.h |  3 ++-
 kernel/sys.c          |  2 +-
 mm/page-writeback.c   | 18 ++++++++++++++----
 mm/vmscan.c           |  4 ++--
 6 files changed, 25 insertions(+), 13 deletions(-)

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
index 7326b54ab728..9692c553526b 100644
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
@@ -1700,6 +1699,17 @@ static void balance_dirty_pages(struct bdi_writeback=
 *wb,
 				sdtc =3D mdtc;
 		}
=20
+		if (current->flags & PF_LOCAL_THROTTLE)
+			/* This task must only be throttled based on the bdi
+			 * it is writing to - dirty pages for other bdis might
+			 * be pages this task is trying to write out.  So it
+			 * gets a free pass unless both global and local
+			 * thresholds are exceeded.  i.e unless
+			 * "dirty_exceeded".
+			 */
+			if (!dirty_exceeded)
+				break;
+
 		if (dirty_exceeded && !wb->dirty_exceeded)
 			wb->dirty_exceeded =3D 1;
=20
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b06868fc4926..80ab523926aa 100644
=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1879,13 +1879,13 @@ static unsigned noinline_for_stack move_pages_to_lr=
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
2.26.0


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6XpzIACgkQOeye3VZi
gblxTg/9H3OthTPtgokar8rv/DOZ1O4zATcEl4h2SYG0KF2h7yib8sx/SVzf8MEY
QPJAv4yeC9OZyxW/wJx0gIXIE6Q1qRCMs8ufjb914y3j87RqWbWMrTbMHN1AkUFi
UzYl9La/poEfRCUkrZ63QJ57p3CarHQjp7jnDJcwBJhIN1qV8ox+E+IWHFcnTpc0
YfXk5WetDp3AUAv1CKcRHqOGrFzuNmEkhBV1wevtO4SgKFx73sovBfxBBLyTg8Zi
0Vcc6dswa693/fTgwSNA67a2Ad9V2DEx3ajmcpITrj93KGBi5ebyqn32kXhseYay
IyQnsMIiyP2qThVb9Z9uSrbkwyPvp3UrObDqHO5SJC8i80XHhZBREY5aiq25QA0x
V1qi7L8tltWMCqym7uSohacnayxrSGvUk551p4Sb2b/jvqeM+D5rkZiQZUqanZ5s
IchStC0Gov5cIFiYTJYFL2pz1qmvB5wivJ3V027Rlg6mb4vSXYcaKANp952ycE91
MehuphI4Xm2Mz+lfhoDv5l5HIXmntqpRGSYhUL02927R2NccxueTUj0ZD422XV01
t0Mjes5tVM5lWUIuCJ5iyFMqjHp38KYlqZpTG9XEjDLz8IPfxe51Uj1p6lFjK0Om
ndE+6t1XA/UJTlh8Y6eVvUHMtP/HiMBccQyQaknYigM9xmLVh1U=
=VvA2
-----END PGP SIGNATURE-----
--=-=-=--
