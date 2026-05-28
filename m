Return-Path: <linux-nfs+bounces-22049-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFOOHnuYGGqklQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22049-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575A5F7279
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 21:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3706A3045E48
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2026 19:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFB9344052;
	Thu, 28 May 2026 19:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIDeuMHj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2419C327C00;
	Thu, 28 May 2026 19:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779996753; cv=none; b=nkqdPw2B0ZN8dKiE+zEwKhjsT1ud3AS4ktHuBe44yw7PTnAfSj1rIR6wBLCYEI5VfrSMZ4Qj5RLwG2JeaejXkllHKr5N4YFI2dxDS/GviZKiKhY6z+FLUlcFCTKpieMOS2jd8IcjPAnGz6afhb5t7sjh2M/PUA7KxRiNiy/p2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779996753; c=relaxed/simple;
	bh=4kTJP3/PuJCbw1gUUjPb+o5S0X7njZJvgd0CVuEmvAM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rz7JTRlmKgiOUsKSFMLAysw1rTp0SAWhugKfaastN4F8OBknCed1juW2bb4c9bg2tnqrJ1pFGSMlPLmOuTbrEuRrv8cFpnlk3/isDG9bqDh5pUubv8ASTi3KPJyGFpxhkoA+dekrNCRW56pc5nHgxHUJ7YNig44T1aI0GomUzCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIDeuMHj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B841F00A3D;
	Thu, 28 May 2026 19:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779996751;
	bh=JM/88wGqxdW2QQAyju/5sTtvbV9Wku0JNIr01QJjLSc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KIDeuMHj6KZp76Ci5rK0cIRgsXoeGD+R4SziK6s4HwGoeWEIzLVw9dOCrg8QC5grZ
	 CK8R7RgI1CcvuT8gLEY1o/d0+w2uI5QWRXvUrtFfWtqenCXLYjlGnUhGA2oAg1QG4f
	 MDs7QS/mj+EEEkCQG04IFbpVpKVNhIwNgFhu2LmJHLFtd2wba7LhPBwdAsPYO/1VIl
	 0wO4XA3wo5XPaTFTzSPLAAUaNrIF/3rxHMN2mUJl66nyKynxtNp4BGF34L5kndVLwx
	 WkxlkeXyQkfebZplnOxkYp7WAYiQAhe+7DW4uPMBM96R/vhH46zyYSpcqLMSw8UQ8R
	 B059rIdfGaSAg==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 28 May 2026 15:32:13 -0400
Subject: [PATCH 6/6] SUNRPC: close backchannel before destroying callback
 service
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-tier2-v1-6-d026a1415e0b@oracle.com>
References: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
In-Reply-To: <20260528-tier2-v1-0-d026a1415e0b@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 Simo Sorce <simo@redhat.com>, Chuck Lever <chuck.lever@oracle.com>, 
 Chris Mason <clm@meta.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=5746;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=EDn9R6Xw0XZLF1vqhdOo7odD1jxtLBfkqRM59O1qaZ8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqGJhI10BLMzHbcnFnRKECZlAbdrOHRs4UspBCA
 nT+FrQE3GOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCahiYSAAKCRAzarMzb2Z/
 l1qED/0Yw5cWC7nSZeHHRW7Eag/JtWU0DRpDAB6fDEF93w0mjw/1aZ2qlpiQfaFBIu4GBcR7XUG
 +PWImVVmetOU/CoyE4jJlrY7Qft5VFhKyhPWhmAqWX2iJs5HbJ8WjJSLhzoVfmb56TkpHF/PlaD
 eh/aKIjL/tlAiOZGaWtV+sb6X9Bp9PSRB+ZhcJ9ELdiZRCUcqfeoOswkNzVQG1O/z9m2YXdEvDo
 ZTq9LSIPZMbxCdpjmBHpwIT3bDOyBA/HdRk+SwFRKvL74RFhA2Ekm4l29Pbs+NyWsqH4YF0aqyT
 NxpZo3e6dqie58EiV3f0X0MCrU3CtKon6iyKrNdJalBafklh8ITxA+/263pvbTBoglcnBcHNA9d
 nmNXHYr3fLqLOcCrU2mPOl/ex5EtkckQXXzfU/B+2O+qq8drSpxtGgKIVThEtp5pPYQDXo79KwA
 ePu+QbrgkEZR5U22YwNJ+nT0U36bcck6ZEUAcrexMI9VoPIggzmUtrwb8oIMddKj4JmSTW4Sf4B
 uHZwFLSu0ecqXDtD0AMxgZzHztr8ynDacnAQmKMb1jTIC1ORnUgQL4yturBbhJgEpa65a72R+Qf
 E8ls0pH7WsmuXCkdhZAiYzGVSwgjss5V1nqaU6JQSMRqkRrfOzsr5hkgdUMHOanUZFUItamnxjB
 w/6kexeE9NLXYHA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[linux-nfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22049-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+]
X-Rspamd-Queue-Id: 5575A5F7279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chuck Lever <chuck.lever@oracle.com>

A backchannel receive can complete a request while the NFS callback
service is being torn down.  xprt_complete_bc_request() removes the
request from bc_pa_list, drops bc_alloc_count, marks the request in use,
and then asks xprt_enqueue_bc_request() to hand it to the callback
service.

If teardown has already cleared xprt->bc_serv, xprt_enqueue_bc_request()
currently returns without enqueueing or freeing the committed request.
The xprt_get() taken on entry is leaked as well.  If the producer wins
the race before bc_serv is cleared, it can also enqueue onto sv_cb_list
after nfs_callback_down() has stopped the callback threads, leaving the
request linked to a svc_serv that is about to be freed.

Close the producer side before callback threads are stopped.  Add
xprt_svc_shutdown_bc() to clear xprt->bc_serv under bc_pa_lock, and call
it on callback shutdown and callback-start failure before stopping the
service threads.  Requests that lose the NULL transition in
xprt_enqueue_bc_request() are released through the normal backchannel
free path after balancing bc_slot_count.  Finally, drain any remaining
sv_cb_list requests after the callback threads have stopped and before
svc_destroy() frees the service.

Fixes: 441244d4273a ("SUNRPC: cleanup common code in backchannel request")
Fixes: 9e9fdd0ad0fb ("NFSv4.1: protect destroying and nullifying bc_serv structure")
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/callback.c              |  4 +++-
 include/linux/sunrpc/bc_xprt.h |  5 +++++
 net/sunrpc/backchannel_rqst.c  | 38 +++++++++++++++++++++++++++++++-------
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index ff4e9fd38e83..bc282b744f34 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -231,8 +231,9 @@ int nfs_callback_up(u32 minorversion, struct rpc_xprt *xprt)
 	cb_info->users++;
 err_net:
 	if (!cb_info->users) {
+		xprt_svc_shutdown_bc(xprt);
 		svc_set_num_threads(cb_info->serv, 0, 0);
-		svc_destroy(&cb_info->serv);
+		xprt_svc_destroy_nullify_bc(xprt, &cb_info->serv);
 	}
 err_create:
 	mutex_unlock(&nfs_callback_mutex);
@@ -254,6 +255,7 @@ void nfs_callback_down(int minorversion, struct net *net, struct rpc_xprt *xprt)
 
 	mutex_lock(&nfs_callback_mutex);
 	serv = cb_info->serv;
+	xprt_svc_shutdown_bc(xprt);
 	nfs_callback_down_net(minorversion, serv, net);
 	cb_info->users--;
 	if (cb_info->users == 0) {
diff --git a/include/linux/sunrpc/bc_xprt.h b/include/linux/sunrpc/bc_xprt.h
index 98939cb664cf..59d0cc889beb 100644
--- a/include/linux/sunrpc/bc_xprt.h
+++ b/include/linux/sunrpc/bc_xprt.h
@@ -32,6 +32,7 @@ int xprt_setup_bc(struct rpc_xprt *xprt, unsigned int min_reqs);
 void xprt_destroy_bc(struct rpc_xprt *xprt, unsigned int max_reqs);
 void xprt_free_bc_rqst(struct rpc_rqst *req);
 unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt);
+void xprt_svc_shutdown_bc(struct rpc_xprt *xprt);
 void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv);
 
 /*
@@ -71,6 +72,10 @@ static inline void xprt_free_bc_request(struct rpc_rqst *req)
 {
 }
 
+static inline void xprt_svc_shutdown_bc(struct rpc_xprt *xprt)
+{
+}
+
 static inline void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
 {
 	svc_destroy(serv);
diff --git a/net/sunrpc/backchannel_rqst.c b/net/sunrpc/backchannel_rqst.c
index 0ffa4d01a938..1482b06e0f38 100644
--- a/net/sunrpc/backchannel_rqst.c
+++ b/net/sunrpc/backchannel_rqst.c
@@ -25,20 +25,39 @@ unsigned int xprt_bc_max_slots(struct rpc_xprt *xprt)
 }
 
 /*
- * Helper function to nullify backchannel server pointer in transport.
- * We need to synchronize setting the pointer to NULL (done so after
- * the backchannel server is shutdown) with the usage of that pointer
- * by the backchannel request processing routines
- * xprt_complete_bc_request() and rpcrdma_bc_receive_call().
+ * Close the backchannel producer side, drain any requests still
+ * queued on sv_cb_list, then destroy the callback service.
  */
 void xprt_svc_destroy_nullify_bc(struct rpc_xprt *xprt, struct svc_serv **serv)
 {
-	spin_lock(&xprt->bc_pa_lock);
+	struct svc_serv *bc_serv = *serv;
+	struct rpc_rqst *req;
+
+	xprt_svc_shutdown_bc(xprt);
+	while ((req = lwq_dequeue(&bc_serv->sv_cb_list, struct rpc_rqst,
+				  rq_bc_list)) != NULL) {
+		atomic_dec(&req->rq_xprt->bc_slot_count);
+		xprt_free_bc_request(req);
+	}
 	svc_destroy(serv);
+}
+EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
+
+/*
+ * Clear the backchannel server pointer in the transport.  The NULL
+ * store is serialized under bc_pa_lock against readers of
+ * xprt->bc_serv in xprt_complete_bc_request() and
+ * rpcrdma_bc_receive_call().  Clearing it before the callback service
+ * is stopped prevents a producer from enqueueing onto a service that
+ * is being torn down.
+ */
+void xprt_svc_shutdown_bc(struct rpc_xprt *xprt)
+{
+	spin_lock(&xprt->bc_pa_lock);
 	xprt->bc_serv = NULL;
 	spin_unlock(&xprt->bc_pa_lock);
 }
-EXPORT_SYMBOL_GPL(xprt_svc_destroy_nullify_bc);
+EXPORT_SYMBOL_GPL(xprt_svc_shutdown_bc);
 
 /*
  * Helper routines that track the number of preallocation elements
@@ -393,7 +412,12 @@ void xprt_enqueue_bc_request(struct rpc_rqst *req)
 	if (bc_serv) {
 		lwq_enqueue(&req->rq_bc_list, &bc_serv->sv_cb_list);
 		svc_pool_wake_idle_thread(&bc_serv->sv_pools[0]);
+		spin_unlock(&xprt->bc_pa_lock);
+		return;
 	}
 	spin_unlock(&xprt->bc_pa_lock);
+
+	atomic_dec(&xprt->bc_slot_count);
+	xprt_free_bc_request(req);
 }
 EXPORT_SYMBOL_GPL(xprt_enqueue_bc_request);

-- 
2.54.0


