Return-Path: <linux-nfs+bounces-17073-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755CCBB23F
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 19:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F352F3006443
	for <lists+linux-nfs@lfdr.de>; Sat, 13 Dec 2025 18:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1E52EFDAF;
	Sat, 13 Dec 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfJohBd9"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896C81DF748
	for <linux-nfs@vger.kernel.org>; Sat, 13 Dec 2025 18:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765651331; cv=none; b=UcnrKRpbl2r8jDZrOiHPWLvL0AhvS21uc9JaINrNCFX/ME23wYIv56mwh4wvJgysVgWQOyJU0fKsTj5om+R2pTDJfmwhyoQCDL/5a/tWahhYvhAHqk5m1lJfsMGJ3s0kMRw3WLPCpNIIMamW0x9iQctb4KUw6d+pezj3hXLGlo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765651331; c=relaxed/simple;
	bh=55oT2DAzLuo1iEiDfJkWnrJzx1YvNhaFdgFY2A6sDpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ga9HvYbFh6Gout2lPckJX4YJQXXMf+6c4ciFxYjfNv9EPxHT0FWAkv/OIiE9gh8NfE8j2Zi2d9SZfGWlSQ5vq6xZpaAxxpDwo9XcEyOOU3t4ENIHU6yK/QvMgEA/lm+ywR92PdXlIQixuwGYdLgWeq27uaKcS8ITqx2JVL9N9+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfJohBd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220ADC19421;
	Sat, 13 Dec 2025 18:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765651330;
	bh=55oT2DAzLuo1iEiDfJkWnrJzx1YvNhaFdgFY2A6sDpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfJohBd9icG68G/7nTXUi1pwhbZ0P6epkOUm4rBiDROJ72YzUE66sOYpSaQaVfTx3
	 acas2LPJQOCI0AAr6g40iv1Gri2pCgkEJav6/PgplwrwQB+y01JFgA4hao5MWopdTt
	 f6aP3/QOeBHy6U0DhW/HwN1lZu80sDV7C7qytz6d2MAuL6RVcuvQZ8L6pqVXtkcDJc
	 wNZeOWXjQEqXhuOKj3pQWQx+CF9VG8dW2nCEGuHINsXvrFSSYYjhq7DfZp2qStc/RE
	 DUs4Fpid7t0WyGwR3BAwAfhyo2VAZ5vNZbvAkrUMn+/yQmwZfGpvpmxrKKKZr+gj4Q
	 KFmvsfNl4sMqQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	lilingfeng3@huawei.com,
	yangerkun@huawei.com,
	yi.zhang@huawei.com,
	houtao1@huawei.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v3 1/2] nfsd: provide locking for v4_end_grace
Date: Sat, 13 Dec 2025 13:41:59 -0500
Message-ID: <20251213184200.585652-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251213184200.585652-1-cel@kernel.org>
References: <20251213184200.585652-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

Writing to v4_end_grace can race with server shutdown and result in
memory being accessed after it was freed - reclaim_str_hashtbl in
particularly.

We cannot hold nfsd_mutex across the nfsd4_end_grace() call as that is
held while client_tracking_op->init() is called and that can wait for
an upcall to nfsdcltrack which can write to v4_end_grace, resulting in a
deadlock.

nfsd4_end_grace() is also called by the landromat work queue and this
doesn't require locking as server shutdown will stop the work and wait
for it before freeing anything that nfsd4_end_grace() might access.

However, we must be sure that writing to v4_end_grace doesn't restart
the work item after shutdown has already waited for it.  For this we
add a new flag protected with nn->client_lock.  It is set only while it
is safe to make client tracking calls, and v4_end_grace only schedules
work while the flag is set with the spinlock held.

So this patch adds a nfsd_net field "client_tracking_active" which is
set as described.  Another field "grace_end_forced", is set when
v4_end_grace is written.  After this is set, and providing
client_tracking_active is set, the laundromat is scheduled.
This "grace_end_forced" field bypasses other checks for whether the
grace period has finished.

This resolves a race which can result in use-after-free.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Closes: https://lore.kernel.org/linux-nfs/20250623030015.2353515-1-neil@brown.name/T/#t
Fixes: 7f5ef2e900d9 ("nfsd: add a v4_end_grace file to /proc/fs/nfsd")
X-Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 42 ++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsctl.c    |  3 +--
 fs/nfsd/state.h     |  2 +-
 4 files changed, 44 insertions(+), 5 deletions(-)

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
index d0efa3e0965f..1d307cc533d9 100644
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
@@ -6570,7 +6570,7 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return nfs_ok;
 }
 
-void
+static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
 	/* do nothing if grace period already ended */
@@ -6603,6 +6603,33 @@ nfsd4_end_grace(struct nfsd_net *nn)
 	 */
 }
 
+/**
+ * nfsd4_force_end_grace - forcibly end the NFSv4 grace period
+ * @nn: network namespace for the server instance to be updated
+ *
+ * Forces bypass of normal grace period completion, then schedules
+ * the laundromat to end the grace period immediately. Does not wait
+ * for the grace period to fully terminate before returning.
+ *
+ * Return values:
+ *   %true: Grace termination schedule
+ *   %false: No action was taken
+ */
+bool nfsd4_force_end_grace(struct nfsd_net *nn)
+{
+	if (!nn->client_tracking_ops)
+		return false;
+	spin_lock(&nn->client_lock);
+	if (nn->grace_ended || !nn->client_tracking_active) {
+		spin_unlock(&nn->client_lock);
+		return false;
+	}
+	WRITE_ONCE(nn->grace_end_forced, true);
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	spin_unlock(&nn->client_lock);
+	return true;
+}
+
 /*
  * If we've waited a lease period but there are still clients trying to
  * reclaim, wait a little longer to give them a chance to finish.
@@ -6612,6 +6639,8 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	time64_t double_grace_period_end = nn->boot_time +
 					   2 * nn->nfsd4_lease;
 
+	if (READ_ONCE(nn->grace_end_forced))
+		return false;
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size)
@@ -8932,6 +8961,8 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
 	nn->grace_ended = false;
+	nn->grace_end_forced = false;
+	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -9012,6 +9043,10 @@ nfs4_state_start_net(struct net *net)
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
@@ -9060,6 +9095,9 @@ nfs4_state_shutdown_net(struct net *net)
 
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
+	spin_lock(&nn->client_lock);
+	nn->client_tracking_active = false;
+	spin_unlock(&nn->client_lock);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5ce9a49e76ba..242fcbd958f1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1082,10 +1082,9 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
-			if (!nn->nfsd_serv)
+			if (!nfsd4_force_end_grace(nn))
 				return -EBUSY;
 			trace_nfsd_end_grace(netns(file));
-			nfsd4_end_grace(nn);
 			break;
 		default:
 			return -EINVAL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index b052c1effdc5..848c5383d782 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -849,7 +849,7 @@ static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 #endif
 
 /* grace period management */
-void nfsd4_end_grace(struct nfsd_net *nn);
+bool nfsd4_force_end_grace(struct nfsd_net *nn);
 
 /* nfs4recover operations */
 extern int nfsd4_client_tracking_init(struct net *net);
-- 
2.52.0


