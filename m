Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAFA49D9BC
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 05:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbiA0E76 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 23:59:58 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44512 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiA0E75 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 23:59:57 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E65561F76C;
        Thu, 27 Jan 2022 04:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643259596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=214MWV4/ujoXspMn/NBhkpmz5/Of2CqMEcAdw8yB8MI=;
        b=GaycZBcm/ALgeug1VIuZMqwfD6R3xJRcZCZ43rq0LcZ014nILzaxIsI5zP4JBYAQGvAtRz
        dwbkHX6L9H7k5dFXttMhhaqugiyJLvz0cS2qcKEI3cfCxPFwkDpV3T5HvHI0Yvyz4ghR+v
        QPlF+ByP8w0Nsu7JMfUr4OIM6g+lIxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643259596;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=214MWV4/ujoXspMn/NBhkpmz5/Of2CqMEcAdw8yB8MI=;
        b=+1cUAFyDiBfFArZiCWWsbbu+RNLq7Wj5hhTrZr8osYsv+GjaNzrSGQL2KOo5uaAGDtuBMP
        +tNGkAPqxWhQ+BAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BEB413BCF;
        Thu, 27 Jan 2022 04:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IrJdMssm8mFPVgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 04:59:55 +0000
Subject: [PATCH 4/4] nfsd: allow delegation state ids to be revoked and then
 freed
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 15:58:10 +1100
Message-ID: <164325949071.23133.1986695063796663253.stgit@noble.brown>
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Revoking state through 'unlock_filesystem' now revokes any delegation
states found.  When the stateids are then freed by the client, the
revoked stateids will be cleaned up correctly.

As there is already support for revoking delegations, we build on that
for admin-revoking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c |   35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b1dc8ed1d356..30177554a77b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1270,14 +1270,15 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 		destroy_unhashed_deleg(dp);
 }
 
-static void revoke_delegation(struct nfs4_delegation *dp)
+static void revoke_delegation(struct nfs4_delegation *dp,
+			      unsigned short sc_type)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 
 	WARN_ON(!list_empty(&dp->dl_recall_lru));
 
-	if (clp->cl_minorversion) {
-		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
+	if (clp->cl_minorversion || sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) {
+		dp->dl_stid.sc_type = sc_type;
 		refcount_inc(&dp->dl_stid.sc_count);
 		spin_lock(&clp->cl_lock);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
@@ -1613,7 +1614,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned short sc_types;
 
-	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1625,6 +1626,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 								  sc_types);
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
+				struct nfs4_delegation *dp;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1663,6 +1665,18 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 					}
 					mutex_unlock(&stp->st_mutex);
 					break;
+				case NFS4_DELEG_STID:
+					dp = delegstateid(stid);
+					spin_lock(&state_lock);
+					if (!unhash_delegation_locked(dp))
+						dp = NULL;
+					spin_unlock(&state_lock);
+					if (dp) {
+						list_del_init(&dp->dl_recall_lru);
+						revoke_delegation(
+							dp, NFS4_ADMIN_REVOKED_DELEG_STID);
+					}
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -4742,8 +4756,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 	struct nfs4_delegation *dp = cb_to_delegation(cb);
 
 	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
-	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
-	        return 1;
+	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID ||
+	    dp->dl_stid.sc_type == NFS4_ADMIN_REVOKED_DELEG_STID)
+		return 1;
 
 	switch (task->tk_status) {
 	case 0:
@@ -5770,7 +5785,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
-		revoke_delegation(dp);
+		revoke_delegation(dp, NFS4_REVOKED_DELEG_STID);
 	}
 
 	spin_lock(&nn->client_lock);
@@ -5988,8 +6003,9 @@ nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 	 */
 	if (typemask & NFS4_REVOKED_DELEG_STID)
 		return_revoked = true;
-	else if (typemask & NFS4_DELEG_STID)
-		typemask |= NFS4_REVOKED_DELEG_STID;
+	if (typemask & NFS4_DELEG_STID)
+		typemask |= NFS4_REVOKED_DELEG_STID |
+			NFS4_ADMIN_REVOKED_DELEG_STID;
 
 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
 		CLOSE_STATEID(stateid))
@@ -6330,6 +6346,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		ret = nfs_ok;
 		goto out;
 	case NFS4_REVOKED_DELEG_STID:
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
 		spin_unlock(&s->sc_lock);
 		dp = delegstateid(s);
 		list_del_init(&dp->dl_recall_lru);


