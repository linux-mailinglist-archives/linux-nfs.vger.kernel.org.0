Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA97DDA74
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 02:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbjKABBK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 21:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbjKABBK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 21:01:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD04C9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 18:01:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 673BC1F45A;
        Wed,  1 Nov 2023 01:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698800463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXysBykSeW30chslpMH7j83afeQvJFFuwO8aP8ilkkM=;
        b=Bpx7YrfR0GstyTnA9Syy4Gw7e5QEjekY3mx7aco+01z26dkwE7JshTXrZs2knzQhvqCYxV
        xCT2asItVeEeJRC3jJUh3VlKVFkjQ4HKl9IJPZ4biw0gMDt/ohybI3tabEnVyM0TsRdSu1
        nCT8uOq1p3azbleWHb9rdJps+TvspNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698800463;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXysBykSeW30chslpMH7j83afeQvJFFuwO8aP8ilkkM=;
        b=JS06m/IXXbnUudeaMaWT3iVwS/7bvgZXMaECygr88luKPDTf7cLdi/FhgJGXuExiUbCw9D
        GsCzaey2/Ch2bJCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 64B6A138EF;
        Wed,  1 Nov 2023 01:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hwC0B02jQWX1OgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 01:01:01 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/6] nfsd: prepare for supporting admin-revocation of state
Date:   Wed,  1 Nov 2023 11:57:08 +1100
Message-ID: <20231101010049.27315-2-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231101010049.27315-1-neilb@suse.de>
References: <20231101010049.27315-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 - introduces 3 new state-id types for revoked open, lock, and
   delegation state.  This requires the bitmask to be 'short',
   not 'char'
 - reports NFS4ERR_ADMIN_REVOKED when these are accessed
 - introduces a per-client counter of these states and returns
   SEQ4_STATUS_ADMIN_STATE_REVOKED when the counter is not zero.
   Decrement this when freeing any admin-revoked state.
 - introduces stub code to find all interesting states for a given
   superblock so they can be revoked via the 'unlock_filesystem'
   file in /proc/fs/nfsd/
   No actual states are handled yet.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4layouts.c |  2 +-
 fs/nfsd/nfs4state.c   | 93 +++++++++++++++++++++++++++++++++++++++----
 fs/nfsd/nfsctl.c      |  1 +
 fs/nfsd/nfsd.h        |  1 +
 fs/nfsd/state.h       | 35 +++++++++++-----
 fs/nfsd/trace.h       |  8 +++-
 6 files changed, 120 insertions(+), 20 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..09d0363bfbc4 100644
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
index 65fd5510323a..f3ba53a16105 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1202,6 +1202,13 @@ alloc_init_deleg(struct nfs4_client *clp, struct nfs4_file *fp,
 	return NULL;
 }
 
+void nfs4_unhash_stid(struct nfs4_stid *s)
+{
+	if (s->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS)
+		atomic_dec(&s->sc_client->cl_admin_revoked);
+	s->sc_type = 0;
+}
+
 void
 nfs4_put_stid(struct nfs4_stid *s)
 {
@@ -1215,6 +1222,7 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	nfs4_unhash_stid(s);
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
@@ -1265,11 +1273,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
 	nfs4_put_stid(&dp->dl_stid);
 }
 
-void nfs4_unhash_stid(struct nfs4_stid *s)
-{
-	s->sc_type = 0;
-}
-
 /**
  * nfs4_delegation_exists - Discover if this delegation already exists
  * @clp:     a pointer to the nfs4_client we're granting a delegation to
@@ -1536,6 +1539,7 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
 	}
 
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	nfs4_unhash_stid(s);
 	list_add(&stp->st_locks, reaplist);
 }
 
@@ -1680,6 +1684,53 @@ static void release_openowner(struct nfs4_openowner *oo)
 	nfs4_put_stateowner(&oo->oo_owner);
 }
 
+static struct nfs4_stid *find_one_sb_stid(struct nfs4_client *clp,
+					  struct super_block *sb,
+					  unsigned short sc_types)
+{
+	unsigned long id, tmp;
+	struct nfs4_stid *stid;
+
+	spin_lock(&clp->cl_lock);
+	idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+		if ((stid->sc_type & sc_types) &&
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
@@ -2465,7 +2516,8 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 }
 
 static struct nfs4_stid *
-find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
+find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
+		     unsigned short typemask)
 {
 	struct nfs4_stid *s;
 
@@ -2549,6 +2601,8 @@ static int client_info_show(struct seq_file *m, void *v)
 	}
 	seq_printf(m, "callback state: %s\n", cb_state2str(clp->cl_cb_state));
 	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
+	seq_printf(m, "admin-revoked states: %d\n",
+		   atomic_read(&clp->cl_admin_revoked));
 	drop_client(clp);
 
 	return 0;
@@ -4108,6 +4162,8 @@ nfsd4_sequence(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	}
 	if (!list_empty(&clp->cl_revoked))
 		seq->status_flags |= SEQ4_STATUS_RECALLABLE_STATE_REVOKED;
+	if (atomic_read(&clp->cl_admin_revoked))
+		seq->status_flags |= SEQ4_STATUS_ADMIN_STATE_REVOKED;
 out_no_session:
 	if (conn)
 		free_conn(conn);
@@ -5200,6 +5256,11 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
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
@@ -6478,6 +6539,11 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
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
@@ -6496,7 +6562,7 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 __be32
 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid, unsigned short typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn)
 {
 	__be32 status;
@@ -6512,6 +6578,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	else if (typemask & NFS4_DELEG_STID)
 		typemask |= NFS4_REVOKED_DELEG_STID;
 
+	if (typemask & NFS4_OPEN_STID)
+		typemask |= NFS4_ADMIN_REVOKED_STID;
+	if (typemask & NFS4_LOCK_STID)
+		typemask |= NFS4_ADMIN_REVOKED_LOCK_STID;
+	if (typemask & NFS4_DELEG_STID)
+		typemask |= NFS4_ADMIN_REVOKED_DELEG_STID;
+
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
 		return nfserr_bad_stateid;
@@ -6532,6 +6605,10 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 			return nfserr_deleg_revoked;
 		return nfserr_bad_stateid;
 	}
+	if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
+		nfs4_put_stid(stid);
+		return nfserr_admin_revoked;
+	}
 	*s = stid;
 	return nfs_ok;
 }
@@ -6899,7 +6976,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  */
 static __be32
 nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-			 stateid_t *stateid, char typemask,
+			 stateid_t *stateid, unsigned short typemask,
 			 struct nfs4_ol_stateid **stpp,
 			 struct nfsd_net *nn)
 {
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
index f96eaa8e9413..3af5ab55c978 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -88,17 +88,23 @@ struct nfsd4_callback_ops {
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
+#define NFS4_ALL_ADMIN_REVOKED_STIDS (NFS4_ADMIN_REVOKED_STID |		\
+				     NFS4_ADMIN_REVOKED_LOCK_STID |	\
+				     NFS4_ADMIN_REVOKED_DELEG_STID)
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
@@ -372,6 +378,7 @@ struct nfs4_client {
 	clientid_t		cl_clientid;	/* generated by server */
 	nfs4_verifier		cl_confirm;	/* generated by server */
 	u32			cl_minorversion;
+	atomic_t		cl_admin_revoked; /* count of admin-revoked states */
 	/* NFSv4.1 client implementation id: */
 	struct xdr_netobj	cl_nii_domain;
 	struct xdr_netobj	cl_nii_name;
@@ -694,7 +701,7 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		stateid_t *stateid, int flags, struct nfsd_file **filp,
 		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid, unsigned short typemask,
 		     struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
@@ -736,6 +743,14 @@ static inline void get_nfs4_file(struct nfs4_file *fi)
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
index fbc0ccb40424..e359d531402c 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -648,6 +648,9 @@ TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
 TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
 TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
 TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
+TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_STID);
+TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_LOCK_STID);
+TRACE_DEFINE_ENUM(NFS4_ADMIN_REVOKED_DELEG_STID);
 
 #define show_stid_type(x)						\
 	__print_flags(x, "|",						\
@@ -657,7 +660,10 @@ TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
 		{ NFS4_CLOSED_STID,		"CLOSED" },		\
 		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
 		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
-		{ NFS4_LAYOUT_STID,		"LAYOUT" })
+		{ NFS4_LAYOUT_STID,		"LAYOUT" },		\
+		{ NFS4_ADMIN_REVOKED_STID,	"ADMIN_REVOKED" },	\
+		{ NFS4_ADMIN_REVOKED_LOCK_STID,	"ADMIN_REVOKED_LOCK" },	\
+		{ NFS4_ADMIN_REVOKED_DELEG_STID,"ADMIN_REVOKED_DELEG" })
 
 DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_PROTO(
-- 
2.42.0

