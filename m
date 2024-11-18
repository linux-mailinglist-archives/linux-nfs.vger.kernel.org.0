Return-Path: <linux-nfs+bounces-8058-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB00A9D1A52
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6963CB21866
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21C61E7C0A;
	Mon, 18 Nov 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ik3MI2rX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FCC154BF0;
	Mon, 18 Nov 2024 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731964748; cv=none; b=AF0x/BD0U9lwpoKI3NJT9ZQMhkBZ+T39rTwB/RwKptZ/1KWbXE9GWoWDOHHG3D/wyoocSe7FtOpqA2Ad0OM0+jFTWWTU6/8Ean/9KyEID1NhZGRDEfhAv+CwNC8GMn8rMTYsUEInnHrAskopVuCBIlrIbcD9GddspAaHyyFySi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731964748; c=relaxed/simple;
	bh=ItwqzqsjETC47W9U0Pcv8HL3d66AO8IYKlWyoLrn0H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPXjAzrJNRYOcC5f5I5ur3mNoV0WLgcpy4H3qYMxzJXkPp1pQTVDYTKVRry0oD427SDpz+ck7Gs2s94mUoTQk025ta/C4Ja6S44aEfV79zpVNQ8nSoPfp5h2Te9UqKEN3Qn2s/JV0O/YWcUhv+Urn6E77HNBgby126LdyMKT6R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ik3MI2rX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70B3C4CED7;
	Mon, 18 Nov 2024 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731964748;
	bh=ItwqzqsjETC47W9U0Pcv8HL3d66AO8IYKlWyoLrn0H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ik3MI2rXaxvX4w+sRB/B6HHl1dB6m9mBPhnm3vypFRFkA/n4ogzB2z3Mn1g5u/tG4
	 yXofY4Z2yHQbWa8vh1DqSURgQmdy+MpmWMYqcr8UGT2NDvghzKMr0c+6JXdJm/oKIN
	 86RWmBASwEyQv1cUsxSy7MCPoBzlse75Koiup0Yb3zmOOaeRt/ZJbLXAROIQIeumJb
	 Qc8EBEKl0Vgetc6twqFvKOZSdSOKL2ADBxi7lc02SLvLJsFJsbglIPyn8aSfoRTXFb
	 66aG71tKFU7CjM6dlpZKhCqY3G9gYv+miRQc47gD7PkxvXM7/MNrpp+Yen/1WHa0Ur
	 a9o+ww6PEr2fQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.1 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Mon, 18 Nov 2024 16:18:58 -0500
Message-ID: <20241118211900.3808-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118211900.3808-1-cel@kernel.org>
References: <20241118211900.3808-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit aadc3bbea163b6caaaebfdd2b6c4667fbc726752 ]

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
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-49974
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/netns.h     |  1 +
 fs/nfsd/nfs4proc.c  | 11 +++++++++--
 fs/nfsd/nfs4state.c |  1 +
 fs/nfsd/xdr4.h      |  1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 548422b24a7d..41c750f34473 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -152,6 +152,7 @@ struct nfsd_net {
 	u32		s2s_cp_cl_id;
 	struct idr	s2s_cp_stateids;
 	spinlock_t	s2s_cp_lock;
+	atomic_t	pending_async_copies;
 
 	/*
 	 * Version information
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index b8fb37cc59c4..6637a7ef974b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1243,6 +1243,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1781,10 +1782,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	memcpy(&copy->fh, &cstate->current_fh.fh_handle,
 		sizeof(struct knfsd_fh));
 	if (nfsd4_copy_is_async(copy)) {
-		status = nfserrno(-ENOMEM);
 		async_copy = kzalloc(sizeof(struct nfsd4_copy), GFP_KERNEL);
 		if (!async_copy)
 			goto out_err;
+		async_copy->cp_nn = nn;
+		/* Arbitrary cap on number of pending async copy operations */
+		if (atomic_inc_return(&nn->pending_async_copies) >
+				(int)rqstp->rq_pool->sp_nrthreads) {
+			atomic_dec(&nn->pending_async_copies);
+			goto out_err;
+		}
 		INIT_LIST_HEAD(&async_copy->copies);
 		refcount_set(&async_copy->refcount, 1);
 		async_copy->cp_src = kmalloc(sizeof(*async_copy->cp_src), GFP_KERNEL);
@@ -1823,7 +1830,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 893d099e0099..e195012db48e 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8076,6 +8076,7 @@ static int nfs4_state_create_net(struct net *net)
 	spin_lock_init(&nn->client_lock);
 	spin_lock_init(&nn->s2s_cp_lock);
 	idr_init(&nn->s2s_cp_stateids);
+	atomic_set(&nn->pending_async_copies, 0);
 
 	spin_lock_init(&nn->blocked_locks_lock);
 	INIT_LIST_HEAD(&nn->blocked_locks_lru);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 510978e602da..9bd1ade6ba54 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -574,6 +574,7 @@ struct nfsd4_copy {
 	struct nfsd4_ssc_umount_item *ss_nsui;
 	struct nfs_fh		c_fh;
 	nfs4_stateid		stateid;
+	struct nfsd_net		*cp_nn;
 };
 
 static inline void nfsd4_copy_set_sync(struct nfsd4_copy *copy, bool sync)
-- 
2.47.0


