Return-Path: <linux-nfs+bounces-4104-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2407F90F7A6
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 22:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA181C213B1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 20:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C9115AAA6;
	Wed, 19 Jun 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzA65okb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E215A87F
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 20:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829654; cv=none; b=Knkyz3nTxGC2ID4KLY+X2Pe1IlV/Wnth9BFAu5u4zUojflHoUyqSGIi0rYSD/4nbeTMH7I+EH/5xuUv5H6V7o27BFnQZ0uUGPNDgDaGEo5+ywOfuY1kkhdb4XNa51SFJ+Xt/vdr/8yGE44V4bPfJA2t026b64EdAVIdulkMAq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829654; c=relaxed/simple;
	bh=rL0rLxv2RAEagEikL1b7BA6JXAiXjIiCcnBxv0q+Tjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AiADc+z15SkNoEYTGzoLKvVwkVbdK+UZYh0PoWHvUfeeERANNW9vLvXXSO5EVPEJ8W2KnvOcuQ3CXv/67X0Qxs0RnA8SBtliF7zGHRHb0C5THt5slLf7bfWPwgd/RObT2vSmQT7vD/ZNyTW1dbzYuKcUsx/tII8p+9F42AL96ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzA65okb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DD1C2BBFC;
	Wed, 19 Jun 2024 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718829654;
	bh=rL0rLxv2RAEagEikL1b7BA6JXAiXjIiCcnBxv0q+Tjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzA65okbaucKf30wk7gCw4HdDJ5hRsWqY3qBbAbxDff2bIluGzp738mN4jjDyQ58D
	 nfQXT+R0slOIBB8hHe5awwEceS12ePo/pygRfvPUCkBVx9lSGJgIzM6j96GxwpvlYR
	 l+kP25Av8VibQoSTzDSpiLW3QEfIrJWC7/0qeKjGn1SZ2P5/IgLtY+bVscW8XHmCuG
	 cNYNpD9dges5+A5eaTy/QsT0NaoJJqw0PH5ElzF/0Ir6LhsL6LGQEQcSQvAiXsFRDr
	 dXCKwahR6VS8Qy1IWfKSY5CiWVdcaA9y9JaPJ7CsSrzTIPKcjBBIKDTicLI3Egk0Za
	 HxGpGXuFjEL4A==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v6 15/18] nfsd: use SRCU to dereference nn->nfsd_serv
Date: Wed, 19 Jun 2024 16:40:29 -0400
Message-ID: <20240619204032.93740-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240619204032.93740-1-snitzer@kernel.org>
References: <20240619204032.93740-1-snitzer@kernel.org>
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
index 1bddbbf7418e..2d4c29c25c6a 100644
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
index bfc58001dd9a..42db1e6dcff7 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -300,6 +300,26 @@ int nfsd_minorversion(struct nfsd_net *nn, u32 minorversion, enum vers_op change
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
@@ -507,6 +527,7 @@ static void nfsd_shutdown_net(struct net *net)
 		lockd_down(net);
 		nn->lockd_up = false;
 	}
+	cleanup_srcu_struct(&nn->nfsd_serv_srcu);
 #if IS_ENABLED(CONFIG_NFSD_LOCALIO)
 	list_del_rcu(&nn->nfsd_uuid.list);
 #endif
@@ -514,6 +535,7 @@ static void nfsd_shutdown_net(struct net *net)
 	nfsd_shutdown_generic();
 }
 
+// FIXME: nfsd_serv_{get,put} should make it safe to eliminate nfsd_notifier_lock
 static DEFINE_SPINLOCK(nfsd_notifier_lock);
 static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
 	void *ptr)
@@ -523,20 +545,22 @@ static int nfsd_inetaddr_event(struct notifier_block *this, unsigned long event,
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
 
@@ -553,22 +577,24 @@ static int nfsd_inet6addr_event(struct notifier_block *this,
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
 
@@ -589,9 +615,12 @@ void nfsd_destroy_serv(struct net *net)
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
@@ -711,6 +740,10 @@ int nfsd_create_serv(struct net *net)
 	if (nn->nfsd_serv)
 		return 0;
 
+	error = init_srcu_struct(&nn->nfsd_serv_srcu);
+	if (error)
+		return error;
+
 	if (nfsd_max_blksize == 0)
 		nfsd_max_blksize = nfsd_get_default_max_blksize();
 	nfsd_reset_versions(nn);
@@ -727,7 +760,8 @@ int nfsd_create_serv(struct net *net)
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


