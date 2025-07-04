Return-Path: <linux-nfs+bounces-12890-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EEBAF8934
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 09:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EA1188AD67
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Jul 2025 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93BF27A47E;
	Fri,  4 Jul 2025 07:24:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1222DE711
	for <linux-nfs@vger.kernel.org>; Fri,  4 Jul 2025 07:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751613863; cv=none; b=FH8nsonc2WkugxLkwq11/d7BI0ECFpt3Ho2PyxhuZbGmpYxyHtRZe5H96HccwTuRFYoU7hjuwXu/1K3gcekz/Xl3N8dTudVsLJ6g7MJAPKT8bjB4D4Aw71zRQUr7X0fMkx0CBvnEr8lbZKxNIdbFZcWwynAz5gFAyZXckfX6wyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751613863; c=relaxed/simple;
	bh=YfNN/ojHFz9HXtt/wmq+N4/CXdD9mR6dbNy96y0gQx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlNgU6l/Q8BGeWA1vBT74iHGa31Y0JreQCGU1VzDqa1r2FdVlcM8nw6qF6BvLrflaIgzhK0xxmvrlLRkGq69yV/O2eTNucSnXF5SdrS66FvnqrurhBG0hKA55pRCMM0N5/nP/f3L7xq8LHYTTLIl5bN5EnI1t+OgsELVumRX410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uXalw-001jlD-R6;
	Fri, 04 Jul 2025 07:23:48 +0000
From: NeilBrown <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Li Lingfeng <lilingfeng3@huawei.com>
Subject: [PATCH 1/2] nfsd: provide locking for v4_end_grace
Date: Fri,  4 Jul 2025 17:20:17 +1000
Message-ID: <20250704072332.3278129-2-neil@brown.name>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250704072332.3278129-1-neil@brown.name>
References: <20250704072332.3278129-1-neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing to v4_end_grace can race with server shutdown and result in
memory being accessed after it was freed - reclaim_str_hashtbl in
particular.

We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
held while client_tracking_op->init() is called and that can wait for
an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
deadlock.

nfsd4_end_grace() is also called by the landromat work queue and this
doesn't require locking as server shutdown will stop the work and wait
for it before freeing anything that nfsd4_end_grace() might access.

However, we must be sure that writing to v4_end_grace doesn't restart
the work item after shutdown has already waited for it.  For this we add
a new flag protected with a spin_lock, and nn->client_lock is suitable.
It is set only while it is safe to make client tracking calls, and
v4_end_grace only schedules work while the flag is set and with the
spin_lock held.

So this patch adds an nfsd_net field "client_tracking_active" which is
set as described.  Another field "grace_end_forced", is set when
v4_end_grace is written.  After this is set, and providing
client_tracking_active is set, the laundromat is scheduled.
This "grace_end_forced" field bypasses other checks for whether the
grace period has finished.

This resolves a race which can result in use-after-free.

Reported-and-tested-by: Li Lingfeng <lilingfeng3@huawei.com>
Closes: https://lore.kernel.org/linux-nfs/20250513074305.3362209-1-lilingfeng3@huawei.com
Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsctl.c    |  6 +++---
 fs/nfsd/state.h     |  2 +-
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..fe8338735e7c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -66,6 +66,8 @@ struct nfsd_net {
 
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
+	bool grace_end_forced;
+	bool client_tracking_active;
 	time64_t boot_time;
 
 	struct dentry *nfsd_client_dir;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86f..124fe4f669aa 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -84,7 +84,7 @@ static u64 current_sessionid = 1;
 /* forward declarations */
 static bool check_for_locks(struct nfs4_file *fp, struct nfs4_lockowner *lowner);
 static void nfs4_free_ol_stateid(struct nfs4_stid *stid);
-void nfsd4_end_grace(struct nfsd_net *nn);
+static void nfsd4_end_grace(struct nfsd_net *nn);
 static void _free_cpntf_state_locked(struct nfsd_net *nn, struct nfs4_cpntf_state *cps);
 static void nfsd4_file_hash_remove(struct nfs4_file *fi);
 static void deleg_reaper(struct nfsd_net *nn);
@@ -6458,7 +6458,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return nfs_ok;
 }
 
-void
+static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
 	/* do nothing if grace period already ended */
@@ -6491,6 +6491,36 @@ nfsd4_end_grace(struct nfsd_net *nn)
 	 */
 }
 
+/**
+ * nfsd4_force_end_grace - forcibly end the grace period
+ * @nn: nfsd_net in which the grace period must end.
+ *
+ *
+ * An nfsv4 grace period can be terminated early if it is known that
+ * no more client could reclaim state.  Sometimes user-space can provide
+ * that information - which will potentially be provided asychnronously
+ * w.r.t. server startup or shutdown.
+ *
+ * nfsd4_force_end_grace() causing the grace period to end and takes
+ * care to ensure races with server start/stop are not problematic.
+ *
+ * Return value:  %false if the NFS server was not active and
+ *      %true if the server was, or may have been, active.
+ */
+bool
+nfsd4_force_end_grace(struct nfsd_net *nn)
+{
+	if (!nn->client_tracking_ops)
+		return false;
+	spin_lock(&nn->client_lock);
+	if (nn->client_tracking_active) {
+		nn->grace_end_forced = true;
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+	spin_unlock(&nn->client_lock);
+	return true;
+}
+
 /*
  * If we've waited a lease period but there are still clients trying to
  * reclaim, wait a little longer to give them a chance to finish.
@@ -6500,6 +6530,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	time64_t double_grace_period_end = nn->boot_time +
 					   2 * nn->nfsd4_lease;
 
+	if (nn->grace_end_forced)
+		return false;
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size)
@@ -8807,6 +8839,8 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
+	nn->grace_end_forced = false;
+	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8887,6 +8921,10 @@ nfs4_state_start_net(struct net *net)
 		return ret;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
+	/* safe for laundromat to run now */
+	spin_lock(&nn->client_lock);
+	nn->client_tracking_active = true;
+	spin_unlock(&nn->client_lock);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
@@ -8935,6 +8973,9 @@ nfs4_state_shutdown_net(struct net *net)
 
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
+	spin_lock(&nn->client_lock);
+	nn->client_tracking_active = false;
+	spin_unlock(&nn->client_lock);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..658f3f86a59f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1082,10 +1082,10 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
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
@@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 #endif
 
 /* grace period management */
-void nfsd4_end_grace(struct nfsd_net *nn);
+bool nfsd4_force_end_grace(struct nfsd_net *nn);
 
 /* nfs4recover operations */
 extern int nfsd4_client_tracking_init(struct net *net);
-- 
2.49.0


