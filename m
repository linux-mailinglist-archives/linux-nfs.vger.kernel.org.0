Return-Path: <linux-nfs+bounces-17812-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B0D1ADCF
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 19:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 942413056547
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 18:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D7A34F27F;
	Tue, 13 Jan 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFgt7F87"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450034F244;
	Tue, 13 Jan 2026 18:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768329471; cv=none; b=dpm8YdtR+my5//Rd0EP7Bnjoa+FeJCx6rMOlqw/0r+yexYCV8rzn05cavGyOhhNAnxwexDV2UvCITnT2g8Jwf8gCH2a/MZ9wMVofcVK/Z6awUlwAQWz/70qiz+fOfckkbtE0u6kv9jYlbndSvr/28CZLiqlVflLY7xwLEibywgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768329471; c=relaxed/simple;
	bh=ceY4Hl7QOvn87D3m3WbtQvOB4ywUgRMbZQ9ZzJ2YjwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TofLvaCJAb64GSAsE98z8uMv5fAZNRVLgGVzyLMa0FHmePIxYdc53UvNdUedAgKXUqthPpaqgeEOb36IWXM2geSnyVp4qba7YqSqTARrs+zq+xStSHeroqtVQ5g6Q64U+2+Z166GOINWDGFl0cj7vp3+Is0XQQ9F3r14Evcxehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFgt7F87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FFAC19422;
	Tue, 13 Jan 2026 18:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768329471;
	bh=ceY4Hl7QOvn87D3m3WbtQvOB4ywUgRMbZQ9ZzJ2YjwU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kFgt7F87A6tkzO39egAFh1KPqsisEt7DwBZ5qe3+mW0ds9BJEz60p3BpNYtcQs3y2
	 /iJzoTN6F1047M4iUw7AdQw6ur1WVxgaCatt68UO81zaI1KNdooyIFg7pRp5sdtzl9
	 Zt8zZRRTUgYqBLRBx3DaPM41G6PVOaOD5OSWtyj+qzZCYeBbBRjZAVbnUgBCqPyHNr
	 RUARuTlJxr9M1uDr6SujbyahDrT6QY3s1VbOj8K3pTCnzBTaux+Nw0XCGnYylXnZD5
	 igaSEklSuR6HUd2p1lNXAWoGmmc4VL89gy7hQFyElj4Pf62rm4jDTMnl3wML7JRIVY
	 1npVY+vxrhyLg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 13 Jan 2026 13:37:39 -0500
Subject: [PATCH 1/2] nfsd/sunrpc: add svc_rqst->rq_private pointer and
 remove rq_lease_breaker
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-rq_private-v1-1-88ed308364e6@kernel.org>
References: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
In-Reply-To: <20260113-rq_private-v1-0-88ed308364e6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Ben Coddington <bcodding@hammerspace.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5650; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ceY4Hl7QOvn87D3m3WbtQvOB4ywUgRMbZQ9ZzJ2YjwU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZpD8Y1MWqHC/k0e08gg0r9DWubqQtpyXMufUP
 Me3WHNv6DeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWaQ/AAKCRAADmhBGVaC
 FUjmD/0Ud83VQeI9dz1vZL2TN1IQshS62ymvCfkil9yxqpaqE9kFytX0dR3hM+f48OqjD8rsjmO
 yGjddq93DEkawqqCfk7Da0jYyh1HrMKAti1/ZtDTHXO1SjKw5nNlagEewv2DGMFJdhevAdTgwmB
 N30/We5v/TlPzfetRF+u6w00UHaORytrH/MG2REUJLYyUCauaJclbSUoKb+MTWlLsEE37HyQRx0
 K55J0aS3KxD/NRyciEnsa2dw//aYEMYdNDVz3yM+GGRXZ+KB7JI+bBvYL6plz90QdA7ycBu9z+s
 ZDPYucLmGfv7yNgJuElJ6LYnzwDaEegyPiL0zG6tBoD2J2Ji2C1B/CSYxZU888O8QYk6MXjQ2tH
 xkgOSqjEFCJJyfoZlCawliRffyAaEfgI4CoyxhwSOLJy936T0IS7cdcldoLRZVqw/2gJsdNxCig
 XE0KEmcvUDXuc13liDvCn4616bQ8HfjD0LX9LuHrJla9A83Xo5O+VSdNxixNCi8e6V4PFot18KW
 TnvZTcX5NRyQaTH4KbokPnt3eIuohDlm3Lphd4S0NAOO94Wv8RHe/LpMRFnumpn6hErjHW2R5Bl
 jmXQs0ZL0FbfPJ2d9Bf5tuldNplt/qBDPm0CRrsgpe/DXF+lys9gnviE0WrlPGq2NCCapY7ORnZ
 rDAWwEBdKOvOvFQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

rq_lease_breaker has always been a NFSv4 specific layering violation in
svc_rqst. The reason it's there though is that we need a place that is
thread-local, and accessible from the svc_rqst pointer.

Add a new rq_private pointer to struct svc_rqst. This is intended for
use by the threads that are handling the service. sunrpc code doesn't
touch it.

In nfsd, define a new struct nfsd_thread_local_info. nfsd declares one
of these on the stack and puts a pointer to it in rq_private.

Add a new ntli_lease_breaker field to the new struct and convert all of
the places that access rq_lease_breaker to use the new field instead.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c         | 3 ++-
 fs/nfsd/nfs4state.c        | 9 ++++++---
 fs/nfsd/nfsd.h             | 4 ++++
 fs/nfsd/nfssvc.c           | 3 +++
 include/linux/sunrpc/svc.h | 5 ++++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index d476d108f6e107ad5310e4ea504daabd750cf450..5c30ea99daad2825ba62fefc456a6d2cc41b6063 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -3038,6 +3038,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	struct svc_fh *current_fh = &cstate->current_fh;
 	struct svc_fh *save_fh = &cstate->save_fh;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
 	__be32		status;
 
 	resp->xdr = &rqstp->rq_res_stream;
@@ -3076,7 +3077,7 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
 	}
 	check_if_stalefh_allowed(args);
 
-	rqstp->rq_lease_breaker = (void **)&cstate->clp;
+	ntli->ntli_lease_breaker = &cstate->clp;
 
 	trace_nfsd_compound(rqstp, args->tag, args->taglen, args->client_opcnt);
 	while (!status && resp->opcnt < args->opcnt) {
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index af2b307ac78cf3733a173f9024aced87fe94603f..583c13b5aaf3cd12a87c7aae62fe6a8223368f55 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -5542,13 +5542,15 @@ nfsd_break_deleg_cb(struct file_lease *fl)
 static bool nfsd_breaker_owns_lease(struct file_lease *fl)
 {
 	struct nfs4_delegation *dl = fl->c.flc_owner;
+	struct nfsd_thread_local_info *ntli;
 	struct svc_rqst *rqst;
 	struct nfs4_client *clp;
 
 	rqst = nfsd_current_rqst();
 	if (!nfsd_v4client(rqst))
 		return false;
-	clp = *(rqst->rq_lease_breaker);
+	ntli = rqst->rq_private;
+	clp = *ntli->ntli_lease_breaker;
 	return dl->dl_stid.sc_client == clp;
 }
 
@@ -9360,13 +9362,14 @@ __be32
 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 			     struct nfs4_delegation **pdp)
 {
-	__be32 status;
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
+	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
 	struct file_lease *fl;
 	struct nfs4_cb_fattr *ncf;
 	struct inode *inode = d_inode(dentry);
+	__be32 status;
 
 	ctx = locks_inode_context(inode);
 	if (!ctx)
@@ -9387,7 +9390,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		break;
 	}
 	if (dp == NULL || dp == NON_NFSD_LEASE ||
-	    dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
+	    dp->dl_recall.cb_clp == *(ntli->ntli_lease_breaker)) {
 		spin_unlock(&ctx->flc_lock);
 		if (dp == NON_NFSD_LEASE) {
 			status = nfserrno(nfsd_open_break_lease(inode,
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index a01d709533585f09df1399b85eecc36ea7c466c5..938906c6d10cd65e7e3a1bc889b4fdcb56918f6f 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -82,6 +82,10 @@ extern atomic_t			nfsd_th_cnt;		/* number of available threads */
 
 extern const struct seq_operations nfs_exports_op;
 
+struct nfsd_thread_local_info {
+	struct nfs4_client	**ntli_lease_breaker;
+};
+
 /*
  * Common void argument and result helpers
  */
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index eee8c3f4a251a3fae6e41679de0ec34c76caf198..8ce366c9e49220e8baf475c2e5f3424fedc1cec1 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -900,6 +900,7 @@ nfsd(void *vrqstp)
 	struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
 	struct net *net = perm_sock->xpt_net;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct nfsd_thread_local_info ntli = { };
 	bool have_mutex = false;
 
 	/* At this point, the thread shares current->fs
@@ -914,6 +915,8 @@ nfsd(void *vrqstp)
 
 	set_freezable();
 
+	rqstp->rq_private = &ntli;
+
 	/*
 	 * The main request loop
 	 */
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4dc14c7a711b010473bf03fc401df0e66d9aa4bd..ab8237ba9596e9f31e2c42abedec435a23162b40 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -175,6 +175,9 @@ static inline unsigned long svc_serv_maxpages(const struct svc_serv *serv)
 /*
  * The context of a single thread, including the request currently being
  * processed.
+ *
+ * RPC programs are free to use rq_private to stash thread-local information.
+ * The sunrpc layer will not access it.
  */
 struct svc_rqst {
 	struct list_head	rq_all;		/* all threads list */
@@ -251,7 +254,7 @@ struct svc_rqst {
 	unsigned long		bc_to_initval;
 	unsigned int		bc_to_retries;
 	unsigned int		rq_status_counter; /* RPC processing counter */
-	void			**rq_lease_breaker; /* The v4 client breaking a lease */
+	void			*rq_private;	/* For use by the service thread */
 };
 
 /* bits for rq_flags */

-- 
2.52.0


