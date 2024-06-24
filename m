Return-Path: <linux-nfs+bounces-4275-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171119153C7
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 18:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C9E286034
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jun 2024 16:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E3119DFAD;
	Mon, 24 Jun 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxWEtwXi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DB619DF65
	for <linux-nfs@vger.kernel.org>; Mon, 24 Jun 2024 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246486; cv=none; b=VIeJ32uv6K1PbhrrLQgn2RfqTHkyunTBwB76IVusZH8vi2M5hyz4DH+UGXZnBDAAJSoOwO8KTf4EMQGChlHCCUX6HYRFfvTJtAZEM3JKc1mKCgAFPp5zMJx550XDgVX5IY7AKLzVWcqvqHdgeybwkqYBOYCw7EqpNM80zni6Shw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246486; c=relaxed/simple;
	bh=7tP3EcWslye1Nv84pyKqLj2XuP9+NRi10fsfNV2thWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6OI1O7ZmzPVtR2kDeUREBycrw+E5c3ZDVlV0oP92kOHBY3JGf2C+iuzioMlDKsYwELCWQEZL9j8XeGiNtefPW7IXAw3bThzaIJNkmeIcI1lTYtJb44T2YpEFsIz+KTyV6JfCv6OK7lH7YekBFPbRoewzIoKKk92thiHm6Cdvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxWEtwXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4ECC32782;
	Mon, 24 Jun 2024 16:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719246486;
	bh=7tP3EcWslye1Nv84pyKqLj2XuP9+NRi10fsfNV2thWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxWEtwXiCd1TAnRpRpd+K/uy8WS7ok30Yw8HIxgx0H4fEGPpsT3Ms0vuCnJ2tFQG0
	 PTD2ZeftBjM4pEdJNJTnsbUUQChllTStYRLkWImmn5EW1rGOHLA4cc3u/lYN7i0afE
	 FbJ037U0hHeHm+n7Vs97LyDcM26xSZWlo8t8JdNC2AaOcoF/2nLUoGScK/JlIEMgB3
	 Sg56o/xwLAFfD8pGrNit5rIBMp0wn0l/Rvjpxtre0NCaIdOct3w7b1kFshuvkk5qNF
	 oz5OzhO5FIfmfGk6rpacHfeUc0mj10XCxEUqvGPQxdo6b4V/7VcHxEy/PApQWMHSC5
	 tYdWTFKFASpnQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v7 17/20] nfsd: use SRCU to dereference nn->nfsd_serv
Date: Mon, 24 Jun 2024 12:27:38 -0400
Message-ID: <20240624162741.68216-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624162741.68216-1-snitzer@kernel.org>
References: <20240624162741.68216-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nfsd_serv_get, nfsd_serv_put and nfsd_serv_sync and update
the nfsd code to prevent nfsd_destroy_serv from destroying
nn->nfsd_serv until all nfsd code is done with it (particularly the
localio code that doesn't run in the context of nfsd's svc threads,
nor does it take the nfsd_mutex).

Commit 83d5e5b0af90 ("dm: optimize use SRCU and RCU") provided a
familiar well-worn pattern for how implement.

Suggested-by: NeilBrown <neilb@suse.de>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfsd/filecache.c | 13 ++++++++---
 fs/nfsd/netns.h     | 14 ++++++++++--
 fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
 fs/nfsd/nfsctl.c    |  7 ++++--
 fs/nfsd/nfssvc.c    | 54 ++++++++++++++++++++++++++++++++++++---------
 5 files changed, 88 insertions(+), 25 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 99631fa56662..474b3a3af3fb 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -413,12 +413,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 		struct nfsd_file *nf = list_first_entry(dispose,
 						struct nfsd_file, nf_lru);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
+		int srcu_idx;
+		struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
 		spin_lock(&l->lock);
 		list_move_tail(&nf->nf_lru, &l->freeme);
 		spin_unlock(&l->lock);
-		svc_wake_up(nn->nfsd_serv);
+		svc_wake_up(serv);
+		nfsd_serv_put(nn, srcu_idx);
 	}
 }
 
@@ -443,11 +446,15 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
 			list_move(l->freeme.next, &dispose);
 		spin_unlock(&l->lock);
-		if (!list_empty(&l->freeme))
+		if (!list_empty(&l->freeme)) {
+			int srcu_idx;
+			struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 			/* Wake up another thread to share the work
 			 * *before* doing any actual disposing.
 			 */
-			svc_wake_up(nn->nfsd_serv);
+			svc_wake_up(serv);
+			nfsd_serv_put(nn, srcu_idx);
+		}
 		nfsd_file_dispose_list(&dispose);
 	}
 }
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0c5a1d97e4ac..92d0d0883f17 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -139,8 +139,14 @@ struct nfsd_net {
 	u32 clverifier_counter;
 
 	struct svc_info nfsd_info;
-#define nfsd_serv nfsd_info.serv
-
+	/*
+	 * The current 'nfsd_serv' at nfsd_info.serv.  Using 'void' rather than
+	 * 'struct svc_serv' to guard against new code dereferencing nfsd_serv
+	 * without using proper synchronization.
+	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
+	 */
+	void __rcu *nfsd_serv;
+	struct srcu_struct nfsd_serv_srcu;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -225,6 +231,10 @@ struct nfsd_net {
 extern bool nfsd_support_version(int vers);
 extern void nfsd_netns_free_versions(struct nfsd_net *nn);
 
+extern struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx);
+extern void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx);
+extern void nfsd_serv_sync(struct nfsd_net *nn);
+
 extern unsigned int nfsd_net_id;
 
 void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..8876810e569d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1919,6 +1919,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
 	u32 num = ca->maxreqs;
 	unsigned long avail, total_avail;
 	unsigned int scale_factor;
+	int srcu_idx;
+	struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 
 	spin_lock(&nfsd_drc_lock);
 	if (nfsd_drc_max_mem > nfsd_drc_mem_used)
@@ -1940,7 +1942,7 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
 	 * Give the client one slot even if that would require
 	 * over-allocation--it is better than failure.
 	 */
-	scale_factor = max_t(unsigned int, 8, nn->nfsd_serv->sv_nrthreads);
+	scale_factor = max_t(unsigned int, 8, serv->sv_nrthreads);
 
 	avail = clamp_t(unsigned long, avail, slotsize,
 			total_avail/scale_factor);
@@ -1949,6 +1951,8 @@ static u32 nfsd4_get_drc_mem(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn
 	nfsd_drc_mem_used += num * slotsize;
 	spin_unlock(&nfsd_drc_lock);
 
+	nfsd_serv_put(nn, srcu_idx);
+
 	return num;
 }
 
@@ -3702,12 +3706,16 @@ nfsd4_replay_create_session(struct nfsd4_create_session *cr_ses,
 
 static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfsd_net *nn)
 {
-	u32 maxrpc = nn->nfsd_serv->sv_max_mesg;
+	int srcu_idx;
+	struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
+	u32 maxrpc = serv->sv_max_mesg;
+	__be32 status = nfs_ok;
 
-	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ)
-		return nfserr_toosmall;
-	if (ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ)
-		return nfserr_toosmall;
+	if (ca->maxreq_sz < NFSD_MIN_REQ_HDR_SEQ_SZ ||
+	    ca->maxresp_sz < NFSD_MIN_RESP_HDR_SEQ_SZ) {
+		status = nfserr_toosmall;
+		goto out;
+	}
 	ca->headerpadsz = 0;
 	ca->maxreq_sz = min_t(u32, ca->maxreq_sz, maxrpc);
 	ca->maxresp_sz = min_t(u32, ca->maxresp_sz, maxrpc);
@@ -3726,8 +3734,9 @@ static __be32 check_forechannel_attrs(struct nfsd4_channel_attrs *ca, struct nfs
 	 * accounting is soft and provides no guarantees either way.
 	 */
 	ca->maxreqs = nfsd4_get_drc_mem(ca, nn);
-
-	return nfs_ok;
+out:
+	nfsd_serv_put(nn, srcu_idx);
+	return status;
 }
 
 /*
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 075ada559e18..d3eeb829bc9b 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1569,10 +1569,12 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 {
 	struct nfsd_net *nn = net_generic(sock_net(skb->sk), nfsd_net_id);
 	int i, ret, rqstp_index = 0;
+	int srcu_idx;
+	struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 
 	rcu_read_lock();
 
-	for (i = 0; i < nn->nfsd_serv->sv_nrpools; i++) {
+	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_rqst *rqstp;
 
 		if (i < cb->args[0]) /* already consumed */
@@ -1580,7 +1582,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 		rqstp_index = 0;
 		list_for_each_entry_rcu(rqstp,
-				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
+				&serv->sv_pools[i].sp_all_threads,
 				rq_all) {
 			struct nfsd_genl_rqstp genl_rqstp;
 			unsigned int status_counter;
@@ -1645,6 +1647,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	ret = skb->len;
 out:
 	rcu_read_unlock();
+	nfsd_serv_put(nn, srcu_idx);
 
 	return ret;
 }
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index c16c7d630859..6f41fb832484 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -279,6 +279,26 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
 	return 0;
 }
 
+struct svc_serv *nfsd_serv_get(struct nfsd_net *nn, int *srcu_idx)
+	__acquires(nn->nfsd_serv_srcu)
+{
+	*srcu_idx = srcu_read_lock(&nn->nfsd_serv_srcu);
+
+	return srcu_dereference(nn->nfsd_serv, &nn->nfsd_serv_srcu);
+}
+
+void nfsd_serv_put(struct nfsd_net *nn, int srcu_idx)
+	__releases(nn->nfsd_serv_srcu)
+{
+	srcu_read_unlock(&nn->nfsd_serv_srcu, srcu_idx);
+}
+
+void nfsd_serv_sync(struct nfsd_net *nn)
+{
+	synchronize_srcu(&nn->nfsd_serv_srcu);
+	synchronize_rcu_expedited();
+}
+
 /*
  * Maximum number of nfsd processes
  */
@@ -486,6 +506,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	cleanup_srcu_struct(&nn->nfsd_serv_srcu);
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
 	list_del_rcu(&nn->nfsd_uuid.list);
 #endif
@@ -493,6 +514,7 @@ static void nfsd_shutdown_net(struct net *net)
 	nfsd_shutdown_generic();
 }
 
+// FIXME: nfsd_serv_{get,put} should make it safe to eliminate nfsd_notifier_lock
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
 static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	void *ptr)
@@ -502,20 +524,22 @@ static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	struct net *net = dev_net(dev);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in sin;
+	int srcu_idx;
+	struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 
-	if (event != NETDEV_DOWN || !nn->nfsd_serv)
+	if (event != NETDEV_DOWN || !serv)
 		goto out;
 
 	spin_lock(&nfsd_notifier_lock);
-	if (nn->nfsd_serv) {
+	if (serv) {
 		dprintk("nfsd_inetaddr_event: removed %pI4\n", &ifa->ifa_local);
 		sin.sin_family = AF_INET;
 		sin.sin_addr.s_addr = ifa->ifa_local;
-		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin);
+		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin);
 	}
 	spin_unlock(&nfsd_notifier_lock);
-
 out:
+	nfsd_serv_put(nn, srcu_idx);
 	return NOTIFY_DONE;
 }
 
@@ -532,22 +556,24 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
 	struct net *net = dev_net(dev);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct sockaddr_in6 sin6;
+	int srcu_idx;
+	struct svc_serv *serv = nfsd_serv_get(nn, &srcu_idx);
 
-	if (event != NETDEV_DOWN || !nn->nfsd_serv)
+	if (event != NETDEV_DOWN || !serv)
 		goto out;
 
 	spin_lock(&nfsd_notifier_lock);
-	if (nn->nfsd_serv) {
+	if (serv) {
 		dprintk("nfsd_inet6addr_event: removed %pI6\n", &ifa->addr);
 		sin6.sin6_family = AF_INET6;
 		sin6.sin6_addr = ifa->addr;
 		if (ipv6_addr_type(&sin6.sin6_addr) & IPV6_ADDR_LINKLOCAL)
 			sin6.sin6_scope_id = ifa->idev->dev->ifindex;
-		svc_age_temp_xprts_now(nn->nfsd_serv, (struct sockaddr *)&sin6);
+		svc_age_temp_xprts_now(serv, (struct sockaddr *)&sin6);
 	}
 	spin_unlock(&nfsd_notifier_lock);
-
 out:
+	nfsd_serv_put(nn, srcu_idx);
 	return NOTIFY_DONE;
 }
 
@@ -568,9 +594,12 @@ void nfsd_destroy_serv(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	struct svc_serv *serv = nn->nfsd_serv;
 
+	lockdep_assert_held(&nfsd_mutex);
+
 	spin_lock(&nfsd_notifier_lock);
-	nn->nfsd_serv = NULL;
+	rcu_assign_pointer(nn->nfsd_serv, NULL);
 	spin_unlock(&nfsd_notifier_lock);
+	nfsd_serv_sync(nn);
 
 	/* check if the notifier still has clients */
 	if (atomic_dec_return(&nfsd_notifier_refcount) == 0) {
@@ -690,6 +719,10 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
+	error = init_srcu_struct(&nn->nfsd_serv_srcu);
+	if (error)
+		return error;
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
@@ -707,7 +740,8 @@ int nfsd_create_serv(struct net *net)
 	}
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_info.mutex = &nfsd_mutex;
-	nn->nfsd_serv = serv;
+	nn->nfsd_info.serv = serv;
+	rcu_assign_pointer(nn->nfsd_serv, nn->nfsd_info.serv);
 	spin_unlock(&nfsd_notifier_lock);
 
 	set_max_drc();
-- 
2.44.0


