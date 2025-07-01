Return-Path: <linux-nfs+bounces-12828-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED73AEEC57
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 04:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A2417C70F
	for <lists+linux-nfs@lfdr.de>; Tue,  1 Jul 2025 02:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE041A23BD;
	Tue,  1 Jul 2025 02:14:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A5A86328
	for <linux-nfs@vger.kernel.org>; Tue,  1 Jul 2025 02:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751336053; cv=none; b=hdBg3G8dmfpDbnX6pfWNInOg8lXnBY3h8WB90INmwTP65HdKOEG9iWPkz3DoSPux9fm7pqRfqD8I1JxLpXnSQ+1RHeHNBjYXCccCWKDDDzqBicK4nOWZ0tCxoUAGNTiTHfZKkUJjC8i80wDjyOJFRtN22EbC6tfN+GH4GyhTPpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751336053; c=relaxed/simple;
	bh=rpXimO+xocvkx5wZbwqRQxJgdJUQaKomNNClnFasLZ4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=hCw7edBcYpXGFZa72NVKNz/6XyRv7qQK9VUyzuyJLXPFvkGD2cPdWRzO5dD+oU62VZol20YmIcc++lJRiTNNNmnXKnOYRiOTAomBxLeeULl+qy0XOATf9/KJdBUy1xMtxmdjS4Jlftyd2JRgVLMIhPNnW6BTmarbv+EsyHpHFuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWQVX-00FHm2-DW;
	Tue, 01 Jul 2025 02:14:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 Li Lingfeng <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, Olga Kornievskaia <okorniev@redhat.com>,
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH RFT] nfsd: provide locking for v4_end_grace
Date: Tue, 01 Jul 2025 12:14:01 +1000
Message-id: <175133604142.565058.11913456377522907637@noble.neil.brown.name>


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
the work item after shutdown has already waited for it.  For this we can
use disable_delayed_work_sync() instead of cancel_delayed_work_sync().

So this patch adds a nfsd_net field "grace_end_forced", sets that when
v4_end_grace is written, and schedules the laundromat (providing it
hasn't been disabled).  This field bypasses other checks for whether the
grace period has finished.  The delayed work is disabled before
nfsd4_client_tracking_exit() is call to shutdown client tracking.

This resolves a race which can result in use-after-free.

Note that disable_delayed_work_sync() was added in v6.10.  To backport
to an earlier kernel without that interface the exclusion could be
provided by some spinlock that was released in the shutdown path
after ->nfsd_serv is set to NULL.  It would need to be taken before
the test on nfsd_serv in write_v4_end_grace() and released after
nfsd4_force_end_grace() is called.

Reported-by: Li Lingfeng <lilingfeng3@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4state.c | 19 ++++++++++++++++---
 fs/nfsd/nfsctl.c    |  7 ++++++-
 fs/nfsd/state.h     |  2 +-
 4 files changed, 24 insertions(+), 5 deletions(-)

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
index d5694987f86f..b34f157334e6 100644
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
@@ -6491,6 +6491,16 @@ nfsd4_end_grace(struct nfsd_net *nn)
 	 */
 }
=20
+void
+nfsd4_force_end_grace(struct nfsd_net *nn)
+{
+	nn->grace_end_forced =3D true;
+	/* This is a no-op after nfs4_state_shutdown_net() has called
+	 * disable_delayed_work_sync()
+	 */
+	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+}
+
 /*
  * If we've waited a lease period but there are still clients trying to
  * reclaim, wait a little longer to give them a chance to finish.
@@ -6500,6 +6510,8 @@ static bool clients_still_reclaiming(struct nfsd_net *n=
n)
 	time64_t double_grace_period_end =3D nn->boot_time +
 					   2 * nn->nfsd4_lease;
=20
+	if (nn->grace_end_forced)
+		return false;
 	if (nn->track_reclaim_completes &&
 			atomic_read(&nn->nr_reclaim_complete) =3D=3D
 			nn->reclaim_str_hashtbl_size)
@@ -8807,6 +8819,7 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree =3D RB_ROOT;
 	nn->boot_time =3D ktime_get_real_seconds();
 	nn->grace_ended =3D false;
+	nn->grace_end_forced =3D false;
 	nn->nfsd4_manager.block_opens =3D true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8935,7 +8948,7 @@ nfs4_state_shutdown_net(struct net *net)
=20
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
-	cancel_delayed_work_sync(&nn->laundromat_work);
+	disable_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
=20
 	INIT_LIST_HEAD(&reaplist);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 3f3e9f6c4250..a9e6c2a155da 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1082,10 +1082,15 @@ static ssize_t write_v4_end_grace(struct file *file, =
char *buf, size_t size)
 		case 'Y':
 		case 'y':
 		case '1':
+			/* This test ensures we don't try to
+			 * end grace before the server has been started,
+			 * but doesn't guarantee we don't end grace
+			 * while the server is being shut down.
+			 */
 			if (!nn->nfsd_serv)
 				return -EBUSY;
 			trace_nfsd_end_grace(netns(file));
-			nfsd4_end_grace(nn);
+			nfsd4_force_end_grace(nn);
 			break;
 		default:
 			return -EINVAL;
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 1995bca158b8..e2bea9908fa8 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -836,7 +836,7 @@ static inline void nfsd4_revoke_states(struct net *net, s=
truct super_block *sb)
 #endif
=20
 /* grace period management */
-void nfsd4_end_grace(struct nfsd_net *nn);
+void nfsd4_force_end_grace(struct nfsd_net *nn);
=20
 /* nfs4recover operations */
 extern int nfsd4_client_tracking_init(struct net *net);
--=20
2.49.0


