Return-Path: <linux-nfs+bounces-1595-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D47A841830
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 02:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD5D1B229E6
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jan 2024 01:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3682E40C;
	Tue, 30 Jan 2024 01:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G3/VuvMg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wBJUwFCS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G3/VuvMg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wBJUwFCS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D56E22083
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jan 2024 01:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706577160; cv=none; b=Y1BrdMEK00J7JyquOandSS1YwQNBx66J+YuZNWPsKBjvNAnYRTNEyEQGQ4WZOTXStdkiEKMrOKIDuHNEczLcdexQ/t6MOrfGp38CmOXdNh1Z98tSRfM4u2jm5SN1UBEoLEugr3+kkmjjvofmRcX1pm4FNZSRMX8ZzFe+YOFfUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706577160; c=relaxed/simple;
	bh=M1NBEqCESJHMQc4NDUC5lUg7MRLE3pqSOaKHYe5OQvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=esjlY/XAG/x9OzmnoxHanbd+dc+9a1pZK782FNBeAaYHAAbjKt10au0nBPevPrJ6oZtVj+qGk5cxi7MHzHmDPErodT93C29EWQi//aHaKF8hkirIHOsG/s8xO38WVpxShicv3fFNtU2clm0/Cqy3iFFTI5gdqELYQ6DRxUA7v8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G3/VuvMg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wBJUwFCS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G3/VuvMg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wBJUwFCS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8F8D1F80F;
	Tue, 30 Jan 2024 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZKXpkDBJB28dQZpV9p5BJv52DV8Hv4R40lpJeiLNzc=;
	b=G3/VuvMgT46EJQM8IidA881ZzC9qtsNrAtGwrz4jNHWI6lQ5+IJ+gj1sjwnPV4LbVuUIVh
	b1f471AME6JpLjYIwsgb5hbotv2o5WvsX/JYB3PQd/qMBxlMa/lU3WdxlnyyPSoSqKgAU4
	x85CMMnYcazULBJXYk36jIqfSFt5CC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZKXpkDBJB28dQZpV9p5BJv52DV8Hv4R40lpJeiLNzc=;
	b=wBJUwFCS+Lg5A27xl1pGGg5sRZf6YK3VQxdhGXsuRYnTO6R71qrXRmM2wpNx0JO9kvXWZ5
	MWUwb52hzkDfsHDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706577156; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZKXpkDBJB28dQZpV9p5BJv52DV8Hv4R40lpJeiLNzc=;
	b=G3/VuvMgT46EJQM8IidA881ZzC9qtsNrAtGwrz4jNHWI6lQ5+IJ+gj1sjwnPV4LbVuUIVh
	b1f471AME6JpLjYIwsgb5hbotv2o5WvsX/JYB3PQd/qMBxlMa/lU3WdxlnyyPSoSqKgAU4
	x85CMMnYcazULBJXYk36jIqfSFt5CC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706577156;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZKXpkDBJB28dQZpV9p5BJv52DV8Hv4R40lpJeiLNzc=;
	b=wBJUwFCS+Lg5A27xl1pGGg5sRZf6YK3VQxdhGXsuRYnTO6R71qrXRmM2wpNx0JO9kvXWZ5
	MWUwb52hzkDfsHDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A27012FF7;
	Tue, 30 Jan 2024 01:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bLnPMAFNuGX2QAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 30 Jan 2024 01:12:33 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 13/13] nfsd: allow layout state to be admin-revoked.
Date: Tue, 30 Jan 2024 12:08:33 +1100
Message-ID: <20240130011102.8623-14-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130011102.8623-1-neilb@suse.de>
References: <20240130011102.8623-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="G3/VuvMg";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wBJUwFCS
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.51
X-Rspamd-Queue-Id: B8F8D1F80F
X-Spam-Flag: NO

When there is layout state on a filesystem that is being "unlocked" that
is now revoked, which involves closing the nfsd_file and releasing the
vfs lease.

To avoid races, ->ls_file can now be accessed either:
 - under ->fi_lock for the state's sc_file or
 - under rcu_read_lock() if nfsd_file_get() is used.
To support this, ->fence_client and nfsd4_cb_layout_fail() now take a
second argument being the nfsd_file.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/blocklayout.c |  4 ++--
 fs/nfsd/nfs4layouts.c | 43 ++++++++++++++++++++++++++++++++-----------
 fs/nfsd/nfs4state.c   | 11 +++++++++--
 fs/nfsd/pnfs.h        |  8 +++++++-
 4 files changed, 50 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 46fd74d91ea9..3c040c81c77d 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -328,10 +328,10 @@ nfsd4_scsi_proc_layoutcommit(struct inode *inode,
 }
 
 static void
-nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls)
+nfsd4_scsi_fence_client(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
-	struct block_device *bdev = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_bdev;
+	struct block_device *bdev = file->nf_file->f_path.mnt->mnt_sb->s_bdev;
 
 	bdev->bd_disk->fops->pr_ops->pr_preempt(bdev, NFSD_MDS_PR_KEY,
 			nfsd4_scsi_pr_key(clp), 0, true);
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 857b822450b4..1cfd61db2472 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -152,6 +152,23 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 #endif
 }
 
+void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
+{
+	struct nfsd_file *fl;
+
+	spin_lock(&ls->ls_stid.sc_file->fi_lock);
+	fl = ls->ls_file;
+	ls->ls_file = NULL;
+	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
+
+	if (fl) {
+		if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
+			vfs_setlease(fl->nf_file, F_UNLCK, NULL,
+				     (void **)&ls);
+		nfsd_file_put(fl);
+	}
+}
+
 static void
 nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 {
@@ -169,9 +186,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	list_del_init(&ls->ls_perfile);
 	spin_unlock(&fp->fi_lock);
 
-	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
-	nfsd_file_put(ls->ls_file);
+	nfsd4_close_layout(ls);
 
 	if (ls->ls_recalled)
 		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
@@ -605,7 +620,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *clp, struct nfs4_file *fp)
 }
 
 static void
-nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
+nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	char addr_str[INET6_ADDRSTRLEN];
@@ -627,7 +642,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
 
 	argv[0] = (char *)nfsd_recall_failed;
 	argv[1] = addr_str;
-	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
+	argv[2] = file->nf_file->f_path.mnt->mnt_sb->s_id;
 	argv[3] = NULL;
 
 	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
@@ -657,6 +672,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 	struct nfsd_net *nn;
 	ktime_t now, cutoff;
 	const struct nfsd4_layout_ops *ops;
+	struct nfsd_file *fl;
 
 	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
 	switch (task->tk_status) {
@@ -688,12 +704,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 		 * Unknown error or non-responding client, we'll need to fence.
 		 */
 		trace_nfsd_layout_recall_fail(&ls->ls_stid.sc_stateid);
-
-		ops = nfsd4_layout_ops[ls->ls_layout_type];
-		if (ops->fence_client)
-			ops->fence_client(ls);
-		else
-			nfsd4_cb_layout_fail(ls);
+		rcu_read_lock();
+		fl = nfsd_file_get(ls->ls_file);
+		rcu_read_unlock();
+		if (fl) {
+			ops = nfsd4_layout_ops[ls->ls_layout_type];
+			if (ops->fence_client)
+				ops->fence_client(ls, fl);
+			else
+				nfsd4_cb_layout_fail(ls, fl);
+			nfsd_file_put(fl);
+		}
 		return 1;
 	case -NFS4ERR_NOMATCHING_LAYOUT:
 		trace_nfsd_layout_recall_done(&ls->ls_stid.sc_stateid);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index fe21af8dfc68..a66d66b9f769 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1721,7 +1721,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG;
+	sc_types = SC_TYPE_OPEN | SC_TYPE_LOCK | SC_TYPE_DELEG | SC_TYPE_LAYOUT;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1734,6 +1734,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
 				struct nfs4_delegation *dp;
+				struct nfs4_layout_stateid *ls;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1789,6 +1790,10 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 					if (dp)
 						revoke_delegation(dp);
 					break;
+				case SC_TYPE_LAYOUT:
+					ls = layoutstateid(stid);
+					nfsd4_close_layout(ls);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -2868,7 +2873,6 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	struct nfsd_file *file;
 
 	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
-	file = ls->ls_file;
 
 	seq_puts(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
@@ -2876,12 +2880,15 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 
 	/* XXX: What else would be useful? */
 
+	spin_lock(&ls->ls_stid.sc_file->fi_lock);
+	file = ls->ls_file;
 	if (file) {
 		seq_puts(s, ", ");
 		nfs4_show_superblock(s, file);
 		seq_puts(s, ", ");
 		nfs4_show_fname(s, file);
 	}
+	spin_unlock(&ls->ls_stid.sc_file->fi_lock);
 	if (st->sc_status & SC_STATUS_ADMIN_REVOKED)
 		seq_puts(s, ", admin-revoked");
 	seq_puts(s, " }\n");
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index de1e0dfed06a..925817f66917 100644
--- a/fs/nfsd/pnfs.h
+++ b/fs/nfsd/pnfs.h
@@ -37,7 +37,8 @@ struct nfsd4_layout_ops {
 	__be32 (*proc_layoutcommit)(struct inode *inode,
 			struct nfsd4_layoutcommit *lcp);
 
-	void (*fence_client)(struct nfs4_layout_stateid *ls);
+	void (*fence_client)(struct nfs4_layout_stateid *ls,
+			     struct nfsd_file *file);
 };
 
 extern const struct nfsd4_layout_ops *nfsd4_layout_ops[];
@@ -72,11 +73,13 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
 void nfsd4_return_all_client_layouts(struct nfs4_client *);
 void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
 		struct nfs4_file *fp);
+void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
 int nfsd4_init_pnfs(void);
 void nfsd4_exit_pnfs(void);
 #else
 struct nfs4_client;
 struct nfs4_file;
+struct nfs4_layout_stateid;
 
 static inline void nfsd4_setup_layout_type(struct svc_export *exp)
 {
@@ -89,6 +92,9 @@ static inline void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
 		struct nfs4_file *fp)
 {
 }
+static inline void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
+{
+}
 static inline void nfsd4_exit_pnfs(void)
 {
 }
-- 
2.43.0


