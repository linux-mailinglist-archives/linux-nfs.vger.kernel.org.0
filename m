Return-Path: <linux-nfs+bounces-18497-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPv3L8nGd2nckgEAu9opvQ
	(envelope-from <linux-nfs+bounces-18497-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 534888CCEA
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 20:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1486F3021EB6
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jan 2026 19:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AD288C96;
	Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcLdNGs7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41D3288C81
	for <linux-nfs@vger.kernel.org>; Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457341; cv=none; b=tA724CVvKxC0BFlIpitLLNRJ6joaIrTh97LNsqtbJJHYsYw0hljfjH2VuIBjXmAwEpbo/vjmsLeCHQmubJaH6LmzgCR/X6T6+Vf6O73ESsfFOiJpsSGoH6mqb2odXVkoTx2o+6ukamprKafJJ6hZIPBRBXIy8a5JEp5e1gdwd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457341; c=relaxed/simple;
	bh=DvGiQHGTtFgWGgTXwfusdDFlmJfKFXtQtEcfxu4LsVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qey2E8Xwod9uLzOT9NP7Z5vziNUgw/3PIv/ACPp9A1nvHgUn1YjlrZ7qVpIpdeBrfz7NJJsrPoqVUS+qJHkmkyeGz8dubIC1TiCfQ6Df1BjLZQLPPEaq6auLPzhNPBF5BzfdiBI+tYxtrIwAXFWghA30ym7UzlntrhhEzrfnQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcLdNGs7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1560CC116C6;
	Mon, 26 Jan 2026 19:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457341;
	bh=DvGiQHGTtFgWGgTXwfusdDFlmJfKFXtQtEcfxu4LsVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tcLdNGs7DOKG9FD6FFbghxgyzjZfSYJaZPRfNNzQlY3j0IFUVSKmKeyuPsjQ+dbY1
	 p5GKbh2lGKM4rhHvgtJC6WF4+OVa1CrhsdJYQK5IrAvRsYuDucrPsG0m6CDosfvfaC
	 9Hh9HN0TmSfpkq8inzrGbk0SmJhx0ZNkmf6cAWb80Hr7uiVWwJpaBjKjS7EWPzkB0c
	 sqVnVXaSlE5tyhTWrU/HdmYeXQhwKJm1H4j0dJDsjjRIZFY3jDBTqf+uVrqb7gLj/g
	 nqY+hEqCuE2m2HJ/NrZ0iZiSnFFtJvnUE1P8DX+Qr7PIe7IRrlj0PyHw5jefLAsDpk
	 sBVBs1DADtS3A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 04/14] lockd: Have nlm_fopen() return errno values
Date: Mon, 26 Jan 2026 14:55:25 -0500
Message-ID: <20260126195535.154697-5-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126195535.154697-1-cel@kernel.org>
References: <20260126195535.154697-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18497-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 534888CCEA
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The nlm_fopen() function is part of the API between nfsd and lockd.

Currently its return value is an on-the-wire NLM status code. But
that forces NFSD to include NLM wire protocol definitions despite
having no other dependency on the NLM wire protocol.

In addition, a CONFIG_LOCKD_V4 Kconfig symbol appears in the middle
of NFSD source code.

Refactor: Let's not use on-the-wire values as part of a high-level
API between two Linux kernel modules. That's what we have errno for,
right?

And, instead of simply moving the CONFIG_LOCKD_V4 check, we can get
rid of it entirely and let the decision of what actual NLM status
code goes on the wire to be left up to NLM version-specific code.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 18 ++++++++++---
 fs/lockd/svcproc.c          | 14 ++++++++++-
 fs/lockd/svcsubs.c          | 27 +++++++++++++++-----
 fs/nfsd/lockd.c             | 50 +++++++++++++++++++++----------------
 include/linux/lockd/bind.h  |  8 +++---
 include/linux/lockd/lockd.h |  2 ++
 6 files changed, 82 insertions(+), 37 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 55b6dcc56db1..4ceb27cc72e4 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -73,9 +73,21 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
 no_locks:
 	nlmsvc_release_host(host);
- 	if (error)
-		return error;	
-	return nlm_lck_denied_nolocks;
+	switch (error) {
+	case nlm_granted:
+		return nlm_lck_denied_nolocks;
+	case nlm__int__stale_fh:
+		return nlm4_stale_fh;
+	case nlm__int__failed:
+		return nlm4_failed;
+	default:
+		if (be32_to_cpu(error) >= 30000) {
+			pr_warn_once("lockd: unhandled internal status %u\n",
+				     be32_to_cpu(error));
+			return nlm4_failed;
+		}
+		return error;
+	}
 }
 
 /*
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 27ed71935e45..272c8f36ed2a 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -39,8 +39,20 @@ static inline __be32 cast_status(__be32 status)
 #else
 static inline __be32 cast_status(__be32 status)
 {
-	if (status == nlm__int__deadlock)
+	switch (status) {
+	case nlm__int__deadlock:
 		status = nlm_lck_denied;
+		break;
+	case nlm__int__stale_fh:
+	case nlm__int__failed:
+		status = nlm_lck_denied_nolocks;
+		break;
+	default:
+		if (be32_to_cpu(status) >= 30000)
+			pr_warn_once("lockd: unhandled internal status %u\n",
+				     be32_to_cpu(status));
+		break;
+	}
 	return status;
 }
 #endif
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9103896164f6..4186e53190ac 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -87,14 +87,29 @@ static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
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
+			nlmerr = nlm__int__drop_reply;
+			break;
+		case -ESTALE:
+			nlmerr = nlm__int__stale_fh;
+			break;
+		default:
+			nlmerr = nlm__int__failed;
+			break;
+		}
+	}
+
+	return nlmerr;
 }
 
 /*
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index 8c230ccd6645..6fe1325815e0 100644
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
+ * nlm_fopen() holds the dentry reference until nlm_fclose() releases it.
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
-		return nlm__int__drop_reply;
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
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 793691912137..195e6ce28f6e 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -44,6 +44,8 @@
  */
 #define nlm__int__drop_reply	cpu_to_be32(30000)
 #define nlm__int__deadlock	cpu_to_be32(30001)
+#define nlm__int__stale_fh	cpu_to_be32(30002)
+#define nlm__int__failed	cpu_to_be32(30003)
 
 /*
  * Lockd host handle (used both by the client and server personality).
-- 
2.52.0


