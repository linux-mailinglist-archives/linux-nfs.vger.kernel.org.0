Return-Path: <linux-nfs+bounces-18364-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kBK8HrHDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18364-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:37 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C426679CC8
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EDF3230055E7
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC622274FC2;
	Fri, 23 Jan 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XH30kohT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93F32BEC4E
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194385; cv=none; b=KZnixSqkaUpXGwH4RFb2V2oGx3RIpULPQvDjQl+gyeR/xdo76uIs3QGk6Qmf+Bwfus136Rznf+3bEG2Px8Ayi2Tfmvnl/05zEpj4KWbpi0yn8+MPxox/6GP94X66q2ZIk5NGi80jgvHQSwA8aE6hqnP6cv4kTMfaaiJJesnVOzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194385; c=relaxed/simple;
	bh=gmdR4o8dgPjuFluFnFfQUjIMKlPyP4t12LBW4nE3+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYaR1b31x4bDc6yxNprvRld8rTRl8jkiAT+A4H7jCT3ABIwGIHzJsxghPGw0dK8qIFgUGoU79Q8seEc1a0JKcjXRS2zWYCW80BAwu45S5GrtT+ASeJ6pABcbEVe1P9sG/cxVeRhnsxQ02DzJ8CqplBhbG4QRjfSCsgpU+jH5a4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XH30kohT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06855C19423;
	Fri, 23 Jan 2026 18:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194385;
	bh=gmdR4o8dgPjuFluFnFfQUjIMKlPyP4t12LBW4nE3+Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XH30kohTkIE0PrHqBodOPByElC8J79FUPQnZ3jUQsQS06w67bZPJewYBrXnumO3J6
	 ImopcShzpOipdUSQ/4LrFrSjWZEgRdQrJWV7n7I2irdeQ2I8sjeYdVUkpUe9nVH0UM
	 tk2Hcm2dh4UQMyPNB0w74WnAow5hW88M6NYtsuzgFkH5cxIuIPbd1TV/BA0wuk/vnz
	 Bssms/Uu0SxGA5+bHP0EacXBBOMSrIwoauz9uAumYOEqIqMYHsg95wD3tysBE1eTuh
	 lbitc4VODPEcmlb23Np1XnlMITLQYpe7JZoNutOXnaRMV2vhPyLI4kXAzg/2hwg8lc
	 d6QUAgVFLhzNg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 03/42] lockd: Have nlm_fopen() return errno values
Date: Fri, 23 Jan 2026 13:52:20 -0500
Message-ID: <20260123185259.1215767-4-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123185259.1215767-1-cel@kernel.org>
References: <20260123185259.1215767-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18364-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: C426679CC8
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 13 +++++++---
 fs/lockd/svcproc.c          |  9 ++++++-
 fs/lockd/svcsubs.c          | 27 +++++++++++++++-----
 fs/nfsd/lockd.c             | 50 +++++++++++++++++++++----------------
 include/linux/lockd/bind.h  |  8 +++---
 include/linux/lockd/lockd.h |  2 ++
 6 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 061686b36b38..bcad4efdf4ab 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -73,9 +73,16 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
 
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
+		return error;
+	}
 }
 
 /*
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 3e890534c3dc..557dfd9c2a9e 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -39,8 +39,15 @@ static inline __be32 cast_status(__be32 status)
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
+	}
 	return status;
 }
 #endif
diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 9103896164f6..e3ceb0745464 100644
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
+			nlmerr = nlm_drop_reply;
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
index c774ce9aa296..6fe1325815e0 100644
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
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 36a744f212ca..7bf402e772b0 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -44,6 +44,8 @@
  */
 #define nlm_drop_reply		cpu_to_be32(30000)
 #define nlm__int__deadlock	cpu_to_be32(30001)
+#define nlm__int__stale_fh	cpu_to_be32(30002)
+#define nlm__int__failed	cpu_to_be32(30003)
 
 /*
  * Lockd host handle (used both by the client and server personality).
-- 
2.52.0


