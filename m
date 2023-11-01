Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5E7DDA7A
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 02:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376989AbjKABBk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 21:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376986AbjKABBj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 21:01:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1FEDA
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 18:01:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D901E2184F;
        Wed,  1 Nov 2023 01:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698800495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBjx/eZua0itBAgwFVdiluI795jNhIuQXlz6Q4PUwFc=;
        b=yN51Jdz6s6nnaQYJdtXOLFUEiekjBdO4VkgdDIi0MaCFiGccZYEEmBr0W9Wnq3KkwhEhrz
        71Z0WjSL8OH5+BLpkFLGt/qUOYpzFCHAiGzkysgH2PubSmx7E2qOYVTeU+7as/fSFk/JtK
        /kPzD6aRqIWvQBTwG0BwP3l82GZ9hYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698800495;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jBjx/eZua0itBAgwFVdiluI795jNhIuQXlz6Q4PUwFc=;
        b=7Xih1imGNiLefIgt6RnyCsNkC53GdNvEwniC0eQq4jYb1xhAA7dUioZLyOhUeuVU+BR3Tp
        reUPkkSxJf4fnwDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BC13138EF;
        Wed,  1 Nov 2023 01:01:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S+ZjBWqjQWUjOwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 01:01:30 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then freed
Date:   Wed,  1 Nov 2023 11:57:13 +1100
Message-ID: <20231101010049.27315-7-neilb@suse.de>
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

Revoking state through 'unlock_filesystem' now revokes any delegation
states found.  When the stateids are then freed by the client, the
revoked stateids will be cleaned up correctly.

As there is already support for revoking delegations, we build on that
for admin-revoking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ed879f68944b..9fdbdc64262d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1367,7 +1367,8 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 		destroy_unhashed_deleg(dp);
 }
 
-static void revoke_delegation(struct nfs4_delegation *dp)
+static void revoke_delegation(struct nfs4_delegation *dp,
+			      unsigned short sc_type)
 {
 	struct nfs4_client *clp = dp->dl_stid.sc_client;
 
@@ -1375,9 +1376,9 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (clp->cl_minorversion) {
+	if (clp->cl_minorversion || sc_type == NFS4_ADMIN_REVOKED_DELEG_STID) {
 		spin_lock(&clp->cl_lock);
-		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
+		dp->dl_stid.sc_type = sc_type;
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
@@ -1708,7 +1709,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned short sc_types;
 
-	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1720,6 +1721,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 								  sc_types);
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
+				struct nfs4_delegation *dp;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1758,6 +1760,18 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
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
@@ -4695,6 +4709,7 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 	struct nfs4_client *cl = s->sc_client;
 	LIST_HEAD(reaplist);
 	struct nfs4_ol_stateid *stp;
+	struct nfs4_delegation *dp;
 	bool unhashed;
 
 	switch (s->sc_type) {
@@ -4712,6 +4727,12 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 		if (unhashed)
 			nfs4_put_stid(s);
 		break;
+	case NFS4_ADMIN_REVOKED_DELEG_STID:
+		dp = delegstateid(s);
+		list_del_init(&dp->dl_recall_lru);
+		spin_unlock(&cl->cl_lock);
+		nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}
@@ -5073,8 +5094,9 @@ static int nfsd4_cb_recall_done(struct nfsd4_callback *cb,
 	trace_nfsd_cb_recall_done(&dp->dl_stid.sc_stateid, task);
 
 	if (dp->dl_stid.sc_type == NFS4_CLOSED_DELEG_STID ||
-	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID)
-	        return 1;
+	    dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID ||
+	    dp->dl_stid.sc_type == NFS4_ADMIN_REVOKED_DELEG_STID)
+		return 1;
 
 	switch (task->tk_status) {
 	case 0:
@@ -6438,7 +6460,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
-		revoke_delegation(dp);
+		revoke_delegation(dp, NFS4_REVOKED_DELEG_STID);
 	}
 
 	spin_lock(&nn->client_lock);
-- 
2.42.0

