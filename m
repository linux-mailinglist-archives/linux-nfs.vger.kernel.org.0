Return-Path: <linux-nfs+bounces-3817-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 326269082A0
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 05:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 832F8B22BB4
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jun 2024 03:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597AA1474B3;
	Fri, 14 Jun 2024 03:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbRV0bul"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AD61474A3
	for <linux-nfs@vger.kernel.org>; Fri, 14 Jun 2024 03:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718336691; cv=none; b=g0aYovmpAxIJ6aDpkajD/zgAqECze+R0W34KSQCvga8PbEbzZMA+N/16cQWbB0QTAxQ9/0ivMCiAUMREgEb499ohm6O4vq3hgaC2ggala/IoNCjXZdQagLdw4CBgo/9efGyHU5YVG5Gwn1kGSCzKF3bDGHiXx60oqg556fddDX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718336691; c=relaxed/simple;
	bh=PGXgXRtxoJmS8mA/HDlNNfVNEknhKdxj7CeASCKVtJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFVXOb1N9aAdQWLdJ09/CzVayVosnHr1c5HsZOj7Qwyaa7PcJZUhUTtWE3wvyK80TFsqWBClOJLsW+27X1elFEpQnQj7LGy/NOMJmqen6+d/UPsVUwn78K5xyGvApdMDMhECvEix7aI3g2or9ZRSOiTGqIJRjl3M8rtRYeBvvBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbRV0bul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80161C2BBFC;
	Fri, 14 Jun 2024 03:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718336690;
	bh=PGXgXRtxoJmS8mA/HDlNNfVNEknhKdxj7CeASCKVtJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HbRV0bulg9LJEFKLbOUyjDbm4WR/kGYib1ikj1xzR3eII1upCz+++WB9UQHnj/oI/
	 I4egNwBU3FDOegBehMSaBpjTlCxggem2kRddUYbSEERVRr7+kAVMWe/vQKwB7AVRRv
	 yirbhsUpincVTYsgyXJxA8DEkHQSJQzNlnUklqmHO9rFbADcCibDGEA4sPxre/Rbat
	 uaEuuiE5bct7w/ayHQBHdPdnfHnA7gN3hhuWdejjnVh+AadJ1R1NoQw+/FvxnHGo/Q
	 O0ZxMayskfqpxiNsSUhMLFHMDAh8CmpOqAVBr3rjcyqntFhMLRbRRNntjF4hvv4Irb
	 ooU4W/5zX/LjQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v3 17/18] nfsd: use SRCU to dereference nn->nfsd_serv
Date: Thu, 13 Jun 2024 23:44:25 -0400
Message-ID: <20240614034426.31043-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240614034426.31043-1-snitzer@kernel.org>
References: <20240614034426.31043-1-snitzer@kernel.org>
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
 fs/nfsd/netns.h     | 12 ++++++++--
 fs/nfsd/nfs4state.c | 25 ++++++++++++++-------
 fs/nfsd/nfsctl.c    |  7 ++++--
 fs/nfsd/nfssvc.c    | 55 ++++++++++++++++++++++++++++++++++++---------
 5 files changed, 87 insertions(+), 25 deletions(-)

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
index 0c5a1d97e4ac..0eebcc03bcd3 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -139,8 +139,12 @@ struct nfsd_net {
 	u32 clverifier_counter;
 
 	struct svc_info nfsd_info;
-#define nfsd_serv nfsd_info.serv
-
+	/*
+	 * The current 'nfsd_serv' at nfsd_info.serv
+	 * Use nfsd_serv_get() or take nfsd_mutex to dereference.
+	 */
+	void __rcu *nfsd_serv;
+	struct srcu_struct nfsd_serv_srcu;
 
 	/*
 	 * clientid and stateid data for construction of net unique COPY
@@ -225,6 +229,10 @@ struct nfsd_net {
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
index e26b1bc7ad33..b8ea5fc409f0 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1561,10 +1561,12 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
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
@@ -1572,7 +1574,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 
 		rqstp_index = 0;
 		list_for_each_entry_rcu(rqstp,
-				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
+				&serv->sv_pools[i].sp_all_threads,
 				rq_all) {
 			struct nfsd_genl_rqstp genl_rqstp;
 			unsigned int status_counter;
@@ -1637,6 +1639,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 	ret = skb->len;
 out:
 	rcu_read_unlock();
+	nfsd_serv_put(nn, srcu_idx);
 
 	return ret;
 }
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index d6e9d346e84a..5889bc88a061 100644
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
 
+// FIXME: eliminate nfsd_notifier_lock
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
@@ -727,8 +760,10 @@ int nfsd_create_serv(struct net *net)
 	}
 	spin_lock(&nfsd_notifier_lock);
 	nn->nfsd_info.mutex = &nfsd_mutex;
-	nn->nfsd_serv = serv;
+	nn->nfsd_info.serv = serv;
+	rcu_assign_pointer(nn->nfsd_serv, nn->nfsd_info.serv);
 	spin_unlock(&nfsd_notifier_lock);
+	nfsd_serv_sync(nn);
 
 	set_max_drc();
 	/* check if the notifier is already set */
-- 
2.44.0


