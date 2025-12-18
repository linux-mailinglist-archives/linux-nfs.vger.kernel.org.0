Return-Path: <linux-nfs+bounces-17218-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 951F9CCD80A
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CCBD30249A1
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832E2D5419;
	Thu, 18 Dec 2025 20:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht6Z4Dic"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95082D8DAF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088853; cv=none; b=P95y2VO29xaRQ/7wN1sLWGteFcg7tUsdvZsW/Vnx4sFTcw81y0fdKP2z2HgE/sLgZSYULoqreWQya8ZBSlqjtf/2UICbxC/S5WZtyrdYlzuMmQnLA6HXdKC338aUB+c8k0lf4uSmwPpT+QTFo6EAJARyK1hoTLBh8JZM3k4oKkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088853; c=relaxed/simple;
	bh=px+OTv9WLN+a64TMFUrsGZK+jj45nNq0pmYgb78gxL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wy7iZakSZxy442PjpP7lwK8M+UIMQ5r7YxLoAEAjykBSD7za83wAceeRhCAjt3lhTqH7YgnRDpSFbtz4aMnLjspjNRWYCEyzrgVKmTqgt8ZwWZuA4QkBqQGnSvA4qH46OwskcO+K+w5BZrCdHIae04i+iEn0awDDiu8OBxP9Ras=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht6Z4Dic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C683FC16AAE;
	Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088853;
	bh=px+OTv9WLN+a64TMFUrsGZK+jj45nNq0pmYgb78gxL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ht6Z4DicGCGt9oVL91cq1fBww9l7uXeYClKhFQRzcZMxHN9TzhpuANtqWU1CjQ0PC
	 Fduf2qiaOSPIQJqVuty4NjUp6GN5EfiUy2TeOIh4a6ZNlfCtUXrtCeWKVqCOpBmNqv
	 oEa3PVdFaG8Czb89sra/rGLdMuEXM1BGhaT83uF7qTWZOCc4BM6TlfuZVMyTO9SWEF
	 Ts6kkvQl3fXg3++9yg6tTvlOOgbsNteIJW4cRfUtFpt0yHWm5BKnF0k1vjluXH8XmV
	 dw038zOaAFwCN0oyNkOOk20rFkF9c0lSCTzIwW7E3hvc2MvYflrwi7D3uazhn2FLTe
	 OBJwrku9RxujQ==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 30/36] lockd: Update share_file helpers
Date: Thu, 18 Dec 2025 15:13:40 -0500
Message-ID: <20251218201346.1190928-31-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Refactor the internal nlmsvc_share_file() and nlmsvc_unshare_file()
helper functions to use raw arguments rather than the common struct
nlm_args, which is about to be replaced for NLMv4.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/share.h    |  8 ++++----
 fs/lockd/svc4proc.c |  7 ++++---
 fs/lockd/svcproc.c  |  7 +++++--
 fs/lockd/svcshare.c | 35 +++++++++++++++++++++++------------
 4 files changed, 36 insertions(+), 21 deletions(-)

diff --git a/fs/lockd/share.h b/fs/lockd/share.h
index d8f4ebd9c278..a2867e30c593 100644
--- a/fs/lockd/share.h
+++ b/fs/lockd/share.h
@@ -20,10 +20,10 @@ struct nlm_share {
 	u32			s_mode;		/* deny mode */
 };
 
-__be32	nlmsvc_share_file(struct nlm_host *, struct nlm_file *,
-					       struct nlm_args *);
-__be32	nlmsvc_unshare_file(struct nlm_host *, struct nlm_file *,
-					       struct nlm_args *);
+__be32	nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
+			  struct xdr_netobj *oh, u32 access, u32 mode);
+__be32	nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
+			    struct xdr_netobj *oh);
 void	nlmsvc_traverse_shares(struct nlm_host *, struct nlm_file *,
 					       nlm_host_match_fn_t);
 
diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index ae85526c9ec6..67b9dcfce19c 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -866,7 +866,8 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
-	resp->status = nlmsvc_share_file(host, file, argp);
+	resp->status = nlmsvc_share_file(host, file, &lock->oh,
+					 argp->fsm_access, argp->fsm_mode);
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
@@ -904,8 +905,8 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 	if (resp->status)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
-	/* Now try to lock the file */
-	resp->status = nlmsvc_unshare_file(host, file, argp);
+	/* Now try to unshare the file */
+	resp->status = nlmsvc_unshare_file(host, file, &lock->oh);
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 0e1ac985c757..957009af9ae1 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -407,7 +407,9 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to create the share */
-	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
+	resp->status = cast_status(nlmsvc_share_file(host, file, &argp->lock.oh,
+						     argp->fsm_access,
+						     argp->fsm_mode));
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
@@ -442,7 +444,8 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
 
 	/* Now try to unshare the file */
-	resp->status = cast_status(nlmsvc_unshare_file(host, file, argp));
+	resp->status = cast_status(nlmsvc_unshare_file(host, file,
+						       &argp->lock.oh));
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
diff --git a/fs/lockd/svcshare.c b/fs/lockd/svcshare.c
index 8675ac80ab16..53f5655c128c 100644
--- a/fs/lockd/svcshare.c
+++ b/fs/lockd/svcshare.c
@@ -25,12 +25,21 @@ nlm_cmp_owner(struct nlm_share *share, struct xdr_netobj *oh)
 	    && !memcmp(share->s_owner.data, oh->data, oh->len);
 }
 
+/**
+ * nlmsvc_share_file - create a share
+ * @host: Network client peer
+ * @file: File to be shared
+ * @oh: Share owner handle
+ * @access: Requested access mode
+ * @mode: Requested file sharing mode
+ *
+ * Returns an NLM status code.
+ */
 __be32
 nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
-			struct nlm_args *argp)
+		  struct xdr_netobj *oh, u32 access, u32 mode)
 {
 	struct nlm_share	*share;
-	struct xdr_netobj	*oh = &argp->lock.oh;
 	u8			*ohdata;
 
 	if (nlmsvc_file_cannot_lock(file))
@@ -39,13 +48,11 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 	for (share = file->f_shares; share; share = share->s_next) {
 		if (share->s_host == host && nlm_cmp_owner(share, oh))
 			goto update;
-		if ((argp->fsm_access & share->s_mode)
-		 || (argp->fsm_mode   & share->s_access ))
+		if ((access & share->s_mode) || (mode & share->s_access))
 			return nlm_lck_denied;
 	}
 
-	share = kmalloc(sizeof(*share) + oh->len,
-						GFP_KERNEL);
+	share = kmalloc(sizeof(*share) + oh->len, GFP_KERNEL);
 	if (share == NULL)
 		return nlm_lck_denied_nolocks;
 
@@ -61,20 +68,24 @@ nlmsvc_share_file(struct nlm_host *host, struct nlm_file *file,
 	file->f_shares      = share;
 
 update:
-	share->s_access = argp->fsm_access;
-	share->s_mode   = argp->fsm_mode;
+	share->s_access = access;
+	share->s_mode = mode;
 	return nlm_granted;
 }
 
-/*
- * Delete a share.
+/**
+ * nlmsvc_unshare_file - delete a share
+ * @host: Network client peer
+ * @file: File to be unshared
+ * @oh: Share owner handle
+ *
+ * Returns an NLM status code.
  */
 __be32
 nlmsvc_unshare_file(struct nlm_host *host, struct nlm_file *file,
-			struct nlm_args *argp)
+		    struct xdr_netobj *oh)
 {
 	struct nlm_share	*share, **shpp;
-	struct xdr_netobj	*oh = &argp->lock.oh;
 
 	if (nlmsvc_file_cannot_lock(file))
 		return nlm_lck_denied_nolocks;
-- 
2.52.0


