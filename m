Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0F847EEAF9
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Nov 2023 03:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjKQCVx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Nov 2023 21:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQCVw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Nov 2023 21:21:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5167CE
        for <linux-nfs@vger.kernel.org>; Thu, 16 Nov 2023 18:21:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5661F2050A;
        Fri, 17 Nov 2023 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700187707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Jc5ZLDjZeUGgghXKVqK5RnTFLYj9gHqEKCFa7zY3nQ=;
        b=bbgyF2DK3glu/lJZWPRkUW8jidixtun1urmxQSDH9U97JmzzIlMnvR5PsO22OfmmpFcGG+
        +ywn+zeoFi0+iHZnVqLMUfDFn7Wz2Yzw7xmhBm8ne8UWQH/w/o+OR3DaeQVtZK7PVXeXm0
        dfK8B46K2Cafa4P5vjtKmxnqNKtAoPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700187707;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Jc5ZLDjZeUGgghXKVqK5RnTFLYj9gHqEKCFa7zY3nQ=;
        b=o2+S8pk7lceHsXpHl+QAZH1dLhWiDastwosZtyRTiPMEVsc/X2+WekSB1QoOjm0srijmz2
        /zE3fxkNvxAnr8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BF631341F;
        Fri, 17 Nov 2023 02:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WVPPADnOVmUmEwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 17 Nov 2023 02:21:45 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/9] nfsd: avoid race after unhash_delegation_locked()
Date:   Fri, 17 Nov 2023 13:18:48 +1100
Message-ID: <20231117022121.23310-3-neilb@suse.de>
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
         RCVD_TLS_ALL(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS4_CLOSED_DELEG_STID and NFS4_REVOKED_DELEG_STID are similar in
purpose.
REVOKED is used for NFSv4.1 states which have been revoked because the
lease has expired.  CLOSED is used in other cases.
The difference has two practical effects.
1/ REVOKED states are on the ->cl_revoked list
2/ REVOKED states result in nfserr_deleg_revoked from
   nfsd4_verify_open_stid() asnd nfsd4_validate_stateid while
   CLOSED states result in nfserr_bad_stid.

Currently a state that is being revoked is first set to "CLOSED" in
unhash_delegation_locked(), then possibly to "REVOKED" in
revoke_delegation(), at which point it is added to the cl_revoked list.

It is possible that a stateid test could see the CLOSED state
which really should be REVOKED, and so return the wrong error code.  So
it is safest to remove this window of inconsistency.

With this patch, unhash_delegation_locked() always set the state
correctly, and revoke_delegation() no longer changes the state.

Also remove a redundant test on minorversion when
NFS4_REVOKED_DELEG_STID is seen - it can only be seen when minorversion
is non-zero.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6368788a7d4e..7469583382fb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1334,7 +1334,7 @@ static bool delegation_hashed(struct nfs4_delegation *dp)
 }
 
 static bool
-unhash_delegation_locked(struct nfs4_delegation *dp)
+unhash_delegation_locked(struct nfs4_delegation *dp, unsigned char type)
 {
 	struct nfs4_file *fp = dp->dl_stid.sc_file;
 
@@ -1343,7 +1343,9 @@ unhash_delegation_locked(struct nfs4_delegation *dp)
 	if (!delegation_hashed(dp))
 		return false;
 
-	dp->dl_stid.sc_type = NFS4_CLOSED_DELEG_STID;
+	if (dp->dl_stid.sc_client->cl_minorversion == 0)
+		type = NFS4_CLOSED_DELEG_STID;
+	dp->dl_stid.sc_type = type;
 	/* Ensure that deleg break won't try to requeue it */
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
@@ -1359,7 +1361,7 @@ static void destroy_delegation(struct nfs4_delegation *dp)
 	bool unhashed;
 
 	spin_lock(&state_lock);
-	unhashed = unhash_delegation_locked(dp);
+	unhashed = unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID);
 	spin_unlock(&state_lock);
 	if (unhashed)
 		destroy_unhashed_deleg(dp);
@@ -1373,9 +1375,8 @@ static void revoke_delegation(struct nfs4_delegation *dp)
 
 	trace_nfsd_stid_revoke(&dp->dl_stid);
 
-	if (clp->cl_minorversion) {
+	if (dp->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		spin_lock(&clp->cl_lock);
-		dp->dl_stid.sc_type = NFS4_REVOKED_DELEG_STID;
 		refcount_inc(&dp->dl_stid.sc_count);
 		list_add(&dp->dl_recall_lru, &clp->cl_revoked);
 		spin_unlock(&clp->cl_lock);
@@ -2234,7 +2235,7 @@ __destroy_client(struct nfs4_client *clp)
 	spin_lock(&state_lock);
 	while (!list_empty(&clp->cl_delegations)) {
 		dp = list_entry(clp->cl_delegations.next, struct nfs4_delegation, dl_perclnt);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -5197,8 +5198,7 @@ nfs4_check_deleg(struct nfs4_client *cl, struct nfsd4_open *open,
 		goto out;
 	if (deleg->dl_stid.sc_type == NFS4_REVOKED_DELEG_STID) {
 		nfs4_put_stid(&deleg->dl_stid);
-		if (cl->cl_minorversion)
-			status = nfserr_deleg_revoked;
+		status = nfserr_deleg_revoked;
 		goto out;
 	}
 	flags = share_access_to_flags(open->op_share_access);
@@ -6235,7 +6235,7 @@ nfs4_laundromat(struct nfsd_net *nn)
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
 		if (!state_expired(&lt, dp->dl_time))
 			break;
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp, NFS4_REVOKED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
@@ -8350,7 +8350,7 @@ nfs4_state_shutdown_net(struct net *net)
 	spin_lock(&state_lock);
 	list_for_each_safe(pos, next, &nn->del_recall_lru) {
 		dp = list_entry (pos, struct nfs4_delegation, dl_recall_lru);
-		WARN_ON(!unhash_delegation_locked(dp));
+		WARN_ON(!unhash_delegation_locked(dp, NFS4_CLOSED_DELEG_STID));
 		list_add(&dp->dl_recall_lru, &reaplist);
 	}
 	spin_unlock(&state_lock);
-- 
2.42.0

