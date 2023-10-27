Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F6A7D8CED
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjJ0B4t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 21:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345132AbjJ0B4s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 21:56:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43171B8
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 18:56:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B95CD21C08;
        Fri, 27 Oct 2023 01:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698371803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhQG6eVmWzBaNQFmK9kGNjQJ7IAg8othhMQ9Nr59iZ8=;
        b=ng5QyIlK33FoDFP8lHqbdihi9Z5WL8BhnpxKnOgR8707BTnIqE/Hf0Y3GoKW6QPovypeGl
        yAatiwR/dVsjcGJOoaCyXyPOqlRFTfBtgAnlYwAi/Lihn4cHQWPDmhg/MuWDR+nw6k+ffS
        eWy/drVuKKTyq1dm+IeZEpjxKkyYd3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698371803;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhQG6eVmWzBaNQFmK9kGNjQJ7IAg8othhMQ9Nr59iZ8=;
        b=CX5+fG3ZeAoWNtNsWApNjOGBKOmz/3r9KT0cImOngGyjnknUOHRmisRS8ROcGodMxN3AwF
        cWC+bD6rvakAnABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B00D5133F5;
        Fri, 27 Oct 2023 01:56:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XBWzGdkYO2USCgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 01:56:41 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 3/6] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Date:   Fri, 27 Oct 2023 12:45:31 +1100
Message-ID: <20231027015613.26247-4-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027015613.26247-1-neilb@suse.de>
References: <20231027015613.26247-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_FIVE(0.00)[6];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 fs/nfsd/nfs4state.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+)

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
index e15d35c57991..cea36f3ff204 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1723,6 +1723,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 				switch (stid->sc_type) {
 				}
 				nfs4_put_stid(stid);
+				if (clp->cl_minorversion == 0)
+					/* Allow cleanup after a lease period.
+					 * store_release ensures cleanup will
+					 * see any newly revoked states if it
+					 * sees the time updated.
+					 */
+					smp_store_release(&nn->nfs40_last_revoke,
+							  ktime_get_boottime_seconds());
 				spin_lock(&nn->client_lock);
 				goto retry;
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
@@ -6253,6 +6299,41 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
 	}
 }
 
+static void nfs40_clean_admin_revoked(struct nfsd_net *nn,
+				      struct laundry_time *lt)
+{
+	struct nfs4_client *clp;
+
+	/* load_acquire avoids races with nfsd4_revoke_states() */
+	if (smp_load_acquire(&nn->nfs40_last_revoke) == 0 ||
+	    nn->nfs40_last_revoke > lt->cutoff)
+		return;
+
+	nn->nfs40_last_revoke = 0;
+
+retry:
+	spin_lock(&nn->client_lock);
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
+				nfsd_drop_revoked_stid(stid);
+				nfs4_put_stid(stid);
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
@@ -6286,6 +6367,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
+	nfs40_clean_admin_revoked(nn, &lt);
+
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
@@ -6504,6 +6587,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
 	if (ret == nfs_ok)
 		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
 	spin_unlock(&s->sc_lock);
+	if (ret == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(s->sc_client,
+					&s->sc_stateid);
 	return ret;
 }
 
@@ -6555,6 +6641,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	}
 out_unlock:
 	spin_unlock(&cl->cl_lock);
+	if (status == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(cl, stateid);
 	return status;
 }
 
@@ -6604,6 +6692,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return nfserr_bad_stateid;
 	}
 	if (stid->sc_type & NFS4_ALL_ADMIN_REVOKED_STIDS) {
+		nfs40_drop_revoked_stid(cstate->clp, stateid);
 		nfs4_put_stid(stid);
 		return nfserr_admin_revoked;
 	}
@@ -6923,6 +7012,13 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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

