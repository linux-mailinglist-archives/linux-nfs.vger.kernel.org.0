Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E6E7DDA73
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 02:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376931AbjKABBW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 21:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbjKABBV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 21:01:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9369BF4
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 18:01:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 499762184F;
        Wed,  1 Nov 2023 01:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698800474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEMvrgugH8OJnZVdaeGDlkzjt7mzcEWUEKn0B3JiNNA=;
        b=kb64DYs4W1nBViXXecwrFCJ5sE6PwSK7+eXRH4Q6YaJGEqXC/cRyDbTUD2vmcC9+M6Zvig
        +hAtUhFT0M81CkIOp+ZWnBk1PpSGiv6UUverDYljD1qPK5bBlKtExzPKI6yfJvZGZEXnhh
        c59n7gC0upWADuLS6eVh2QDpj7eu098=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698800474;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mEMvrgugH8OJnZVdaeGDlkzjt7mzcEWUEKn0B3JiNNA=;
        b=yD7UDwYWqM9OhPNWIrTpxbyPEBhwgRcg4qvMyd4s4WXh/2ZPX/KL6vsMRGi9VBABlb2T64
        1tTCBMFSpAnbSfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42809138EF;
        Wed,  1 Nov 2023 01:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vy6kOlejQWUJOwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 01:01:11 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Date:   Wed,  1 Nov 2023 11:57:10 +1100
Message-ID: <20231101010049.27315-4-neilb@suse.de>
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

For NFSv4.1 and later the client easily discovers if there is any
admin-revoked state and will then find and explicitly free it.

For NFSv4.0 there is no such mechanism.  The client can only find that
state is admin-revoked if it tries to use that state, and there is no
way for it to explicitly free the state.  So the server must hold on to,
at least, the stateid for an indefinite amount of time.  A
RELEASE_LOCKOWNER request might justify forgetting some of these
stateids, as would the whole clients lease lapsing, but these are not
reliable.

This patch takes two approaches.

Whenever a client uses an revoked stateid, that stateid is then
discarded and will not be recognised again.  This might confuse a client
which expect to get NFS4ERR_ADMIN_REVOKED consistently once it get it at
all, but should mostly work.  Hopefully one error will lead to other
resources being closed (e.g.  process exits), which will result in more
stateid being freed when a CLOSE attempt gets NFS4ERR_ADMIN_REVOKED.

Also, any admin-revoked stateids that have been that way for more than
one lease time are periodically revoke.

No actual freeing of state happens in this patch.  That will come in
future patches which handle the different sorts of revoked state.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/netns.h     |  4 ++
 fs/nfsd/nfs4state.c | 98 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index ec49b200b797..02f8fa095b0f 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -197,6 +197,10 @@ struct nfsd_net {
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
+
+	/* last time an admin-revoke happened for NFSv4.0 */
+	time64_t		nfs40_last_revoke;
+
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e15d35c57991..13484a9cef21 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1724,6 +1724,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
+				if (clp->cl_minorversion == 0)
+					/* Allow cleanup after a lease period.
+					 * store_release ensures cleanup will
+					 * see any newly revoked states if it
+					 * sees the time updated.
+					 */
+					nn->nfs40_last_revoke =
+						ktime_get_boottime_seconds();
 				goto retry;
 			}
 		}
@@ -4645,6 +4653,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 	return ret;
 }
 
+static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
+{
+	struct nfs4_client *cl = s->sc_client;
+
+	switch (s->sc_type) {
+	default:
+		spin_unlock(&cl->cl_lock);
+	}
+}
+
+static void nfs40_drop_revoked_stid(struct nfs4_client *cl,
+				    stateid_t *stid)
+{
+	/* NFSv4.0 has no way for the client to tell the server
+	 * that it can forget an admin-revoked stateid.
+	 * So we keep it around until the first time that the
+	 * client uses it, and drop it the first time
+	 * nfserr_admin_revoked is returned.
+	 * For v4.1 and later we wait until explicitly told
+	 * to free the stateid.
+	 */
+	if (cl->cl_minorversion == 0) {
+		struct nfs4_stid *st;
+
+		spin_lock(&cl->cl_lock);
+		st = find_stateid_locked(cl, stid);
+		if (st)
+			nfsd_drop_revoked_stid(st);
+		else
+			spin_unlock(&cl->cl_lock);
+	}
+}
+
 static __be32
 nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
@@ -4672,6 +4713,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
 
 	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
 	ret = nfsd4_verify_open_stid(&stp->st_stid);
+	if (ret == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(stp->st_stid.sc_client,
+					&stp->st_stid.sc_stateid);
+
 	if (ret != nfs_ok)
 		mutex_unlock(&stp->st_mutex);
 	return ret;
@@ -5256,6 +5301,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	}
 	if (deleg->dl_stid.sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) {
 		nfs4_put_stid(&deleg->dl_stid);
+		nfs40_drop_revoked_stid(cl, &open->op_delegate_stateid);
 		status = nfserr_admin_revoked;
 		goto out;
 	}
@@ -6253,6 +6299,43 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
 	}
 }
 
+static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
+				      struct laundry_time *lt)
+{
+	struct nfs4_client *clp;
+
+	spin_lock(&nn->client_lock);
+	if (nn->nfs40_last_revoke == 0 ||
+	    nn->nfs40_last_revoke > lt->cutoff) {
+		spin_unlock(&nn->client_lock);
+		return;
+	}
+	nn->nfs40_last_revoke = 0;
+
+retry:
+	list_for_each_entry(clp, &nn->client_lru, cl_lru) {
+		unsigned long id, tmp;
+		struct nfs4_stid *stid;
+
+		if (atomic_read(&clp->cl_admin_revoked) == 0)
+			continue;
+
+		spin_lock(&clp->cl_lock);
+		idr_for_each_entry_ul(&clp->cl_stateids, stid, tmp, id)
+			if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
+				refcount_inc(&stid->sc_count);
+				spin_unlock(&nn->client_lock);
+				/* this function drops ->cl_lock */
+				nfsd_drop_revoked_stid(stid);
+				nfs4_put_stid(stid);
+				spin_lock(&nn->client_lock);
+				goto retry;
+			}
+		spin_unlock(&clp->cl_lock);
+	}
+	spin_unlock(&nn->client_lock);
+}
+
 static time64_t
 nfs4_laundromat(struct nfsd_net *nn)
 {
@@ -6286,6 +6369,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
+	nfs40_clean_admin_revoked(nn, &lt);
+
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
@@ -6504,6 +6589,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
 	if (ret == nfs_ok)
 		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
 	spin_unlock(&s->sc_lock);
+	if (ret == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(s->sc_client,
+					&s->sc_stateid);
 	return ret;
 }
 
@@ -6555,6 +6643,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	}
 out_unlock:
 	spin_unlock(&cl->cl_lock);
+	if (status == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(cl, stateid);
 	return status;
 }
 
@@ -6604,6 +6694,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return nfserr_bad_stateid;
 	}
 	if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
+		nfs40_drop_revoked_stid(cstate->clp, stateid);
 		nfs4_put_stid(stid);
 		return nfserr_admin_revoked;
 	}
@@ -6923,6 +7014,13 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nfs4_put_stid(s);
 		ret = nfs_ok;
 		goto out;
+	case NFS4_ADMIN_REVOKED_STID:
+	case NFS4_ADMIN_REVOKED_LOCK_STID:
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
+		spin_unlock(&s->sc_lock);
+		nfsd_drop_revoked_stid(s);
+		ret = nfs_ok;
+		goto out;
 	/* Default falls through and returns nfserr_bad_stateid */
 	}
 	spin_unlock(&s->sc_lock);
-- 
2.42.0

