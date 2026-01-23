Return-Path: <linux-nfs+bounces-18384-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCFBI+XDc2kCygAAu9opvQ
	(envelope-from <linux-nfs+bounces-18384-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:29 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F42E79D7A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 19:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E4B63048059
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Jan 2026 18:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318FF2C08B1;
	Fri, 23 Jan 2026 18:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzS45Waj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B9257821
	for <linux-nfs@vger.kernel.org>; Fri, 23 Jan 2026 18:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769194402; cv=none; b=eGqQmEut9GAON/Er7Bv3d0t8q7XUkjSZGrRyEn91Pz22j04FKPFZ3VM64ECMs4enyqpY7WP/3rVmaqB3jU+2SZj+5L2mamttQPpbTQ+GN9q6GdaIiRFkVl0U+9PTMjO3QA+B2tpTDomSjS8OoxY9wbp1ju6PiRb6pzD8OXEI7sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769194402; c=relaxed/simple;
	bh=OwVXc8bVujx6AWuWY9vw3uenG6jowg0uIlYAlbLBDTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aI74M94KoNNQJdCaLESHXNNjBGNdbPuxenqwkCXtYzRRCfQf5rsmvxw0NeA4DXmUJbI2wmbN71rdmPDpAq8JoFEd443b42sTVWFZK24IKlh2KQ2+AP5xVtLoAc6rLwnbPst9uybbXTwd3CZEQKOOHusa6YasMpwPwyCKOoUGdxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzS45Waj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C938EC4CEF1;
	Fri, 23 Jan 2026 18:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769194401;
	bh=OwVXc8bVujx6AWuWY9vw3uenG6jowg0uIlYAlbLBDTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzS45WajnRVRoC4uZ2WY1L98bm1I4x7MmXa/UKNgQHycAolqztDUFFZU8dLAUQQbB
	 giLf8IOlAUU4+hcL4gaDUnKzZwWl/YPHJUQTiCAnzQ0yoR0/jYupfzQj/bRjFFxJ1j
	 uw+q4gvaRZ3tNVp+7ZCN3Aa9KMf4nS3+fW3ARVgsjE26QZoPKeU/XaADBxZxVBWSW7
	 15dStRJnrs9Ciw7oYLSfZOHfJO8KTpPq/0vfWl+H4G6jgolJyDdEjp/DAEFOhZHIAS
	 5lcE6dNViZsaYuZdUDsQR/LW0e86M8RG9qBw3lff2vTTo9iEu+odVJwPKE6tM8llwV
	 CCxlfcmuEqo4A==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 23/42] lockd: Use xdrgen XDR functions for the NLMv4 LOCK_MSG procedure
Date: Fri, 23 Jan 2026 13:52:40 -0500
Message-ID: <20260123185259.1215767-24-cel@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-18384-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 0F42E79D7A
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The LOCK_MSG procedure is part of NLM's asynchronous lock
request flow, where clients send LOCK_MSG to request locks
that may block. This patch continues the xdrgen migration by
converting LOCK_MSG to use generated XDR functions.

This patch converts the LOCK_MSG procedure to use xdrgen
functions nlm4_svc_decode_nlm4_lockargs and
nlm4_svc_encode_void generated from the NLM version 4
protocol specification. The procedure handler uses xdrgen
types through the nlm4_lockargs_wrapper structure that
bridges between generated code and the legacy nlm_lock
representation.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining
argp fields are cleared as needed.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct nlm_res,
preventing LOCK and LOCK_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 76 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 16 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index c0e043fa0eba..7ab458648637 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -804,19 +804,63 @@ static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 				__nlm4svc_proc_test_msg);
 }
 
+static __be32
+__nlm4svc_proc_lock_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	resp->status = nlmsvc_lock(rqstp, file, host, &argp->lock,
+				   argp->xdrgen.block, &resp->cookie,
+				   argp->xdrgen.reclaim);
+	nlmsvc_release_lockowner(&argp->lock);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm_drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_lock_msg - LOCK_MSG: Establish a monitored lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_LOCK_MSG(nlm4_lockargs) = 7;
+ *
+ * The response to this request is delivered via the LOCK_RES procedure.
+ */
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_lockargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: LOCK_MSG      called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, true);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_LOCK_RES,
-				__nlm4svc_proc_lock);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_LOCK_RES,
+				__nlm4svc_proc_lock_msg);
 }
 
 static __be32 nlm4svc_proc_cancel_msg(struct svc_rqst *rqstp)
@@ -1093,15 +1137,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "TEST_MSG",
 	},
-	[NLMPROC_LOCK_MSG] = {
-		.pc_func = nlm4svc_proc_lock_msg,
-		.pc_decode = nlm4svc_decode_lockargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "LOCK_MSG",
+	[NLMPROC4_LOCK_MSG] = {
+		.pc_func	= nlm4svc_proc_lock_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_lockargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_lockargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "LOCK_MSG",
 	},
 	[NLMPROC_CANCEL_MSG] = {
 		.pc_func = nlm4svc_proc_cancel_msg,
-- 
2.52.0


