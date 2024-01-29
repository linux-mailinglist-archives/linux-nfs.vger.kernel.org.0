Return-Path: <linux-nfs+bounces-1528-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95E83FCDE
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C44D01C21E5D
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2371A11CB8;
	Mon, 29 Jan 2024 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DvIN8+SU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qhhhad8a";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DvIN8+SU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qhhhad8a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB911C94
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499491; cv=none; b=Nk6jGyg1qoI3E9Pu8aawmp6rKTBBniKCRtggS3R1cjydbqmFtL8uG8sy+gzFQlX57gMc+fQtarBf4vlp9kqMt9srHsIkt98fdDwRl75p7414Cp9wEFbWSkLqy2TBaetvzu8u4lBQ1CZxq/qufQluxMVcX2zbUXa7gO0Fja6DrLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499491; c=relaxed/simple;
	bh=X5Uf3LmNTI0bC5hkvd13MlkURj15mZ2CKXcQEvRvZlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEVqZ8Pptd2oHDiH13ITBl27s4FT6uiC8pIbGmr1fLXf/y8nvvBPp7OMrpJFDuHd0GOnYohuoqbfndx5G2AUp2J1RI5pFnGtUgKCe8LDNqVnwn2aDkIFSjbuJ9ixDWl9VJ2KZxZNmSz02usPVrtb3HP2T24dtwcxcS5N6v82GqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DvIN8+SU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qhhhad8a; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DvIN8+SU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Qhhhad8a; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C8C331F7C9;
	Mon, 29 Jan 2024 03:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu1Ow1W9OQnqxwN2CThzghDPKP1iC8VJopwG5C3kkEA=;
	b=DvIN8+SUoAKmRWZs0WDLAw6UMdznZqzb2HoQxMaCep9gCv7HuGna09ZcMqjnH8QweTH6/i
	M1ybsu1AE57qIf7abluTt9Ba2d+GsL8aFf8zm9qeUcdhb/wyG9n6fZ/T+53AODBrLZtd3Y
	RMtp6iu/SUVPv+ZsKLoYuqD2LpWNobQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu1Ow1W9OQnqxwN2CThzghDPKP1iC8VJopwG5C3kkEA=;
	b=Qhhhad8al0CvivDp9pSDU2NrEykXrF+P0PTC04R9cuKV44SKUqd1u5VhCZEcg3q9H8bMKw
	kXYUxIE8ux95uWAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu1Ow1W9OQnqxwN2CThzghDPKP1iC8VJopwG5C3kkEA=;
	b=DvIN8+SUoAKmRWZs0WDLAw6UMdznZqzb2HoQxMaCep9gCv7HuGna09ZcMqjnH8QweTH6/i
	M1ybsu1AE57qIf7abluTt9Ba2d+GsL8aFf8zm9qeUcdhb/wyG9n6fZ/T+53AODBrLZtd3Y
	RMtp6iu/SUVPv+ZsKLoYuqD2LpWNobQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu1Ow1W9OQnqxwN2CThzghDPKP1iC8VJopwG5C3kkEA=;
	b=Qhhhad8al0CvivDp9pSDU2NrEykXrF+P0PTC04R9cuKV44SKUqd1u5VhCZEcg3q9H8bMKw
	kXYUxIE8ux95uWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31AC713867;
	Mon, 29 Jan 2024 03:38:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zterNpwdt2VaKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:38:04 +0000
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
Date: Mon, 29 Jan 2024 14:29:35 +1100
Message-ID: <20240129033637.2133-14-neilb@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129033637.2133-1-neilb@suse.de>
References: <20240129033637.2133-1-neilb@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=DvIN8+SU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Qhhhad8a
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
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
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: C8C331F7C9
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
index e749d5c0e23a..268b47a6f3b6 100644
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


