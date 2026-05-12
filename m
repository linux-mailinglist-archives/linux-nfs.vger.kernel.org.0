Return-Path: <linux-nfs+bounces-21570-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJ+hJTVuA2pS5wEAu9opvQ
	(envelope-from <linux-nfs+bounces-21570-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CDC527232
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 814793067DF3
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2026 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5AE37FF6F;
	Tue, 12 May 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAnU2zuV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FF6343D9D
	for <linux-nfs@vger.kernel.org>; Tue, 12 May 2026 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609666; cv=none; b=j7FrJSOgjrgvwnpPs13KGz3dkPkQk+hkHrS4T6VzyNp2ikrXNUzJ0kMcdUPd23az3VkSbZvAsGFkQ8PWkVgNRgNQecXGcRsVwXo2mxDkeAnftNYfQNAP8a8M3MEWA1BsBtSoG4iwQPDjn40TkyVNpsaSWmfR701mkPU3c/n3gkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609666; c=relaxed/simple;
	bh=RNF9HlArEQCy9d+he5pqWrnpeOIzvNarWsVgJK6eGm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nh8ty9FIVtGs/wXtoe4/t6TlL7Tblt0wyugv9pbKUwTF4PlWguQ+ffbgQvQbpNmWpg2kYEcRnEdksxqirCSG4ABa2yducIXuGUZ/a20UnxunEjPsHgUCOA3kyOSdHr5ibU6Y8WeZLCXZcZnnHN9YyTBbOY7Ugyp2cFLiH4WSBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAnU2zuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF238C2BCB0;
	Tue, 12 May 2026 18:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609666;
	bh=RNF9HlArEQCy9d+he5pqWrnpeOIzvNarWsVgJK6eGm8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sAnU2zuVO4HKkBxLIaQ7PRztEkehzOsXrwDyGWJdjVwSIOhLRnsmT9pGnWhiLoApS
	 Y3lwvpT81ncUY2Xq7Q+GopQC2FrRG2SifrW7BapsK5xpvcvO5Xt8bftsn5erelqnnI
	 V+tQsxSSRTQzSkZIBkeIc8Bc+Ylds4mlaLueeTjqCkIUW+CM7rVH5nGdIl2uwsjFqC
	 SlMZBMU4DuNhHaNpPlmEQLw+djG455gAlYRyx7rt4ILp9UcSE/0cfpmkVDDKfHNvZP
	 +x9rDdLV1WAYP244kXoWGcnFPYhRFUqBvZDZBarSH9pefDuTUD6VviSi4NzdmyLRLi
	 Dapx9p8IMbDNQ==
From: Chuck Lever <cel@kernel.org>
Date: Tue, 12 May 2026 14:14:05 -0400
Subject: [PATCH 30/38] lockd: Use xdrgen XDR functions for the NLMv3
 SM_NOTIFY procedure
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-nlm4-xdrgen-v1-30-19d99b2634b4@oracle.com>
References: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
In-Reply-To: <20260512-nlm4-xdrgen-v1-0-19d99b2634b4@oracle.com>
To: Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=4876;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=4Qff39bteNlJK0/jwjcqyAi2jN1rOB8fJ51G+rxq5kY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqA23mANZkwtpIJMjP3nMC9FtW7L16Q9HzAdN9X
 AEgTNvyqC2JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagNt5gAKCRAzarMzb2Z/
 l5z2D/42qiWBPbr2hTgqhIzjszkVBsmoQTo+PxXYZ97APjSrRdZOcg63m2wSKOmnrVC0nGcuTaC
 G09IzSqU316sfEPRLnPzVih1kxcYsR0OwKYegT5qedb3JxzwqXQLmuFv5/pt4ZoR+bKhZ9CFnc5
 00Q6CO++wMah+u2cOPQH+VHfOaPmqMCA115utRzxxbuNN0pMMWAKVEGIrplToJ4k2M4tVDem3Nw
 VFSPSK/9nCC3J1lqrqWDaf2C+rMpArp3WyaI/PPJyffi+2PID2kr45/f/jtJE8LRZjX3Xpu7gCG
 l3i3pZe4ruymT/OWg68jGsIZIFr1C/m5GVASKHAJ2hViu4fvMOt95geEtDVJ25S0wBjF9EanF+r
 N/+am3gX89eEo6XJ4jE/gXoALZTihbOUt7wkkvlNtA5nHpMkXHTVBigljklbgrmydXbGUJ/j7tU
 hexPjyoA4opl4rSjhHmpZN4MZ30Z7Vie90jV1EuE+RzMBKMQ5OmU2MyrdsH518LEhbcCVb2zh0G
 C3uZ7EYVZU+Ccf7TPtybB6TsIn3yugsFXUbMDXFge3M4mKPUnaKyTkGw5NgogqNyHTo1HoEfSP+
 2fy9QUB4tqNzJg9WQzKyq1h1CnLJkyBgoN5kP5b4tIYdeOVTQDdR8NLq3zW1m/IKgc98ePVt/OO
 qWHasi5aprleCMA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 79CDC527232
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21570-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

Continue the xdrgen migration by converting NLMv3 SM_NOTIFY,
a private callback from statd to notify lockd when a remote
host has rebooted.  The procedure now uses
nlm_svc_decode_nlm_notifyargs and nlm_svc_encode_void,
generated from the NLM version 3 protocol specification.

A new struct nlm_notifyargs_wrapper bridges between the
xdrgen-generated nlm_notifyargs and the lockd_reboot
structure expected by nlm_host_rebooted().  The wrapper
contains both the xdrgen-decoded arguments and a reboot
field for the existing API.

Setting pc_argzero to zero is safe because the generated
decoder fills argp->xdrgen before the procedure runs, so
the zeroing memset performed by the dispatch layer is no
longer needed.

Setting pc_xdrressize to XDR_void reflects that SM_NOTIFY
returns no data; the previous value of St over-reserved a
status word in the reply buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/lockd/svcproc.c | 86 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 31 deletions(-)

diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
index a2ac747e96ce..e0328dc89deb 100644
--- a/fs/lockd/svcproc.c
+++ b/fs/lockd/svcproc.c
@@ -80,6 +80,13 @@ struct nlm_unlockargs_wrapper {
 
 static_assert(offsetof(struct nlm_unlockargs_wrapper, xdrgen) == 0);
 
+struct nlm_notifyargs_wrapper {
+	struct nlm_notifyargs		xdrgen;
+	struct lockd_reboot		reboot;
+};
+
+static_assert(offsetof(struct nlm_notifyargs_wrapper, xdrgen) == 0);
+
 static __be32
 nlm_netobj_to_cookie(struct lockd_cookie *cookie, netobj *object)
 {
@@ -1022,6 +1029,44 @@ static __be32 nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
+/**
+ * nlmsvc_proc_sm_notify - SM_NOTIFY: Peer has rebooted
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
+ *   void NLM_SM_NOTIFY(nlm_notifyargs) = 16;
+ */
+static __be32 nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
+{
+	struct nlm_notifyargs_wrapper *argp = rqstp->rq_argp;
+	struct lockd_reboot *reboot = &argp->reboot;
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
@@ -1129,27 +1174,6 @@ nlmsvc_proc_free_all(struct svc_rqst *rqstp)
 	return rpc_success;
 }
 
-/*
- * SM_NOTIFY: private callback from statd (not part of official NLM proto)
- */
-static __be32
-nlmsvc_proc_sm_notify(struct svc_rqst *rqstp)
-{
-	struct lockd_reboot *argp = rqstp->rq_argp;
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
 nlmsvc_proc_unused(struct svc_rqst *rqstp)
 {
@@ -1328,15 +1352,15 @@ static const struct svc_procedure nlmsvc_procedures[24] = {
 		.pc_xdrressize	= XDR_void,
 		.pc_name	= "GRANTED_RES",
 	},
-	[NLMPROC_NSM_NOTIFY] = {
-		.pc_func = nlmsvc_proc_sm_notify,
-		.pc_decode = nlmsvc_decode_reboot,
-		.pc_encode = nlmsvc_encode_void,
-		.pc_argsize = sizeof(struct lockd_reboot),
-		.pc_argzero = sizeof(struct lockd_reboot),
-		.pc_ressize = sizeof(struct nlm_void),
-		.pc_xdrressize = St,
-		.pc_name = "SM_NOTIFY",
+	[NLM_SM_NOTIFY] = {
+		.pc_func	= nlmsvc_proc_sm_notify,
+		.pc_decode	= nlm_svc_decode_nlm_notifyargs,
+		.pc_encode	= nlm_svc_encode_void,
+		.pc_argsize	= sizeof(struct nlm_notifyargs_wrapper),
+		.pc_argzero	= 0,
+		.pc_ressize	= 0,
+		.pc_xdrressize	= XDR_void,
+		.pc_name	= "SM_NOTIFY",
 	},
 	[17] = {
 		.pc_func = nlmsvc_proc_unused,
@@ -1418,10 +1442,10 @@ union nlmsvc_xdrstore {
 	struct nlm_lockargs_wrapper	lockargs;
 	struct nlm_cancargs_wrapper	cancargs;
 	struct nlm_unlockargs_wrapper	unlockargs;
+	struct nlm_notifyargs_wrapper	notifyargs;
 	struct nlm_testres_wrapper	testres;
 	struct nlm_res_wrapper		res;
 	struct lockd_args		args;
-	struct lockd_reboot		reboot;
 };
 
 /*

-- 
2.54.0


