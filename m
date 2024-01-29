Return-Path: <linux-nfs+bounces-1524-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6883FCDA
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 04:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10F1F220ED
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jan 2024 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D671094E;
	Mon, 29 Jan 2024 03:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JcHbVS08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4sEvtZe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JcHbVS08";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="b4sEvtZe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96BF10940
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jan 2024 03:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499467; cv=none; b=B/UChH3U2Dei2WbTKyEa8Agykq88hftK0bAnfPEciDQ+pngvENg/RIQgNi8wDPtvF5J/VjMIb91194JUeuYu0gvRVqn0dkSsPgkgMC7pQ4cUPz8ba+Hknxck9QJQQ2j565CTJ/DNbVwbkP4fbk7b1X2XEmHzNVZGYZeMp5EMjVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499467; c=relaxed/simple;
	bh=HiURsG40AKHXZZIrdUI4u0pYGx/haoO1OkqFB6t1S+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7zzPRJs8jct1mp5XwSdYMT3GwrPGirCVQzATvqM9QPAD02kdlP1vtAs3PaeeZk91AWSOy7lHaO/U30Nx1JPTEKVohWCgbEf9uIcyUMK7mR+1EIKsIJ6nmtLMrrBie2arg8SMFKuOBBmxzNTLDKukacNg0O9NsnruGdJVyVF30I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JcHbVS08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b4sEvtZe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JcHbVS08; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=b4sEvtZe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F99B2229F;
	Mon, 29 Jan 2024 03:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAhAZ3KuWuYl9phAjgcwom/NgjQwoRC9war6v3BxNQk=;
	b=JcHbVS08TVxqTZhCI9ojBEPO2qhbyLdSkixmeuKLTJJzcIjsYwHF/zbahZIG5ojfR8NLv1
	Of1Iq/7zwmbMiL3WOexWj3+XmDnMAtWRAI1ullZHjyuARDf4PkJDagVDMiCzmBjppeTjW2
	HS/VgXmpHECSX77tQj2a1ukTQVaOvpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAhAZ3KuWuYl9phAjgcwom/NgjQwoRC9war6v3BxNQk=;
	b=b4sEvtZeNjCxYegR1JEk6DQrCuHZf179/mKgvIntQc2bUSOCVkF9mE4YRLF02Pu2/7Qtfg
	ToHGiuITV3GmM+DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706499464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAhAZ3KuWuYl9phAjgcwom/NgjQwoRC9war6v3BxNQk=;
	b=JcHbVS08TVxqTZhCI9ojBEPO2qhbyLdSkixmeuKLTJJzcIjsYwHF/zbahZIG5ojfR8NLv1
	Of1Iq/7zwmbMiL3WOexWj3+XmDnMAtWRAI1ullZHjyuARDf4PkJDagVDMiCzmBjppeTjW2
	HS/VgXmpHECSX77tQj2a1ukTQVaOvpM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706499464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAhAZ3KuWuYl9phAjgcwom/NgjQwoRC9war6v3BxNQk=;
	b=b4sEvtZeNjCxYegR1JEk6DQrCuHZf179/mKgvIntQc2bUSOCVkF9mE4YRLF02Pu2/7Qtfg
	ToHGiuITV3GmM+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FD0913867;
	Mon, 29 Jan 2024 03:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WqDtEYUdt2VDKgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jan 2024 03:37:41 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Christoph Hellwig <hch@lst.de>,
	Tom Haynes <loghyr@gmail.com>
Subject: [PATCH 09/13] nfsd: allow admin-revoked NFSv4.0 state to be freed.
Date: Mon, 29 Jan 2024 14:29:31 +1100
Message-ID: <20240129033637.2133-10-neilb@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JcHbVS08;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=b4sEvtZe
X-Spamd-Result: default: False [1.69 / 50.00];
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
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,netapp.com,oracle.com,talpey.com,lst.de,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 2F99B2229F
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

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
 fs/nfsd/nfs4state.c | 98 ++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 74b4360779a1..b35bdd5c10de 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -192,6 +192,10 @@ struct nfsd_net {
 	atomic_t		nfsd_courtesy_clients;
 	struct shrinker		*nfsd_client_shrinker;
 	struct work_struct	nfsd_shrinker_work;
+
+	/* last time an admin-revoke happened for NFSv4.0 */
+	time64_t		nfs40_last_revoke;
+
 };
 
 /* Simple check to find out if a given net was properly initialized */
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e1492ca7c75c..900d295bd570 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1733,6 +1733,14 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
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
@@ -4617,6 +4625,40 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 	return ret;
 }
 
+static void nfsd4_drop_revoked_stid(struct nfs4_stid *s)
+	__releases(&s->sc_client->cl_lock)
+{
+	struct nfs4_client *cl = s->sc_client;
+
+	switch (s->sc_type) {
+	default:
+		spin_unlock(&cl->cl_lock);
+	}
+}
+
+static void nfsd40_drop_revoked_stid(struct nfs4_client *cl,
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
+			nfsd4_drop_revoked_stid(st);
+		else
+			spin_unlock(&cl->cl_lock);
+	}
+}
+
 static __be32
 nfsd4_verify_open_stid(struct nfs4_stid *s)
 {
@@ -4639,6 +4681,10 @@ nfsd4_lock_ol_stateid(struct nfs4_ol_stateid *stp)
 
 	mutex_lock_nested(&stp->st_mutex, LOCK_STATEID_MUTEX);
 	ret = nfsd4_verify_open_stid(&stp->st_stid);
+	if (ret == nfserr_admin_revoked)
+		nfsd40_drop_revoked_stid(stp->st_stid.sc_client,
+					&stp->st_stid.sc_stateid);
+
 	if (ret != nfs_ok)
 		mutex_unlock(&stp->st_mutex);
 	return ret;
@@ -5222,6 +5268,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 	}
 	if (deleg->dl_stid.sc_status & SC_STATUS_REVOKED) {
 		nfs4_put_stid(&deleg->dl_stid);
+		nfsd40_drop_revoked_stid(cl, &open->op_delegate_stateid);
 		status = nfserr_deleg_revoked;
 		goto out;
 	}
@@ -6206,6 +6253,43 @@ nfs4_process_client_reaplist(struct list_head *reaplist)
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
+			if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
+				refcount_inc(&stid->sc_count);
+				spin_unlock(&nn->client_lock);
+				/* this function drops ->cl_lock */
+				nfsd4_drop_revoked_stid(stid);
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
@@ -6239,6 +6323,8 @@ nfs4_laundromat(struct nfsd_net *nn)
 	nfs4_get_client_reaplist(nn, &reaplist, &lt);
 	nfs4_process_client_reaplist(&reaplist);
 
+	nfs40_clean_admin_revoked(nn, &lt);
+
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
@@ -6457,6 +6543,9 @@ static __be32 nfsd4_stid_check_stateid_generation(stateid_t *in, struct nfs4_sti
 	if (ret == nfs_ok)
 		ret = check_stateid_generation(in, &s->sc_stateid, has_session);
 	spin_unlock(&s->sc_lock);
+	if (ret == nfserr_admin_revoked)
+		nfsd40_drop_revoked_stid(s->sc_client,
+					&s->sc_stateid);
 	return ret;
 }
 
@@ -6501,6 +6590,8 @@ static __be32 nfsd4_validate_stateid(struct nfs4_client *cl, stateid_t *stateid)
 	}
 out_unlock:
 	spin_unlock(&cl->cl_lock);
+	if (status == nfserr_admin_revoked)
+		nfsd40_drop_revoked_stid(cl, stateid);
 	return status;
 }
 
@@ -6547,6 +6638,7 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 		return nfserr_deleg_revoked;
 	}
 	if (stid->sc_status & SC_STATUS_ADMIN_REVOKED) {
+		nfsd40_drop_revoked_stid(cstate->clp, stateid);
 		nfs4_put_stid(stid);
 		return nfserr_admin_revoked;
 	}
@@ -6839,6 +6931,11 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	s = find_stateid_locked(cl, stateid);
 	if (!s || s->sc_status & SC_STATUS_CLOSED)
 		goto out_unlock;
+	if (s->sc_status & SC_STATUS_ADMIN_REVOKED) {
+		nfsd4_drop_revoked_stid(s);
+		ret = nfs_ok;
+		goto out;
+	}
 	spin_lock(&s->sc_lock);
 	switch (s->sc_type) {
 	case SC_TYPE_DELEG:
@@ -6865,7 +6962,6 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&cl->cl_lock);
 		ret = nfsd4_free_lock_stateid(stateid, s);
 		goto out;
-	/* Default falls through and returns nfserr_bad_stateid */
 	}
 	spin_unlock(&s->sc_lock);
 out_unlock:
-- 
2.43.0


