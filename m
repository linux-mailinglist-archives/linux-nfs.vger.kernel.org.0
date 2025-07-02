Return-Path: <linux-nfs+bounces-12853-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EA5AF1026
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 11:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13FA316B400
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jul 2025 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FD024729A;
	Wed,  2 Jul 2025 09:38:42 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDEC246760
	for <linux-nfs@vger.kernel.org>; Wed,  2 Jul 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449122; cv=none; b=skruw3b0+dCLVx6Glozm8iCVmVDpPz6LnWzFs7B4UJ24N97vvzKmN3H5dvRqcWrFSlY6W0WEq4+pldxrqmoMAdvxveLxXqwyCiKZEUlze0wlPrx65zNE3ObRAH4r/d6PmYAXMgLpg9TQJWcpV+YL1Tgz7jMSQIfweR3wDmiuUFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449122; c=relaxed/simple;
	bh=TP1PeEMszkbryeTfLnMOhgSDRRnbv5gn+9tGENJ9wLI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VjYjOD9qISnF3SFJ3Ran8Z8IZQYoWulbWbXngmA1fhErWEXUagusQ55NynfFLooTTh9J1ljpM4+7qcbw1z/rDI+woeWrTQeylfUVqOv08BHjmEAXeCL3Y5gJNFJIq8d3Qy/T/tGC38CiaI02JcJsbtCNHcfLefuq3yTQQXXCC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uWtvD-00GUhp-Ng;
	Wed, 02 Jul 2025 09:38:31 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Li Lingfeng" <lilingfeng3@huawei.com>
Cc: linux-nfs@vger.kernel.org, "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Chuck Lever" <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>,
 "yangerkun" <yangerkun@huawei.com>, "zhangyi (F)" <yi.zhang@huawei.com>,
 "Hou Tao" <houtao1@huawei.com>,
 "chengzhihao1@huawei.com" <chengzhihao1@huawei.com>,
 "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH RFT v2] nfsd: provide locking for v4_end_grace
In-reply-to: <5e248899-18cb-4d2e-ac40-8bcb1c036984@huawei.com>
References: <175136659151.565058.6474755472267609432@noble.neil.brown.name>,
 <5e248899-18cb-4d2e-ac40-8bcb1c036984@huawei.com>
Date: Wed, 02 Jul 2025 19:38:31 +1000
Message-id: <175144911127.565058.5990359597048022103@noble.neil.brown.name>

On Wed, 02 Jul 2025, Li Lingfeng wrote:
> Hi Neil,
>=20
> Thank you for the patch. I tested it on mainline and can confirm it
> resolves the issue I encountered without triggering any deadlocks.
> The approach looks solid, and I'll have my colleagues review it as well.

That's really good news - thanks.  And thanks for getting multiple
reviews - there could easily be details that I have missed.

>=20
> However, during validation on our internal 5.10-based kernel (which
> backported disable_delayed_work/disable_delayed_work_sync), I observed an
> unexpected behavior: the laundromat_work still executed after calling
> disable_delayed_work and before enable_delayed_work could be invoked.
> I'll investigate why this occurred.
>=20
> As you mentioned, disable_delayed_work_sync() was introduced in v6.10.
> Do you have plans to provide a backport solution for earlier kernel?

The following is how I would do it prior to 6.10.  It might make sense
to submit this upstream with the 'stable' tag, and then add a patch
which reverts to the simpler version for upstream only.

Let me know if this works on 5.10.

Thanks,
NeilBrown


Subject: [PATCH] nfsd: provide locking for v4_end_grace

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
Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfsd/netns.h     |  2 ++
 fs/nfsd/nfs4state.c | 29 +++++++++++++++++++++++++++--
 fs/nfsd/nfsctl.c    |  6 +++---
 fs/nfsd/state.h     |  2 +-
 4 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 3e2d0fde80a7..fe8338735e7c 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -66,6 +66,8 @@ struct nfsd_net {
=20
 	struct lock_manager nfsd4_manager;
 	bool grace_ended;
+	bool grace_end_forced;
+	bool client_tracking_active;
 	time64_t boot_time;
=20
 	struct dentry *nfsd_client_dir;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index d5694987f86f..d17a40f95eb2 100644
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
+	spin_lock(&nn->client_lock);
+	if (nn->client_tracking_active) {
+		nn->grace_end_forced =3D true;
+		mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
+	}
+	spin_unlock(&nn->client_lock);
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
@@ -8807,6 +8823,8 @@ static int nfs4_state_create_net(struct net *net)
 	nn->unconf_name_tree =3D RB_ROOT;
 	nn->boot_time =3D ktime_get_real_seconds();
 	nn->grace_ended =3D false;
+	nn->grace_end_forced =3D false;
+	nn->client_tracking_active =3D false;
 	nn->nfsd4_manager.block_opens =3D true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -8887,6 +8905,10 @@ nfs4_state_start_net(struct net *net)
 		return ret;
 	locks_start_grace(net, &nn->nfsd4_manager);
 	nfsd4_client_tracking_init(net);
+	/* safe for laundromat to run now */
+	spin_lock(&nn->client_lock);
+	nn->client_tracking_active =3D true;
+	spin_unlock(&nn->client_lock);
 	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size =3D=3D 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
@@ -8935,6 +8957,9 @@ nfs4_state_shutdown_net(struct net *net)
=20
 	shrinker_free(nn->nfsd_client_shrinker);
 	cancel_work_sync(&nn->nfsd_shrinker_work);
+	spin_lock(&nn->client_lock);
+	nn->client_tracking_active =3D false;
+	spin_unlock(&nn->client_lock);
 	cancel_delayed_work_sync(&nn->laundromat_work);
 	locks_end_grace(&nn->nfsd4_manager);
=20
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

base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
--=20
2.49.0


