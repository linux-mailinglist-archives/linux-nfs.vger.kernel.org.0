Return-Path: <linux-nfs+bounces-22612-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NuKvJKE9MWrDewUAu9opvQ
	(envelope-from <linux-nfs+bounces-22612-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:12:17 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EA568F2A7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:12:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YqcwGgSX;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22612-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22612-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D727630E68FD
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9EA45348A;
	Tue, 16 Jun 2026 11:59:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC40450902;
	Tue, 16 Jun 2026 11:59:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611168; cv=none; b=Dpw2W8a8t7/hb8zWeYLfMyrr5zHaba38/NSrw0Gp8xW2xSAatcv7fZDETaWXpzEIH+oOTa/Yq+1pxAoaanFOfai7eacmkTh4gaNeZOmbaEm5COLkmu651Lkz8bRK0yRBwrMvbKw/n1ACptlCrDU8MhgD7urFco4KGQzbQFCXzAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611168; c=relaxed/simple;
	bh=we6H7/kw7sun8GUZEcu5tkP70PvIYfwMUXKnc7SChow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZbEBZxY3KXhF8yvPVK9Y8ZVyx60SK088Ok4RlvJBIZBMylPxhAoEExyyvMk3G3W0vrj073G1Bzk4JX3K+5fPaZJ8J9eawhwDvIWUYbuPW03BrnXCWLR+UPLqcdd5YyHSh43ig3ppTgru/YVxw9xvz0wOjW07zgzdkgRjrzac8YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqcwGgSX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141D51F000E9;
	Tue, 16 Jun 2026 11:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611165;
	bh=VGUD4PraC1HmP4/qFSf3ebB5EoWCHUcBu+JjU9cXG1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YqcwGgSXEg6nZfywlfi3kWKBaN89kjsvT5U+VMVwvQNA48uIVqdC7vmU+5iJVyHHJ
	 v31ZCBTbj+Gu5R0n1NANrfsX+vmqKli1sKqNQfcOCIKbPCMLUsOYgQWssoaS0blUoH
	 0suKSH+OJ/+8+BXRlj+Ivf9bcWFCEvPssqk2XxPxfPDiJWj9FtQgs2I3pqAYS38EHf
	 aBzIil7sH4ejdsRLjk7jcuAYjp9bSP8nII5SKPfaI5lUmlKFGcbeGeXlLRT3POUIy6
	 uZ3e+TLulIzDAaRDuth59W0+mUZ8oOqc3gBB14rVRsDBzN95Ch/sVcemu4Vp2euNbR
	 1+8FRyxkw6ccw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:53 -0400
Subject: [PATCH v7 10/20] nfsd: add notification handlers for dir events
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-10-6cbc7eac0ade@kernel.org>
References: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
In-Reply-To: <20260616-dir-deleg-v7-0-6cbc7eac0ade@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Chuck Lever <cel@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
 Alexander Aring <alex.aring@gmail.com>, Amir Goldstein <amir73il@gmail.com>, 
 Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 Calum Mackay <calum.mackay@oracle.com>, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=33367; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=we6H7/kw7sun8GUZEcu5tkP70PvIYfwMUXKnc7SChow=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqG74RvobJOrLuaEEW+b3cAHaYb6twdevonW
 arrdLI3bhiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hgAKCRAADmhBGVaC
 FeeSEACpkKhMFHMF2WbmJDvfo2HXrDUuRXsnH7hFvymOb0rtpRKv1Y5ytcaCXozLCvYc3AjesaP
 J8V1+/eg7mIA2yffM/g1r8p04tE7vmmV5pOJUPx/umY4d75I63pCKUsfCMCiyxj0kYlN7aOCBWb
 WQv4j0rD3UB9IkKsJwmkBancR+GTe20X9RKtXHrHvXmKlORIf8wOORBKN4PvOG20y8Wxt/Cjouo
 i0ZV0mf+dfKo3hrEBYViDAVkmrXtlQ1ZdxP1v5FIGS1C33wrsI6hp5CvJDvOKqlN4ILG6YP+8HL
 79Kj+9n6j79kTBRzrbYrs1UbQKaOCeOPCMnh0ryI7+VvXadO9psP99fXQRkhCKzoWvUwsZJ+aU0
 DHmo5b+deCdkO/W0uA7gKe6s6IIKcvQ6wHWJ78MQnsYoWldWIBfwMXVDzRvkH4pF4EsN8K43/sR
 Xvsz+m3QF/P8PwhNo0QF19ODXf9RkKg1sH9WIDCVQp8SrqLN8IA1vY9s+DB/+Eodt/rt91r8epc
 wjBhriyIQ1Up+FBUUzLDMUPYV9PuhE2MksfgdqjcrIYhC1e3KTleDwX6gct+5DUdOavrw3h5e6E
 NNo7Je8kqQGFIvN5ryWFP/Nz9jY+X66bckA1fxvlUP5/K9+PFOzlAzO2x2PRYZm2Zl+onm9qRRQ
 9NrqEWXmt60OrJw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22612-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[goodmis.org,gmail.com,suse.cz,zeniv.linux.org.uk,kernel.org,oracle.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,cna_fh.data:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03EA568F2A7

Add the necessary parts to accept a fsnotify callback for directory
change event and create a CB_NOTIFY request for it. When a dir nfsd_file
is created set a handle_event callback to handle the notification.

Use that to allocate a nfsd_notify_event object and then hand off a
reference to each delegation's CB_NOTIFY. If anything fails along the
way, recall any affected delegations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/sunrpc/xdr/nfs4_1.x |   3 +
 fs/nfsd/filecache.c               |  70 ++++++--
 fs/nfsd/nfs4callback.c            |  51 +++++-
 fs/nfsd/nfs4state.c               | 330 +++++++++++++++++++++++++++++++++++---
 fs/nfsd/nfs4xdr.c                 | 117 ++++++++++++++
 fs/nfsd/nfs4xdr_gen.c             |  12 +-
 fs/nfsd/nfs4xdr_gen.h             |   9 ++
 fs/nfsd/state.h                   |  20 ++-
 fs/nfsd/trace.h                   |  23 +++
 fs/nfsd/xdr4.h                    |   3 +
 10 files changed, 587 insertions(+), 51 deletions(-)

diff --git a/Documentation/sunrpc/xdr/nfs4_1.x b/Documentation/sunrpc/xdr/nfs4_1.x
index 99a831d68da8..a32df1e882e5 100644
--- a/Documentation/sunrpc/xdr/nfs4_1.x
+++ b/Documentation/sunrpc/xdr/nfs4_1.x
@@ -445,6 +445,7 @@ struct notify_remove4 {
         notify_entry4   nrm_old_entry;
         nfs_cookie4     nrm_old_entry_cookie;
 };
+pragma public notify_remove4;
 
 struct notify_add4 {
         /*
@@ -458,6 +459,7 @@ struct notify_add4 {
         prev_entry4         nad_prev_entry<1>;
         bool                nad_last_entry;
 };
+pragma public notify_add4;
 
 struct notify_attr4 {
         notify_entry4   na_changed_entry;
@@ -467,6 +469,7 @@ struct notify_rename4 {
         notify_remove4  nrn_old_entry;
         notify_add4     nrn_new_entry;
 };
+pragma public notify_rename4;
 
 struct notify_verifier4 {
         verifier4       nv_old_cookieverf;
diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index c5f2c5768324..b9548eb17c77 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -78,6 +78,7 @@ static struct kmem_cache		*nfsd_file_mark_slab;
 static struct list_lru			nfsd_file_lru;
 static unsigned long			nfsd_file_flags;
 static struct fsnotify_group		*nfsd_file_fsnotify_group;
+static struct fsnotify_group		*nfsd_dir_fsnotify_group;
 static struct delayed_work		nfsd_filecache_laundrette;
 static struct rhltable			nfsd_file_rhltable
 						____cacheline_aligned_in_smp;
@@ -153,7 +154,7 @@ static void
 nfsd_file_mark_put(struct nfsd_file_mark *nfm)
 {
 	if (refcount_dec_and_test(&nfm->nfm_ref)) {
-		fsnotify_destroy_mark(&nfm->nfm_mark, nfsd_file_fsnotify_group);
+		fsnotify_destroy_mark(&nfm->nfm_mark, nfm->nfm_mark.group);
 		fsnotify_put_mark(&nfm->nfm_mark);
 	}
 }
@@ -161,35 +162,37 @@ nfsd_file_mark_put(struct nfsd_file_mark *nfm)
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
 		mutex_init(&new->nfm_recalc_mutex);
@@ -830,12 +833,36 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
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
@@ -887,8 +914,7 @@ nfsd_file_cache_init(void)
 		goto out_shrinker;
 	}
 
-	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							0);
+	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops, 0);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
@@ -897,11 +923,23 @@ nfsd_file_cache_init(void)
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
 		if (file && (file->f_mode & FMODE_OPENED)) {
 			get_file(file);
 			nf->nf_file = file;
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 2df281554abf..71dcb448fa0a 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -896,11 +896,14 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
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
+	unsigned int start;
 
 	WARN_ON_ONCE(hdr.minorversion == 0);
 
@@ -908,13 +911,43 @@ static void nfs4_xdr_enc_cb_notify(struct rpc_rqst *req,
 	encode_cb_sequence4args(xdr, cb, &hdr);
 
 	/*
-	 * FIXME: get stateid and fh from delegation. Inline the cna_changes
-	 * buffer, and zero it.
+	 * nfsd4_cb_notify_prepare() sized the payload against a single page,
+	 * but did not account for the compound, sequence, stateid, and
+	 * filehandle encoded here. If the variable-length encode overflows the
+	 * backchannel send buffer, roll back to before the operation so that a
+	 * truncated CB_NOTIFY is never placed on the wire.
 	 */
-	xdrgen_encode_CB_NOTIFY4args(xdr, &args);
+	start = xdr_stream_pos(xdr);
+
+	if (xdr_stream_encode_u32(xdr, OP_CB_NOTIFY) < 0)
+		goto out_err;
+
+	args.cna_stateid.seqid = dp->dl_stid.sc_stateid.si_generation;
+	memcpy(&args.cna_stateid.other, &dp->dl_stid.sc_stateid.si_opaque,
+	       ARRAY_SIZE(args.cna_stateid.other));
+	args.cna_fh.len = dp->dl_stid.sc_file->fi_fhandle.fh_size;
+	args.cna_fh.data = dp->dl_stid.sc_file->fi_fhandle.fh_raw;
+	args.cna_changes.count = ncn->ncn_nf_cnt;
+	args.cna_changes.element = ncn->ncn_nf;
+	if (!xdrgen_encode_CB_NOTIFY4args(xdr, &args))
+		goto out_err;
 
 	hdr.nops++;
 	encode_cb_nops(&hdr);
+	return;
+
+out_err:
+	/*
+	 * Drop the CB_NOTIFY op and emit a valid CB_SEQUENCE-only compound so
+	 * the client still advances its slot. Flag the failure so the done
+	 * handler recalls the delegation and the missed notification is not
+	 * silently lost. The flag is written here in the transmit path and read
+	 * in the done handler; the two are serialized phases of the same
+	 * rpc_task, so no additional barrier is needed.
+	 */
+	ncn->ncn_encode_err = true;
+	xdr_truncate_encode(xdr, start);
+	encode_cb_nops(&hdr);
 }
 
 static int nfs4_xdr_dec_cb_notify(struct rpc_rqst *rqstp,
@@ -1412,6 +1445,16 @@ static void nfsd41_destroy_cb(struct nfsd4_callback *cb)
 	else
 		clear_bit(NFSD4_CALLBACK_RUNNING, &cb->cb_flags);
 
+	/*
+	 * Order the clear of NFSD4_CALLBACK_RUNNING above before the ->release()
+	 * callback below. A release op may re-check producer-side state to decide
+	 * whether to requeue itself (see nfsd4_cb_notify_release()), and that
+	 * check must not be reordered ahead of the clear. The plain clear_bit()
+	 * path carries no ordering; clear_and_wake_up_bit() already issues this
+	 * barrier internally, so the extra one is harmless there.
+	 */
+	smp_mb__after_atomic();
+
 	if (cb->cb_ops && cb->cb_ops->release)
 		cb->cb_ops->release(cb);
 	nfsd41_cb_inflight_end(clp);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2d82cdd96e12..5a4f0843c2fe 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -55,6 +55,7 @@
 #include "netns.h"
 #include "pnfs.h"
 #include "filecache.h"
+#include "nfs4xdr_gen.h"
 #include "trace.h"
 
 #define NFSDDBG_FACILITY                NFSDDBG_PROC
@@ -3485,19 +3486,154 @@ nfsd4_cb_getattr_release(struct nfsd4_callback *cb)
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
+	 * When called from the lease break (nfsd_break_deleg_cb()) the state
+	 * code is serialized by the flc_lock and the lease has not been
+	 * removed yet, so sc_count is known to be nonzero. The CB_NOTIFY
+	 * callback paths reach here from a workqueue without the flc_lock,
+	 * where the delegation may already be unhashed with sc_count at zero.
+	 * Use refcount_inc_not_zero() so both cases are safe, and bail if the
+	 * delegation is already being torn down.
+	 */
+	if (!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
+		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
+		return;
+	}
+	queued = nfsd4_run_cb(&dp->dl_recall);
+	WARN_ON_ONCE(!queued);
+	if (!queued) {
+		refcount_dec(&dp->dl_stid.sc_count);
+		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
+	}
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
+	/* Clear any failure recorded by a previous transmit. */
+	ncn->ncn_encode_err = false;
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
+	if (dp->dl_stid.sc_status)
+		return 1;
+
+	/*
+	 * The CB_NOTIFY op overflowed the send buffer and was dropped from the
+	 * compound. The notification is lost, so recall the delegation rather
+	 * than leaving the client unaware of the directory change.
+	 */
+	if (ncn->ncn_encode_err) {
+		nfsd_break_one_deleg(dp);
+		return 1;
+	}
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
@@ -3506,6 +3642,9 @@ nfsd4_cb_notify_release(struct nfsd4_callback *cb)
 	struct nfs4_delegation *dp =
 			container_of(ncn, struct nfs4_delegation, dl_cb_notify);
 
+	/* Drain events that arrived while this callback was in flight */
+	if (READ_ONCE(ncn->ncn_evt_cnt) > 0)
+		nfsd4_run_cb_notify(ncn);
 	nfs4_put_stid(&dp->dl_stid);
 }
 
@@ -3522,6 +3661,7 @@ static const struct nfsd4_callback_ops nfsd4_cb_getattr_ops = {
 };
 
 static const struct nfsd4_callback_ops nfsd4_cb_notify_ops = {
+	.prepare	= nfsd4_cb_notify_prepare,
 	.done		= nfsd4_cb_notify_done,
 	.release	= nfsd4_cb_notify_release,
 	.opcode		= OP_CB_NOTIFY,
@@ -5781,29 +5921,6 @@ static const struct nfsd4_callback_ops nfsd4_cb_recall_ops = {
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
-	if (!queued) {
-		refcount_dec(&dp->dl_stid.sc_count);
-		clear_bit(NFSD4_CALLBACK_RUNNING, &dp->dl_recall.cb_flags);
-	}
-}
-
 /* Called from break_lease() with flc_lock held. */
 static bool
 nfsd_break_deleg_cb(struct file_lease *fl)
@@ -9991,3 +10108,170 @@ void nfsd_update_cmtime_attr(struct file *f, unsigned int flags)
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
+	struct name_snapshot newname;
+	u32 newnamelen = 0;
+
+	/*
+	 * For a rename, @q is the old name and the live dentry carries the new
+	 * name. Snapshot the new name now, while it is guaranteed to describe
+	 * this event: the dentry can be renamed again before the CB_NOTIFY work
+	 * runs, which would corrupt a late read in nfsd4_encode_notify_event().
+	 */
+	if (mask & FS_RENAME) {
+		take_dentry_name_snapshot(&newname, dentry);
+		newnamelen = newname.name.len;
+	}
+
+	ne = kmalloc(struct_size(ne, ne_name, q->len + 1 +
+				 (newnamelen ? newnamelen + 1 : 0)), GFP_NOFS);
+	if (!ne)
+		goto out;
+
+	memcpy(ne->ne_name, q->name, q->len);
+	ne->ne_name[q->len] = '\0';
+	ne->ne_namelen = q->len;
+
+	ne->ne_newnamelen = newnamelen;
+	if (newnamelen) {
+		char *p = nfsd_notify_event_newname(ne);
+
+		memcpy(p, newname.name.name, newnamelen);
+		p[newnamelen] = '\0';
+	}
+
+	refcount_set(&ne->ne_ref, 1);
+	ne->ne_mask = mask;
+	ne->ne_dentry = dget(dentry);
+	ne->ne_target = target;
+	if (ne->ne_target)
+		ihold(ne->ne_target);
+out:
+	if (mask & FS_RENAME)
+		release_dentry_name_snapshot(&newname);
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
+	trace_nfsd_handle_dir_event(mask, dir, name);
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
+	/*
+	 * FS_RENAME fires on the source directory even for a cross-dir
+	 * rename, where the moved entry now lives under a different parent.
+	 * NOTIFY4_RENAME_ENTRY describes an in-place rename, so reporting it
+	 * here would advertise a name absent from this directory.
+	 */
+	if ((mask & FS_RENAME) && dentry && d_inode(dentry->d_parent) != dir)
+		mask &= ~FS_RENAME;
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
index ad192d25724c..976d60115cd6 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4189,6 +4189,123 @@ nfsd4_encode_fattr4(struct svc_rqst *rqstp, struct xdr_stream *xdr,
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
+ * Encode @nne into @xdr. The matching bit in @notify_mask is set on
+ * success.
+ *
+ * Return: pointer to the start of the encoded event, or NULL if the
+ * event could not be encoded.
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
+		char *newname = nfsd_notify_event_newname(nne);
+
+		/* Don't send any attributes in the old_entry since they're the same in new */
+		if (!nfsd4_setup_notify_entry4(&nr.nrn_old_entry.nrm_old_entry, xdr,
+					       NULL, dp, nf, nne->ne_name,
+					       nne->ne_namelen))
+			goto out_err;
+
+		if (!nfsd4_setup_notify_entry4(&nr.nrn_new_entry.nad_new_entry, xdr,
+					       nne->ne_dentry, dp, nf, newname,
+					       nne->ne_newnamelen))
+			goto out_err;
+
+		/* If a file was overwritten, report it in nad_old_entry */
+		if (nne->ne_target) {
+			if (!nfsd4_setup_notify_entry4(&old.nrm_old_entry, xdr,
+						       NULL, dp, nf, newname,
+						       nne->ne_newnamelen))
+				goto out_err;
+			nr.nrn_new_entry.nad_old_entry.count = 1;
+			nr.nrn_new_entry.nad_old_entry.element = &old;
+		}
+
+		p = (u8 *)xdr->p;
+		if (!xdrgen_encode_notify_rename4(xdr, &nr))
+			goto out_err;
+		*notify_mask |= BIT(NOTIFY4_RENAME_ENTRY);
+	}
+	return p;
+out_err:
+	pr_warn("nfsd: unable to marshal notify event to xdr stream\n");
+	return NULL;
+}
+
 static void svcxdr_init_encode_from_buffer(struct xdr_stream *xdr,
 				struct xdr_buf *buf, __be32 *p, int bytes)
 {
diff --git a/fs/nfsd/nfs4xdr_gen.c b/fs/nfsd/nfs4xdr_gen.c
index b1a583a6dfa1..d1240ade120d 100644
--- a/fs/nfsd/nfs4xdr_gen.c
+++ b/fs/nfsd/nfs4xdr_gen.c
@@ -628,7 +628,7 @@ xdrgen_decode_prev_entry4(struct xdr_stream *xdr, struct prev_entry4 *ptr)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_decode_notify_remove4(struct xdr_stream *xdr, struct notify_remove4 *ptr)
 {
 	if (!xdrgen_decode_notify_entry4(xdr, &ptr->nrm_old_entry))
@@ -638,7 +638,7 @@ xdrgen_decode_notify_remove4(struct xdr_stream *xdr, struct notify_remove4 *ptr)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr)
 {
 	if (xdr_stream_decode_u32(xdr, &ptr->nad_old_entry.count) < 0)
@@ -677,7 +677,7 @@ xdrgen_decode_notify_attr4(struct xdr_stream *xdr, struct notify_attr4 *ptr)
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_decode_notify_rename4(struct xdr_stream *xdr, struct notify_rename4 *ptr)
 {
 	if (!xdrgen_decode_notify_remove4(xdr, &ptr->nrn_old_entry))
@@ -1050,7 +1050,7 @@ xdrgen_encode_prev_entry4(struct xdr_stream *xdr, const struct prev_entry4 *valu
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_remove4 *value)
 {
 	if (!xdrgen_encode_notify_entry4(xdr, &value->nrm_old_entry))
@@ -1060,7 +1060,7 @@ xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_remove4
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *value)
 {
 	if (value->nad_old_entry.count > 1)
@@ -1099,7 +1099,7 @@ xdrgen_encode_notify_attr4(struct xdr_stream *xdr, const struct notify_attr4 *va
 	return true;
 }
 
-static bool __maybe_unused
+bool
 xdrgen_encode_notify_rename4(struct xdr_stream *xdr, const struct notify_rename4 *value)
 {
 	if (!xdrgen_encode_notify_remove4(xdr, &value->nrn_old_entry))
diff --git a/fs/nfsd/nfs4xdr_gen.h b/fs/nfsd/nfs4xdr_gen.h
index 0e11cd537a98..c62299bac735 100644
--- a/fs/nfsd/nfs4xdr_gen.h
+++ b/fs/nfsd/nfs4xdr_gen.h
@@ -32,6 +32,15 @@ bool xdrgen_decode_posixaceperm4(struct xdr_stream *xdr, posixaceperm4 *ptr);
 bool xdrgen_encode_posixaceperm4(struct xdr_stream *xdr, const posixaceperm4 value);
 
 
+bool xdrgen_decode_notify_remove4(struct xdr_stream *xdr, struct notify_remove4 *ptr);
+bool xdrgen_encode_notify_remove4(struct xdr_stream *xdr, const struct notify_remove4 *value);
+
+bool xdrgen_decode_notify_add4(struct xdr_stream *xdr, struct notify_add4 *ptr);
+bool xdrgen_encode_notify_add4(struct xdr_stream *xdr, const struct notify_add4 *value);
+
+bool xdrgen_decode_notify_rename4(struct xdr_stream *xdr, struct notify_rename4 *ptr);
+bool xdrgen_encode_notify_rename4(struct xdr_stream *xdr, const struct notify_rename4 *value);
+
 bool xdrgen_decode_CB_NOTIFY4args(struct xdr_stream *xdr, struct CB_NOTIFY4args *ptr);
 bool xdrgen_encode_CB_NOTIFY4args(struct xdr_stream *xdr, const struct CB_NOTIFY4args *value);
 
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ac9dd798ea22..f8457e0f2b57 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -201,10 +201,23 @@ struct nfsd_notify_event {
 	refcount_t	ne_ref;		// refcount
 	u32		ne_mask;	// FS_* mask from fsnotify callback
 	struct dentry	*ne_dentry;	// dentry reference to target
-	u32		ne_namelen;	// length of ne_name
-	char		ne_name[];	// name of dentry being changed
+	struct inode	*ne_target;	// inode overwritten by rename, or NULL
+	u32		ne_namelen;	// length of ne_name (old name for a rename)
+	u32		ne_newnamelen;	// length of new name (rename only), else 0
+	char		ne_name[];	// entry name, then new name (rename only)
 };
 
+/*
+ * For a rename, the new name is snapshotted at event-alloc time and stored
+ * immediately after the (NUL-terminated) old name in ne_name[]. ne_dentry can
+ * be renamed again before the CB_NOTIFY work runs, so the new name must not be
+ * read from the live dentry at encode time.
+ */
+static inline char *nfsd_notify_event_newname(struct nfsd_notify_event *ne)
+{
+	return ne->ne_name + ne->ne_namelen + 1;
+}
+
 static inline struct nfsd_notify_event *nfsd_notify_event_get(struct nfsd_notify_event *ne)
 {
 	refcount_inc(&ne->ne_ref);
@@ -214,6 +227,7 @@ static inline struct nfsd_notify_event *nfsd_notify_event_get(struct nfsd_notify
 static inline void nfsd_notify_event_put(struct nfsd_notify_event *ne)
 {
 	if (refcount_dec_and_test(&ne->ne_ref)) {
+		iput(ne->ne_target);
 		dput(ne->ne_dentry);
 		kfree(ne);
 	}
@@ -901,6 +915,8 @@ void nfsd_update_cmtime_attr(struct file *f, unsigned int flags);
 extern struct nfs4_client_reclaim *nfs4_client_to_reclaim(struct xdr_netobj name,
 				struct xdr_netobj princhash, struct nfsd_net *nn);
 extern bool nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn);
+int nfsd_handle_dir_event(u32 mask, const struct inode *dir, const void *data,
+			  int data_type, const struct qstr *name);
 
 void put_nfs4_file(struct nfs4_file *fi);
 extern void nfs4_put_cpntf_state(struct nfsd_net *nn,
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 171e8fdbafb6..db0a0dc70660 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -12,6 +12,7 @@
 #include <linux/sunrpc/clnt.h>
 #include <linux/sunrpc/xprt.h>
 #include <trace/misc/fs.h>
+#include <trace/misc/fsnotify.h>
 #include <trace/misc/nfs.h>
 #include <trace/misc/sunrpc.h>
 
@@ -1377,6 +1378,28 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+TRACE_EVENT(nfsd_handle_dir_event,
+	TP_PROTO(u32 mask, const struct inode *dir, const struct qstr *name),
+	TP_ARGS(mask, dir, name),
+	TP_STRUCT__entry(
+		__field(u32, mask)
+		__field(dev_t, s_dev)
+		__field(u64, i_ino)
+		__string_len(name, name ? name->name : NULL,
+				   name ? name->len : 0)
+	),
+	TP_fast_assign(
+		__entry->mask = mask;
+		__entry->s_dev = dir ? dir->i_sb->s_dev : 0;
+		__entry->i_ino = dir ? dir->i_ino : 0;
+		__assign_str(name);
+	),
+	TP_printk("inode=0x%x:0x%x:0x%llx mask=%s name=%s",
+			MAJOR(__entry->s_dev), MINOR(__entry->s_dev),
+			__entry->i_ino, show_fsnotify_mask(__entry->mask),
+			__get_str(name))
+);
+
 DECLARE_EVENT_CLASS(nfsd_file_gc_class,
 	TP_PROTO(
 		const struct nfsd_file *nf
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


