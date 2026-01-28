Return-Path: <linux-nfs+bounces-18568-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGJgKx0pemlk3QEAu9opvQ
	(envelope-from <linux-nfs+bounces-18568-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DF73BA3A8B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 68E213002D12
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Jan 2026 15:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0C336BCCD;
	Wed, 28 Jan 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1FN5Azv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999F236B075
	for <linux-nfs@vger.kernel.org>; Wed, 28 Jan 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769613579; cv=none; b=PE5n1gRVPLZeKyOxJH6fdutloo74DO+c1DRFwgBpC3qGoF08BJcOwpcVU5j3Kk0W2GJ5fDMU7JVzqlZKnoDZ1puu8hY6IpB9RIawTKrQueQ8xrtVY4dGpuXZGsdIZY63bDqDy9sxjfRtawThsRyuRHrUUj/CjIAv8C/JQGpgK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769613579; c=relaxed/simple;
	bh=RCNc5+gwlc+mMUb/X+adZ1MMGdHUd9lIOI5NBG884A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ty+rwQ+Njo+CGKESJzCY/McUo3opbxEQOu8ikfln1Rs++k5lj26Vsf07hEQn9AomT7U97ts1RDyQIBCdGyDuh4DbT+PwHgEH/6Wh7anpASlyDrB3bjl4wQOo4YKfYgPQZjeK0UZiRZwaZYJIg7Xe9a+mS4Opya2JyTuWY/98+EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1FN5Azv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70A4C116C6;
	Wed, 28 Jan 2026 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769613579;
	bh=RCNc5+gwlc+mMUb/X+adZ1MMGdHUd9lIOI5NBG884A4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h1FN5AzvpPstHjWgK4eGXFhhpMA+1ZC8blxwTl+IZCoEnTfLQ6zFML5mxG4Wleb9P
	 6Ozhby0un3NFwZV7AtNHuiD+yV/DYsbzb24TAzbnF4uF5opvudnJIHhcaZHqWZo2np
	 9HOK0N2fr7+SJdu+uqesFoXW5B2O7uUz7gJ5uFlFHUARGH04nczLizQ0/ElLX7r5rg
	 8LO/zpgQ3V/wWL4zx2+7C6DCCSb1LJ1YGz4gpgFDoFagaH+TGbRwjw/o1oaQn8NXTS
	 9yeoN7ubGn9xtfAmUxXbzBqurVTQZGw91cnHKeGkN44DdlJxJaySxpNRfy+ZSM1f2J
	 ebn/TESrqDHhg==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 02/14] lockd: Relocate and rename nlm_drop_reply
Date: Wed, 28 Jan 2026 10:19:23 -0500
Message-ID: <20260128151935.1646063-3-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128151935.1646063-1-cel@kernel.org>
References: <20260128151935.1646063-1-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18568-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: DF73BA3A8B
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The nlm_drop_reply status code is internal to the kernel's lockd
implementation and must never appear on the wire. Its previous
location in xdr.h grouped it with legitimate NLM protocol status
codes, obscuring this critical distinction.

Relocate the definition to lockd.h with a comment block for internal
status codes, and rename to nlm__int__drop_reply to make its
internal-only nature explicit. This prepares for adding additional
internal status codes in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c         | 22 ++++++++++++++--------
 fs/lockd/svclock.c          |  4 ++--
 fs/lockd/svcproc.c          | 24 +++++++++++++++---------
 fs/nfsd/lockd.c             |  2 +-
 include/linux/lockd/lockd.h |  6 ++++++
 include/linux/lockd/xdr.h   |  2 --
 6 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 4b6f18d97734..9c756d07223a 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -104,12 +104,13 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now check for conflicting locks */
 	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
 				       &resp->lock);
-	if (resp->status == nlm_drop_reply)
+	if (resp->status == nlm__int__drop_reply)
 		rc = rpc_drop_reply;
 	else
 		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
@@ -140,13 +141,14 @@ __nlm4svc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
 					argp->block, &argp->cookie,
 					argp->reclaim);
-	if (resp->status == nlm_drop_reply)
+	if (resp->status == nlm__int__drop_reply)
 		rc = rpc_drop_reply;
 	else
 		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
@@ -182,7 +184,8 @@ __nlm4svc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Try to cancel request. */
 	resp->status = nlmsvc_cancel_blocked(SVC_NET(rqstp), file, &argp->lock);
@@ -222,7 +225,8 @@ __nlm4svc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to remove the lock */
 	resp->status = nlmsvc_unlock(SVC_NET(rqstp), file, &argp->lock);
@@ -369,7 +373,8 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to create the share */
 	resp->status = nlmsvc_share_file(host, file, argp);
@@ -404,7 +409,8 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = nlmsvc_unshare_file(host, file, argp);
diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 712df1e025d8..83b6dd243bcd 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -463,7 +463,7 @@ nlmsvc_defer_lock_rqst(struct svc_rqst *rqstp, struct nlm_block *block)
 		block->b_deferred_req =
 			rqstp->rq_chandle.defer(block->b_cache_req);
 		if (block->b_deferred_req != NULL)
-			status = nlm_drop_reply;
+			status = nlm__int__drop_reply;
 	}
 	dprintk("lockd: nlmsvc_defer_lock_rqst block %p flags %d status %d\n",
 		block, block->b_flags, ntohl(status));
@@ -531,7 +531,7 @@ nlmsvc_lock(struct svc_rqst *rqstp, struct nlm_file *file,
 			ret = nlm_lck_denied;
 			goto out;
 		}
-		ret = nlm_drop_reply;
+		ret = nlm__int__drop_reply;
 		goto out;
 	}
 
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 95c6bf7ab757..2a2e48a9bd12 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -25,7 +25,7 @@ static inline __be32 cast_status(__be32 status)
 	case nlm_lck_denied_nolocks:
 	case nlm_lck_blocked:
 	case nlm_lck_denied_grace_period:
-	case nlm_drop_reply:
+	case nlm__int__drop_reply:
 		break;
 	case nlm4_deadlock:
 		status = nlm_lck_denied;
@@ -122,12 +122,13 @@ __nlmsvc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now check for conflicting locks */
 	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
 						   &argp->lock, &resp->lock));
-	if (resp->status == nlm_drop_reply)
+	if (resp->status == nlm__int__drop_reply)
 		rc = rpc_drop_reply;
 	else
 		dprintk("lockd: TEST          status %d vers %d\n",
@@ -159,13 +160,14 @@ __nlmsvc_proc_lock(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to lock the file */
 	resp->status = cast_status(nlmsvc_lock(rqstp, file, host, &argp->lock,
 					       argp->block, &argp->cookie,
 					       argp->reclaim));
-	if (resp->status == nlm_drop_reply)
+	if (resp->status == nlm__int__drop_reply)
 		rc = rpc_drop_reply;
 	else
 		dprintk("lockd: LOCK         status %d\n", ntohl(resp->status));
@@ -202,7 +204,8 @@ __nlmsvc_proc_cancel(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Try to cancel request. */
 	resp->status = cast_status(nlmsvc_cancel_blocked(net, file, &argp->lock));
@@ -243,7 +246,8 @@ __nlmsvc_proc_unlock(struct svc_rqst *rqstp, struct nlm_res *resp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to remove the lock */
 	resp->status = cast_status(nlmsvc_unlock(net, file, &argp->lock));
@@ -400,7 +404,8 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to create the share */
 	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
@@ -435,7 +440,8 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 
 	/* Obtain client and file */
 	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+		return resp->status == nlm__int__drop_reply ?
+			rpc_drop_reply : rpc_success;
 
 	/* Now try to unshare the file */
 	resp->status = cast_status(nlmsvc_unshare_file(host, file, argp));
diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
index c774ce9aa296..8c230ccd6645 100644
--- a/fs/nfsd/lockd.c
+++ b/fs/nfsd/lockd.c
@@ -71,7 +71,7 @@ nlm_fopen(struct svc_rqst *rqstp, struct nfs_fh *f, struct file **filp,
 		 * to callback when the delegation is returned but might
 		 * not have a proper lock request to block on.
 		 */
-		return nlm_drop_reply;
+		return nlm__int__drop_reply;
 	case nfserr_stale:
 		return nlm_stale_fh;
 	default:
diff --git a/include/linux/lockd/lockd.h b/include/linux/lockd/lockd.h
index 330e38776bb2..fdefec39553f 100644
--- a/include/linux/lockd/lockd.h
+++ b/include/linux/lockd/lockd.h
@@ -38,6 +38,12 @@
  */
 #define LOCKD_DFLT_TIMEO	10
 
+/*
+ * Internal-use status codes, not to be placed on the wire.
+ * Version handlers translate these to appropriate wire values.
+ */
+#define nlm__int__drop_reply	cpu_to_be32(30000)
+
 /*
  * Lockd host handle (used both by the client and server personality).
  */
diff --git a/include/linux/lockd/xdr.h b/include/linux/lockd/xdr.h
index 17d53165d9f2..292e4e38d17d 100644
--- a/include/linux/lockd/xdr.h
+++ b/include/linux/lockd/xdr.h
@@ -33,8 +33,6 @@ struct svc_rqst;
 #define	nlm_lck_blocked		cpu_to_be32(NLM_LCK_BLOCKED)
 #define	nlm_lck_denied_grace_period	cpu_to_be32(NLM_LCK_DENIED_GRACE_PERIOD)
 
-#define nlm_drop_reply		cpu_to_be32(30000)
-
 /* Lock info passed via NLM */
 struct nlm_lock {
 	char *			caller;
-- 
2.52.0


