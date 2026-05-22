Return-Path: <linux-nfs+bounces-21791-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id II6+JNVNEGq5VwYAu9opvQ
	(envelope-from <linux-nfs+bounces-21791-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:36:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFCC5B42F0
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 14:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11FB4302C8E1
	for <lists+linux-nfs@lfdr.de>; Fri, 22 May 2026 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1953A1688;
	Fri, 22 May 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+FUHKKt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69E739F183;
	Fri, 22 May 2026 12:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779452969; cv=none; b=e83MgwEhj0mw5XJmFx1PE8RJsJyqa4hZGwgCDWmrBXVPUkNj68q0et+BLn3ptYewcnlbRO0F+SfkMOzWnriiAcJfPZZyqKpGSiSHyqmAgXDUjeGcaL7EFHJ/eivD+iCMSn7J3NvxwUbknw0p2Wi3r5SfMPM6iyo7jMo+PaAyka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779452969; c=relaxed/simple;
	bh=Uu4tDkKoytdRq57XY7pijXjWvigWHLAZI1AxVhlmhRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHNg1hjaZUMJjIkYPOrQ4aA7BsKHtyrjW38ji7Vm5wravIIFdJR88QlkFDWpqYVFTkjOMpKRW4V0GzSP6j4GxC865uf4NQVPjHJsyCUNgB5JT2/3nQegbBF96SgiFOQhUObWh/fpUjVI7mQB/mZzQ+wefn6cjvvPSH5nVkZQrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+FUHKKt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15C71F000E9;
	Fri, 22 May 2026 12:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779452966;
	bh=hkizLCm3QMsM0IeJ8aY/PsvxeOtNLlUq74YGgXZ0zxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I+FUHKKtzwNsFfAveq+ddqQt9VCnQTfONq4qEGbAE8rVcEGklJ2PD5XI2eJr+sUx0
	 va8RuTGOEWGoM8wYOzBWbsZPD4jK0/fj7I129FKOFH5lll/QxL0hRmO/DpUxuKYXsI
	 nIjDVHATH2YBYOA817MBEKKXJjPfvpu+JSnPwxN+ItoXJVa9bfTtojFG5BKt4oqiKA
	 mv7BD+BIg41JRkbKxTtsb8RicKwpT4A6p6Q2VijGiBAuUwqRw6HsdRwd8GcqrlMoPs
	 dCMKjnYsSRfe/xsnqdzIbVomd/Q82ZAef3LIgmyDi/1LZlcidjhjaN8s7NeICNwRXN
	 Nm6sUD0u3BdhA==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 22 May 2026 08:28:59 -0400
Subject: [PATCH v4 10/21] nfsd: add notification handlers for dir events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-dir-deleg-v4-10-2acb883ac6bc@kernel.org>
References: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
In-Reply-To: <20260522-dir-deleg-v4-0-2acb883ac6bc@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: Alexander Aring <alex.aring@gmail.com>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=23201; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Uu4tDkKoytdRq57XY7pijXjWvigWHLAZI1AxVhlmhRs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqEEwPeBLRicHcM4m2E0x9hhBMD4WOzsUsvXWht
 423jEstoGSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahBMDwAKCRAADmhBGVaC
 FRxoD/9fDO0n+8uiHxg6Sf1anwYjHCCbdwitISwAatRJ1P4niNGPR5L6o/defzOfFUiSVbA/SRd
 65eY18uEbJLfilpxn9CAnchputR8QHYuO2xvt8E3td3gUygPl+35tVB7/4WrI2Ek42omPXxveW8
 GdUGHlDaJZYeBxZ3z3w8DmzdlxVqjLim2YZccetOe5cX9F1gTmj8iA5VbOOf9AA4NxvkYWzTVgP
 HOgjfxPLiSNCRjvSPZQWJ598zmL6u9OrdGEFt4rDLkst0wmjmQ/0bt1vY20jaiPHihAHveGF/cT
 bN/VMRB/4i3sXmHhh0CL3LjLhVOnEaEODX77FEwcHSEvQ5wI70/5H5lGvLV4hUnSQtT1B7y99Fa
 menA52GlK+YJuD63b2T7AInBqmfJkS77zZd9o+BECYr0WZ4jIJrFDPI0NWDNF3puzo/DFkLCvDv
 4PXaM+oge/EUBZNHCCfwuvys4Vtp96s3dh1/Pygk5PK8AXioy4A6tFqk4kbrZSyQ7UC3EKBbZGC
 9AFhVxBkrzsck6gdUPMmtdddtZpPJLkHYyJ/5GnGaW4oKw9jZkJg2IIQpnnLivX7y9myIVWmuRk
 DBpmPTCq8TDfV0c0esVRL4/eUP/5J59oy4U2FJflztEFUfqvwvXKiGlMpdcC3mC69w0ndYX5La+
 02LV6XWXui/yWBQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21791-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cna_fh.data:url]
X-Rspamd-Queue-Id: 7AFCC5B42F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add the necessary parts to accept a fsnotify callback for directory
change event and create a CB_NOTIFY request for it. When a dir nfsd_file
is created set a handle_event callback to handle the notification.

Use that to allocate a nfsd_notify_event object and then hand off a
reference to each delegation's CB_NOTIFY. If anything fails along the
way, recall any affected delegations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c    |  70 ++++++++++---
 fs/nfsd/nfs4callback.c |  19 +++-
 fs/nfsd/nfs4state.c    | 268 +++++++++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfs4xdr.c      | 121 ++++++++++++++++++++++
 fs/nfsd/state.h        |   4 +
 fs/nfsd/xdr4.h         |   3 +
 6 files changed, 443 insertions(+), 42 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 24511c3208db..be8f6d8a3ba0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -72,6 +72,7 @@ static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
+static struct fsnotify_group		*nfsd_dir_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
@@ -147,7 +148,7 @@ static void
 nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 {
 	if (refcount_dec_and_test(&nfm->nfm_ref)) {
-		fsnotify_destroy_mark(&nfm->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_destroy_mark(&nfm->nfm_mark, nfm->nfm_mark.group);
 		fsnotify_put_mark(&nfm->nfm_mark);
 	}
 }
@@ -155,35 +156,37 @@ nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 static struct nfsd_file_mark *
 nfsd_file_mark_find_or_create(struct inode *inode)
 {
-	int			err;
-	struct fsnotify_mark	*mark;
 	struct nfsd_file_mark	*nfm = NULL, *new;
+	struct fsnotify_group	*group;
+	struct fsnotify_mark	*mark;
+	int			err;
+
+	group = S_ISDIR(inode->i_mode) ? nfsd_dir_fsnotify_group : nfsd_file_fsnotify_group;
 
 	do {
-		fsnotify_group_lock(nfsd_file_fsnotify_group);
-		mark = fsnotify_find_inode_mark(inode,
-						nfsd_file_fsnotify_group);
+		fsnotify_group_lock(group);
+		mark = fsnotify_find_inode_mark(inode, group);
 		if (mark) {
 			nfm = nfsd_file_mark_get(container_of(mark,
 						 struct nfsd_file_mark,
 						 nfm_mark));
-			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+			fsnotify_group_unlock(group);
 			if (nfm) {
 				fsnotify_put_mark(mark);
 				break;
 			}
 			/* Avoid soft lockup race with nfsd_file_mark_put() */
-			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
+			fsnotify_destroy_mark(mark, group);
 			fsnotify_put_mark(mark);
 		} else {
-			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+			fsnotify_group_unlock(group);
 		}
 
 		/* allocate a new nfm */
 		new = kmem_cache_alloc(nfsd_file_mark_slab, GFP_KERNEL);
 		if (!new)
 			return NULL;
-		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_init_mark(&new->nfm_mark, group);
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
 		refcount_set(&new->nfm_ref, 1);
 
@@ -812,12 +815,36 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 	return 0;
 }
 
+#ifdef CONFIG_NFSD_V4
+static int
+nfsd_dir_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
+			       const void *data, int data_type, struct inode *dir,
+			       const struct qstr *name, u32 cookie,
+			       struct fsnotify_iter_info *iter_info)
+{
+	return nfsd_handle_dir_event(mask, dir, data, data_type, name);
+}
+#else
+static int
+nfsd_dir_fsnotify_handle_event(struct fsnotify_group *group, u32 mask,
+			       const void *data, int data_type, struct inode *dir,
+			       const struct qstr *name, u32 cookie,
+			       struct fsnotify_iter_info *iter_info)
+{
+	return 0;
+}
+#endif
 
 static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
 	.handle_inode_event = nfsd_file_fsnotify_handle_event,
 	.free_mark = nfsd_file_mark_free,
 };
 
+static const struct fsnotify_ops nfsd_dir_fsnotify_ops = {
+	.handle_event = nfsd_dir_fsnotify_handle_event,
+	.free_mark = nfsd_file_mark_free,
+};
+
 int
 nfsd_file_cache_init(void)
 {
@@ -869,8 +896,7 @@ nfsd_file_cache_init(void)
 		goto out_shrinker;
 	}
 
-	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							0);
+	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops, 0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
@@ -879,11 +905,23 @@ nfsd_file_cache_init(void)
 		goto out_notifier;
 	}
 
+	nfsd_dir_fsnotify_group = fsnotify_alloc_group(&nfsd_dir_fsnotify_ops, 0);
+	if (IS_ERR(nfsd_dir_fsnotify_group)) {
+		pr_err("nfsd: unable to create fsnotify group: %ld\n",
+			PTR_ERR(nfsd_dir_fsnotify_group));
+		ret = PTR_ERR(nfsd_dir_fsnotify_group);
+		nfsd_dir_fsnotify_group = NULL;
+		goto out_notify_group;
+	}
+
 	INIT_DELAYED_WORK(&nfsd_filecache_laundrette, nfsd_file_gc_worker);
 out:
 	if (ret)
 		clear_bit(NFSD_FILE_CACHE_UP, &nfsd_file_flags);
 	return ret;
+out_notify_group:
+	fsnotify_put_group(nfsd_file_fsnotify_group);
+	nfsd_file_fsnotify_group = NULL;
 out_notifier:
 	lease_unregister_notifier(&nfsd_file_lease_notifier);
 out_shrinker:
@@ -1019,6 +1057,8 @@ nfsd_file_cache_shutdown(void)
 	rcu_barrier();
 	fsnotify_put_group(nfsd_file_fsnotify_group);
 	nfsd_file_fsnotify_group = NULL;
+	fsnotify_put_group(nfsd_dir_fsnotify_group);
+	nfsd_dir_fsnotify_group = NULL;
 	kmem_cache_destroy(nfsd_file_slab);
 	nfsd_file_slab = NULL;
 	fsnotify_wait_marks_destroyed();
@@ -1223,10 +1263,8 @@ nfsd_file_do_acquire(struct svc_rqst *rqstp, struct net *net,
 open_file:
 	trace_nfsd_file_alloc(nf);
 
-	if (type == S_IFREG)
-		nf->nf_mark = nfsd_file_mark_find_or_create(inode);
-
-	if (type != S_IFREG || nf->nf_mark) {
+	nf->nf_mark = nfsd_file_mark_find_or_create(inode);
+	if (nf->nf_mark) {
 		if (file) {
 			get_file(file);
 			nf->nf_file = file;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index ea3e7deb06fa..1964a213f80e 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -870,21 +870,30 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
 				   const void *data)
 {
 	const struct nfsd4_callback *cb = data;
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 	struct nfs4_cb_compound_hdr hdr = {
 		.ident = 0,
 		.minorversion = cb->cb_clp->cl_minorversion,
 	};
-	struct CB_NOTIFY4args args = { };
+	struct CB_NOTIFY4args args;
+	__be32 *p;
 
 	WARN_ON_ONCE(hdr.minorversion == 0);
 
 	encode_cb_compound4args(xdr, &hdr);
 	encode_cb_sequence4args(xdr, cb, &hdr);
 
-	/*
-	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
-	 * buffer, and zero it.
-	 */
+	p = xdr_reserve_space(xdr, 4);
+	*p = cpu_to_be32(OP_CB_NOTIFY);
+
+	args.cna_stateid.seqid = dp->dl_stid.sc_stateid.si_generation;
+	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
+	       ARRAY_SIZE(args.cna_stateid.other));
+	args.cna_fh.len = dp->dl_stid.sc_file->fi_fhandle.fh_size;
+	args.cna_fh.data = dp->dl_stid.sc_file->fi_fhandle.fh_raw;
+	args.cna_changes.count = ncn->ncn_nf_cnt;
+	args.cna_changes.element = ncn->ncn_nf;
 	WARN_ON_ONCE(!xdrgen_encode_CB_NOTIFY4args(xdr, &args));
 
 	hdr.nops++;
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 8a4fb41b84c9..3afde2e91efe 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 #include "trace.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
@@ -3457,19 +3458,131 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
+static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
+{
+	bool queued;
+
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags))
+		return;
+
+	/*
+	 * We're assuming the state code never drops its reference
+	 * without first removing the lease.  Since we're in this lease
+	 * callback (and since the lease code is serialized by the
+	 * flc_lock) we know the server hasn't removed the lease yet, and
+	 * we know it's safe to take a reference.
+	 */
+	refcount_inc(&dp->dl_stid.sc_count);
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued)
+		refcount_dec(&dp->dl_stid.sc_count);
+}
+
+static bool
+nfsd4_cb_notify_prepare(struct nfsd4_callback *cb)
+{
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+	struct nfsd_notify_event *events[NOTIFY4_EVENT_QUEUE_SIZE];
+	struct xdr_buf xdr = { .buflen = PAGE_SIZE * NOTIFY4_PAGE_ARRAY_SIZE,
+			       .pages  = ncn->ncn_pages };
+	struct xdr_stream stream;
+	struct nfsd_file *nf;
+	int count, i;
+	bool error = false;
+
+	xdr_init_encode_pages(&stream, &xdr);
+
+	spin_lock(&ncn->ncn_lock);
+	count = ncn->ncn_evt_cnt;
+
+	/* spurious queueing? */
+	if (count == 0) {
+		spin_unlock(&ncn->ncn_lock);
+		return false;
+	}
+
+	/* we can't keep up! */
+	if (count > NOTIFY4_EVENT_QUEUE_SIZE) {
+		spin_unlock(&ncn->ncn_lock);
+		goto out_recall;
+	}
+
+	memcpy(events, ncn->ncn_evt, sizeof(*events) * count);
+	ncn->ncn_evt_cnt = 0;
+	spin_unlock(&ncn->ncn_lock);
+
+	rcu_read_lock();
+	nf = nfsd_file_get(rcu_dereference(dp->dl_stid.sc_file->fi_deleg_file));
+	rcu_read_unlock();
+	if (!nf) {
+		for (i = 0; i < count; ++i)
+			nfsd_notify_event_put(events[i]);
+		goto out_recall;
+	}
+
+	for (i = 0; i < count; ++i) {
+		struct nfsd_notify_event *nne = events[i];
+
+		if (!error) {
+			u32 *maskp = (u32 *)xdr_reserve_space(&stream, sizeof(*maskp));
+			u8 *p;
+
+			if (!maskp) {
+				error = true;
+				goto put_event;
+			}
+
+			p = nfsd4_encode_notify_event(&stream, nne, dp, nf, maskp);
+			if (!p) {
+				pr_notice("Could not generate CB_NOTIFY from fsnotify mask 0x%x\n",
+					  nne->ne_mask);
+				error = true;
+				goto put_event;
+			}
+
+			ncn->ncn_nf[i].notify_mask.count = 1;
+			ncn->ncn_nf[i].notify_mask.element = maskp;
+			ncn->ncn_nf[i].notify_vals.data = p;
+			ncn->ncn_nf[i].notify_vals.len = (u8 *)stream.p - p;
+		}
+put_event:
+		nfsd_notify_event_put(nne);
+	}
+	if (!error) {
+		ncn->ncn_nf_cnt = count;
+		nfsd_file_put(nf);
+		return true;
+	}
+	nfsd_file_put(nf);
+out_recall:
+	nfsd_break_one_deleg(dp);
+	return false;
+}
+
 static int
 nfsd4_cb_notify_done(struct nfsd4_callback *cb,
 				struct rpc_task *task)
 {
+	struct nfsd4_cb_notify *ncn = container_of(cb, struct nfsd4_cb_notify, ncn_cb);
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
 	switch (task->tk_status) {
 	case -NFS4ERR_DELAY:
 		rpc_delay(task, 2 * HZ);
 		return 0;
 	default:
+		/* For any other hard error, recall the deleg */
+		nfsd_break_one_deleg(dp);
+		fallthrough;
+	case 0:
 		return 1;
 	}
 }
 
+static void nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn);
+
 static void
 nfsd4_cb_notify_release(struct nfsd4_callback *cb)
 {
@@ -3478,6 +3591,9 @@ nfsd4_cb_notify_release(struct nfsd4_callback *cb)
 	struct nfs4_delegation *dp =
 			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 
+	/* Drain events that arrived while this callback was in flight */
+	if (ncn->ncn_evt_cnt > 0)
+		nfsd4_run_cb_notify(ncn);
 	nfs4_put_stid(&dp->dl_stid);
 }
 
@@ -3494,6 +3610,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 };
 
 static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.prepare	= nfsd4_cb_notify_prepare,
 	.done		= nfsd4_cb_notify_done,
 	.release	= nfsd4_cb_notify_release,
 	.opcode		= OP_CB_NOTIFY,
@@ -5726,27 +5843,6 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
 	.opcode		= OP_CB_RECALL,
 };
 
-static void nfsd_break_one_deleg(struct nfs4_delegation *dp)
-{
-	bool queued;
-
-	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags))
-		return;
-
-	/*
-	 * We're assuming the state code never drops its reference
-	 * without first removing the lease.  Since we're in this lease
-	 * callback (and since the lease code is serialized by the
-	 * flc_lock) we know the server hasn't removed the lease yet, and
-	 * we know it's safe to take a reference.
-	 */
-	refcount_inc(&dp->dl_stid.sc_count);
-	queued = nfsd4_run_cb(&dp->dl_recall);
-	WARN_ON_ONCE(!queued);
-	if (!queued)
-		refcount_dec(&dp->dl_stid.sc_count);
-}
-
 /* Called from break_lease() with flc_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lease *fl)
@@ -9855,3 +9951,133 @@ void nfsd_update_cmtime_attr(struct file *f, unsigned int flags)
 				      MINOR(inode->i_sb->s_dev),
 				      inode->i_ino, ret);
 }
+
+static void
+nfsd4_run_cb_notify(struct nfsd4_cb_notify *ncn)
+{
+	struct nfs4_delegation *dp = container_of(ncn, struct nfs4_delegation, dl_cb_notify);
+
+	if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags))
+		return;
+
+	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count))
+		clear_bit(NFSD4_CALLBACK_RUNNING, &ncn->ncn_cb.cb_flags);
+	else
+		nfsd4_run_cb(&ncn->ncn_cb);
+}
+
+static struct nfsd_notify_event *
+alloc_nfsd_notify_event(u32 mask, const struct qstr *q, struct dentry *dentry,
+			struct inode *target)
+{
+	struct nfsd_notify_event *ne;
+
+	ne = kmalloc(sizeof(*ne) + q->len + 1, GFP_KERNEL);
+	if (!ne)
+		return NULL;
+
+	memcpy(&ne->ne_name, q->name, q->len);
+	refcount_set(&ne->ne_ref, 1);
+	ne->ne_mask = mask;
+	ne->ne_name[q->len] = '\0';
+	ne->ne_namelen = q->len;
+	ne->ne_dentry = dget(dentry);
+	ne->ne_target = target;
+	if (ne->ne_target)
+		ihold(ne->ne_target);
+	return ne;
+}
+
+static bool
+should_notify_deleg(u32 mask, struct file_lease *fl)
+{
+	/* Don't notify the client generating the event */
+	if (nfsd_breaker_owns_lease(fl))
+		return false;
+
+	/* Skip if this event wasn't ignored by the lease */
+	if ((mask & FS_DELETE) && !(fl->c.flc_flags & FL_IGN_DIR_DELETE))
+		return false;
+	if ((mask & FS_CREATE) && !(fl->c.flc_flags & FL_IGN_DIR_CREATE))
+		return false;
+	if ((mask & FS_RENAME) && !(fl->c.flc_flags & FL_IGN_DIR_RENAME))
+		return false;
+
+	return true;
+}
+
+static void
+nfsd_recall_all_dir_delegs(const struct inode *dir)
+{
+	struct file_lock_context *ctx = locks_inode_context(dir);
+	struct file_lock_core *flc;
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		struct file_lease *fl = container_of(flc, struct file_lease, c);
+
+		if (fl->fl_lmops == &nfsd_lease_mng_ops)
+			nfsd_break_deleg_cb(fl);
+	}
+	spin_unlock(&ctx->flc_lock);
+}
+
+int
+nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
+		      int data_type, const struct qstr *name)
+{
+	struct dentry *dentry = fsnotify_data_dentry(data, data_type);
+	struct inode *target = fsnotify_data_rename_target(data, data_type);
+	struct file_lock_context *ctx;
+	struct file_lock_core *flc;
+	struct nfsd_notify_event *evt;
+
+	/* Normalize cross-dir rename events to create/delete */
+	if (mask & FS_MOVED_FROM) {
+		mask &= ~FS_MOVED_FROM;
+		mask |= FS_DELETE;
+	}
+	if (mask & FS_MOVED_TO) {
+		mask &= ~FS_MOVED_TO;
+		mask |= FS_CREATE;
+	}
+
+	/* Don't do anything if this is not an expected event */
+	if (!(mask & (FS_CREATE|FS_DELETE|FS_RENAME)))
+		return 0;
+
+	ctx = locks_inode_context(dir);
+	if (!ctx || list_empty(&ctx->flc_lease))
+		return 0;
+
+	evt = alloc_nfsd_notify_event(mask, name, dentry, target);
+	if (!evt) {
+		nfsd_recall_all_dir_delegs(dir);
+		return 0;
+	}
+
+	spin_lock(&ctx->flc_lock);
+	list_for_each_entry(flc, &ctx->flc_lease, flc_list) {
+		struct file_lease *fl = container_of(flc, struct file_lease, c);
+		struct nfs4_delegation *dp = flc->flc_owner;
+		struct nfsd4_cb_notify *ncn = &dp->dl_cb_notify;
+
+		if (!should_notify_deleg(mask, fl))
+			continue;
+
+		spin_lock(&ncn->ncn_lock);
+		if (ncn->ncn_evt_cnt >= NOTIFY4_EVENT_QUEUE_SIZE) {
+			/* We're generating notifications too fast. Recall. */
+			spin_unlock(&ncn->ncn_lock);
+			nfsd_break_deleg_cb(fl);
+			continue;
+		}
+		ncn->ncn_evt[ncn->ncn_evt_cnt++] = nfsd_notify_event_get(evt);
+		spin_unlock(&ncn->ncn_lock);
+
+		nfsd4_run_cb_notify(ncn);
+	}
+	spin_unlock(&ctx->flc_lock);
+	nfsd_notify_event_put(evt);
+	return 0;
+}
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index e17488a911f7..31df04675713 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4172,6 +4172,127 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
 	goto out;
 }
 
+static bool
+nfsd4_setup_notify_entry4(struct notify_entry4 *ne, struct xdr_stream *xdr,
+			  struct dentry *dentry, struct nfs4_delegation *dp,
+			  struct nfsd_file *nf, char *name, u32 namelen)
+{
+	uint32_t *attrmask;
+
+	/* Reserve space for attrmask */
+	attrmask = xdr_reserve_space(xdr, 3 * sizeof(uint32_t));
+	if (!attrmask)
+		return false;
+
+	ne->ne_file.data = name;
+	ne->ne_file.len = namelen;
+	ne->ne_attrs.attrmask.element = attrmask;
+
+	attrmask[0] = 0;
+	attrmask[1] = 0;
+	attrmask[2] = 0;
+	ne->ne_attrs.attr_vals.data = NULL;
+	ne->ne_attrs.attr_vals.len = 0;
+	ne->ne_attrs.attrmask.count = 1;
+	return true;
+}
+
+/**
+ * nfsd4_encode_notify_event - encode a notify
+ * @xdr: stream to which to encode the fattr4
+ * @nne: nfsd_notify_event to encode
+ * @dp: delegation where the event occurred
+ * @nf: nfsd_file on which event occurred
+ * @notify_mask: pointer to word where notification mask should be set
+ *
+ * Encode @nne into @xdr. Returns a pointer to the start of the event, or NULL if
+ * the event couldn't be encoded. The appropriate bit in the notify_mask will also
+ * be set on success.
+ */
+u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *nne,
+			      struct nfs4_delegation *dp, struct nfsd_file *nf,
+			      u32 *notify_mask)
+{
+	u8 *p = NULL;
+
+	*notify_mask = 0;
+
+	if (nne->ne_mask & FS_DELETE) {
+		struct notify_remove4 nr = { };
+
+		if (!nfsd4_setup_notify_entry4(&nr.nrm_old_entry, xdr, nne->ne_dentry, dp,
+					       nf, nne->ne_name, nne->ne_namelen))
+			goto out_err;
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_remove4(xdr, &nr))
+			goto out_err;
+		*notify_mask |= BIT(NOTIFY4_REMOVE_ENTRY);
+	} else if (nne->ne_mask & FS_CREATE) {
+		struct notify_add4 na = { };
+		struct notify_remove4 old = { };
+
+		if (!nfsd4_setup_notify_entry4(&na.nad_new_entry, xdr, nne->ne_dentry, dp,
+					       nf, nne->ne_name, nne->ne_namelen))
+			goto out_err;
+
+		/* If a file was overwritten, report it in nad_old_entry */
+		if (nne->ne_target) {
+			if (!nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
+						       NULL, dp, nf,
+						       nne->ne_name, nne->ne_namelen))
+				goto out_err;
+			na.nad_old_entry.count = 1;
+			na.nad_old_entry.element = &old;
+		}
+
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_add4(xdr, &na))
+			goto out_err;
+
+		*notify_mask |= BIT(NOTIFY4_ADD_ENTRY);
+	} else if (nne->ne_mask & FS_RENAME) {
+		struct notify_rename4 nr = { };
+		struct notify_remove4 old = { };
+		struct name_snapshot n;
+		bool ret;
+
+		/* Don't send any attributes in the old_entry since they're the same in new */
+		if (!nfsd4_setup_notify_entry4(&nr.nrn_old_entry.nrm_old_entry, xdr,
+					       NULL, dp, nf, nne->ne_name,
+					       nne->ne_namelen))
+			goto out_err;
+
+		take_dentry_name_snapshot(&n, nne->ne_dentry);
+		ret = nfsd4_setup_notify_entry4(&nr.nrn_new_entry.nad_new_entry, xdr,
+					       nne->ne_dentry, dp, nf, (char *)n.name.name,
+					       n.name.len);
+
+		/* If a file was overwritten, report it in nad_old_entry */
+		if (ret && nne->ne_target) {
+			ret = nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
+							NULL, dp, nf,
+							(char *)n.name.name, n.name.len);
+			if (ret) {
+				nr.nrn_new_entry.nad_old_entry.count = 1;
+				nr.nrn_new_entry.nad_old_entry.element = &old;
+			}
+		}
+
+		if (ret) {
+			p = (u8 *)xdr->p;
+			ret = xdrgen_encode_notify_rename4(xdr, &nr);
+		}
+		release_dentry_name_snapshot(&n);
+		if (!ret)
+			goto out_err;
+		*notify_mask |= BIT(NOTIFY4_RENAME_ENTRY);
+	}
+	return p;
+out_err:
+	pr_warn("nfsd: unable to marshal notify_rename4 to xdr stream\n");
+	return NULL;
+}
+
 static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 				struct xdr_buf *buf, __be32 *p, int bytes)
 {
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 505fabf8f1bf..e85cce4f8bc5 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -201,6 +201,7 @@ struct nfsd_notify_event {
 	refcount_t	ne_ref;		// refcount
 	u32		ne_mask;	// FS_* mask from fsnotify callback
 	struct dentry	*ne_dentry;	// dentry reference to target
+	struct inode	*ne_target;	// inode overwritten by rename, or NULL
 	u32		ne_namelen;	// length of ne_name
 	char		ne_name[];	// name of dentry being changed
 };
@@ -214,6 +215,7 @@ static inline struct nfsd_notify_event *nfsd_notify_event_get(struct nfsd_notify
 static inline void nfsd_notify_event_put(struct nfsd_notify_event *ne)
 {
 	if (refcount_dec_and_test(&ne->ne_ref)) {
+		iput(ne->ne_target);
 		dput(ne->ne_dentry);
 		kfree(ne);
 	}
@@ -898,6 +900,8 @@ void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
+int nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
+			  int data_type, const struct qstr *name);
 
 void put_nfs4_file(struct nfs4_file *fi);
 extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 85574b2a139a..62ac790428be 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -970,6 +970,9 @@ __be32 nfsd4_encode_fattr_to_buf(__be32 **p, int words,
 		struct svc_fh *fhp, struct svc_export *exp,
 		struct dentry *dentry,
 		u32 *bmval, struct svc_rqst *, int ignore_crossmnt);
+u8 *nfsd4_encode_notify_event(struct xdr_stream *xdr, struct nfsd_notify_event *nne,
+			      struct nfs4_delegation *dd, struct nfsd_file *nf,
+			      u32 *notify_mask);
 extern __be32 nfsd4_setclientid(struct svc_rqst *rqstp,
 		struct nfsd4_compound_state *, union nfsd4_op_u *u);
 extern __be32 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,

-- 
2.54.0


