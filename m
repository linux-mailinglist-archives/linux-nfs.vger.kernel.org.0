Return-Path: <linux-nfs+bounces-17188-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA033CCD7B6
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F5930194EE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095B52C3248;
	Thu, 18 Dec 2025 20:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QygiGwf5"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9532263C8C
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088830; cv=none; b=qXr7IO+curqqGjv2vkXra/sc8SoeSUt2bBVf5XePxnbn4jFzKX6CehkGvrYfjN74xb7Icmnl12vqd8JDQcUUK3/eyZyvhAox2AySrK+k1CdPP6riHyAIE1yfH8xOhDNT3hFgC/DohlebGhjYlSO8JtHLMUJW24+liIuSpvxIxpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088830; c=relaxed/simple;
	bh=eQ18PSc5gJaZas/mhoJF8Gb36LGOtILLs/AN/jCUQek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q18VseAfU2M5FCCkqa6tdOhEKmEwH2EBVuxJNO+bHlps3g2udXrBWgPYEx4O2mS4Xw3WJKsAW6Z7Imx+9rr1/WtFokgPdJ3WNyOXWO0LpmlbT4Az1yT0bv7Jf02/UW6Jau7vPiw/ONyZkZD8wBdNhGNvlo9MYCLs62smcEazSMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QygiGwf5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBFCC19421;
	Thu, 18 Dec 2025 20:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088830;
	bh=eQ18PSc5gJaZas/mhoJF8Gb36LGOtILLs/AN/jCUQek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QygiGwf5GJEX8uLRaUmk1Vt+0HhSbaIzoMrnjgyAuhGlBYncXl9HGq3h2fO5chlym
	 o+7KklML46G0yU92sdTxrYdTLLFIhdMIe9LK2nHLyyyRU3FZBnSAHQXOWgmuvoYo6b
	 aGvTqtRm4SdERyY9sn2+Ece5jVFyaWNgbkjqHZktA2Ll90BEUFmaTB8FNPCkZ1JHP+
	 l4a+HaVfHZlZTFj0CHp3nMZInacQUKF2DiN8ZKt6aickZ7X+6CiNlA6ManPJOJfa0R
	 fw7vkCJ+uW6Fc3ftkMUEHjwocdROPhIP1T2xAHwzXhFTOX4+0IOwb3nj7WiC33f0wq
	 ZxYPJzglL9dAA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 01/36] lockd: Have nlm_fopen() return errno values
Date: Thu, 18 Dec 2025 15:13:11 -0500
Message-ID: <20251218201346.1190928-2-cel@kernel.org>
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

The nlm_fopen() function is part of the API between nfsd and lockd.

Currently its return value is an on-the-wire NLM status code. But
that means that the definitions of those status codes need to be
included in NFSD, which is otherwise uninterested in the NLM wire
protocol.

In addition, a CONFIG_LOCKD_V4 Kconfig symbol appears in the middle
of NFSD source code.

Refactor: Let's not use on-the-wire values as part of a high-level
API between two Linux kernel modules. That's what we have errno for,
right?

Perform some additional white-space and internal documentation
clean-ups while we're here.

Strictly speaking, nlm_fopen() should eventually be changed to use
nfsd_file_acquire_gc() instead of calling nfsd_open() directly.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcsubs.c         | 37 +++++++++++++++++++++++-----
 fs/nfsd/lockd.c            | 50 +++++++++++++++++++++-----------------
 include/linux/lockd/bind.h |  8 +++---
 3 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9103896164f6..543f8d7e1b2b 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -87,14 +87,39 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
 			   struct nlm_file *file, int mode)
 {
 	struct file **fp = &file->f_file[mode];
-	__be32	nfserr;
+	__be32 nlmerr = nlm_granted;
+	int error;
 
 	if (*fp)
-		return 0;
-	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
-	if (nfserr)
-		dprintk("lockd: open failed (error %d)\n", nfserr);
-	return nfserr;
+		return nlmerr;
+
+	error = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
+	if (error) {
+		dprintk("lockd: open failed (errno %d)\n", error);
+		switch (error) {
+		case -EWOULDBLOCK:
+			nlmerr = nlm_drop_reply;
+			break;
+		case -ESTALE:
+#ifdef CONFIG_LOCKD_V4
+			/* cast_status() converts this for NLMv3 requests */
+			nlmerr = nlm4_stale_fh;
+#else
+			nlmerr = nlm_lck_denied_nolocks;
+#endif
+			break;
+		default:
+#ifdef CONFIG_LOCKD_V4
+			/* cast_status() converts this for NLMv3 requests */
+			nlmerr = nlm4_failed;
+#else
+			nlmerr = nlm_lck_denied_nolocks;
+#endif
+			break;
+		}
+	}
+
+	return nlmerr;
 }
 
 /*
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index c774ce9aa296..f2a9bda513cf 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -14,19 +14,20 @@
 
 #define NFSDDBG_FACILITY		NFSDDBG_LOCKD
 
-#ifdef CONFIG_LOCKD_V4
-#define nlm_stale_fh	nlm4_stale_fh
-#define nlm_failed	nlm4_failed
-#else
-#define nlm_stale_fh	nlm_lck_denied_nolocks
-#define nlm_failed	nlm_lck_denied_nolocks
-#endif
-/*
- * Note: we hold the dentry use count while the file is open.
+/**
+ * nlm_fopen - Open an NFSD file
+ * @rqstp: NLM RPC procedure execution context
+ * @f: NFS file handle to be opened
+ * @filp: OUT: an opened struct file
+ * @flags: the POSIX open flags to use
+ *
+ * The dentry reference count remains held while the file is open.
+ *
+ * Returns zero on success or a negative errno value if the file
+ * cannot be opened.
  */
-static __be32
-nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
-		int mode)
+static int nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f,
+		     struct file **filp, int flags)
 {
 	__be32		nfserr;
 	int		access;
@@ -47,18 +48,17 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 	 * if NFSEXP_NOAUTHNLM is set.  Some older clients use AUTH_NULL
 	 * for NLM requests.
 	 */
-	access = (mode == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
+	access = (flags == O_WRONLY) ? NFSD_MAY_WRITE : NFSD_MAY_READ;
 	access |= NFSD_MAY_NLM | NFSD_MAY_OWNER_OVERRIDE | NFSD_MAY_BYPASS_GSS;
 	nfserr = nfsd_open(rqstp, &fh, S_IFREG, access, filp);
 	fh_put(&fh);
-	/* We return nlm error codes as nlm doesn't know
-	 * about nfsd, but nfsd does know about nlm..
-	 */
+
 	switch (nfserr) {
 	case nfs_ok:
-		return 0;
+		break;
 	case nfserr_jukebox:
-		/* this error can indicate a presence of a conflicting
+		/*
+		 * This error can indicate a presence of a conflicting
 		 * delegation to an NLM lock request. Options are:
 		 * (1) For now, drop this request and make the client
 		 * retry. When delegation is returned, client's lock retry
@@ -66,19 +66,25 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 		 * (2) NLM4_DENIED as per "spec" signals to the client
 		 * that the lock is unavailable now but client can retry.
 		 * Linux client implementation does not. It treats
-		 * NLM4_DENIED same as NLM4_FAILED and errors the request.
+		 * NLM4_DENIED same as NLM4_FAILED and fails the request.
 		 * (3) For the future, treat this as blocked lock and try
 		 * to callback when the delegation is returned but might
 		 * not have a proper lock request to block on.
 		 */
-		return nlm_drop_reply;
+		return -EWOULDBLOCK;
 	case nfserr_stale:
-		return nlm_stale_fh;
+		return -ESTALE;
 	default:
-		return nlm_failed;
+		return -ENOLCK;
 	}
+
+	return 0;
 }
 
+/**
+ * nlm_fclose - Close an NFSD file
+ * @filp: a struct file that was opened by nlm_fopen()
+ */
 static void
 nlm_fclose(struct file *filp)
 {
diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
index c53c81242e72..2f5dd9e943ee 100644
--- a/include/linux/lockd/bind.h
+++ b/include/linux/lockd/bind.h
@@ -26,11 +26,9 @@ struct rpc_clnt;
  * This is the set of functions for lockd->nfsd communication
  */
 struct nlmsvc_binding {
-	__be32			(*fopen)(struct svc_rqst *,
-						struct nfs_fh *,
-						struct file **,
-						int mode);
-	void			(*fclose)(struct file *);
+	int		(*fopen)(struct svc_rqst *rqstp, struct nfs_fh *f,
+				 struct file **filp, int flags);
+	void		(*fclose)(struct file *filp);
 };
 
 extern const struct nlmsvc_binding *nlmsvc_ops;
-- 
2.52.0


