Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED017EEB03
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKQCWa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjKQCWa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:22:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEE9D4E
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:22:26 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 69B1B1F8C2;
        Fri, 17 Nov 2023 02:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3Q/d0DHlV1rM4Ulsg2PL6DcvjD8jrR/iOTNSW1MY4Q=;
        b=FCcJ/Z5TM7wvPDFmSdCZKky31fQNC1ZvLKzOshy8Ma8vZHVrV57tAaddQ2MiSngwOk/N8J
        T4Wf05io+lYmDTEdum5Dfz17s3DjYBEvlGr80nQqxTQQp8HRbNaBzbBK3ryVeCXnwWRLfK
        aDOKGnlv+TsodgYsaGpLzlXlhgNC7yE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187745;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y3Q/d0DHlV1rM4Ulsg2PL6DcvjD8jrR/iOTNSW1MY4Q=;
        b=d1dZFun5jn1LDh55O+BNHsjb9YapI8RxCZLpJf+sz8AaFy0ZuZdQzFtPIyJs7WQiFZ5SGZ
        +3jTI1oNSRPqHmCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57A661341F;
        Fri, 17 Nov 2023 02:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2EQOBF/OVmVxEwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:22:23 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 9/9] nfsd: allow delegation state ids to be revoked and then freed
Date:   Fri, 17 Nov 2023 13:18:55 +1100
Message-ID: <20231117022121.23310-10-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117022121.23310-1-neilb@suse.de>
References: <20231117022121.23310-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
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
         BAYES_HAM(-0.00)[44.20%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
 fs/nfsd/nfs4state.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index dd454f50383e..feceaf4bf638 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1340,9 +1340,12 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned int statusmask)
 	if (!delegation_hashed(dp))
 		return false;
 
-	if (dp->dl_stid.sc_client->cl_minorversion == 0)
+	if (statusmask == NFS4_STID_REVOKED &&
+	    dp->dl_stid.sc_client->cl_minorversion == 0)
 		statusmask = NFS4_STID_CLOSED;
 	dp->dl_stid.sc_status |= statusmask;
+	if (statusmask & NFS4_STID_ADMIN_REVOKED)
+		atomic_inc(&dp->dl_stid.sc_client->cl_admin_revoked);
 
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
@@ -1373,7 +1376,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (dp->dl_stid.sc_status & NFS4_STID_REVOKED) {
+	if (dp->dl_stid.sc_status &
+	    (NFS4_STID_REVOKED | NFS4_STID_ADMIN_REVOKED)) {
 		spin_lock(&clp->cl_lock);
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
@@ -1708,7 +1712,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned int sc_types;
 
-	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID | NFS4_DELEG_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1720,6 +1724,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 								  sc_types);
 			if (stid) {
 				struct nfs4_ol_stateid *stp;
+				struct nfs4_delegation *dp;
 
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
@@ -1765,6 +1770,18 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 						spin_unlock(&clp->cl_lock);
 					mutex_unlock(&stp->st_mutex);
 					break;
+				case NFS4_DELEG_STID:
+					dp = delegstateid(stid);
+					spin_lock(&state_lock);
+					if (!unhash_delegation_locked(
+						    dp, NFS4_STID_ADMIN_REVOKED))
+						dp = NULL;
+					spin_unlock(&state_lock);
+					if (dp) {
+						list_del_init(&dp->dl_recall_lru);
+						revoke_delegation(dp);
+					}
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -4707,6 +4724,7 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 	struct nfs4_client *cl = s->sc_client;
 	LIST_HEAD(reaplist);
 	struct nfs4_ol_stateid *stp;
+	struct nfs4_delegation *dp;
 	bool unhashed;
 
 	switch (s->sc_type) {
@@ -4724,6 +4742,12 @@ static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 		if (unhashed)
 			nfs4_put_stid(s);
 		break;
+	case NFS4_DELEG_STID:
+		dp = delegstateid(s);
+		list_del_init(&dp->dl_recall_lru);
+		spin_unlock(&cl->cl_lock);
+		nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}
-- 
2.42.0

