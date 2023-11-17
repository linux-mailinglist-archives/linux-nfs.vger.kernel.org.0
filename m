Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001837EEB00
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjKQCWP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCWO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:22:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6CB1A8
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:22:10 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B779218D6;
        Fri, 17 Nov 2023 02:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooRI/et5A+51adLDH8bA3VqFKSAlv6DipaaSgCczwsw=;
        b=zXOwV8OAlzP/o8CpQSOGJDlFW8tyFLMk3FYbztoAx2kKzMSdyc4JaA7kCAMXXTuajlypnP
        S0+wxoHsoAFdFf3FWcniScFsv4nCA8txQ3cX/H7bs8EpHShBF7JbILhXt1Nu3QD+7AltJl
        wgtSLPJjwV25Zqf/mpPVajIZB8AF1GQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187729;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooRI/et5A+51adLDH8bA3VqFKSAlv6DipaaSgCczwsw=;
        b=HDgHUrXf4yFJ1WLMXyANSdcFUQ3aQDrHDDii7s2w+Jvi6voimr2jMXUeI41lDDImHOOiFZ
        s73A3ikr33zetQCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C4711341F;
        Fri, 17 Nov 2023 02:22:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bskEOU7OVmVVEwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:22:06 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/9] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Date:   Fri, 17 Nov 2023 13:18:52 +1100
Message-ID: <20231117022121.23310-7-neilb@suse.de>
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

For NFSv4.1 and later the client easily discovers if there is any
admin-revoked state and will then find and explicitly free it.

For NFSv4.0 there is no such mechanism.  The client can only find that
state is admin-revoked if it tries to use that state, and there is no
way for it to explicitly free the state.  So the server must hold on to
the stateid (at least) for an indefinite amount of time.  A
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
 fs/nfsd/nfs4state.c | 97 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 100 insertions(+), 1 deletion(-)

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
index 8debd148840f..8a1b8376ff08 100644
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
@@ -4650,6 +4658,39 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
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
@@ -5255,6 +5300,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	}
 	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
+		nfs40_drop_revoked_stid(cl, &open->op_delegate_stateid);
 		status = nfserr_deleg_revoked;
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
+			if (stid->sc_status & NFS4_STID_ADMIN_REVOKED) {
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
 
@@ -6548,6 +6636,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	}
 out_unlock:
 	spin_unlock(&cl->cl_lock);
+	if (status == nfserr_admin_revoked)
+		nfs40_drop_revoked_stid(cl, stateid);
 	return status;
 }
 
@@ -6594,6 +6684,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return nfserr_deleg_revoked;
 	}
 	if (stid->sc_type & NFS4_STID_ADMIN_REVOKED) {
+		nfs40_drop_revoked_stid(cstate->clp, stateid);
 		nfs4_put_stid(stid);
 		return nfserr_admin_revoked;
 	}
@@ -6886,6 +6977,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & NFS4_STID_CLOSED)
 		goto out_unlock;
+	if (s->sc_status & NFS4_STID_ADMIN_REVOKED) {
+		nfsd_drop_revoked_stid(s);
+		ret = nfs_ok;
+		goto out;
+	}
 	spin_lock(&s->sc_lock);
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
@@ -6912,7 +7008,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&cl->cl_lock);
 		ret = nfsd4_free_lock_stateid(stateid, s);
 		goto out;
-	/* Default falls through and returns nfserr_bad_stateid */
 	}
 	spin_unlock(&s->sc_lock);
 out_unlock:
-- 
2.42.0

