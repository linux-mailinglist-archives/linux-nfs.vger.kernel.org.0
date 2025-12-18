Return-Path: <linux-nfs+bounces-17215-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A70CCD804
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 21:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0B49302EFC5
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Dec 2025 20:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58D462D8DB0;
	Thu, 18 Dec 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIT1E98x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C302D8DAF
	for <linux-nfs@vger.kernel.org>; Thu, 18 Dec 2025 20:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766088851; cv=none; b=kbwAcpVtWww4xaGfv3fZUgmLhKAudV/NedxEQB0EbsYHR/KmyrDpcic+GON1waue7luG7Nsn367WTfyBp9uxnu9pDAuDUiL0K7V7aiqPQJbr8jkxp7X4XTKJBxpQnR1+GTTEM+kNYYfdEi/Uk6OuNERmMRxHf27veTbDMDGSY98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766088851; c=relaxed/simple;
	bh=YigxBQ30CIOKHUNHeW8Suxjd0NUvaL+y2jHcn7M0k34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZQe/c8poXbik9bQfZqbR/AwyvH1wEwbuBHTnIm0GmO/aVud88WfzXZuZ57eBB/ocDP/BJ1ON4KUK/4/cP0JwxgvkQAv220v4bivi50iyVQVmjw27+YdnLAKz5R2L6NoR0s6ay7uC9exzPVgdn/3J/XB2aGccYILTKPhGfXNTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIT1E98x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEE8C113D0;
	Thu, 18 Dec 2025 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766088851;
	bh=YigxBQ30CIOKHUNHeW8Suxjd0NUvaL+y2jHcn7M0k34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIT1E98xEWrFqfK2pwBrZD7+HFj+qkpo9/M+vTRWlGZzIN7MXEWzYA5MK5FRsmDsv
	 bz8b2u4H391QHb355Dg5qml9+DmbuJ7DUMGUSMHYKKEdmwSC5WEdrEbc5iCSQhYpRr
	 pARK2GqCxZ0LyGznFEvQ2rHRJrQb+w1HYS1MBeBewnBdNxEkZrKCuhaNFPOJnmSB5Y
	 gqf6yB4my+KQHr2nx2m45z2a7YSbSQfBPmy+1FpIuErdNdhhLCR4ft1dfHMc1JoxQ2
	 n4AuvnTJEW13a72FkZR+yJc1n1Ff4uGatMiuVl6nVsZlod96lG062Krnozwue2gBnv
	 I3u03xiJKG8tw==
From: Chuck Lever <cel@kernel.org>
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Cc: <linux-nfs@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v1 27/36] lockd: Use xdrgen XDR functions for the NLMv4 SM_NOTIFY procedure
Date: Thu, 18 Dec 2025 15:13:37 -0500
Message-ID: <20251218201346.1190928-28-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218201346.1190928-1-cel@kernel.org>
References: <20251218201346.1190928-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Replace the NLMPROC4_SM_NOTIFY entry in the nlm_procedures4 array
with an entry that uses the xdrgen-built XDR functions for that
procedure. Helper functions are introduced which will be used here
and in subsequent patches.

The .pc_argzero field is now set to zero for the NLMv4 SM_NOTIFY
procedure. The xdrgen decoders are trusted to initialize all
arguments in the argp->xdrgen field, making the early defensive
memset unnecessary. The remaining argp fields are cleared as needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svc4proc.c | 74 +++++++++++++++++++++++++++------------------
 fs/lockd/xdr4.h     |  7 +++++
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
index fb610e390aa9..8a4ca46cf48b 100644
--- a/fs/lockd/svc4proc.c
+++ b/fs/lockd/svc4proc.c
@@ -789,6 +789,41 @@ static __be32 nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
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
+ */
+static __be32 nlm4svc_proc_sm_notify(struct svc_rqst *rqstp)
+{
+	struct nlm4_notifyargs_wrapper *argp = rqstp->rq_argp;
+	struct nlm_reboot *reboot = &argp->reboot;
+
+	if (!nlm_privileged_requester(rqstp)) {
+		char buf[RPC_MAX_ADDRBUFLEN];
+
+		printk(KERN_WARNING "lockd: rejected NSM callback from %s\n",
+				svc_print_addr(rqstp, buf, sizeof(buf)));
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
@@ -891,27 +926,6 @@ nlm4svc_proc_free_all(struct svc_rqst *rqstp)
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
@@ -1091,15 +1105,15 @@ const struct svc_procedure nlmsvc_procedures4[24] = {
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
diff --git a/fs/lockd/xdr4.h b/fs/lockd/xdr4.h
index c4c7f8222cf1..edfbe7c06644 100644
--- a/fs/lockd/xdr4.h
+++ b/fs/lockd/xdr4.h
@@ -46,6 +46,13 @@ struct nlm4_unlockargs_wrapper {
 
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
-- 
2.52.0


