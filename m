Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD10149D9B9
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 05:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbiA0E7o (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 23:59:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:43898 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiA0E7o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 23:59:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 111B0210DE;
        Thu, 27 Jan 2022 04:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643259583; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv39KLywJE4fn+ScVf89K78uppvf03mcFnjKLSGd8UA=;
        b=GHm88u2GcU5z2I50XGC42QpHHBzBdd//C0U8x6pdNrJY5IDuG1vomCVeV4Vuufht4MWJ+8
        VZzij7grbFRoWjh3i7F/iudXVf24PpAujamJf05O7XiJCtQmSwz2BYmVrWuZaAMuIBxzFh
        EGwSaoNHUw205sVOX/sUOwKriAFCJsY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643259583;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nv39KLywJE4fn+ScVf89K78uppvf03mcFnjKLSGd8UA=;
        b=uOXX10nA1yJPK/aeJ/K3m9K0GeNJje5RB8HX9GyxG/twWrPn6Kh6ihyJoCTUMSPJAS84YF
        hEILmjarXCKMhUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3577513BCF;
        Thu, 27 Jan 2022 04:59:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AD2kOL0m8mEwVgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 04:59:41 +0000
Subject: [PATCH 1/4] nfsd: prepare for supporting admin-revocation of state
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 15:58:10 +1100
Message-ID: <164325949068.23133.18090188528073823272.stgit@noble.brown>
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The NFSv4 protocol allows state to be revoked by the admin and has error
codes which allow this to be communicated to the client.

This patch
 - introduces 3 new state-id types for revoked open, lock, and
   delegation state.  This requires the bitmask to be 'short',
   not 'char'
 - reports NFS4ERR_ADMIN_REVOKED when these are accessed
 - introduces a per-client counter of these states and returns
   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero
 - introduces stub code to find all interesting states for a given
   superblock so they can be revoked via the 'unlock_filesystem'
   file in /proc/fs/nfsd/
   No actual states are handled yet.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4layouts.c |    2 +
 fs/nfsd/nfs4state.c   |   79 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/nfsd/nfsctl.c      |    1 +
 fs/nfsd/nfsd.h        |    1 +
 fs/nfsd/state.h       |   26 ++++++++++------
 5 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 6d1b5bb051c5..211cbefa3d80 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -269,7 +269,7 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
 {
 	struct nfs4_layout_stateid *ls;
 	struct nfs4_stid *stid;
-	unsigned char typemask = NFS4_LAYOUT_STID;
+	unsigned short typemask = NFS4_LAYOUT_STID;
 	__be32 status;
 
 	if (create)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 72900b89cf84..ad02b4ebe1b6 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1575,6 +1575,55 @@ static void release_openowner(struct nfs4_openowner *oo)
 	nfs4_put_stateowner(&oo->oo_owner);
 }
 
+static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
+					  struct super_block *sb,
+					  unsigned short sc_types)
+{
+	unsigned long id = 0;
+	struct nfs4_stid *stid;
+
+	spin_lock(&clp->cl_lock);
+	do {
+		id += 1;
+		stid = idr_get_next_ul(&clp->cl_stateids, &id);
+	} while (stid &&
+		 !((stid->sc_type & sc_types) &&
+		   stid->sc_file->fi_inode->i_sb == sb));
+	if (stid)
+		refcount_inc(&stid->sc_count);
+	spin_unlock(&clp->cl_lock);
+	return stid;
+}
+
+void nfsd4_revoke_states(struct net *net, struct super_block *sb)
+{
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	unsigned int idhashval;
+	unsigned short sc_types;
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
@@ -2349,7 +2398,8 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 }
 
 static struct nfs4_stid *
-find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
+find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
+		     unsigned short typemask)
 {
 	struct nfs4_stid *s;
 
@@ -2426,6 +2476,8 @@ static int client_info_show(struct seq_file *m, void *v)
 	}
 	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
 	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
+	seq_printf(m, "admin-revoked states: %d\n",
+		   atomic_read(&clp->cl_admin_revoked));
 	drop_client(clp);
 
 	return 0;
@@ -3907,6 +3959,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 out_no_session:
 	if (conn)
 		free_conn(conn);
@@ -4361,6 +4415,11 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
 		break;
 	case NFS4_REVOKED_DELEG_STID:
 		ret = nfserr_deleg_revoked;
+		break;
+	case NFS4_ADMIN_REVOKED_STID:
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
+		ret = nfserr_admin_revoked;
+		break;
 	}
 	return ret;
 }
@@ -4893,6 +4952,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 			status = nfserr_deleg_revoked;
 		goto out;
 	}
+	if (deleg->dl_stid.sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) {
+		nfs4_put_stid(&deleg->dl_stid);
+		status = nfserr_admin_revoked;
+		goto out;
+	}
 	flags = share_access_to_flags(open->op_share_access);
 	status = nfs4_check_delegmode(deleg, flags);
 	if (status) {
@@ -5840,6 +5904,11 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	case NFS4_REVOKED_DELEG_STID:
 		status = nfserr_deleg_revoked;
 		break;
+	case NFS4_ADMIN_REVOKED_STID:
+	case NFS4_ADMIN_REVOKED_LOCK_STID:
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
+		status = nfserr_admin_revoked;
+		break;
 	case NFS4_OPEN_STID:
 	case NFS4_LOCK_STID:
 		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
@@ -5858,7 +5927,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 __be32
 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid, unsigned short typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn)
 {
 	__be32 status;
@@ -5893,6 +5962,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 			return nfserr_deleg_revoked;
 		return nfserr_bad_stateid;
 	}
+	if (((*s)->sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) && !return_revoked) {
+		nfs4_put_stid(*s);
+		return nfserr_admin_revoked;
+	}
 	return nfs_ok;
 }
 
@@ -6235,7 +6308,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  */
 static __be32
 nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-			 stateid_t *stateid, char typemask,
+			 stateid_t *stateid, unsigned short typemask,
 			 struct nfs4_ol_stateid **stpp,
 			 struct nfsd_net *nn)
 {
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b9f27fbcd768..2576867bdd71 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -323,6 +323,7 @@ static ssize_t write_unlock_fs(struct file *file, char *buf, size_t size)
 	 * 3.  Is that directory the root of an exported file system?
 	 */
 	error = nlmsvc_unlock_all_by_sb(path.dentry->d_sb);
+	nfsd4_revoke_states(netns(file), path.dentry->d_sb);
 
 	path_put(&path);
 	return error;
diff --git a/fs/nfsd/nfsd.h b/fs/nfsd/nfsd.h
index 3e5008b475ff..f9fdd4078956 100644
--- a/fs/nfsd/nfsd.h
+++ b/fs/nfsd/nfsd.h
@@ -249,6 +249,7 @@ void		nfsd_lockd_shutdown(void);
 #define	nfserr_no_grace		cpu_to_be32(NFSERR_NO_GRACE)
 #define	nfserr_reclaim_bad	cpu_to_be32(NFSERR_RECLAIM_BAD)
 #define	nfserr_badname		cpu_to_be32(NFSERR_BADNAME)
+#define	nfserr_admin_revoked	cpu_to_be32(NFS4ERR_ADMIN_REVOKED)
 #define	nfserr_cb_path_down	cpu_to_be32(NFSERR_CB_PATH_DOWN)
 #define	nfserr_locked		cpu_to_be32(NFSERR_LOCKED)
 #define	nfserr_wrongsec		cpu_to_be32(NFSERR_WRONGSEC)
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 95457cfd37fc..8429bfc06216 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -88,17 +88,20 @@ struct nfsd4_callback_ops {
  */
 struct nfs4_stid {
 	refcount_t		sc_count;
-#define NFS4_OPEN_STID 1
-#define NFS4_LOCK_STID 2
-#define NFS4_DELEG_STID 4
+	struct list_head	sc_cp_list;
+	unsigned short		sc_type;
+#define NFS4_OPEN_STID			BIT(0)
+#define NFS4_LOCK_STID			BIT(1)
+#define NFS4_DELEG_STID			BIT(2)
 /* For an open stateid kept around *only* to process close replays: */
-#define NFS4_CLOSED_STID 8
+#define NFS4_CLOSED_STID		BIT(3)
 /* For a deleg stateid kept around only to process free_stateid's: */
-#define NFS4_REVOKED_DELEG_STID 16
-#define NFS4_CLOSED_DELEG_STID 32
-#define NFS4_LAYOUT_STID 64
-	struct list_head	sc_cp_list;
-	unsigned char		sc_type;
+#define NFS4_REVOKED_DELEG_STID		BIT(4)
+#define NFS4_CLOSED_DELEG_STID		BIT(5)
+#define NFS4_LAYOUT_STID		BIT(6)
+#define NFS4_ADMIN_REVOKED_STID		BIT(7)
+#define NFS4_ADMIN_REVOKED_LOCK_STID	BIT(8)
+#define NFS4_ADMIN_REVOKED_DELEG_STID	BIT(9)
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
@@ -330,6 +333,7 @@ struct nfs4_client {
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
 	u32			cl_minorversion;
+	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
@@ -645,7 +649,7 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		stateid_t *stateid, int flags, struct nfsd_file **filp,
 		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid, unsigned short typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
@@ -691,6 +695,8 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
 }
 struct nfsd_file *find_any_file(struct nfs4_file *f);
 
+void nfsd4_revoke_states(struct net *net, struct super_block *sb);
+
 /* grace period management */
 void nfsd4_end_grace(struct nfsd_net *nn);
 


