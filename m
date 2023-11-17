Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE577EEAFE
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjKQCWE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCWD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:22:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE891A7
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:21:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7A43C22929;
        Fri, 17 Nov 2023 02:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187718; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYccEyqrgoyCDKwp7ax/MAqJlg9nEWj3foGqRoejbuI=;
        b=aVje2Qlj5VK3AsuzlaLPZbtFTXzv47IWoclw+KjVTfUtzSSAGYPAydiZHW3vVfX4yj4hmf
        LrJISWXWaIdWVMn+uZXQBmkoFFw1Ji35R12y5jKGUVoHxwoCGTIvB2imnrwMSqwPWjwhOH
        sx6iCIiqfOavOjYvTqkhiz+6h5DMTZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187718;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KYccEyqrgoyCDKwp7ax/MAqJlg9nEWj3foGqRoejbuI=;
        b=pVFUXssjXl/2zk8G8FrqxZ6q3RopdB3cT74xFI2aiywquFff6d1LTvZM8gr4SOaKGlVRUk
        LqeqWex2tGDF9gDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 695B51341F;
        Fri, 17 Nov 2023 02:21:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uY1+CETOVmU3EwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:21:56 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/9] nfsd: prepare for supporting admin-revocation of state
Date:   Fri, 17 Nov 2023 13:18:50 +1100
Message-ID: <20231117022121.23310-5-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117022121.23310-1-neilb@suse.de>
References: <20231117022121.23310-1-neilb@suse.de>
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
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.20)[-0.999];
         MID_CONTAINS_FROM(1.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4 protocol allows state to be revoked by the admin and has error
codes which allow this to be communicated to the client.

This patch
 - introduces a new state-id status NFS4_STID_ADMIN_REVOKE
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
 fs/nfsd/nfs4state.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/nfsctl.c    |  1 +
 fs/nfsd/nfsd.h      |  1 +
 fs/nfsd/state.h     | 10 +++++++
 fs/nfsd/trace.h     |  3 +-
 5 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b1fdd0ee0f5c..a2b3320a6ba8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1215,6 +1215,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
+		atomic_dec(&s->sc_client->cl_admin_revoked);
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
@@ -1534,6 +1536,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
 	}
 
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
+		atomic_dec(&s->sc_client->cl_admin_revoked);
 	list_add(&stp->st_locks, reaplist);
 }
 
@@ -1679,6 +1683,54 @@ static void release_openowner(struct nfs4_openowner *oo)
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
@@ -2550,6 +2602,8 @@ static int client_info_show(struct seq_file *m, void *v)
 	}
 	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
 	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
+	seq_printf(m, "admin-revoked states: %d\n",
+		   atomic_read(&clp->cl_admin_revoked));
 	drop_client(clp);
 
 	return 0;
@@ -4109,6 +4163,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 out_no_session:
 	if (conn)
 		free_conn(conn);
@@ -4598,7 +4654,9 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
 	__be32 ret = nfs_ok;
 
-	if (s->sc_status & NFS4_STID_REVOKED)
+	if (s->sc_status & NFS4_STID_ADMIN_REVOKED)
+		ret = nfserr_admin_revoked;
+	else if (s->sc_status & NFS4_STID_REVOKED)
 		ret = nfserr_deleg_revoked;
 	else if (s->sc_status & NFS4_STID_CLOSED)
 		ret = nfserr_bad_stateid;
@@ -5189,6 +5247,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
 	if (deleg == NULL)
 		goto out;
+	if (deleg->dl_stid.sc_status & NFS4_STID_ADMIN_REVOKED) {
+		nfs4_put_stid(&deleg->dl_stid);
+		status = nfserr_admin_revoked;
+		goto out;
+	}
 	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
 		status = nfserr_deleg_revoked;
@@ -6509,6 +6572,8 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		 */
 		statusmask |= NFS4_STID_REVOKED;
 
+	statusmask |= NFS4_STID_ADMIN_REVOKED;
+
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
@@ -6527,6 +6592,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		nfs4_put_stid(stid);
 		return nfserr_deleg_revoked;
 	}
+	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
+		nfs4_put_stid(stid);
+		return nfserr_admin_revoked;
+	}
 	*s = stid;
 	return nfs_ok;
 }
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 739ed5bf71cd..50368eec86b0 100644
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
index f5ff42f41ee7..d46203eac3c8 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -280,6 +280,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
 #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
 #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
+#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
 #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
 #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 22f9eb3986d2..18bc2889136c 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -112,6 +112,7 @@ struct nfs4_stid {
 #define NFS4_STID_CLOSED	BIT(0)
 /* For a deleg stateid kept around only to process free_stateid's: */
 #define NFS4_STID_REVOKED	BIT(1)
+#define NFS4_STID_ADMIN_REVOKED	BIT(2)
 	unsigned short		sc_status;
 
 	struct list_head	sc_cp_list;
@@ -388,6 +389,7 @@ struct nfs4_client {
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
 	u32			cl_minorversion;
+	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
@@ -752,6 +754,14 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
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
index 54d82e14d724..d0274d203f99 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -651,7 +651,8 @@ DEFINE_STATESEQID_EVENT(open_confirm);
 #define show_stid_status(x)						\
 	__print_flags(x, "|",						\
 		{ NFS4_STID_CLOSED,		"CLOSED" },		\
-		{ NFS4_STID_REVOKED,		"REVOKED" })		\
+		{ NFS4_STID_REVOKED,		"REVOKED" },		\
+		{ NFS4_STID_ADMIN_REVOKED,	"ADMIN_REVOKED" })
 
 DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_PROTO(
-- 
2.42.0

