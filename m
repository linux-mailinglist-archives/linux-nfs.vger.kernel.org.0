Return-Path: <linux-nfs+bounces-19002-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JtrO7DmlGmjIgIAu9opvQ
	(envelope-from <linux-nfs+bounces-19002-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:44 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 963A81514AC
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 23:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B6628301DD79
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Feb 2026 22:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5A3313E1B;
	Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uusEnXe6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC57313276
	for <linux-nfs@vger.kernel.org>; Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771366061; cv=none; b=NvzX/ibq7WnUKWsdDgbgpIMmGdJ7P+pjYLvarF75izURURBt9Xzb1cG6kjQlRO66FAAzC7bek1WRK8BA5NXvGktCLJXkGsa1QTtdHbL8Am0JAEeakcx2MdJZHKO+CLQHnoJQpxtQz3g92uOpASW6i4vaTi69fOCLOVp0d+kNgxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771366061; c=relaxed/simple;
	bh=AgB7+7AJpvfyjKPUFLyb9ggPzwZ6LuB0P/68kGOaxTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2WsDz2WSxOzTJNBggBntP9JnzClGwSX0LmwwE91AUM7i4va7E4bmr/xtP2ur8tStU3l+9yxhrcBIFJ3LVnzHDKRitv2W7nHO7zvsMKzWWqtSFrLVmqmUywNSMlrvRhBBKGN9pkAoLSBNxfi0Slz0Pb4jG9Kq68yCSlhNMuK7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uusEnXe6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2308AC4CEF7;
	Tue, 17 Feb 2026 22:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771366061;
	bh=AgB7+7AJpvfyjKPUFLyb9ggPzwZ6LuB0P/68kGOaxTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uusEnXe6zYsRtX3WsnGgisbx2LODXAHK2iOAfed1olUt4bfOV6fApRu5WGzhwgIZ3
	 wzxJavjxj7Rux+DBKO9Bdnsg/5s1uivnsDLD3ZjWX9WwNvUKIGo68T155vxkeWWc8h
	 eOek1N8JY1U7xFbzGD1nG6Lb9Vgynjg0sOpnBzIRzJoUy962zxgrv1YHQVQYuGuas0
	 PurC6+XPzDYMYSyUT7QUMIVDUw9IZX17pSPd9z2MU08zQZGu4/u7J4AlSVWBrO37Ez
	 dKsVpB6Nf9E0txp7W/SC/1lwcU9tmLp3Jmpk+kDq2dNnGerlyc7kzhkrgjqdWirjnB
	 ePwvIhqXC6ajw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v3 19/29] lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
Date: Tue, 17 Feb 2026 17:07:11 -0500
Message-ID: <20260217220721.1928847-20-cel@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com];
	TAGGED_FROM(0.00)[bounces-19002-lists,linux-nfs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 963A81514AC
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Convert the SM_NOTIFY procedure to use xdrgen functions
nlm4_svc_decode_nlm4_notifyargs and nlm4_svc_encode_void.
SM_NOTIFY is a private callback from statd to notify lockd
when a remote host has rebooted.

This patch introduces struct nlm4_notifyargs_wrapper to
bridge between the xdrgen-generated nlm4_notifyargs and
the nlm_reboot structure expected by nlm_host_rebooted().
The wrapper contains both the xdrgen-decoded arguments
and a reboot field for the existing API.

The pc_argzero field is set to zero because xdrgen decoders
reliably initialize all arguments, making the early
defensive memset unnecessary.

This change also corrects the pc_xdrressize field, which
previously contained a placeholder value.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 86 +++++++++++++++++++++++++++++----------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index f986cdac5d00..4f8c41046ed6 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -62,6 +62,13 @@ struct nlm4_unlockargs_wrapper {
 
 static_assert(offsetof(struct nlm4_unlockargs_wrapper, xdrgen) == 0);
 
+struct nlm4_notifyargs_wrapper {
+	struct nlm4_notifyargs		xdrgen;
+	struct nlm_reboot		reboot;
+};
+
+static_assert(offsetof(struct nlm4_notifyargs_wrapper, xdrgen) == 0);
+
 struct nlm4_testres_wrapper {
 	struct nlm4_testres		xdrgen;
 	struct nlm_lock			lock;
@@ -984,6 +991,44 @@ static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlm4svc_proc_sm_notify - SM_NOTIFY: Peer has rebooted
+ * @rqstp: RPC transaction context
+ *
+ * Returns:
+ *   %rpc_success:		RPC executed successfully.
+ *   %rpc_system_err:		RPC execution failed.
+ *
+ * The SM_NOTIFY procedure is a private callback from Linux statd and is
+ * not part of the official NLM protocol.
+ *
+ * RPC synopsis:
+ *   void NLMPROC4_SM_NOTIFY(nlm4_notifyargs) = 16;
+ */
+static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
+{
+	struct nlm4_notifyargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_reboot *reboot = &argp->reboot;
+
+	if (!nlm_privileged_requester(rqstp)) {
+		char buf[RPC_MAX_ADDRBUFLEN];
+
+		pr_warn("lockd: rejected NSM callback from %s\n",
+			svc_print_addr(rqstp, buf, sizeof(buf)));
+		return rpc_system_err;
+	}
+
+	reboot->len = argp->xdrgen.notify.name.len;
+	reboot->mon = (char *)argp->xdrgen.notify.name.data;
+	reboot->state = argp->xdrgen.notify.state;
+	memcpy(&reboot->priv.data, argp->xdrgen.private,
+	       sizeof(reboot->priv.data));
+
+	nlm_host_rebooted(SVC_NET(rqstp), reboot);
+
+	return rpc_success;
+}
+
 /*
  * SHARE: create a DOS share or alter existing share.
  */
@@ -1088,27 +1133,6 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * SM_NOTIFY: private callback from statd (not part of official NLM proto)
- */
-static __be32
-nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
-{
-	struct nlm_reboot *argp = rqstp->rq_argp;
-
-	dprintk("lockd: SM_NOTIFY     called\n");
-
-	if (!nlm_privileged_requester(rqstp)) {
-		char buf[RPC_MAX_ADDRBUFLEN];
-		printk(KERN_WARNING "lockd: rejected NSM callback from %s\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)));
-		return rpc_system_err;
-	}
-
-	nlm_host_rebooted(SVC_NET(rqstp), argp);
-	return rpc_success;
-}
-
 static __be32
 nlm4svc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1288,15 +1312,15 @@ static const struct svc_procedure nlm4svc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "GRANTED_RES",
 	},
-	[NLMPROC_NSM_NOTIFY] = {
-		.pc_func = nlm4svc_proc_sm_notify,
-		.pc_decode = nlm4svc_decode_reboot,
-		.pc_encode = nlm4svc_encode_void,
-		.pc_argsize = sizeof(struct nlm_reboot),
-		.pc_argzero = sizeof(struct nlm_reboot),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "SM_NOTIFY",
+	[NLMPROC4_SM_NOTIFY] = {
+		.pc_func	= nlm4svc_proc_sm_notify,
+		.pc_decode	= nlm4_svc_decode_nlm4_notifyargs,
+		.pc_encode	= nlm4_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm4_notifyargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlm4svc_proc_unused,
@@ -1378,10 +1402,10 @@ union nlm4svc_xdrstore {
 	struct nlm4_lockargs_wrapper	lockargs;
 	struct nlm4_cancargs_wrapper	cancargs;
 	struct nlm4_unlockargs_wrapper	unlockargs;
+	struct nlm4_notifyargs_wrapper	notifyargs;
 	struct nlm4_testres_wrapper	testres;
 	struct nlm4_res_wrapper		res;
 	struct nlm_args			args;
-	struct nlm_reboot		reboot;
 };
 
 static DEFINE_PER_CPU_ALIGNED(unsigned long,
-- 
2.53.0


