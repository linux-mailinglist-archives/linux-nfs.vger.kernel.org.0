Return-Path: <linux-nfs+bounces-10184-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AFFA3AAD9
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 22:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631E97A46BA
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Feb 2025 21:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CF91D47B5;
	Tue, 18 Feb 2025 21:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6+jnler"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA011CF5E2;
	Tue, 18 Feb 2025 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914151; cv=none; b=ZRKH8Y2aN6FRxSzPLlrFvP4+nP5OONEeaFABjkq3O5VGJDUa4O2hp4/gcAh7dQbfSEj3ScFyKO+RdWTSzJzQkf0yAatdbu7lgImgCSbnPBzzg82qqsdGRx+6UVfsY+p88Dx/JNXTyrDvvKqWRScx8DMbazr67CxA8kzWDDpc8Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914151; c=relaxed/simple;
	bh=y6FpShoTcyq9TvI+wxI5f9fccNQwoEQ08LRQ2tXtJpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F4M3d6TzP9o4OH+b6jKNvFwaCqNmJypKgOgzAXCzLFo+YxLO+QW7RUTcOtXxQE6qh7ErwG3xlaGHOFyfL0sZ2D/tGgfFljZE6jjTuDmuQyd7/CI3dY1p+fa2EnFR7bTZUxK3NRNgQSXeRukoOlONVGWmjWo18rLdnxqsDX9Aq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6+jnler; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EA5C4CEE9;
	Tue, 18 Feb 2025 21:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914149;
	bh=y6FpShoTcyq9TvI+wxI5f9fccNQwoEQ08LRQ2tXtJpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z6+jnler8xg+LCEkk0dCVT1PwRDkNwcV/ypBEkQxFOrpzG9GEWbpFuQeYlCD0WbYQ
	 yHpnz7Ljp8XKLHdt+eWzNnkrvyVQ1a0IqmR7ck7wcgzNOSyNpZCA2K0rpOKQe6cLFD
	 IJqTpx4BjOowwjiNg7WLUSICKUa6mDobfJpak1GFU4L8LvcgC3PU27P9CTY/SnP2Po
	 y/y5S4J9ZYlIMcZStvH41mVNeljoBO4lrISSpm+qO+xSl/fkIcPnO4qZhMrNbAjFB9
	 jRsaNSot30wn2SRc+oziAkRW8RsWqaKyitjdzl3kRqg5qn+oLX3Ovy37xS1YNSFOLf
	 BJNCj4UNu7GJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 18 Feb 2025 16:28:57 -0500
Subject: [PATCH 1/3] nfsd: prevent callback tasks running concurrently
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-nfsd-callback-v1-1-14f966967dd8@kernel.org>
References: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
In-Reply-To: <20250218-nfsd-callback-v1-0-14f966967dd8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Li Lingfeng <lilingfeng3@huawei.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6167; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=y6FpShoTcyq9TvI+wxI5f9fccNQwoEQ08LRQ2tXtJpI=;
 b=owEBbAKT/ZANAwAIAQAOaEEZVoIVAcsmYgBntPujHfuf7swQb87Vkt4Cr48VnZwcWLD2Sjsn3
 QNX8kINcaeJAjIEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ7T7owAKCRAADmhBGVaC
 FQfqD/dncMBobXt2LANC/IOufL8hlasSmBHlXVlI2/ZYXLdb+uEiyX13ZQrqe+ktu/+tH1OXzxr
 cY7chEgIghQm+GdPkCNJSnJMVBjqpW7TRFsV7gDnU9nNMM/E40FR/i/vb9AL+I4Wrdv69/lpLa3
 zb0RxKL2AYMDruuKP0EIWRhfQ2ghiQzYbu6+wQXQUtOsuSvofVdQbwkcXFLmLyahTH2aou2GZxf
 y0RqmmJPiR5elFTmpL8aRgMlddrZZ6zNtGYrg+OjPEoNMe7deCMXX2MzULLV/wuqO1fhoQ9THVh
 Cb6fbYG74ddndMqRvfSPPvCMOs1VzFCf6evSdAQhU7IPloqo+/i6kurEanvmGsrdm8IIaeSZCzD
 5vnapZLdEcChyx4f/6Jar2wUmfG+HW1GRFSt7idUF3XosZy+hfldnV8Y/+BVKG13s6gK6j+Nx7Q
 IP+ssZK7FMbLTmdr13NuW7WdB9l9E7v2zmMcn+/WnRsWJPKCzpajgyjZNw2ZBTdkwELMwVGkC4C
 Ow+SNCu12QKeLUSzCBGym0gj/G+A9WlpiS+KS5rntNskFln/xDNNK/AkkPa9l3k/CNF5TCLUF7U
 0OIQzv3H0s1z45um+i9Zafg5cKmxl+lha+ZiPmw7q8j0AgXQugDiRLlm4R5zXd0pBpJhV1Rd4NE
 O615Rh0TbMYSH
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
index 74d2d7b42676d907bec9159b927aeed223d668c3..dc7105e685b8057ca4e2fcc5ceb85754e96981a2 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -67,6 +67,8 @@ typedef struct {
 struct nfsd4_callback {
 	struct nfs4_client *cb_clp;
 	struct rpc_message cb_msg;
+#define NFSD4_CALLBACK_RUNNING	BIT(0)
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


