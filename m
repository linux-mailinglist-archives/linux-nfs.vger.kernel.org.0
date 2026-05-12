Return-Path: <linux-nfs+bounces-21564-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uGhiNu9xA2rH5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21564-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A589527AFF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 800B633033F4
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8437F014;
	Tue, 12 May 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdpM6iHd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E24436D510
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609661; cv=none; b=HxlBL6wLeBHiUXG82kA3j3qaoW2fKrrLwaTlxzS+3yiP2G7hSs4SGTv1wmNzcUnpXtRSLbhAH6sUOBCCwtg8usYTrqgqs55DaErtTAR0TzNxMMuiX++b+AJj4jYYLpDICJPKzonv2IVBXN+QPHpRZwJqr/OqgGE6C9yEzgSJh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609661; c=relaxed/simple;
	bh=eJJWPHdHZGIqo1Ly2jWx6Yrlu/e7OxYqsXaa0g9kIQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgNKnV4pLYja1/1EuzRwgJ82s95DKG9BoGtJg9KyBQ8ep+yl1Kx5BtaccbsJHldlwipfvloY4BoaI3PHny//v+D5UGekGDk2T35djTPVzBYXXqnCTq7XCjRk8YR+ZVQCQcvDDq5QqkuJ/UBTb2rxkPLVp/VBTCCLQGdKJDwGNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdpM6iHd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EE2C2BCB0;
	Tue, 12 May 2026 18:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609661;
	bh=eJJWPHdHZGIqo1Ly2jWx6Yrlu/e7OxYqsXaa0g9kIQA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZdpM6iHdgV0T8YhasNRDO0eTd9rMcNjo5urPzpqpMnXZBdRezpWiCS4tQ9X4CO3lU
	 xHCEgymB63P3VXUVS2UNRfGwIBanob3Y/WF4g8HZF3Y+dTn/5OixOyftwymTzt7TJf
	 9bWs1yTyCf8ZbuWPezNmicRwGvA50ojAhV1Zr7mrokUjI874clKSPboDmPSfRMsZSv
	 45gpacOhjJp7CW0hKxU/tIG0eHl8auL8UJRyUfzJmKAsA1fIk552Lw9Eu0IlMei53a
	 kAhFQ/K0+6u6o+NMMdOiKrSnbJPNzWpEhGYW/liM1+kDZFSHhg4TrnbRUMta4xCO8b
	 VB1gKZAXl5E/g==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:59 -0400
Subject: [PATCH 24/38] lockd: Use xdrgen XDR functions for the NLMv3
 GRANTED_MSG procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-24-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4713;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=luE90QsRVMalXm/YUdHSE4a+ttim7rLy/tyxoUibWZ0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mKwHoWesvBmYWdXhPVLcU7x3Vct5lYwnaR
 O91zNodDNCJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l3UNEACMDIY/zg8YUbDeBzeFEAQZNDIyGMKVmBPUoN9EOyvjxcUL0FQaAQl7eCbR5f9sovukXde
 /KOOP6hS+/BpUMIPl2quJ6sEVdarXUFSwEXPy1gjIQzVYQNnMIqAhAVWmCTEwj+S2/tdDWjJ4ii
 s61Eya9IsALWnUnWOEoVB0a2imcGz8Oq7uh1OGcGNWI9UnjCF78OCLSqoTECy1wRjwEKkte2K3l
 FDakA//DOZxKRUTzSdGeFIJowkutLDnTn4qZ8LPHvWMYcFtbmonZgv/3q9arScGKOaAOwb3dFtb
 y0HEg8HVZp4IkYaZms5FT6Wni2332nvX/ZXoo9CH12wZd8megqWlc2NJ2lwYmtuucIoRrlTZORl
 5zmNvJuc1legjUcRpqOTMqIWviRWNzNs42/YiESFdbtUwLenqqxoxUt0IazewDIWv5NglNaYtNI
 Howw+UMuXSEFE1kB8RBzmfGMMDBC9qXJYjdRLKGfp6sHZBk1YpytwPh7dTR+Vu4fYFgkE5eYIjA
 6zT8KpLWlt1AHVtM5MgYy3IAxC6XtQ/MEjegZryn1EGwW5tOATbpsUWODAgFF0smP4gSM36CXPd
 kU0TbwQnJ7AhuGLulDclBe83HD6OIJoQMxHxFXKxNlJRgVVg1ce4R5OeNveH1pfNT1KSv1BWO4E
 C1z901zkO2FKaxQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 8A589527AFF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21564-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 GRANTED_MSG,
the async counterpart to GRANTED that a remote NLM uses to tell
this lockd that a previously blocked client lock request has
become available. The procedure now uses
nlm_svc_decode_nlm_testargs and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification. The procedure
handler reaches the xdrgen types through the
nlm_testargs_wrapper structure, which bridges between generated
code and the legacy lockd_lock representation.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so
the zeroing memset performed by the dispatch layer is not
needed. The lock member of the wrapper is populated explicitly
in __nlmsvc_proc_granted_msg() by nlm_lock_to_lockd_lock()
rather than relying on zero-initialization.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct lockd_res,
preventing GRANTED and GRANTED_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 78 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index d059accfdebd..21a363450d59 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -594,23 +594,6 @@ nlmsvc_proc_unlock(struct svc_rqst *rqstp)
 		rpc_drop_reply : rpc_success;
 }
 
-/*
- * GRANTED: A server calls us to tell that a process' lock request
- * was granted
- */
-static __be32
-__nlmsvc_proc_granted(struct svc_rqst *rqstp, struct lockd_res *resp)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-
-	resp->cookie = argp->cookie;
-
-	dprintk("lockd: GRANTED       called\n");
-	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
-	dprintk("lockd: GRANTED       status %d\n", ntohl(resp->status));
-	return rpc_success;
-}
-
 /**
  * nlmsvc_proc_granted - GRANTED: Blocked lock has been granted
  * @rqstp: RPC transaction context
@@ -966,19 +949,52 @@ static __be32 nlmsvc_proc_unlock_msg(struct svc_rqst *rqstp)
 			       __nlmsvc_proc_unlock_msg);
 }
 
+static __be32
+__nlmsvc_proc_granted_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
+{
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+
+	resp->status = nlm_lck_denied;
+	if (nlm_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	if (nlm_lock_to_lockd_lock(&argp->lock, &argp->xdrgen.alock))
+		goto out;
+
+	resp->status = nlmclnt_grant(svc_addr(rqstp), &argp->lock);
+
+out:
+	return rpc_success;
+}
+
+/**
+ * nlmsvc_proc_granted_msg - GRANTED_MSG: Blocked lock has been granted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_garbage_args:	The request arguments are malformed.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_GRANTED_MSG(nlm_testargs) = 10;
+ *
+ * The response to this request is delivered via the GRANTED_RES procedure.
+ */
 static __be32 nlmsvc_proc_granted_msg(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: GRANTED_MSG   called\n");
+	if (argp->xdrgen.cookie.len > NLM_MAXCOOKIELEN)
+		return rpc_garbage_args;
 
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
 	return nlmsvc_callback(rqstp, host, NLMPROC_GRANTED_RES,
-			       __nlmsvc_proc_granted);
+			       __nlmsvc_proc_granted_msg);
 }
 
 /*
@@ -1244,15 +1260,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "UNLOCK_MSG",
 	},
-	[NLMPROC_GRANTED_MSG] = {
-		.pc_func = nlmsvc_proc_granted_msg,
-		.pc_decode = nlmsvc_decode_testargs,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "GRANTED_MSG",
+	[NLM_GRANTED_MSG] = {
+		.pc_func	= nlmsvc_proc_granted_msg,
+		.pc_decode	= nlm_svc_decode_nlm_testargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "GRANTED_MSG",
 	},
 	[NLMPROC_TEST_RES] = {
 		.pc_func = nlmsvc_proc_null,

-- 
2.54.0


