Return-Path: <linux-nfs+bounces-8084-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB1239D1A8A
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 22:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47EDC2810AC
	for <lists+linux-nfs@lfdr.de>; Mon, 18 Nov 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC2D1E7C1C;
	Mon, 18 Nov 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKR2Zm5V"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D7155C94;
	Mon, 18 Nov 2024 21:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731965028; cv=none; b=M8N2f8wyXot4snnk3c+MPmfuC8Pen9kr0DE6+YrU/tfXPbabGBvMGhlQgQQC0XmZ51Z5rxxK+SQ/rf0JUQ8mxzVddkQoz/o97Ly0jVWMx3XMuju+eOWjFIV8LiocImzRZ7jWNp2SnBXXjzhYtaoZxLoH31iaufCzgjGb56+EFMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731965028; c=relaxed/simple;
	bh=+7sm/tQdvitSOS6l7ydW5R5PAUM8zvgonJY0FUU0fnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbOuGYTZ7yMZJb6JMXfrTCCUXwfyGfjh6fd+OZuGOcexV/CgRF7MkLdwTTKmz9jrfBOr93kh+LEuMLJLYLKVB2yg5j/zFa5SHtWrtHlmFJHvwcgPKSJ5ehuIvd90MKWtpJF6s2Y1+XSz4u3FLKI9EutGcUUwer9a1VEaNJbHVIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKR2Zm5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE795C4CECF;
	Mon, 18 Nov 2024 21:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731965028;
	bh=+7sm/tQdvitSOS6l7ydW5R5PAUM8zvgonJY0FUU0fnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DKR2Zm5VfXRi98heetYcqC1KC77UeYn4ws0Uy7X2BUhmvGCzpOU7u6fHHgyKVdRqj
	 iEk9UgULs/0keTeiTzoff8/K3nZnu0agJgax4RnzQKpk35BiSlPOB4gmBiPoA7pa5U
	 JmzbLul8xahl7yDo7T9YY5Au8MooWjNnSLOh1NWKIlkspI+2/DllcGvMDvdcNlLEcT
	 bY/b5br+ODQA6Djh4kL32YL4s+wTk+2cPVp3wkRDfarZxkKlh5cTy3DExzRgZj8rF/
	 qychgW+E+JDwIw6xWOOdup90PcpF7dzaTPDERHHUZBtjhuShkuNer51dDbmx+Uwmz3
	 kv5rQbfHy++tQ==
From: cel@kernel.org
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 3/5] NFSD: Limit the number of concurrent async COPY operations
Date: Mon, 18 Nov 2024 16:23:41 -0500
Message-ID: <20241118212343.3935-4-cel@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118212343.3935-1-cel@kernel.org>
References: <20241118212343.3935-1-cel@kernel.org>
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
index 08d90e0e8fae..54f43501fed9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1244,6 +1244,7 @@ static void nfs4_put_copy(struct nfsd4_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
+	atomic_dec(&copy->cp_nn->pending_async_copies);
 	kfree(copy->cp_src);
 	kfree(copy);
 }
@@ -1782,10 +1783,16 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -1824,7 +1831,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (async_copy)
 		cleanup_async_copy(async_copy);
-	status = nfserrno(-ENOMEM);
+	status = nfserr_jukebox;
 	goto out;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 5ab3045c649f..a7016f738647 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -8079,6 +8079,7 @@ static int nfs4_state_create_net(struct net *net)
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


