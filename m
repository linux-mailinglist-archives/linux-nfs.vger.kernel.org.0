Return-Path: <linux-nfs+bounces-19005-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCyIH0TnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19005-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:12 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B47215156F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8943C30789C0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B9F313525;
	Tue, 17 Feb 2026 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/egX9mS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46103313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366064; cv=none; b=dv63atWUIMCqhbXD8+HHHI+LhavCheeh7LXelD47oUyMWYk9bQMteiZQkEUt7ImM+WwIYDxRLxuQSR8eL7HETdubSujh5X2GBK3iheTg/SpyBGe9y3lv/lk9usHlSzvtfHg0Ypxb6cjpuhSKKkpelfV82TuTr8cdskU5xxmcbLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366064; c=relaxed/simple;
	bh=o0+aiBQXCxU+zQ/lIyKw0/1MlLdCqoV+WotatwmI5RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gRtSwcfrozqHON6T8ZcWmki5jw2CSp1tAEUgbK1pWGEyIlY5ylQEPnQy8YDueWISvv3zoL+UNAqRdhAzmROQpaaez8d4mpm/OxTKPHY7dOiu/rbhW7VnPxJ7VhthCbBxtTbmqFQjhA62RP1SrgY5LK7E93P9MnqI0c2m2PZCH7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/egX9mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC80C19423;
	Tue, 17 Feb 2026 22:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366064;
	bh=o0+aiBQXCxU+zQ/lIyKw0/1MlLdCqoV+WotatwmI5RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g/egX9mSr9/BulJUHl+ULPumiPAyXvYzhC40vLUG4+gDumBZzWPuUoFpsdIF7ER7x
	 zkxhBybXNld2otRv4/fdPWFFWzdS/T8JQOBn2vxJ0i8VncBrKxZenzijBNt2Pf4ZkY
	 m1uHYfWCBBFnmxW1mya3Hg1SKq0kkqk8zDOds5JvKHZ8huioJ5GUJkXXVtdkGGjtZ+
	 PkkrsjU7jp1b0MvHZsEGUrC0hG9fYVzFrm1+Eh3bUSkkkhFfoBhGYguj5o7RHvy2Qb
	 WhoSUagK/rAKjLIxQ3QmUgHXkWj5Hp6mk9XEEBO2DE7cLcsXmlnFV4Q4lPtiAgCPSQ
	 6QRUq2rCdYbZw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 22/29] lockd: Prepare share helpers for xdrgen conversion
Date: Tue, 17 Feb 2026 17:07:14 -0500
Message-ID: <20260217220721.1928847-23-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217220721.1928847-1-cel@kernel.org>
References: <20260217220721.1928847-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19005-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B47215156F
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

In order to convert the NLMv4 server-side XDR functions to use
xdrgen, the internal share helpers need to be decoupled from the
NLMv3-specific struct nlm_args. NLMv4 procedures will use
different argument structures once they are converted.

Refactor nlmsvc_share_file() and nlmsvc_unshare_file() to accept
individual arguments (oh, access, mode) instead of the common
struct nlm_args. This allows both protocol versions to call these
helpers without forcing a common argument structure.

While here, add kdoc comments to both functions and fix a comment
typo in the unshare path.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
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
index 6dd9afc59551..d820d6620e06 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -1072,7 +1072,8 @@ nlm4svc_proc_share(struct svc_rqst *rqstp)
 			rpc_drop_reply : rpc_success;
 
 	/* Now try to create the share */
-	resp->status = nlmsvc_share_file(host, file, argp);
+	resp->status = nlmsvc_share_file(host, file, &lock->oh,
+					 argp->fsm_access, argp->fsm_mode);
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
@@ -1111,8 +1112,8 @@ nlm4svc_proc_unshare(struct svc_rqst *rqstp)
 		return resp->status == nlm__int__drop_reply ?
 			rpc_drop_reply : rpc_success;
 
-	/* Now try to lock the file */
-	resp->status = nlmsvc_unshare_file(host, file, argp);
+	/* Now try to unshare the file */
+	resp->status = nlmsvc_unshare_file(host, file, &lock->oh);
 
 	dprintk("lockd: UNSHARE       status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 75b0dfa1a79a..749abf8886ba 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -423,7 +423,9 @@ nlmsvc_proc_share(struct svc_rqst *rqstp)
 			rpc_drop_reply : rpc_success;
 
 	/* Now try to create the share */
-	resp->status = cast_status(nlmsvc_share_file(host, file, argp));
+	resp->status = cast_status(nlmsvc_share_file(host, file, &argp->lock.oh,
+						     argp->fsm_access,
+						     argp->fsm_mode));
 
 	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(&argp->lock);
@@ -459,7 +461,8 @@ nlmsvc_proc_unshare(struct svc_rqst *rqstp)
 			rpc_drop_reply : rpc_success;
 
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
2.53.0


