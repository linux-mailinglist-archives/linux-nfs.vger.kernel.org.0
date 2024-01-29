Return-Path: <linux-nfs+bounces-1521-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17683FCD7
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5561F2284C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFC91095C;
	Mon, 29 Jan 2024 03:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlCToQMB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X8IqdTeK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NlCToQMB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="X8IqdTeK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BBB10949
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499449; cv=none; b=ptgqi5ToPT96BzLEApWH7eeFvD+BJFBpM5PmjYd8wRB1Hx9bvDzWev1oIlaImhHMmmwCmLYpTFLmS1PYgWMvwJ4zmKXRKTiSa6fbmwNLXqhcbFfYqDcKjf6gS1lA5tdORRELNa6Ffm0xv0IX2n/aFwtycYggtlJlsna6rDqWOC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499449; c=relaxed/simple;
	bh=5Raj01q2xG76WQjgjha7KEPTTKLrav8HLwdgkmp0gQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fm3jqluOJOqtWjnI2j8iXaEZD/5jB6IjT72VRYRUqOuqZiYM2oEKdog7r7qyeqSpD/dVU6X2udJSDW9j861ulJNs9fHoV5Tlr+ZIDrtU7mr/Qu7aoszdoCmSGTVnZT9IgPqgsBkWHLft76xX8vqJLLevlNXh6QIIWjEsFByXW5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlCToQMB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X8IqdTeK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NlCToQMB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=X8IqdTeK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6916F2229C;
	Mon, 29 Jan 2024 03:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGsE1c3ANNAAYxs5yMiloRAS4+ziETOlkp5oePTRPTM=;
	b=NlCToQMBbUq6rz9spvF8842MqrLKjDOx4Q+kmpwpDqllEJWUfk3YL4d6e0VWMThSjtPuH6
	pvdVtmrRyWnJBTFoVCYGAHM66Iia7moLs4ps/j0+w34oC7COYYDhLrVooSstY5DcxWgiWJ
	yFMga9lmhkpcHBiItfi5koxREghAKog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGsE1c3ANNAAYxs5yMiloRAS4+ziETOlkp5oePTRPTM=;
	b=X8IqdTeKLjg6dN1zTa11TQ8fr3AaC+Au57mcMptgdHePzSpvs+U1xcDiKbSbhXltGJ1QqW
	7Ss7xJS8K+0S8oBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGsE1c3ANNAAYxs5yMiloRAS4+ziETOlkp5oePTRPTM=;
	b=NlCToQMBbUq6rz9spvF8842MqrLKjDOx4Q+kmpwpDqllEJWUfk3YL4d6e0VWMThSjtPuH6
	pvdVtmrRyWnJBTFoVCYGAHM66Iia7moLs4ps/j0+w34oC7COYYDhLrVooSstY5DcxWgiWJ
	yFMga9lmhkpcHBiItfi5koxREghAKog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wGsE1c3ANNAAYxs5yMiloRAS4+ziETOlkp5oePTRPTM=;
	b=X8IqdTeKLjg6dN1zTa11TQ8fr3AaC+Au57mcMptgdHePzSpvs+U1xcDiKbSbhXltGJ1QqW
	7Ss7xJS8K+0S8oBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8170113867;
	Mon, 29 Jan 2024 03:37:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I1V3DnMdt2UuKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:23 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 06/13] nfsd: prepare for supporting admin-revocation of state
Date: Mon, 29 Jan 2024 14:29:28 +1100
Message-ID: <20240129033637.2133-7-neilb@suse.de>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The NFSv4 protocol allows state to be revoked by the admin and has error
codes which allow this to be communicated to the client.

This patch
 - introduces a new state-id status SC_STATUS_ADMIN_REVOKED
   which can be set on open, lock, or delegation state.
 - reports NFS4ERR_ADMIN_REVOKED when these are accessed
 - introduces a per-client counter of these states and returns
   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
   Decrements this when freeing any admin-revoked state.
 - introduces stub code to find all interesting states for a given
   superblock so they can be revoked via the 'unlock_filesystem'
   file in /proc/fs/nfsd/
   No actual states are handled yet.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 85 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsctl.c    |  1 +
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 10 ++++++
 fs/nfsd/trace.h     |  3 +-
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6bccdd0af814..8db224906864 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1210,6 +1210,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
+		atomic_dec(&s->sc_client->cl_admin_revoked);
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
@@ -1529,6 +1531,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
 	}
 
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
+		atomic_dec(&s->sc_client->cl_admin_revoked);
 	list_add(&stp->st_locks, reaplist);
 }
 
@@ -1674,6 +1678,68 @@ static void release_openowner(struct nfs4_openowner *oo)
 	nfs4_put_stateowner(&oo->oo_owner);
 }
 
+static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
+					  struct super_block *sb,
+					  unsigned int sc_types)
+{
+	unsigned long id, tmp;
+	struct nfs4_stid *stid;
+
+	spin_lock(&clp->cl_lock);
+	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+		if ((stid->sc_type & sc_types) &&
+		    stid->sc_status == 0 &&
+		    stid->sc_file->fi_inode->i_sb == sb) {
+			refcount_inc(&stid->sc_count);
+			break;
+		}
+	spin_unlock(&clp->cl_lock);
+	return stid;
+}
+
+/**
+ * nfsd4_revoke_states - revoke all nfsv4 states associated with given filesystem
+ * @net - used to identify instance of nfsd (there is one per net namespace)
+ * @sb - super_block used to identify target filesystem
+ *
+ * All nfs4 states (open, lock, delegation, layout) held by the server instance
+ * and associated with a file on the given filesystem will be revoked resulting
+ * in any files being closed and so all references from nfsd to the filesystem
+ * being released.  Thus nfsd will no longer prevent the filesystem from being
+ * unmounted.
+ *
+ * The clients which own the states will subsequently being notified that the
+ * states have been "admin-revoked".
+ */
+void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	unsigned int idhashval;
+	unsigned int sc_types;
+
+	sc_types = 0;
+
+	spin_lock(&nn->client_lock);
+	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
+		struct list_head *head = &nn->conf_id_hashtbl[idhashval];
+		struct nfs4_client *clp;
+	retry:
+		list_for_each_entry(clp, head, cl_idhash) {
+			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
+								  sc_types);
+			if (stid) {
+				spin_unlock(&nn->client_lock);
+				switch (stid->sc_type) {
+				}
+				nfs4_put_stid(stid);
+				spin_lock(&nn->client_lock);
+				goto retry;
+			}
+		}
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static inline int
 hash_sessionid(struct nfs4_sessionid *sessionid)
 {
@@ -2545,6 +2611,8 @@ static int client_info_show(struct seq_file *m, void *v)
 	}
 	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
 	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
+	seq_printf(m, "admin-revoked states: %d\n",
+		   atomic_read(&clp->cl_admin_revoked));
 	drop_client(clp);
 
 	return 0;
@@ -4058,6 +4126,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 out_no_session:
 	if (conn)
 		free_conn(conn);
@@ -4546,7 +4616,9 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
 	__be32 ret = nfs_ok;
 
-	if (s->sc_status & SC_STATUS_REVOKED)
+	if (s->sc_status & SC_STATUS_ADMIN_REVOKED)
+		ret = nfserr_admin_revoked;
+	else if (s->sc_status & SC_STATUS_REVOKED)
 		ret = nfserr_deleg_revoked;
 	else if (s->sc_status & SC_STATUS_CLOSED)
 		ret = nfserr_bad_stateid;
@@ -5137,6 +5209,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
 	if (deleg == NULL)
 		goto out;
+	if (deleg->dl_stid.sc_status & SC_STATUS_ADMIN_REVOKED) {
+		nfs4_put_stid(&deleg->dl_stid);
+		status = nfserr_admin_revoked;
+		goto out;
+	}
 	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
 		status = nfserr_deleg_revoked;
@@ -6443,6 +6520,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		 */
 		statusmask |= SC_STATUS_REVOKED;
 
+	statusmask |= SC_STATUS_ADMIN_REVOKED;
+
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
@@ -6461,6 +6540,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		nfs4_put_stid(stid);
 		return nfserr_deleg_revoked;
 	}
+	if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
+		nfs4_put_stid(stid);
+		return nfserr_admin_revoked;
+	}
 	*s = stid;
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f206ca32e7f5..4bae65e8d28a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -281,6 +281,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 3.  Is that directory the root of an exported file system?
 	 */
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
 
 	path_put(&path);
 	return error;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 304e9728b929..9a86fe8a39ef 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -274,6 +274,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
 #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
 #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
+#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
 #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
 #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index ffc8920d0558..7fa83265ad9a 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -112,6 +112,7 @@ struct nfs4_stid {
 #define SC_STATUS_CLOSED	BIT(0)
 /* For a deleg stateid kept around only to process free_stateid's: */
 #define SC_STATUS_REVOKED	BIT(1)
+#define SC_STATUS_ADMIN_REVOKED	BIT(2)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
@@ -367,6 +368,7 @@ struct nfs4_client {
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
 	u32			cl_minorversion;
+	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
@@ -730,6 +732,14 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 }
 struct nfsd_file *find_any_file(struct nfs4_file *f);
 
+#ifdef CONFIG_NFSD_V4
+void nfsd4_revoke_states(struct net *net, struct super_block *sb);
+#else
+static inline void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+{
+}
+#endif
+
 /* grace period management */
 void nfsd4_end_grace(struct nfsd_net *nn);
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fe08ca18b647..5c58da9f86b7 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -651,7 +651,8 @@ DEFINE_STATESEQID_EVENT(open_confirm);
 #define show_stid_status(x)						\
 	__print_flags(x, "|",						\
 		{ SC_STATUS_CLOSED,		"CLOSED" },		\
-		{ SC_STATUS_REVOKED,		"REVOKED" })		\
+		{ SC_STATUS_REVOKED,		"REVOKED" },		\
+		{ SC_STATUS_ADMIN_REVOKED,	"ADMIN_REVOKED" })
 
 DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_PROTO(
-- 
2.43.0


