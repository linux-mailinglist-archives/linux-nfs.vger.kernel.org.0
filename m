Return-Path: <linux-nfs+bounces-62-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877BD7F6B67
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39158281649
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D2139D;
	Fri, 24 Nov 2023 04:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412F10E0
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:33:13 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8A425BE86;
	Fri, 24 Nov 2023 00:30:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 909DA1340B;
	Fri, 24 Nov 2023 00:30:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i1d3EbjuX2WNegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:30:48 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 11/11] nfsd: allow layout state to be admin-revoked.
Date: Fri, 24 Nov 2023 11:23:23 +1100
Message-ID: <20231124002504.19515-12-neilb@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124002504.19515-1-neilb@suse.de>
References: <20231124002504.19515-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.66
X-Rspamd-Server: rspamd1
X-Spam-Level: *
X-Rspamd-Queue-Id: B8A425BE86
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:97 is neither permitted nor denied by domain of neilb@suse.de) smtp.mailfrom=neilb@suse.de
X-Spamd-Result: default: False [8.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.13)[-0.674];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

When there is layout state on a filesystem that is being "unlocked" that
is now revoked, which involves closing the nfsd_file and releasing the
vfs lease.

To avoid races, all users of ->ls_file - after the layout state has been
successfully created - now need to take a counted reference under
rcu_read_lock().  To support this, ->fence_client and
nfsd4_cb_layout_fail() now take a second argument being the nfsd_file.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/blocklayout.c |  4 ++--
 fs/nfsd/nfs4layouts.c | 38 +++++++++++++++++++++++++++-----------
 fs/nfsd/nfs4state.c   | 26 ++++++++++++++++++++------
 fs/nfsd/pnfs.h        |  7 ++++++-
 4 files changed, 55 insertions(+), 20 deletions(-)

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
index 77656126ad2a..dbc52413ce57 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -152,6 +152,18 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 #endif
 }
 
+void nfsd4_close_layout(struct nfs4_layout_stateid *ls)
+{
+	struct nfsd_file *fl = xchg(&ls->ls_file, NULL);
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
@@ -169,9 +181,7 @@ nfsd4_free_layout_stateid(struct nfs4_stid *stid)
 	list_del_init(&ls->ls_perfile);
 	spin_unlock(&fp->fi_lock);
 
-	if (!nfsd4_layout_ops[ls->ls_layout_type]->disable_recalls)
-		vfs_setlease(ls->ls_file->nf_file, F_UNLCK, NULL, (void **)&ls);
-	nfsd_file_put(ls->ls_file);
+	nfsd4_close_layout(ls);
 
 	if (ls->ls_recalled)
 		atomic_dec(&ls->ls_stid.sc_file->fi_lo_recalls);
@@ -605,7 +615,7 @@ nfsd4_return_all_file_layouts(struct nfs4_client *clp, struct nfs4_file *fp)
 }
 
 static void
-nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
+nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls, struct nfsd_file *file)
 {
 	struct nfs4_client *clp = ls->ls_stid.sc_client;
 	char addr_str[INET6_ADDRSTRLEN];
@@ -627,7 +637,7 @@ nfsd4_cb_layout_fail(struct nfs4_layout_stateid *ls)
 
 	argv[0] = (char *)nfsd_recall_failed;
 	argv[1] = addr_str;
-	argv[2] = ls->ls_file->nf_file->f_path.mnt->mnt_sb->s_id;
+	argv[2] = file->nf_file->f_path.mnt->mnt_sb->s_id;
 	argv[3] = NULL;
 
 	error = call_usermodehelper(nfsd_recall_failed, argv, envp,
@@ -657,6 +667,7 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
 	struct nfsd_net *nn;
 	ktime_t now, cutoff;
 	const struct nfsd4_layout_ops *ops;
+	struct nfsd_file *fl;
 
 	trace_nfsd_cb_layout_done(&ls->ls_stid.sc_stateid, task);
 	switch (task->tk_status) {
@@ -688,12 +699,17 @@ nfsd4_cb_layout_done(struct nfsd4_callback *cb, struct rpc_task *task)
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
index 3d85c88ec4d7..560d246f6e02 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1712,7 +1712,8 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
+	sc_types = (NFS4_OPEN_STID | NFS4_LOCK_STID |
+		    NFS4_DELEG_STID | NFS4_LAYOUT_STID);
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1725,6 +1726,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
 				struct nfs4_delegation *dp;
+				struct nfs4_layout_stateid *ls;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1780,6 +1782,10 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 					if (dp)
 						revoke_delegation(dp);
 					break;
+				case NFS4_LAYOUT_STID:
+					ls = layoutstateid(stid);
+					nfsd4_close_layout(ls);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -2859,17 +2865,25 @@ static int nfs4_show_layout(struct seq_file *s, struct nfs4_stid *st)
 	struct nfsd_file *file;
 
 	ls = container_of(st, struct nfs4_layout_stateid, ls_stid);
-	file = ls->ls_file;
+	rcu_read_lock();
+	file = nfsd_file_get(ls->ls_file);
+	rcu_read_unlock();
 
 	seq_printf(s, "- ");
 	nfs4_show_stateid(s, &st->sc_stateid);
-	seq_printf(s, ": { type: layout, ");
+	seq_printf(s, ": { type: layout");
 
 	/* XXX: What else would be useful? */
 
-	nfs4_show_superblock(s, file);
-	seq_printf(s, ", ");
-	nfs4_show_fname(s, file);
+	if (file) {
+		seq_printf(s, ", ");
+		nfs4_show_superblock(s, file);
+		seq_printf(s, ", ");
+		nfs4_show_fname(s, file);
+		nfsd_file_put(file);
+	}
+	if (st->sc_status & NFS4_STID_ADMIN_REVOKED)
+		seq_puts(s, ", admin-revoked");
 	seq_printf(s, " }\n");
 
 	return 0;
diff --git a/fs/nfsd/pnfs.h b/fs/nfsd/pnfs.h
index de1e0dfed06a..f2777577865e 100644
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
@@ -72,6 +73,7 @@ void nfsd4_setup_layout_type(struct svc_export *exp);
 void nfsd4_return_all_client_layouts(struct nfs4_client *);
 void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
 		struct nfs4_file *fp);
+void nfsd4_close_layout(struct nfs4_layout_stateid *ls);
 int nfsd4_init_pnfs(void);
 void nfsd4_exit_pnfs(void);
 #else
@@ -89,6 +91,9 @@ static inline void nfsd4_return_all_file_layouts(struct nfs4_client *clp,
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
2.42.1


