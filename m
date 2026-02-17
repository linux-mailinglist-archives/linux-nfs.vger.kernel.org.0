Return-Path: <linux-nfs+bounces-18992-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MyaJRbnlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-18992-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5815152F
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95DBD300A8F0
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337E2313525;
	Tue, 17 Feb 2026 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1dapbQN"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A2313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366054; cv=none; b=MC3ZEgL0d0Jq+nT01k2RX4lYpb5uBY4X9/cKoYn5glgbX/OHRK/I3v9sWUAvl31LLIFX2y1/Uqkw21iAu+aWyfwrmKFX2/TEu6ulg0A/PJShRYdCQSAteJ8i3UTJC5UYhu9UaPHy3WH6iw3f4Fu5hu5bUYcNQaibMSS7TdwSQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366054; c=relaxed/simple;
	bh=BAkH9ikchr3jDUIlQGxRUllzM+LAPCQM1xW1plfdA3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHyXzqND8Db6QqYlcyxs+Rf9KuciyQ7qLWNJUY73+BKYFtT8pDHZp4gw+7aHeu7nnuAtRUHLvGLe11306VaqTOznEgtVLLByWcldtkeKpp93IW6xhM6M8WpTuwmcEbZjozAVIPdioXww3lFfD7SnQBGWcel73PpVPx0Cl2uAx+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1dapbQN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12761C19423;
	Tue, 17 Feb 2026 22:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366053;
	bh=BAkH9ikchr3jDUIlQGxRUllzM+LAPCQM1xW1plfdA3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1dapbQNzDq0sYRkaQkkdsPttI4UxoQ6/1WqmRClzkfYIhDIOJMPD4Yn3C3MVM9Zk
	 blpPoXPHXVM1qXdPHV0ehrm+fXjK+rL9vjASzIgjvdwm8xFbAI53UiDrmu7LyTf31J
	 oCEawIyhRC8MJhOIOImXXp2T8KmarjyYpEiehFexv7+1mtUJTM8RJfhCdGZts1fNYe
	 FNhIGD/2mC31n+BYO7pJ3at2ZHrDf88wg5+0dDkobb/eBbgGqqB2XAdfCE2HadFO2h
	 ap9VwS615k3P+J8sZ5sj+Ain2LUHLI8Tw0O0f6QOxY3fH6YKA/eh9thA1oZNh3LzxO
	 kwEk5zOemVYcA==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 09/29] lockd: Use xdrgen XDR functions for the NLMv4 TEST_MSG procedure
Date: Tue, 17 Feb 2026 17:07:01 -0500
Message-ID: <20260217220721.1928847-10-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-18992-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 29D5815152F
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

The TEST_MSG procedure is part of NLM's asynchronous lock request
flow, where clients send TEST_MSG to check lock availability
without blocking. This patch continues the xdrgen migration by
converting TEST_MSG to use generated XDR functions.

This patch converts the TEST_MSG procedure to use xdrgen
functions nlm4_svc_decode_nlm4_testargs and
nlm4_svc_encode_void generated from the NLM version 4 protocol
specification. The procedure handler uses xdrgen types through
the nlm4_testargs_wrapper structure that bridges between
generated code and the legacy nlm_lock representation.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments in the argp->xdrgen field,
making the early defensive memset unnecessary. Remaining argp
fields are cleared as needed.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct nlm_res,
preventing TEST and TEST_MSG from sharing code for now.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 114 +++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 54 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index f1a692f72a39..afce778b62d3 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -260,39 +260,6 @@ nlm4svc_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * TEST: Check for conflicting lock
- */
-static __be32
-__nlm4svc_proc_test(struct svc_rqst *rqstp, struct nlm_res *resp)
-{
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: TEST4        called\n");
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlm4svc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
-
-	/* Now check for conflicting locks */
-	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
-				       &resp->lock);
-	if (resp->status == nlm__int__drop_reply)
-		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: TEST4        status %d\n", ntohl(resp->status));
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 /**
  * nlm4svc_proc_test - TEST: Check for conflicting lock
  * @rqstp: RPC transaction context
@@ -785,25 +752,64 @@ nlm4svc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
 	return rpc_success;
 }
 
-/*
- * 'Async' versions of the above service routines. They aren't really,
- * because we send the callback before the reply proper. I hope this
- * doesn't break any clients.
- */
+static __be32
+__nlm4svc_proc_test_msg(struct svc_rqst *rqstp, struct nlm_res *resp)
+{
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_lockowner *owner;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
 
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm4_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm4svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	owner = argp->lock.fl.c.flc_owner;
+	resp->status = nlmsvc_testlock(rqstp, file, host, &argp->lock,
+				       &resp->lock);
+	nlmsvc_put_lockowner(owner);
+
+out:
+	if (file)
+		nlm_release_file(file);
+	nlmsvc_release_host(host);
+	return resp->status == nlm__int__drop_reply ? rpc_drop_reply : rpc_success;
+}
+
+/**
+ * nlm4svc_proc_test_msg - TEST_MSG: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_TEST_MSG(nlm4_testargs) = 6;
+ *
+ * The response to this request is delivered via the TEST_RES procedure.
+ */
 static __be32 nlm4svc_proc_test_msg(struct svc_rqst *rqstp)
 {
-	struct nlm_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm4_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: TEST_MSG      called\n");
-
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm4svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
-	return nlm4svc_callback(rqstp, host, NLMPROC_TEST_RES,
-				__nlm4svc_proc_test);
+	return nlm4svc_callback(rqstp, host, NLMPROC4_TEST_RES,
+				__nlm4svc_proc_test_msg);
 }
 
 static __be32 nlm4svc_proc_lock_msg(struct svc_rqst *rqstp)
@@ -1087,15 +1093,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= NLM4_nlm4_res_sz,
 		.pc_name	= "GRANTED",
 	},
-	[NLMPROC_TEST_MSG] = {
-		.pc_func = nlm4svc_proc_test_msg,
-		.pc_decode = nlm4svc_decode_testargs,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_args),
-		.pc_argzero = sizeof(struct nlm_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_MSG",
+	[NLMPROC4_TEST_MSG] = {
+		.pc_func	= nlm4svc_proc_test_msg,
+		.pc_decode	= nlm4_svc_decode_nlm4_testargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlm4svc_proc_lock_msg,
-- 
2.53.0


