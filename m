Return-Path: <linux-nfs+bounces-12833-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F5AEF55D
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7FD179E1E
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5383026A0FC;
	Tue,  1 Jul 2025 10:43:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AA1264626
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751366597; cv=none; b=HFZO+YLj2ynjsv9LeAT0F07DoF2cU43CtbVPtNy2JHgD48eBHHAfyDuc5smQa0jCQaoujeAzZ9nfgCbXOqVsrjxCAjebrSR80KExrJaTwdqs44+PIc2mqKm/mkA1qG1T+HVbeXnTaDhSfVxBHAWOYTRnGCxktYzCvKpBbdk7lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751366597; c=relaxed/simple;
	bh=zF3lAvMP1r6jIuYqrvDyAa1tXYlmcWm80iYik+ezoEg=;
	h=Content-Type:MIME-Version:From:Subject:To:Cc:Date:Message-id; b=Ya1/1h65j9ZwVRizMpGroyT+O42ASLWc7VXLB6TU7i/jwsVw97ocshh6xmmwLRgULjclGySYUeAI3UqKcTgcvQVxftZGco1fujKpULuBWimROt6ZYOlZenRPVzEq6AIhC3ox2OHte/PAOK7RgA+sEGW5AI2WUkfQBSfB531ox9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWYSF-00Fm43-PP;
	Tue, 01 Jul 2025 10:43:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
Subject: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date: Tue, 01 Jul 2025 20:43:11 +1000
Message-id: <175136659151.565058.6474755472267609432@noble.neil.brown.name>


Writing to v4_end_grace can race with server shutdown and result in
memory being accessed after it was freed - reclaim_str_hashtbl in
particularly.

We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
held while client_tracking_ops->init() is called and that can wait for
an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
deadlock.

nfsd4_end_grace() is also called by the landromat work queue and this
doesn't require locking as server shutdown will stop the work and wait
for it before freeing anything that nfsd4_end_grace() might access.

However, we must be sure that writing to v4_end_grace doesn't restart
the work item before init has completed or after shutdown has already
waited for it.  For this we can use disable_delayed_work() after
INIT_DELAYED_WORK(), and disable_delayed_work_sync() instead of
cancel_delayed_work_sync().

So this patch adds a nfsd_net field "grace_end_forced", sets that when
v4_end_grace is written, and schedules the laundromat (providing it
hasn't been disabled).  This field bypasses other checks for whether the
grace period has finished.  The delayed work is disabled while
nfsd4_client_tracking_init() is running and before
nfsd4_client_tracking_exit() is call to shutdown client tracking.

This resolves a race which can result in use-after-free.

Note that disable_delayed_work_sync() was added in v6.10.  To backport
to an earlier kernel without that interface the exclusion could be
provided by a spinlock and a flag in nn. The flag would be set when
the delayed_work is enabled and cleared when it is disabled.  The
spinlock would be used to ensure nfsd4_force_end_grace() only queues the
work while the flag is set.

[[=20
 v2 - disable laundromat_work while _init is running as well as while
 _exit is running.  Don't depend on ->nfsd_serv, test
 ->client_tracking_ops instead.
]]

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 27 ++++++++++++++++++++++++---
 fs/nfsd/nfsctl.c    |  6 +++---
 fs/nfsd/state.h     |  2 +-
 4 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..d83c68872c4c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -66,6 +66,7 @@ struct nfsd_net {
=20
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
+	bool grace_end_forced;
 	time64_t boot_time;
=20
 	struct dentry *nfsd_client_dir;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86f..857606035f94 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -84,7 +84,7 @@ static u64 current_sessionid =3D 1;
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *low=
ner);
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
-void nfsd4_end_grace(struct nfsd_net *nn);
+static void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_=
state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
@@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compou=
nd_state *cstate,
 	return nfs_ok;
 }
=20
-void
+static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
 	/* do nothing if grace period already ended */
@@ -6491,6 +6491,20 @@ nfsd4_end_grace(struct nfsd_net *nn)
 	 */
 }
=20
+bool
+nfsd4_force_end_grace(struct nfsd_net *nn)
+{
+	if (!nn->client_tracking_ops)
+		return false;
+	/* laundromat_work must be initialised now, though it might be disabled */
+	nn->grace_end_forced =3D true;
+	/* This is a no-op after nfs4_state_shutdown_net() has called
+	 * disable_delayed_work_sync()
+	 */
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	return true;
+}
+
 /*
  * If we've waited a lease period but there are still clients trying to
  * reclaim, wait a little longer to give them a chance to finish.
@@ -6500,6 +6514,8 @@ static bool clients_still_reclaiming(struct nfsd_net *n=
n)
 	time64_t double_grace_period_end =3D nn->boot_time +
 					   2 * nn->nfsd4_lease;
=20
+	if (nn->grace_end_forced)
+		return false;
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) =3D=3D
 			nn->reclaim_str_hashtbl_size)
@@ -8807,6 +8823,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree =3D RB_ROOT;
 	nn->boot_time =3D ktime_get_real_seconds();
 	nn->grace_ended =3D false;
+	nn->grace_end_forced =3D false;
 	nn->nfsd4_manager.block_opens =3D true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8821,6 +8838,8 @@ static int nfs4_state_create_net(struct net *net)
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
=20
 	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
+	/* Make sure his cannot run until client tracking is initialised */
+	disable_delayed_work(&nn->laundromat_work);
 	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
 	get_net(net);
=20
@@ -8887,6 +8906,8 @@ nfs4_state_start_net(struct net *net)
 		return ret;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
+	/* safe for laundromat to run now */
+	enable_delayed_work(&nn->laundromat_work);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size =3D=3D 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
@@ -8935,7 +8956,7 @@ nfs4_state_shutdown_net(struct net *net)
=20
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
-	cancel_delayed_work_sync(&nn->laundromat_work);
+	disable_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
=20
 	INIT_LIST_HEAD(&reaplist);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..658f3f86a59f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1082,10 +1082,10 @@ static ssize_t write_v4_end_grace(struct file *file, =
char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
-			if (!nn->nfsd_serv)
-				return -EBUSY;
 			trace_nfsd_end_grace(netns(file));
-			nfsd4_end_grace(nn);
+			if (!nfsd4_force_end_grace(nn))
+				return -EBUSY;
+
 			break;
 		default:
 			return -EINVAL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1995bca158b8..05eabc69de40 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *net, s=
truct super_block *sb)
 #endif
=20
 /* grace period management */
-void nfsd4_end_grace(struct nfsd_net *nn);
+bool nfsd4_force_end_grace(struct nfsd_net *nn);
=20
 /* nfs4recover operations */
 extern int nfsd4_client_tracking_init(struct net *net);
--=20
2.49.0


