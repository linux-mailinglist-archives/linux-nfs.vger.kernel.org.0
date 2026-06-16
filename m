Return-Path: <linux-nfs+bounces-22607-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z438MW47MWo7egUAu9opvQ
	(envelope-from <linux-nfs+bounces-22607-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:02:54 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A4F3B68F0ED
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:02:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fZzl19Ja;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22607-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22607-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C4E930074B5
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94EA44B66E;
	Tue, 16 Jun 2026 11:59:17 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9598C449ED6;
	Tue, 16 Jun 2026 11:59:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781611157; cv=none; b=IMgdBVj38i+/2fRUTnSscVW2oZYijitngIiaObxiuh/VQiSH/tyNYDLiNMkoPIxW67AzylHrgDxkRFx2UBgv79P2gYkvTAg3svAJs0de/R9ia1RFA5ZQ/VR3Qrutq83mqecn2VknM8t7EBw9ZXQVB2AXjzT1kPnwIj1y56+EUwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781611157; c=relaxed/simple;
	bh=Kk8PUahLRizu+MUKt45CCbiyX37hklxX+aMqEz4YczY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PULYsHZxJTHfjd+Qndf5yzQ5jeJgHyusEkYGSfRiBxSFmXMr/+oAkhHcV/AzeJe1ohm8EHSkcdKYP9mSV6dZ4qufoNdRh3wnLSEOPOVa0u6mkifsqk2zVs2Ma721LJyvqnW5EEVYsBo5SC8jSEFcqLueJxk0jmi1rambr/ypPfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZzl19Ja; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94CA91F00A3D;
	Tue, 16 Jun 2026 11:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781611156;
	bh=M/qk6AIHD2HwsSNCjrPA17sZ4KvQMWyGz+W8JvpIAO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fZzl19Jap+XUUlTvn7woXl91dG8kFlDqTdS3T4aMsKzsJcPAdlWzn94iNHSBHcI/g
	 Vol1k8XrjRsiTgWwYlxfM6MBkx6lwe4m5WQ012zIhVIMOTPvj3mVntcGKyzI3qLh3o
	 AikeHyNhIVWpf7pRoNFOg5wtI337cZDeeCqeMFfoNcx4En01Fvrkv4oa/fgRjG0M+E
	 Q3MBwL8rk8XUuouoGNICY728fvndxXmiUaEvcECOy4IMMPPOtXkr/fw/6criGezrhU
	 aLhuvUUXl9tFtQI67R6IM4Fu612cjge2TuU0pbOaPYmkA0B7gwZsxA7IcMVN6JyWZt
	 yHCupqXf7Ivzw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 07:58:48 -0400
Subject: [PATCH v7 05/20] nfsd: update the fsnotify mark when setting or
 removing a dir delegation
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-dir-deleg-v7-5-6cbc7eac0ade@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5219; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Kk8PUahLRizu+MUKt45CCbiyX37hklxX+aMqEz4YczY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMTqFx1bgPIB08ZxaWo/NN2XUMxb5Qe3hd18o5
 JfnuvHtzzaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajE6hQAKCRAADmhBGVaC
 FYcfEACv8vVkda/obGFgSNAGKc8rv0r7GMNIBQTpa3dKPJyeMDkInYsTagzFsxrUMvxFnFDoRMr
 QuCfh8fcn0jWGrWaXz6+P3EQmo/XvHckoBWUurM6Aef8JvRsWVXhScxluCIHg7utBh9OOHQIh7x
 EWeErYHOc7git6/+lrhUCPBsuGbs5jt/GyoyY/Pxw6ZIxKWWR8I8oXiRz0h6u9ATYoo4Ye4ycvw
 5iri+f5qNiqgYVgnr56FAm+VveB5SdgN03VKbcqt6xY204Ux/VqguXmxhHuYBJoGv5DRjONxA2Y
 B8i8p7LLO6m1a3+4+5E950VE/K/f9/LgBDSZ1olCK5lTPF+lfZ56iKpaKRM7NNpDLA+zCsXLuB+
 GerUgBtwYVA/FDtgk0ZT13SM20Xif0uFwB2oo6i9dSOdVmN3m2bXzhDcCojz8e2k75pAMG23ZTE
 xY30jAcN86smXrToZrbvSunXo+ULEUwX7l1QvryorZHDQJhdE2BTBherTplFuUHdWvQHIKoig6Q
 t/gQyZbuECSbwUN0DiGeIZEnNm0zovW5D7HJvD4hBnoJCiI3MrGA86APrRsiAYr280GHLX863YR
 pX4aUkUCpunkcYdwC1GUSJAzj+Q8XsC66hZ24uLCNEvNYUJfSPV3uI/8VcsGj13SPPNQis/SF82
 BJo2IzK1TgUENXQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:cel@kernel.org,m:rostedt@goodmis.org,m:alex.aring@gmail.com,m:amir73il@gmail.com,m:jack@suse.cz,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:calum.mackay@oracle.com,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:jlayton@kernel.org,m:alexaring@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[suse.cz:query timed out];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-22607-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.cz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4F3B68F0ED

Add a new helper function that will update the mask on the nfsd_file's
fsnotify_mark to be a union of all current directory delegations on an
inode.

Call that when directory delegations are added or removed, since that
can change what fsnotify events nfsd requires from the VFS layer.

The fsnotify_mark is shared by every nfsd_file open on the inode, so
concurrent delegation adds and removes on the same directory can run
nfsd_fsnotify_recalc_mask() in parallel. Because it reads the lease
state and updates the mark in two separate locked sections, a recalc
working from a stale snapshot of the lease list could clobber a
concurrent update and leave the mark missing required events. Add an
nfm_recalc_mutex to the nfsd_file_mark and hold it across the recalc to
serialize callers.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/filecache.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h |  3 +++
 fs/nfsd/nfs4state.c |  5 +++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1ea2bfd51825..c5f2c5768324 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -192,6 +192,7 @@ nfsd_file_mark_find_or_create(struct inode *inode)
 		fsnotify_init_mark(&new->nfm_mark, nfsd_file_fsnotify_group);
 		new->nfm_mark.mask = FS_ATTRIB|FS_DELETE_SELF;
 		refcount_set(&new->nfm_ref, 1);
+		mutex_init(&new->nfm_recalc_mutex);
 
 		err = fsnotify_add_inode_mark(&new->nfm_mark, inode, 0);
 
@@ -1473,3 +1474,54 @@ int nfsd_file_cache_stats_show(struct seq_file *m, void *v)
 		seq_printf(m, "mean age (ms): -\n");
 	return 0;
 }
+
+/**
+ * nfsd_fsnotify_recalc_mask - recalculate the fsnotify mask for a nfsd_file
+ * @nf: nfsd_file to recalculate the mask on
+ *
+ * When a directory nfsd_file has a delegation added or removed, that may
+ * change the events that nfsd requires from the VFS layer. This function
+ * recalculates the fsnotify mask based on the leases present.
+ */
+void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf)
+{
+	struct inode *inode = file_inode(nf->nf_file);
+	u32 lease_mask, set = 0, clear = 0;
+	struct fsnotify_mark *mark;
+
+	/* This is only needed when adding or removing dir delegs */
+	if (!S_ISDIR(inode->i_mode) || !nf->nf_mark)
+		return;
+
+	mark = &nf->nf_mark->nfm_mark;
+
+	/*
+	 * The mark is shared by every nfsd_file on this inode, so concurrent
+	 * delegation add/remove on the same directory can recalc it in
+	 * parallel. Serialize the read of the lease state and the update of
+	 * the mark so that a recalc working from a stale snapshot of the
+	 * lease list can't clobber a concurrent recalc's update.
+	 */
+	mutex_lock(&nf->nf_mark->nfm_recalc_mutex);
+
+	/* Set up notifications for any ignored delegation events */
+	lease_mask = inode_lease_ignore_mask(inode);
+
+	if (lease_mask & FL_IGN_DIR_CREATE)
+		set |= FS_CREATE | FS_MOVED_TO;
+	else
+		clear |= FS_CREATE | FS_MOVED_TO;
+
+	if (lease_mask & FL_IGN_DIR_DELETE)
+		set |= FS_DELETE | FS_MOVED_FROM;
+	else
+		clear |= FS_DELETE | FS_MOVED_FROM;
+
+	if (lease_mask & FL_IGN_DIR_RENAME)
+		set |= FS_RENAME;
+	else
+		clear |= FS_RENAME;
+
+	fsnotify_modify_mark_mask(mark, set, clear);
+	mutex_unlock(&nf->nf_mark->nfm_recalc_mutex);
+}
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index 683b6437cacc..b224902b438d 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -26,6 +26,8 @@
 struct nfsd_file_mark {
 	struct fsnotify_mark	nfm_mark;
 	refcount_t		nfm_ref;
+	/* serializes nfsd_fsnotify_recalc_mask() against itself */
+	struct mutex		nfm_recalc_mutex;
 };
 
 /*
@@ -86,4 +88,5 @@ __be32 nfsd_file_acquire_local(struct net *net, struct svc_cred *cred,
 __be32 nfsd_file_acquire_dir(struct svc_rqst *rqstp, struct svc_fh *fhp,
 		  struct nfsd_file **pnf);
 int nfsd_file_cache_stats_show(struct seq_file *m, void *v);
+void nfsd_fsnotify_recalc_mask(struct nfsd_file *nf);
 #endif /* _FS_NFSD_FILECACHE_H */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6921504acc29..dcb282f4fe67 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1255,6 +1255,7 @@ static void nfs4_unlock_deleg_lease(struct nfs4_delegation *dp)
 
 	nfsd4_finalize_deleg_timestamps(dp, nf->nf_file);
 	kernel_setlease(nf->nf_file, F_UNLCK, NULL, (void **)&dp);
+	nfsd_fsnotify_recalc_mask(nf);
 	put_deleg_file(fp);
 }
 
@@ -9747,8 +9748,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
  * @nf: nfsd_file opened on the directory
  *
  * Given a GET_DIR_DELEGATION request @gdd, attempt to acquire a delegation
- * on the directory to which @nf refers. Note that this does not set up any
- * sort of async notifications for the delegation.
+ * on the directory to which @nf refers.
  */
 struct nfs4_delegation *
 nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
@@ -9838,6 +9838,7 @@ nfsd_get_dir_deleg(struct nfsd4_compound_state *cstate,
 
 	if (!status) {
 		put_nfs4_file(fp);
+		nfsd_fsnotify_recalc_mask(nf);
 		return dp;
 	}
 

-- 
2.54.0


