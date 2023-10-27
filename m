Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16807D8CF1
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Oct 2023 03:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJ0B5F (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 21:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJ0B5E (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 21:57:04 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA33D1BB
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 18:57:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9684321A5C;
        Fri, 27 Oct 2023 01:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698371820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrYJh+nllpwS6Xh98oEzv9An6BYkELWHgZt8GpFRT60=;
        b=f8y/ieNo9amW0MNbnvJ5eMd5zdpdDhrPBQRXvlcg7KQuK4GXj2MpMJwPFLrBjgIxBdNj4N
        kUd1EbzG1oIvFxYkaUac15Syv6YIyaQZq3YJJ7pb62TMztIi4ek+3YNQa27oIF1yOCRtAf
        5W0lp7VaUmMbnYOhXcjz5valuvSy+rQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698371820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TrYJh+nllpwS6Xh98oEzv9An6BYkELWHgZt8GpFRT60=;
        b=YhjFFgmJ1FpCPkA4uCjA5IZQxX9hGWgs56Zf4s6rA9ExMBo5OrMnYCeaQkXNC+VtOMDLlk
        K0MZdX3lVIBFo9DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 891E1133F5;
        Fri, 27 Oct 2023 01:56:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id imjND+oYO2U0CgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Oct 2023 01:56:58 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] nfsd: allow delegation state ids to be revoked and then freed
Date:   Fri, 27 Oct 2023 12:45:34 +1100
Message-ID: <20231027015613.26247-7-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231027015613.26247-1-neilb@suse.de>
References: <20231027015613.26247-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
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
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index ee93ab5d1e0f..ccdf3beb3640 100644
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
 				if (clp->cl_minorversion == 0)
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
@@ -6436,7 +6458,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_first_entry(&reaplist, struct nfs4_delegation,
 					dl_recall_lru);
 		list_del_init(&dp->dl_recall_lru);
-		revoke_delegation(dp);
+		revoke_delegation(dp, NFS4_REVOKED_DELEG_STID);
 	}
 
 	spin_lock(&nn->client_lock);
-- 
2.42.0

