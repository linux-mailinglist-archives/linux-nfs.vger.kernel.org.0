Return-Path: <linux-nfs+bounces-10211-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03D8A3E174
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD34D7030CA
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Feb 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057B213E6D;
	Thu, 20 Feb 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jr9g/zM0"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767BD213E66;
	Thu, 20 Feb 2025 16:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070049; cv=none; b=Z9wMPE8C9yPQ0Dm3JGrKwWMnlxwwQ9MEjsXlTpQsE0cbr8dTjxizR67n4ElHO1xn5zAykXmNF4GAHxEPl7HNuEakKKA0QAkScSKFSK1bz89sZwn/BGPaXkd8Pcs42HkmZ1LklYzdwZdappL9YeXQ7okDLbF21whk2SAoCBY0MQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070049; c=relaxed/simple;
	bh=cM51zXKQgB7chVb7HCS+hb5p+nJh2B05fSYFZWc6QqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RBPO1ybkULX9KvfjcTRjXNN8n/YSn2cczQPNt8fGfeYRwtgWE+jiSAEABtQdcIsw+s8Wbvk6P6endR+iDkqBKDOMkDt2g05Y9BoP2aOzifpkKRdPyBj8pDZ02WnKb7lmiag6k1MS+r2SS2FRr5o086geok0MQrVmUnaHforwHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jr9g/zM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB9EC4CEDD;
	Thu, 20 Feb 2025 16:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070048;
	bh=cM51zXKQgB7chVb7HCS+hb5p+nJh2B05fSYFZWc6QqA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jr9g/zM0r5mTY0Wmbw4q7Rc92zwe+qqD8Vmi/QJ4ZBqtYtx28tgqtIPJjR9bwrIDV
	 sXAYsfslIu+Pt8zskVDGAsYseQVDJ1C5dVX55jME9bwNXXWBFfze/cC7nGejbx1tvL
	 2hNgunvZFe80OhUzt1G2JVmcaN1ba2toS8OE0N2J19mOrDMzoL+avlt2Xq/WDGopZ+
	 l7HfKNpm6NJZmTTtG6+dVyBVPfEzWTt2BrIDgGVHLn7kv7SNdqzB3ieXsvFdeuVP8M
	 sTEf3tA5uPn4oKobLvD/l9gRpgIpTofdIB1ZNyt0/HDXJQy+/yn2A7BOnQCv4k8IZw
	 DPx6jrRONVayg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 20 Feb 2025 11:47:13 -0500
Subject: [PATCH v2 1/5] nfsd: prevent callback tasks running concurrently
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-nfsd-callback-v2-1-6a57f46e1c3a@kernel.org>
References: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
In-Reply-To: <20250220-nfsd-callback-v2-0-6a57f46e1c3a@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6190; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=cM51zXKQgB7chVb7HCS+hb5p+nJh2B05fSYFZWc6QqA=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBnt1yetRj0At3wEXKZLmmVcWst+WHAgQSRfg5o8
 AR6RO/tNcuJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7dcngAKCRAADmhBGVaC
 FZqoEACRp1d+ELs8oaCUJgU7jqBtu6TQoZdOe/Rd3/aW8EdGN3Iv5TQfIjJ8dFfUxyUKNjgqINf
 IpjJ7P+fPMt1ENWd08OHcUUXG+URVHaEdqgDIuJvANmiiuzXyCG2vhmT112ZF0lXwHAUB79ad+t
 j0XoMqv3Ze0vL4rpImvo3kvDBi5sqRnRCpXVywZg+v9Qal2h0f72KntvN0D0/SEsIthM5Pc/4ST
 lk3UNKpIVAmv0F13Sa/zVI/h7xJo46SXa61EsbMxj0I3YyoyCGqW9atxIG0jJ/PMQx11S4S9qMs
 4XBrSEiBbKj7CjygYGw9yLmV55pWILKc0a6zgbj4EqJuK0TYjYB9fMqOMHRD7re8ii66dfkQawT
 NeeIs2TCHzhLjQW1bSmLZ7QVjMaZeAdwuGyinNMDxmLTsraqICScNliJ+BK4Pz+Qb+Dn4IISt/l
 ReRVzCU1y4Z2rrXZXbbnjTEur17okuKCv0H5By0K+mBDGVwR7V3tdfsVFJemp74m3NoWfODUzNA
 qdxLb0CjFAWE5Eo8yRGYQ/Jj3wHiZrKb+Q7I0epItmw8iJDd7RRvDzxykt7DNJqABqsnzd5N3lg
 3cOynuq0JxHrj7arX1Vygtw7hg0N8Bc9FhSzxwkf0RcdRpZyxqpdhScBGmeNUa3B6PxGZKeCYed
 zTGw4IGMuXfV4BA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

The nfsd4_callback workqueue jobs exist to queue backchannel RPCs to
rpciod. Because they run in different workqueue contexts, the rpc_task
can run concurrently with the workqueue job itself, should it become
requeued. This is problematic as there is no locking when accessing the
fields in the nfsd4_callback.

Add a new unsigned long to nfsd4_callback and declare a new
NFSD4_CALLBACK_RUNNING flag to be set in it. When attempting to run a
workqueue job, do a test_and_set_bit() on that flag first, and don't
queue the workqueue job if it returns true. Clear NFSD4_CALLBACK_RUNNING
in nfsd41_destroy_cb().

This also gives us a more reliable mechanism for handling queueing
failures in codepaths where we have to take references under spinlocks.
We can now do the test_and_set_bit on NFSD4_CALLBACK_RUNNING first, and
only take references to the objects if that returns false.

Most of the nfsd4_run_cb() callers are converted to use this new flag or
the nfsd4_try_run_cb() wrapper. The main exception is the callback
channel probe, which has its own synchronization.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4callback.c |  2 ++
 fs/nfsd/nfs4layouts.c  |  7 ++++---
 fs/nfsd/nfs4proc.c     |  2 +-
 fs/nfsd/nfs4state.c    | 14 ++++++++++----
 fs/nfsd/state.h        |  9 +++++++++
 5 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ae4b7b6df47ff054db197bd2f6083905e4149bee..1f26c811e5f73c2e745ee68d0b6e668d1dd7c704 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1312,6 +1312,7 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 
 	trace_nfsd_cb_destroy(clp, cb);
 	nfsd41_cb_release_slot(cb);
+	clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
@@ -1632,6 +1633,7 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 	cb->cb_msg.rpc_proc = &nfs4_cb_procedures[op];
 	cb->cb_msg.rpc_argp = cb;
 	cb->cb_msg.rpc_resp = cb;
+	cb->cb_flags = 0;
 	cb->cb_ops = ops;
 	INIT_WORK(&cb->cb_work, nfsd4_run_cb_work);
 	cb->cb_status = 0;
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index fbfddd3c4c943c34aa3991328eacb5759e311cc4..290271ac424540e4405a5fd0eacc8db9f47603cd 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -344,9 +344,10 @@ nfsd4_recall_file_layout(struct nfs4_layout_stateid *ls)
 	atomic_inc(&ls->ls_stid.sc_file->fi_lo_recalls);
 	trace_nfsd_layout_recall(&ls->ls_stid.sc_stateid);
 
-	refcount_inc(&ls->ls_stid.sc_count);
-	nfsd4_run_cb(&ls->ls_recall);
-
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ls->ls_recall.cb_flags)) {
+		refcount_inc(&ls->ls_stid.sc_count);
+		nfsd4_run_cb(&ls->ls_recall);
+	}
 out_unlock:
 	spin_unlock(&ls->ls_lock);
 }
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index f6e06c779d09dacdcea81fb3b4135bf600f6cc63..b397246dae7b7e8c2a0ba436bb3813213cfe4fa2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1847,7 +1847,7 @@ static void nfsd4_send_cb_offload(struct nfsd4_copy *copy)
 		      NFSPROC4_CLNT_CB_OFFLOAD);
 	trace_nfsd_cb_offload(copy->cp_clp, &cbo->co_res.cb_stateid,
 			      &cbo->co_fh, copy->cp_count, copy->nfserr);
-	nfsd4_run_cb(&cbo->co_cb);
+	nfsd4_try_run_cb(&cbo->co_cb);
 }
 
 /**
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e806fd97cca972559d1929d37c1a24e760d9d6d8..fabcd979c40695ebcc795cfd2d8a035b7d589a37 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3232,8 +3232,10 @@ static void nfs4_cb_getattr(struct nfs4_cb_fattr *ncf)
 	/* set to proper status when nfsd4_cb_getattr_done runs */
 	ncf->ncf_cb_status = NFS4ERR_IO;
 
-	refcount_inc(&dp->dl_stid.sc_count);
-	nfsd4_run_cb(&ncf->ncf_getattr);
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncf->ncf_getattr.cb_flags)) {
+		refcount_inc(&dp->dl_stid.sc_count);
+		nfsd4_run_cb(&ncf->ncf_getattr);
+	}
 }
 
 static struct nfs4_client *create_client(struct xdr_netobj name,
@@ -5422,6 +5424,10 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
 {
 	bool queued;
+
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags))
+		return;
+
 	/*
 	 * We're assuming the state code never drops its reference
 	 * without first removing the lease.  Since we're in this lease
@@ -6910,7 +6916,7 @@ deleg_reaper(struct nfsd_net *nn)
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-		nfsd4_run_cb(&clp->cl_ra->ra_cb);
+		nfsd4_try_run_cb(&clp->cl_ra->ra_cb);
 	}
 }
 
@@ -7839,7 +7845,7 @@ nfsd4_lm_notify(struct file_lock *fl)
 
 	if (queue) {
 		trace_nfsd_cb_notify_lock(lo, nbl);
-		nfsd4_run_cb(&nbl->nbl_cb);
+		nfsd4_try_run_cb(&nbl->nbl_cb);
 	}
 }
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 74d2d7b42676d907bec9159b927aeed223d668c3..e6af969a03f26b1feb6768af5baa4887bf5fa5e9 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -67,6 +67,8 @@ typedef struct {
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
+#define NFSD4_CALLBACK_RUNNING	BIT(0)	// Callback is running
+	unsigned long cb_flags;
 	const struct nfsd4_callback_ops *cb_ops;
 	struct work_struct cb_work;
 	int cb_seq_status;
@@ -780,6 +782,13 @@ extern void nfsd4_change_callback(struct nfs4_client *clp, struct nfs4_cb_conn *
 extern void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 		const struct nfsd4_callback_ops *ops, enum nfsd4_cb_op op);
 extern bool nfsd4_run_cb(struct nfsd4_callback *cb);
+
+static inline void nfsd4_try_run_cb(struct nfsd4_callback *cb)
+{
+	if (!test_and_set_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags))
+		WARN_ON_ONCE(!nfsd4_run_cb(cb));
+}
+
 extern void nfsd4_shutdown_callback(struct nfs4_client *);
 extern void nfsd4_shutdown_copy(struct nfs4_client *clp);
 void nfsd4_async_copy_reaper(struct nfsd_net *nn);

-- 
2.48.1


