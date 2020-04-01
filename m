Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B96A319B91B
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Apr 2020 01:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733008AbgDAXx3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 19:53:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:38468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732682AbgDAXx3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 19:53:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EB70AEC6;
        Wed,  1 Apr 2020 23:53:27 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "Anna.Schumaker\@Netapp.com" <Anna.Schumaker@Netapp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Date:   Thu, 02 Apr 2020 10:53:20 +1100
Cc:     linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] MM: replace PF_LESS_THROTTLE with PF_LOCAL_THROTTLE
In-Reply-To: <87v9miydai.fsf@notabene.neil.brown.name>
References: <87tv2b7q72.fsf@notabene.neil.brown.name> <87v9miydai.fsf@notabene.neil.brown.name>
Message-ID: <87sghmyd8v.fsf@notabene.neil.brown.name>
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


PF_LESS_THROTTLE exists for loop-back nfsd, and a similar need in the
loop block driver, where a daemon needs to write to one bdi in
order to free up writes queued to another bdi.

The daemon sets PF_LESS_THROTTLE and gets a larger allowance of dirty
pages, so that it can still dirty pages after other processses have been
throttled.

This approach was designed when all threads were blocked equally,
independently on which device they were writing to, or how fast it was.
Since that time the writeback algorithm has changed substantially with
different threads getting different allowances based on non-trivial
heuristics.  This means the simple "add 25%" heuristic is no longer
reliable.

This patch changes the heuristic to ignore the global limits and
consider only the limit relevant to the bdi being written to.  This
approach is already available for BDI_CAP_STRICTLIMIT users (fuse) and
should not introduce surprises.  This has the desired result of
protecting the task from the consequences of large amounts of dirty data
queued for other devices.

This approach of "only consider the target bdi" is consistent with the
other use of PF_LESS_THROTTLE in current_may_throttle(), were it causes
attention to be focussed only on the target bdi.

So this patch
 - renames PF_LESS_THROTTLE to PF_LOCAL_THROTTLE,
 - remove the 25% bonus that that flag gives, and
 - imposes 'strictlimit' handling for any process with PF_LOCAL_THROTTLE
   set.

Note that previously realtime threads were treated the same as
PF_LESS_THROTTLE threads.  This patch does *not* change the behvaiour for
real-time threads, so it is now different from the behaviour of nfsd and
loop tasks.  I don't know what is wanted for realtime.

Signed-off-by: NeilBrown <neilb@suse.de>
=2D--
 drivers/block/loop.c  |  2 +-
 fs/nfsd/vfs.c         |  9 +++++----
 include/linux/sched.h |  2 +-
 kernel/sys.c          |  2 +-
 mm/page-writeback.c   | 10 ++++++----
 mm/vmscan.c           |  4 ++--
 6 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 739b372a5112..2c59371ce936 100644
=2D-- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -897,7 +897,7 @@ static void loop_unprepare_queue(struct loop_device *lo)
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
index 04278493bf15..5dcd27abc8cd 100644
=2D-- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1473,7 +1473,7 @@ extern struct pid *cad_pid;
 #define PF_KSWAPD		0x00020000	/* I am kswapd */
 #define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inheri=
t GFP_NOFS */
 #define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inheri=
t GFP_NOIO */
=2D#define PF_LESS_THROTTLE	0x00100000	/* Throttle me less: I clean memory =
*/
+#define PF_LOCAL_THROTTLE	0x00100000	/* Throttle me less: I clean memory */
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
index 2caf780a42e7..2afb09fa2fe0 100644
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
@@ -1580,6 +1579,9 @@ static void balance_dirty_pages(struct bdi_writeback =
*wb,
 	bool strictlimit =3D bdi->capabilities & BDI_CAP_STRICTLIMIT;
 	unsigned long start_time =3D jiffies;
=20
+	if (current->flags & PF_LOCAL_THROTTLE)
+		/* This task must only be throttled by its own writeback */
+		strictlimit =3D true;
 	for (;;) {
 		unsigned long now =3D jiffies;
 		unsigned long dirty, thresh, bg_thresh;
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 876370565455..c5cf25938c56 100644
=2D-- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1880,13 +1880,13 @@ static unsigned noinline_for_stack move_pages_to_lr=
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

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl6FKXAACgkQOeye3VZi
gbk+MQ//bcEgMT5Zpv9O/dBSsXZXAb3xa/L0Rh/3fJP04ApbxjsltqS9kUXRAkeB
z+GjhE7/Sa8v7OEMG9DihUc6vRtBULUzsLVQK7XL7dtlCNLTJMZAdf6x5V/PJlcK
qLX97Fz0O+Vh/QDnZ67O3rkXU8R2bYgjYn+z8GG9C6hZfz5YSMzXKlPjhZVGWLMu
ZCDYDK+M+qJlaBOQ7XFdDakm88kDUrd1I8Hla9oN4LRuYhN2QhtYTpbpdPMRqqqt
QCEJFB+44+OGMNUy1S6iJU4RoMwstBlQISDXH1+NoBaEeiyW45kseRpTVBFXVLmd
aeliKm3JygvEyr5ndSq/fxwW301zG6STDPcow8/bPa2fqLnSbokBNbivOR8A+gdW
vzDR812O1e8BHwC4lq332CBuod6mNPRmjy8FtHPFPolfPmncO3T0zxh4RCrxS7Wb
8oWw8hsbpO+TU+HNicu5YwWJ6HUAKVvvmqpu6pEOxyGznGiHHWuKRBe85gxUVI5h
m+qwnCWrHArl61Q6fkwZsNhZIKGx1WlEZa2stT+nIImmktZj4CfVtRai9Ff9LifI
09ISrYOBkv7zwT2/ZULfU6+H0UoJoKXsz2D3MBFbyUYLC+9ZP1TIjG6bVOajfwuk
43ktWdtUs1ACRrjwNU8IW2ges2hnG5blhRdGJTVtgPg3HqkGtKc=
=l23v
-----END PGP SIGNATURE-----
--=-=-=--
