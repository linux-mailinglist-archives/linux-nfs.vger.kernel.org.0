Return-Path: <linux-nfs+bounces-65-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30A87F6B6F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 05:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E679A1C20A1F
	for <lists+linux-nfs@lfdr.de>; Fri, 24 Nov 2023 04:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BF8944D;
	Fri, 24 Nov 2023 04:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7A7D68
	for <linux-nfs@vger.kernel.org>; Thu, 23 Nov 2023 20:33:12 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2929620C74;
	Fri, 24 Nov 2023 00:31:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DFC01340B;
	Fri, 24 Nov 2023 00:31:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 664fFNzuX2WpegAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 24 Nov 2023 00:31:24 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 04/11] nfsd: split sc_status out of sc_type
Date: Fri, 24 Nov 2023 11:28:39 +1100
Message-ID: <20231124002925.1816-5-neilb@suse.de>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231124002925.1816-1-neilb@suse.de>
References: <20231124002925.1816-1-neilb@suse.de>
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
X-Rspamd-Queue-Id: 2929620C74
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
	 NEURAL_HAM_SHORT(-0.13)[-0.668];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]

sc_type identifies the type of a state - open, lock, deleg, layout - and
also the status of a state - closed or revoked.

This is a bit untidy and could get worse when "admin-revoked" states are
added.  So clean it up.

With this patch, the type is now all that is stored in sc_type.  This is
zero when the state is first added to ->cl_stateids (causing it to be
ignored), and is then set appropriately once it is fully initialised.
It is set under ->cl_lock to ensure atomicity w.r.t lookup.  It is now
never cleared.

sc_type is still a bit-set even though at most one bit is set.  This allows
lookup functions to be given a bitmap of acceptable types.

sc_type is now an unsigned short rather than char.  There is no value in
restricting to just 8 bits.

The status is stored in a separate unsigned short named "sc_status".  It
has two flags: NFS4_STID_CLOSED and NFS4_STID_REVOKED.
CLOSED combines NFS4_CLOSED_STID, NFS4_CLOSED_DELEG_STID, and is used
for LOCK_STID and LAYOUT_STID instead of setting the sc_type to zero.
These flags are only ever set, never cleared.
For deleg stateids they are set under the global state_lock.
For open and lock stateids they are set under ->cl_lock.
For layout stateids they are set under ->ls_lock

nfs4_unhash_stid() has been removed, and we never set sc_type = 0.  This
was only used for LOCK and LAYOUT stids and they now use
NFS4_STID_CLOSED.

Also TRACE_DEFINE_NUM() calls for the various STD #define have been
removed because these things are not enums, and so that call is
incorrect.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4layouts.c |   6 +-
 fs/nfsd/nfs4state.c   | 165 +++++++++++++++++++++---------------------
 fs/nfsd/state.h       |  40 +++++++---
 fs/nfsd/trace.h       |  23 +++---
 4 files changed, 122 insertions(+), 112 deletions(-)

diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index 5e8096bc5eaa..77656126ad2a 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -269,13 +269,13 @@ nfsd4_preprocess_layout_stateid(struct svc_rqst *rqstp,
 {
 	struct nfs4_layout_stateid *ls;
 	struct nfs4_stid *stid;
-	unsigned char typemask = NFS4_LAYOUT_STID;
+	unsigned short typemask = NFS4_LAYOUT_STID;
 	__be32 status;
 
 	if (create)
 		typemask |= (NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID);
 
-	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &stid,
+	status = nfsd4_lookup_stateid(cstate, stateid, typemask, 0, &stid,
 			net_generic(SVC_NET(rqstp), nfsd_net_id));
 	if (status)
 		goto out;
@@ -518,7 +518,7 @@ nfsd4_return_file_layouts(struct svc_rqst *rqstp,
 		lrp->lrs_present = true;
 	} else {
 		trace_nfsd_layoutstate_unhash(&ls->ls_stid.sc_stateid);
-		nfs4_unhash_stid(&ls->ls_stid);
+		ls->ls_stid.sc_status |= NFS4_STID_CLOSED;
 		lrp->lrs_present = false;
 	}
 	spin_unlock(&ls->ls_lock);
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 276afcba07a0..b9239f2ebc79 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1265,11 +1265,6 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
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
@@ -1334,7 +1329,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
@@ -1344,8 +1339,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 		return false;
 
 	if (dp->dl_stid.sc_client->cl_minorversion == 0)
-		type = NFS4_CLOSED_DELEG_STID;
-	dp->dl_stid.sc_type = type;
+		statusmask = NFS4_STID_CLOSED;
+	dp->dl_stid.sc_status |= statusmask;
+
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1361,7 +1357,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 	bool unhashed;
 
 	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+	unhashed = unhash_delegation_locked(dp, NFS4_STID_CLOSED);
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -1375,7 +1371,7 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
+	if (dp->dl_stid.sc_status & NFS4_STID_REVOKED) {
 		spin_lock(&clp->cl_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
@@ -1384,8 +1380,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 	destroy_unhashed_deleg(dp);
 }
 
-/* 
- * SETCLIENTID state 
+/*
+ * SETCLIENTID state
  */
 
 static unsigned int clientid_hashval(u32 id)
@@ -1548,7 +1544,7 @@ static bool unhash_lock_stateid(struct nfs4_ol_stateid *stp)
 	if (!unhash_ol_stateid(stp))
 		return false;
 	list_del_init(&stp->st_locks);
-	nfs4_unhash_stid(&stp->st_stid);
+	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
 	return true;
 }
 
@@ -1627,6 +1623,7 @@ static void release_open_stateid(struct nfs4_ol_stateid *stp)
 	LIST_HEAD(reaplist);
 
 	spin_lock(&stp->st_stid.sc_client->cl_lock);
+	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
 	if (unhash_open_stateid(stp, &reaplist))
 		put_ol_stateid_locked(stp, &reaplist);
 	spin_unlock(&stp->st_stid.sc_client->cl_lock);
@@ -2235,7 +2232,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+		unhash_delegation_locked(dp, NFS4_STID_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -2467,14 +2464,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 }
 
 static struct nfs4_stid *
-find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
+find_stateid_by_type(struct nfs4_client *cl, stateid_t *t,
+		     unsigned short typemask, unsigned short ok_states)
 {
 	struct nfs4_stid *s;
 
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, t);
 	if (s != NULL) {
-		if (typemask & s->sc_type)
+		if ((s->sc_status & ~ok_states) == 0 &&
+		    (typemask & s->sc_type))
 			refcount_inc(&s->sc_count);
 		else
 			s = NULL;
@@ -4583,7 +4582,8 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 			continue;
 		if (local->st_stateowner != &oo->oo_owner)
 			continue;
-		if (local->st_stid.sc_type == NFS4_OPEN_STID) {
+		if (local->st_stid.sc_type == NFS4_OPEN_STID &&
+		    !local->st_stid.sc_status) {
 			ret = local;
 			refcount_inc(&ret->st_stid.sc_count);
 			break;
@@ -4597,17 +4597,10 @@ nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
 	__be32 ret = nfs_ok;
 
-	switch (s->sc_type) {
-	default:
-		break;
-	case 0:
-	case NFS4_CLOSED_STID:
-	case NFS4_CLOSED_DELEG_STID:
-		ret = nfserr_bad_stateid;
-		break;
-	case NFS4_REVOKED_DELEG_STID:
+	if (s->sc_status & NFS4_STID_REVOKED)
 		ret = nfserr_deleg_revoked;
-	}
+	else if (s->sc_status & NFS4_STID_CLOSED)
+		ret = nfserr_bad_stateid;
 	return ret;
 }
 
@@ -4920,9 +4913,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 
 	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
 
-	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
-	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
-	        return 1;
+	if (dp->dl_stid.sc_status)
+		/* CLOSED or REVOKED */
+		return 1;
 
 	switch (task->tk_status) {
 	case 0:
@@ -5167,12 +5160,12 @@ static int share_access_to_flags(u32 share_access)
 	return share_access == NFS4_SHARE_ACCESS_READ ? RD_STATE : WR_STATE;
 }
 
-static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl, stateid_t *s)
+static struct nfs4_delegation *find_deleg_stateid(struct nfs4_client *cl,
+						  stateid_t *s)
 {
 	struct nfs4_stid *ret;
 
-	ret = find_stateid_by_type(cl, s,
-				NFS4_DELEG_STID|NFS4_REVOKED_DELEG_STID);
+	ret = find_stateid_by_type(cl, s, NFS4_DELEG_STID, NFS4_STID_REVOKED);
 	if (!ret)
 		return NULL;
 	return delegstateid(ret);
@@ -5195,7 +5188,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	deleg = find_deleg_stateid(cl, &open->op_delegate_stateid);
 	if (deleg == NULL)
 		goto out;
-	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
+	if (deleg->dl_stid.sc_status & NFS4_STID_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
 		status = nfserr_deleg_revoked;
 		goto out;
@@ -5842,7 +5835,6 @@ nfsd4_process_open2(struct svc_rqst *rqstp, struct svc_fh *current_fh, struct nf
 	} else {
 		status = nfs4_get_vfs_file(rqstp, fp, current_fh, stp, open, true);
 		if (status) {
-			stp->st_stid.sc_type = NFS4_CLOSED_STID;
 			release_open_stateid(stp);
 			mutex_unlock(&stp->st_mutex);
 			goto out;
@@ -6234,7 +6226,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID);
+		unhash_delegation_locked(dp, NFS4_STID_REVOKED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -6473,22 +6465,20 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	status = nfsd4_stid_check_stateid_generation(stateid, s, 1);
 	if (status)
 		goto out_unlock;
+	status = nfsd4_verify_open_stid(s);
+	if (status)
+		goto out_unlock;
+
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
 		status = nfs_ok;
 		break;
-	case NFS4_REVOKED_DELEG_STID:
-		status = nfserr_deleg_revoked;
-		break;
 	case NFS4_OPEN_STID:
 	case NFS4_LOCK_STID:
 		status = nfsd4_check_openowner_confirmed(openlockstateid(s));
 		break;
 	default:
 		printk("unknown stateid type %x\n", s->sc_type);
-		fallthrough;
-	case NFS4_CLOSED_STID:
-	case NFS4_CLOSED_DELEG_STID:
 		status = nfserr_bad_stateid;
 	}
 out_unlock:
@@ -6498,7 +6488,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 
 __be32
 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
+		     stateid_t *stateid,
+		     unsigned short typemask, unsigned short statusmask,
 		     struct nfs4_stid **s, struct nfsd_net *nn)
 {
 	__be32 status;
@@ -6509,10 +6500,13 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	 *  only return revoked delegations if explicitly asked.
 	 *  otherwise we report revoked or bad_stateid status.
 	 */
-	if (typemask & NFS4_REVOKED_DELEG_STID)
+	if (statusmask & NFS4_STID_REVOKED)
 		return_revoked = true;
-	else if (typemask & NFS4_DELEG_STID)
-		typemask |= NFS4_REVOKED_DELEG_STID;
+	if (typemask & NFS4_DELEG_STID)
+		/* Always allow REVOKED for DELEG so we can
+		 * retturn the appropriate error.
+		 */
+		statusmask |= NFS4_STID_REVOKED;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -6525,14 +6519,12 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	}
 	if (status)
 		return status;
-	stid = find_stateid_by_type(cstate->clp, stateid, typemask);
+	stid = find_stateid_by_type(cstate->clp, stateid, typemask, statusmask);
 	if (!stid)
 		return nfserr_bad_stateid;
-	if ((stid->sc_type == NFS4_REVOKED_DELEG_STID) && !return_revoked) {
+	if ((stid->sc_status & NFS4_STID_REVOKED) && !return_revoked) {
 		nfs4_put_stid(stid);
-		if (cstate->minorversion)
-			return nfserr_deleg_revoked;
-		return nfserr_bad_stateid;
+		return nfserr_deleg_revoked;
 	}
 	*s = stid;
 	return nfs_ok;
@@ -6543,7 +6535,7 @@ nfs4_find_file(struct nfs4_stid *s, int flags)
 {
 	struct nfsd_file *ret = NULL;
 
-	if (!s)
+	if (!s || s->sc_status)
 		return NULL;
 
 	switch (s->sc_type) {
@@ -6666,7 +6658,8 @@ static __be32 find_cpntf_state(struct nfsd_net *nn, stateid_t *st,
 		goto out;
 
 	*stid = find_stateid_by_type(found, &cps->cp_p_stateid,
-			NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID);
+				     NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
+				     0);
 	if (*stid)
 		status = nfs_ok;
 	else
@@ -6724,7 +6717,7 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 
 	status = nfsd4_lookup_stateid(cstate, stateid,
 				NFS4_DELEG_STID|NFS4_OPEN_STID|NFS4_LOCK_STID,
-				&s, nn);
+				0, &s, nn);
 	if (status == nfserr_bad_stateid)
 		status = find_cpntf_state(nn, stateid, &s);
 	if (status)
@@ -6742,9 +6735,6 @@ nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 	case NFS4_LOCK_STID:
 		status = nfs4_check_olstateid(openlockstateid(s), flags);
 		break;
-	default:
-		status = nfserr_bad_stateid;
-		break;
 	}
 	if (status)
 		goto out;
@@ -6823,11 +6813,20 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	spin_lock(&cl->cl_lock);
 	s = find_stateid_locked(cl, stateid);
-	if (!s)
+	if (!s || s->sc_status & NFS4_STID_CLOSED)
 		goto out_unlock;
 	spin_lock(&s->sc_lock);
 	switch (s->sc_type) {
 	case NFS4_DELEG_STID:
+		if (s->sc_status & NFS4_STID_REVOKED) {
+			spin_unlock(&s->sc_lock);
+			dp = delegstateid(s);
+			list_del_init(&dp->dl_recall_lru);
+			spin_unlock(&cl->cl_lock);
+			nfs4_put_stid(s);
+			ret = nfs_ok;
+			goto out;
+		}
 		ret = nfserr_locks_held;
 		break;
 	case NFS4_OPEN_STID:
@@ -6842,14 +6841,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&cl->cl_lock);
 		ret = nfsd4_free_lock_stateid(stateid, s);
 		goto out;
-	case NFS4_REVOKED_DELEG_STID:
-		spin_unlock(&s->sc_lock);
-		dp = delegstateid(s);
-		list_del_init(&dp->dl_recall_lru);
-		spin_unlock(&cl->cl_lock);
-		nfs4_put_stid(s);
-		ret = nfs_ok;
-		goto out;
 	/* Default falls through and returns nfserr_bad_stateid */
 	}
 	spin_unlock(&s->sc_lock);
@@ -6892,6 +6883,7 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  * @seqid: seqid (provided by client)
  * @stateid: stateid (provided by client)
  * @typemask: mask of allowable types for this operation
+ * @statusmask: mask of allowed states: 0 or STID_CLOSED
  * @stpp: return pointer for the stateid found
  * @nn: net namespace for request
  *
@@ -6901,7 +6893,8 @@ static __be32 nfs4_seqid_op_checks(struct nfsd4_compound_state *cstate, stateid_
  */
 static __be32
 nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
-			 stateid_t *stateid, char typemask,
+			 stateid_t *stateid,
+			 unsigned short typemask, unsigned short statusmask,
 			 struct nfs4_ol_stateid **stpp,
 			 struct nfsd_net *nn)
 {
@@ -6912,7 +6905,8 @@ nfs4_preprocess_seqid_op(struct nfsd4_compound_state *cstate, u32 seqid,
 	trace_nfsd_preprocess(seqid, stateid);
 
 	*stpp = NULL;
-	status = nfsd4_lookup_stateid(cstate, stateid, typemask, &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid,
+				      typemask, statusmask, &s, nn);
 	if (status)
 		return status;
 	stp = openlockstateid(s);
@@ -6934,7 +6928,7 @@ static __be32 nfs4_preprocess_confirmed_seqid_op(struct nfsd4_compound_state *cs
 	struct nfs4_ol_stateid *stp;
 
 	status = nfs4_preprocess_seqid_op(cstate, seqid, stateid,
-						NFS4_OPEN_STID, &stp, nn);
+					  NFS4_OPEN_STID, 0, &stp, nn);
 	if (status)
 		return status;
 	oo = openowner(stp->st_stateowner);
@@ -6965,8 +6959,8 @@ nfsd4_open_confirm(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		return status;
 
 	status = nfs4_preprocess_seqid_op(cstate,
-					oc->oc_seqid, &oc->oc_req_stateid,
-					NFS4_OPEN_STID, &stp, nn);
+					  oc->oc_seqid, &oc->oc_req_stateid,
+					  NFS4_OPEN_STID, 0, &stp, nn);
 	if (status)
 		goto out;
 	oo = openowner(stp->st_stateowner);
@@ -7096,18 +7090,20 @@ nfsd4_close(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct net *net = SVC_NET(rqstp);
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	dprintk("NFSD: nfsd4_close on file %pd\n", 
+	dprintk("NFSD: nfsd4_close on file %pd\n",
 			cstate->current_fh.fh_dentry);
 
 	status = nfs4_preprocess_seqid_op(cstate, close->cl_seqid,
-					&close->cl_stateid,
-					NFS4_OPEN_STID|NFS4_CLOSED_STID,
-					&stp, nn);
+					  &close->cl_stateid,
+					  NFS4_OPEN_STID, NFS4_STID_CLOSED,
+					  &stp, nn);
 	nfsd4_bump_seqid(cstate, status);
 	if (status)
-		goto out; 
+		goto out;
 
-	stp->st_stid.sc_type = NFS4_CLOSED_STID;
+	spin_lock(&stp->st_stid.sc_client->cl_lock);
+	stp->st_stid.sc_status |= NFS4_STID_CLOSED;
+	spin_unlock(&stp->st_stid.sc_client->cl_lock);
 
 	/*
 	 * Technically we don't _really_ have to increment or copy it, since
@@ -7149,7 +7145,7 @@ nfsd4_delegreturn(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if ((status = fh_verify(rqstp, &cstate->current_fh, S_IFREG, 0)))
 		return status;
 
-	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, &s, nn);
+	status = nfsd4_lookup_stateid(cstate, stateid, NFS4_DELEG_STID, 0, &s, nn);
 	if (status)
 		goto out;
 	dp = delegstateid(s);
@@ -7603,9 +7599,10 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 							&lock_stp, &new);
 	} else {
 		status = nfs4_preprocess_seqid_op(cstate,
-				       lock->lk_old_lock_seqid,
-				       &lock->lk_old_lock_stateid,
-				       NFS4_LOCK_STID, &lock_stp, nn);
+						  lock->lk_old_lock_seqid,
+						  &lock->lk_old_lock_stateid,
+						  NFS4_LOCK_STID, 0, &lock_stp,
+						  nn);
 	}
 	if (status)
 		goto out;
@@ -7918,8 +7915,8 @@ nfsd4_locku(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		 return nfserr_inval;
 
 	status = nfs4_preprocess_seqid_op(cstate, locku->lu_seqid,
-					&locku->lu_stateid, NFS4_LOCK_STID,
-					&stp, nn);
+					  &locku->lu_stateid, NFS4_LOCK_STID, 0,
+					  &stp, nn);
 	if (status)
 		goto out;
 	nf = find_any_file(stp->st_stid.sc_file);
@@ -8353,7 +8350,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
+		unhash_delegation_locked(dp, NFS4_STID_CLOSED);
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index f96eaa8e9413..bb00dcd4c1ba 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -88,17 +88,33 @@ struct nfsd4_callback_ops {
  */
 struct nfs4_stid {
 	refcount_t		sc_count;
-#define NFS4_OPEN_STID 1
-#define NFS4_LOCK_STID 2
-#define NFS4_DELEG_STID 4
-/* For an open stateid kept around *only* to process close replays: */
-#define NFS4_CLOSED_STID 8
+
+	/* A new stateid is added to the cl_stateids idr early before it
+	 * is fully initialised.  Its sc_type is then zero.  After
+	 * initialisation the sc_type it set under cl_lock, and then
+	 * never changes.
+	 */
+#define NFS4_OPEN_STID		BIT(0)
+#define NFS4_LOCK_STID		BIT(1)
+#define NFS4_DELEG_STID		BIT(2)
+#define NFS4_LAYOUT_STID	BIT(3)
+	unsigned short		sc_type;
+
+/* state_lock protects sc_status for delegation stateids.
+ * ->cl_lock protects sc_status for open and lock stateids.
+ * ->st_mutex also protect sc_status for open stateids.
+ * ->ls_lock protects sc_status for layout stateids.
+ */
+/*
+ * For an open stateid kept around *only* to process close replays.
+ * For deleg stateid, kept in idr until last reference is dropped.
+ */
+#define NFS4_STID_CLOSED	BIT(0)
 /* For a deleg stateid kept around only to process free_stateid's: */
-#define NFS4_REVOKED_DELEG_STID 16
-#define NFS4_CLOSED_DELEG_STID 32
-#define NFS4_LAYOUT_STID 64
+#define NFS4_STID_REVOKED	BIT(1)
+	unsigned short		sc_status;
+
 	struct list_head	sc_cp_list;
-	unsigned char		sc_type;
 	stateid_t		sc_stateid;
 	spinlock_t		sc_lock;
 	struct nfs4_client	*sc_client;
@@ -694,15 +710,15 @@ extern __be32 nfs4_preprocess_stateid_op(struct svc_rqst *rqstp,
 		stateid_t *stateid, int flags, struct nfsd_file **filp,
 		struct nfs4_stid **cstid);
 __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
-		     stateid_t *stateid, unsigned char typemask,
-		     struct nfs4_stid **s, struct nfsd_net *nn);
+			    stateid_t *stateid, unsigned short typemask,
+			    unsigned short statusmask,
+			    struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
 int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_copy *copy);
 void nfs4_free_copy_state(struct nfsd4_copy *copy);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 			struct nfs4_stid *p_stid);
-void nfs4_unhash_stid(struct nfs4_stid *s);
 void nfs4_put_stid(struct nfs4_stid *s);
 void nfs4_inc_and_copy_stateid(stateid_t *dst, struct nfs4_stid *stid);
 void nfs4_remove_reclaim_record(struct nfs4_client_reclaim *, struct nfsd_net *);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index d1e8cf079b0f..568b4ec9a2af 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -641,24 +641,18 @@ DEFINE_EVENT(nfsd_stateseqid_class, nfsd_##name, \
 DEFINE_STATESEQID_EVENT(preprocess);
 DEFINE_STATESEQID_EVENT(open_confirm);
 
-TRACE_DEFINE_ENUM(NFS4_OPEN_STID);
-TRACE_DEFINE_ENUM(NFS4_LOCK_STID);
-TRACE_DEFINE_ENUM(NFS4_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_CLOSED_STID);
-TRACE_DEFINE_ENUM(NFS4_REVOKED_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_CLOSED_DELEG_STID);
-TRACE_DEFINE_ENUM(NFS4_LAYOUT_STID);
-
 #define show_stid_type(x)						\
 	__print_flags(x, "|",						\
 		{ NFS4_OPEN_STID,		"OPEN" },		\
 		{ NFS4_LOCK_STID,		"LOCK" },		\
 		{ NFS4_DELEG_STID,		"DELEG" },		\
-		{ NFS4_CLOSED_STID,		"CLOSED" },		\
-		{ NFS4_REVOKED_DELEG_STID,	"REVOKED" },		\
-		{ NFS4_CLOSED_DELEG_STID,	"CLOSED_DELEG" },	\
 		{ NFS4_LAYOUT_STID,		"LAYOUT" })
 
+#define show_stid_status(x)						\
+	__print_flags(x, "|",						\
+		{ NFS4_STID_CLOSED,		"CLOSED" },		\
+		{ NFS4_STID_REVOKED,		"REVOKED" })		\
+
 DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_PROTO(
 		const struct nfs4_stid *stid
@@ -666,6 +660,7 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
 	TP_ARGS(stid),
 	TP_STRUCT__entry(
 		__field(unsigned long, sc_type)
+		__field(unsigned long, sc_status)
 		__field(int, sc_count)
 		__field(u32, cl_boot)
 		__field(u32, cl_id)
@@ -676,16 +671,18 @@ DECLARE_EVENT_CLASS(nfsd_stid_class,
 		const stateid_t *stp = &stid->sc_stateid;
 
 		__entry->sc_type = stid->sc_type;
+		__entry->sc_status = stid->sc_status;
 		__entry->sc_count = refcount_read(&stid->sc_count);
 		__entry->cl_boot = stp->si_opaque.so_clid.cl_boot;
 		__entry->cl_id = stp->si_opaque.so_clid.cl_id;
 		__entry->si_id = stp->si_opaque.so_id;
 		__entry->si_generation = stp->si_generation;
 	),
-	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s",
+	TP_printk("client %08x:%08x stateid %08x:%08x ref=%d type=%s state=%s",
 		__entry->cl_boot, __entry->cl_id,
 		__entry->si_id, __entry->si_generation,
-		__entry->sc_count, show_stid_type(__entry->sc_type)
+		__entry->sc_count, show_stid_type(__entry->sc_type),
+		show_stid_status(__entry->sc_status)
 	)
 );
 
-- 
2.42.1


