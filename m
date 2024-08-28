Return-Path: <linux-nfs+bounces-5868-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEED962EAB
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 19:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A77F6B213AC
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Aug 2024 17:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7981A704B;
	Wed, 28 Aug 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSf5Lsk/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E5E1A4F15;
	Wed, 28 Aug 2024 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724866816; cv=none; b=caVhhtAMLJUDLcSG51JNju79hUivK2dhz78v1RoTwgA2bEskqqj9A9wCa/mrfFQXy16Shss3Vv6PwX0MAFqaRinzGYpuk5NSZ3et02GaWNriXcW2k5Qrf/3v5bNcz52pORjVt3m1xWH5UKzLR1m9Stw5IGSKgadsQ4r8m8cVYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724866816; c=relaxed/simple;
	bh=+orhpqbhYE73syn3xRae0ko0GUimh1gok3+JeXs6uDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QECQga8Fqhxn+gG+qtyIsYGQW4dLiYPNS5QG+vcDcmXjAdOf49Z8o9/syptedGuMywZB8sDswPq6z7Kj37/eIehLryXA0drhL2pHiWOew1DKzKuC9eWgi0TXjb+BkzfdVR3M1sTlKT/x8JjX2GTlHq4l43rGJe/IfIAhNn6iegU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSf5Lsk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B67F7C4CEC0;
	Wed, 28 Aug 2024 17:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724866816;
	bh=+orhpqbhYE73syn3xRae0ko0GUimh1gok3+JeXs6uDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aSf5Lsk/HF8PJlGzIT13stZDjoRppbHnyg67V3Vw1VahRPiZ3lzaMarZBZJGNbRvf
	 vgGs9SbpgCPFa0nTvhAQWanawZewQo+/VnC5bL8FqoomKMHNaLSn14B2ZpCGlgLRTM
	 thvKUOKUyTY7TtVdnlShiIQmInoqXk4qdGJkPKA2jWjEzycgWjBdo5RiMirYXdu3ol
	 P7G5GxvJQKRj0CBINKFWyeR2AlxaxO6elOK5vU4Vtbp48K4sHAckuOvNcz38uYjYZA
	 w2SqM/a0yr/qmT6mo3SQJ6q/3dJjh7erFK/OGHpOk4qrbfUdczlk9ZnimjR36en3RH
	 W+G1yWek8dMTg==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 2/7] NFSD: Limit the number of concurrent async COPY operations
Date: Wed, 28 Aug 2024 13:40:04 -0400
Message-ID: <20240828174001.322745-11-cel@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240828174001.322745-9-cel@kernel.org>
References: <20240828174001.322745-9-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3621; i=chuck.lever@oracle.com; h=from:subject; bh=VEBWKnuVul4SKhnXBt8l9TWqaWgmVvsUzjYpWA+H0Ig=; b=kA0DAAgBM2qzM29mf5cByyZiAGbPYPqglbuRPJal4DFBuKhVlkGJYND5XDEQ0m42OIf14G4d+ 4kCMwQAAQgAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJmz2D6AAoJEDNqszNvZn+XEyEQAKlS vVcXhCSvVdM3Fp2oHwWJ0bOHDKsN1dSUFg6ZQ+OjmxKP9boLlTYofM8+YC8IVQTa/2IB4Ud03eE 9YxhLDldW5Jncdy2C4z6Z9xr4woSvcJkFaJDOoM6zdGpqCrLjcnce7pgReESP/+T5mKNftngnYR pD0U2gsbx3bRxjWDQmNaEtTeJlghYdvwsBOMiT7uGI+hBvzIgUgzEz1bZG93eL5gd5oQcoDvUQz v7+E8e+I3Ss2fvZKI1/fBUA1PndyQ9pxNEJxjzSLrVAY7onVFi7+xmg21oGfANj2DcF5u/Voscs uBdgnKjvX2ftxCNCAYh+GzhvRHbgSeDT1O/abY8iQ62tLQLoFiWxLaNwsUY6bR2LAx8pbBvd4TH KXy8lPJwxbGHVt99lvG+o3h5NR3kQi9zaPxPTZuy17ygaWk4fm+fJaLzPJBOJdqs+nDufjpy5SG iNo9qJP29SkcWVXbMe8CoJ7JYMiKwbgRBBEJm/ZAOIZxP/EuoIyH4DN6XxV9b+fJU7EqRMNKHd2 7BsM+b+bby0XT3QxQHwUe1PIDB8PlzHsEfVGujBNEAPXarVrdX5XMzBq1L8cYji6K/B2K2a2YDF pMOZk+JorjC69CCtRTIFghhgQ/EntzXvM1BeJMWJswSMYbv07mIR3dGKXrkwv3c4D1H0ywh6jr0 GgfN8
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Nothing appears to limit the number of concurrent async COPY
operations that clients can start. In addition, AFAICT each async
COPY can copy an unlimited number of 4MB chunks, so can run for a
long time. Thus IMO async COPY can become a DoS vector.

Add a restriction mechanism that bounds the number of concurrent
background COPY operations. Start simple and try to be fair -- this
patch implements a per-namespace limit.

An async COPY request that occurs while this limit is exceeded gets
NFS4ERR_DELAY. The requesting client can choose to send the request
again after a delay or fall back to a traditional read/write style
copy.

If there is need to make the mechanism more sophisticated, we can
visit that in future patches.

Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 12 ++++++++++--
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 14ec15656320..5cae26917436 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -148,6 +148,7 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+	atomic_t	pending_async_copies;
 
 	/*
 	 * Version information
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 60c526adc27c..27f7eceb3b00 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1279,6 +1279,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1833,10 +1834,17 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		status = nfserrno(-ENOMEM);
+		/* Arbitrary cap on number of pending async copy operations */
+		int nrthreads = atomic_read(&rqstp->rq_pool->sp_nrthreads);
+
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_nn = nn;
+		if (atomic_inc_return(&nn->pending_async_copies) > nrthreads) {
+			atomic_dec(&nn->pending_async_copies);
+			goto out_err;
+		}
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
@@ -1876,7 +1884,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a20c2c9d7d45..aaebc60cc77c 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8554,6 +8554,7 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
+	atomic_set(&nn->pending_async_copies, 0);
 
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index fbdd42cde1fa..2a21a7662e03 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -713,6 +713,7 @@ struct nfsd4_copy {
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	struct nfsd_net		*cp_nn;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
-- 
2.46.0


