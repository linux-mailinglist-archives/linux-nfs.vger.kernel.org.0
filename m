Return-Path: <linux-nfs+bounces-21560-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPI0L+dxA2q55wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21560-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 064CA527ADE
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7DA32FE99B
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385BC37C0E3;
	Tue, 12 May 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CExYxjhG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A57D36F900
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609658; cv=none; b=L5ACYqmO3jr877YOHfjZpiA0y4p8jK4M8LvjY4qlSOSWYsQYomce0QdkcOr/Oq/2YTSaj0BVJhnTl3A7bIDpj43Gkwlg2sfi9WXTgqKjWRIcK0PPip5OV4f4XjpUQqS3/hfNM/LEO6CtV2AiFKIHbYrNWffuYqO/Jxpr/iy9kBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609658; c=relaxed/simple;
	bh=dSErKFmptQqUPc+TLq+zEtP8Gjf8arHrNTq8BrUM9Gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGepec48r9cPIQEi+bTQJl8fn5lhw8JIuBGCjhg8E4fc9SBlZF2Tq3saLoSyzuyjyR04uTSLxiSnaVivapQt+xlX7DZ2HKtx7a7Qpc4jQhKj9hOawUbc53JYjGHxcmJv6nPwLed20bDFJEo7SbZfsAt+D2dsMByo3SQiz0WAZUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CExYxjhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CE93C2BCB0;
	Tue, 12 May 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609657;
	bh=dSErKFmptQqUPc+TLq+zEtP8Gjf8arHrNTq8BrUM9Gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CExYxjhGm7PLCW6idlgHp6kjNL7VkUh2OxOVe+GVAee0rq9iCW+vjWZW/bCiB8fS3
	 03dYIwvqqos0I+bdiK+IiRzShRZnnAZmJXRiR5w4rlHo81TXYtt0Z3NK8a5rxPyv2P
	 JIhobjOxocUYBzM4So2CoOdBBA7KxvS6V7NFZRBS00xRIsWlQgDdsYeXDxmZIsz9Wf
	 BsbzDOqjcqucSFCD4ecYhuAvWpss77HSnYgWEs+kBmDVIUoaddKiM/8WPpZQJG3USd
	 u8R+Ut0sSspwcI56NmiH5v5WKXnGIyOQUcbfY8eYcpXrQaRk+L72tcz82Yb7zPDdOU
	 rQoM/Y7H2PkVg==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:13:55 -0400
Subject: [PATCH 20/38] lockd: Use xdrgen XDR functions for the NLMv3
 TEST_MSG procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-20-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5762;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=XYd2waRkd8XZXtPWWdrcdqJn6eEJv6MpckEwJbEKKG4=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23lt1tgg0EX1DFODs5l/GvqROswgXBpE+VJB
 SicFp3Sv/KJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5QAKCRAzarMzb2Z/
 l7z2D/9d+h5zDWjfm1L60T/U0arnEqQqnAKEW5abZDo3K/YLvRMrTwYYM9Fz2Cj4Egm+Q715uyV
 nDA+8vV6BA6pT6b82pN4n286iufa2Ez6MOgyAYEhreH5O+636UB1379lY+Fh4Db85p/cRzJnqku
 36lYLp1YK7D0wSrHV9GF80Lbiu5WfBtuwslEMR/IoByGv4Acy8joJnQaDnPzesLtSdiXDPNY+kv
 3c4GzlbePG3+vP90BA0bOzycTQ/EmEpYEezrU6fQ5Ot5Bu1Jpno5ynxF66FU+by0XGdnCjb+wsS
 1mvG5FvE5E2MnG6hOLUwe3ardu+ajFVAa/TVpprfezCR6K5WyX05MB3bPfw2/SQbCDT7ORlOQ9C
 oL6a/k89JsnNF11LwUhFMi2scaFxUDab7Fo/+Da0is8izTgGIfqhwrIHgdnuRxa2/BCA9mXzIEr
 62tH/hH1DWky/UIr9tnXCk6dN+j9sIqY3+l4qdSACjHHEt3XOcPd+a0oCRICZGz2onp/7OsVVOb
 jdznBeK6LcMZ7KWONBIWC0rizivKv7jNkfJ8TxgmmhaZewFZi4NRLbQ7KC2tI6gJQVVaZrljnnm
 lKOLwvSS3KrurkK5w/bf8El+oWcao2YJX00/4YRQE17CVtaSWTX5/hHO0bnvl3Y9bGue+EPCJuY
 BUq1mf6Hf/UfNjg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 064CA527ADE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21560-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 TEST_MSG, the
async counterpart to TEST that clients use to check lock
availability without blocking. The procedure now uses
nlm_svc_decode_nlm_testargs and nlm_svc_encode_void, generated
from the NLM version 3 protocol specification. The procedure
handler reaches the xdrgen types through the
nlm_testargs_wrapper structure, which bridges between generated
code and the legacy lockd_lock representation.

Setting pc_argzero to zero is safe because the generated decoder
fills the argp->xdrgen subfields before the procedure runs, so
the zeroing memset performed by the dispatch layer is not
needed. The lock member of the wrapper is populated explicitly
in nlm3svc_lookup_file() rather than relying on
zero-initialization.

The NLM async callback mechanism uses client-side functions
which continue to take legacy results like struct lockd_res,
preventing TEST and TEST_MSG from sharing code for now.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 112 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 48 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index 2e6afb9a19b9..cd32cfc62338 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -296,40 +296,6 @@ static __be32 nlmsvc_proc_null(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * TEST: Check for conflicting lock
- */
-static __be32
-__nlmsvc_proc_test(struct svc_rqst *rqstp, struct lockd_res *resp)
-{
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
-	struct nlm_file	*file;
-	__be32 rc = rpc_success;
-
-	dprintk("lockd: TEST          called\n");
-	resp->cookie = argp->cookie;
-
-	/* Obtain client and file */
-	if ((resp->status = nlmsvc_retrieve_args(rqstp, argp, &host, &file)))
-		return resp->status == nlm__int__drop_reply ?
-			rpc_drop_reply : rpc_success;
-
-	/* Now check for conflicting locks */
-	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
-						   &argp->lock, &resp->lock));
-	if (resp->status == nlm__int__drop_reply)
-		rc = rpc_drop_reply;
-	else
-		dprintk("lockd: TEST          status %d vers %d\n",
-			ntohl(resp->status), rqstp->rq_vers);
-
-	nlmsvc_release_lockowner(&argp->lock);
-	nlmsvc_release_host(host);
-	nlm_release_file(file);
-	return rc;
-}
-
 /**
  * nlmsvc_proc_test - TEST: Check for conflicting lock
  * @rqstp: RPC transaction context
@@ -805,19 +771,69 @@ nlmsvc_callback(struct svc_rqst *rqstp, struct nlm_host *host, u32 proc,
 	return rpc_success;
 }
 
+static __be32
+__nlmsvc_proc_test_msg(struct svc_rqst *rqstp, struct lockd_res *resp)
+{
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+	unsigned char type = argp->xdrgen.exclusive ? F_WRLCK : F_RDLCK;
+	struct nlm_lockowner *owner;
+	struct nlm_file	*file = NULL;
+	struct nlm_host	*host = NULL;
+
+	resp->status = nlm_lck_denied_nolocks;
+	if (nlm_netobj_to_cookie(&resp->cookie, &argp->xdrgen.cookie))
+		goto out;
+
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
+	if (!host)
+		goto out;
+
+	resp->status = nlm3svc_lookup_file(rqstp, host, &argp->lock,
+					   &file, &argp->xdrgen.alock, type);
+	if (resp->status)
+		goto out;
+
+	owner = argp->lock.fl.c.flc_owner;
+	resp->status = cast_status(nlmsvc_testlock(rqstp, file, host,
+						   &argp->lock, &resp->lock));
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
+ * nlmsvc_proc_test_msg - TEST_MSG: Check for conflicting lock
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_drop_reply:		Do not send an RPC reply.
+ *   %rpc_garbage_args:	The request arguments are malformed.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * RPC synopsis:
+ *   void NLMPROC_TEST_MSG(nlm_testargs) = 6;
+ *
+ * The response to this request is delivered via the TEST_RES procedure.
+ */
 static __be32 nlmsvc_proc_test_msg(struct svc_rqst *rqstp)
 {
-	struct lockd_args *argp = rqstp->rq_argp;
-	struct nlm_host	*host;
+	struct nlm_testargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_host *host;
 
-	dprintk("lockd: TEST_MSG      called\n");
+	if (argp->xdrgen.cookie.len > NLM_MAXCOOKIELEN)
+		return rpc_garbage_args;
 
-	host = nlmsvc_lookup_host(rqstp, argp->lock.caller, argp->lock.len);
+	host = nlm3svc_lookup_host(rqstp, argp->xdrgen.alock.caller_name, false);
 	if (!host)
 		return rpc_system_err;
 
 	return nlmsvc_callback(rqstp, host, NLMPROC_TEST_RES,
-			       __nlmsvc_proc_test);
+			       __nlmsvc_proc_test_msg);
 }
 
 static __be32 nlmsvc_proc_lock_msg(struct svc_rqst *rqstp)
@@ -1103,15 +1119,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= NLM3_nlm_res_sz,
 		.pc_name	= "GRANTED",
 	},
-	[NLMPROC_TEST_MSG] = {
-		.pc_func = nlmsvc_proc_test_msg,
-		.pc_decode = nlmsvc_decode_testargs,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_args),
-		.pc_argzero = sizeof(struct lockd_args),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "TEST_MSG",
+	[NLM_TEST_MSG] = {
+		.pc_func	= nlmsvc_proc_test_msg,
+		.pc_decode	= nlm_svc_decode_nlm_testargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_testargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "TEST_MSG",
 	},
 	[NLMPROC_LOCK_MSG] = {
 		.pc_func = nlmsvc_proc_lock_msg,

-- 
2.54.0


