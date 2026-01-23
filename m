Return-Path: <linux-nfs+bounces-18397-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGuqEP7Dc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18397-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:54 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 032DC79DB2
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDA063038F04
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62EA254B03;
	Fri, 23 Jan 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1IEicS/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B052BFC7B
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194411; cv=none; b=t8IWxByVS+/CJPa7b5IYGS6TymSkAUeBueyxPuB9KKx9egxLpVKw9o52adnHSdtZeihlFIwzmh59usZcs1jcqr3tlCAbudMH1MJ3sqbhRjX0GGWnl3uU1H7a/jBIT1+1oBtjTMl4UStC6/DTlUYUQ0DP2+zYGzeSgcW8PFzvoEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194411; c=relaxed/simple;
	bh=7X9La1FyKGkZj0yudCmno5diCrRI+1A1xjg/iikCw20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kTVyuzDqTciPnx/uMq+JGui7Sc8rfNx6S3miBbc0SmZN9SPydGcoDYF/QztLGUKeX81DuVXsfwV3DmiGEAUlKTKgHFRL+uc4v41tlTqAfpd66iwZSjkE5bLMwYRI8i5n81MpyL5EmPM0j5Ei4wKvYERZ1nvGOXf0dIePfORCP+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1IEicS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A08FC4CEF1;
	Fri, 23 Jan 2026 18:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194411;
	bh=7X9La1FyKGkZj0yudCmno5diCrRI+1A1xjg/iikCw20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j1IEicS/MQVdLpcXX5Zb63EgLbLjlHnWFbKzUySPRMvcCSFiSTLD5XxEvtG3UT8sj
	 db7ePpPVDjoCbaddonKAJMeAgNGPnaRTbcpE8TyEKNZXg2vUNrCPiPB3rn4z50EfbO
	 OyocQ9s6OHKOVv9Pu8L+Xu6yZLms19WxsIvAMW/c/E/MLS4XI2U1hCsjiX0046jvvi
	 0KrsifZuSp5uktHtb/urA/nm5y0Bm5JGH3c8NyiOfC62NvrS8Mo1px6RRbH3MYIeqx
	 9YBKSnnfKKSygOAYrDwK3iOQ+/NrtH4UZy3rR2lF439+F1oeh7+zSaz/WBLQy3xnFM
	 avk00Q43pb42A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 36/42] lockd: Use xdrgen XDR functions for the NLMv4 SHARE procedure
Date: Fri, 23 Jan 2026 13:52:53 -0500
Message-ID: <20260123185259.1215767-37-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18397-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 032DC79DB2
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Now that the share helpers have been decoupled from the
NLMv3-specific struct nlm_args and file_lock initialization
has been hoisted into the procedure handler, the NLMv4 SHARE
procedure can be converted to use xdrgen-generated XDR
functions.

Replace the NLMPROC4_SHARE entry in the nlm_procedures4 array
with an entry that uses xdrgen-built XDR decoders and encoders.
The procedure handler is updated to use the new wrapper
structures (nlm4_shareargs_wrapper and nlm4_shareres_wrapper)
and access arguments through the argp->xdrgen hierarchy.

The .pc_argzero field is set to zero because xdrgen decoders
fully initialize all fields in argp->xdrgen, making the early
defensive memset unnecessary. The remaining argp fields that
fall outside the xdrgen structures are cleared explicitly as
needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 117 ++++++++++++++++++++++++++++++--------------
 1 file changed, 81 insertions(+), 36 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index 53a64709dc36..74a8821e2bce 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -74,6 +74,13 @@ struct nlm4_testres_wrapper {
 	struct nlm_lock			lock;
 };
 
+struct nlm4_shareargs_wrapper {
+	struct nlm4_shareargs		xdrgen;
+	struct nlm_lock			lock;
+};
+
+static_assert(offsetof(struct nlm4_shareargs_wrapper, xdrgen) == 0);
+
 static_assert(offsetof(struct nlm4_testres_wrapper, xdrgen) == 0);
 
 struct nlm4_res_wrapper {
@@ -83,6 +90,12 @@ struct nlm4_res_wrapper {
 
 static_assert(offsetof(struct nlm4_res_wrapper, xdrgen) == 0);
 
+struct nlm4_shareres_wrapper {
+	struct nlm4_shareres		xdrgen;
+};
+
+static_assert(offsetof(struct nlm4_shareres_wrapper, xdrgen) == 0);
+
 static __be32
 nlm4_netobj_to_cookie(struct nlm_cookie *cookie, netobj *object)
 {
@@ -1032,44 +1045,74 @@ static __be32 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 	return rpc_proc_unavail;
 }
 
-/*
- * SHARE: create a DOS share or alter existing share.
+/**
+ * nlm4svc_proc_share - SHARE: Open a file using DOS file-sharing modes
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *
+ * RPC synopsis:
+ *   nlm4_shareres NLMPROC4_SHARE(nlm4_shareargs) = 20;
+ *
+ * Permissible procedure status codes:
+ *   %NLM4_GRANTED:		The requested share lock was granted.
+ *   %NLM4_DENIED:		The requested lock conflicted with existing
+ *				lock reservations for the file.
+ *   %NLM4_DENIED_GRACE_PERIOD:	The server has recently restarted and is
+ *				re-establishing existing locks, and is not
+ *				yet ready to accept normal service requests.
+ *
+ * The Linux NLM server implementation also returns:
+ *   %NLM4_DENIED_NOLOCKS:	A needed resource could not be allocated.
+ *   %NLM4_STALE_FH:		The request specified an invalid file handle.
+ *   %NLM4_FBIG:		The request specified a length or offset
+ *				that exceeds the range supported by the
+ *				server.
+ *   %NLM4_FAILED:		The request failed for an unspecified reason.
  */
-static __be32
-nlm4svc_proc_share(struct svc_rqst *rqstp)
+static __be32 nlm4svc_proc_share(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_res *resp = rqstp->rq_resp;
+	struct nlm4_shareargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm4_shareres_wrapper *resp = rqstp->rq_resp;
 	struct nlm_lock	*lock = &argp->lock;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
+	struct nlm_host	*host = NULL;
+	struct nlm_file	*file = NULL;
+	struct nlm4_lock xdr_lock = {
+		.fh		= argp->xdrgen.share.fh,
+		.oh		= argp->xdrgen.share.oh,
+		.svid		= ~(u32)0,
+	};
 
-	dprintk("lockd: SHARE         called\n");
+	resp->xdrgen.cookie = argp->xdrgen.cookie;
 
-	resp->cookie = argp->cookie;
+	resp->xdrgen.stat = nlm_lck_denied_grace_period;
+	if (locks_in_grace(SVC_NET(rqstp)) && !argp->xdrgen.reclaim)
+		goto out;
 
-	/* Don't accept new lock requests during grace period */
-	if (locks_in_grace(SVC_NET(rqstp)) && !argp->reclaim) {
-		resp->status = nlm_lck_denied_grace_period;
-		return rpc_success;
-	}
+	resp->xdrgen.stat = nlm_lck_denied_nolocks;
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.share.caller_name, true);
+	if (!host)
+		goto out;
 
-	/* Obtain client and file */
-	locks_init_lock(&lock->fl);
-	lock->svid = ~(u32)0;
-	resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file);
-	if (resp->status)
-		return resp->status == nlm_drop_reply ? rpc_drop_reply :rpc_success;
+	resp->xdrgen.stat = nlm4svc_lookup_file(rqstp, host, lock, &file,
+						&xdr_lock, F_RDLCK);
+	if (resp->xdrgen.stat)
+		goto out;
 
-	/* Now try to create the share */
-	resp->status = nlmsvc_share_file(host, file, &lock->oh,
-					 argp->fsm_access, argp->fsm_mode);
+	resp->xdrgen.stat = nlmsvc_share_file(host, file, &lock->oh,
+					      argp->xdrgen.share.access,
+					      argp->xdrgen.share.mode);
 
-	dprintk("lockd: SHARE         status %d\n", ntohl(resp->status));
 	nlmsvc_release_lockowner(lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
 	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rpc_success;
+	return resp->xdrgen.stat == nlm_drop_reply ?
+		rpc_drop_reply : rpc_success;
 }
 
 /*
@@ -1356,15 +1399,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNUSED",
 	},
-	[NLMPROC_SHARE] = {
-		.pc_func = nlm4svc_proc_share,
-		.pc_decode = nlm4svc_decode_shareargs,
-		.pc_encode = nlm4svc_encode_shareres,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_res),
-		.pc_xdrressize = Ck+St+1,
-		.pc_name = "SHARE",
+	[NLMPROC4_SHARE] = {
+		.pc_func	= nlm4svc_proc_share,
+		.pc_decode	= nlm4_svc_decode_nlm4_shareargs,
+		.pc_encode	= nlm4_svc_encode_nlm4_shareres,
+		.pc_argsize	= sizeof(struct nlm4_shareargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= sizeof(struct nlm4_shareres_wrapper),
+		.pc_xdrressize	= NLM4_nlm4_shareres_sz,
+		.pc_name	= "SHARE",
 	},
 	[NLMPROC_UNSHARE] = {
 		.pc_func = nlm4svc_proc_unshare,
@@ -1407,8 +1450,10 @@ union nlm4svc_xdrstore {
 	struct nlm4_cancargs_wrapper	cancargs;
 	struct nlm4_unlockargs_wrapper	unlockargs;
 	struct nlm4_notifyargs_wrapper	notifyargs;
+	struct nlm4_shareargs_wrapper	shareargs;
 	struct nlm4_testres_wrapper	testres;
 	struct nlm4_res_wrapper		res;
+	struct nlm4_shareres_wrapper	shareres;
 	struct nlm_args			args;
 };
 
-- 
2.52.0


