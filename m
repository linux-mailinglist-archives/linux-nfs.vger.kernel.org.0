Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5707DDA75
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 02:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376970AbjKABB2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 21:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376924AbjKABB2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 21:01:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C337C9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 18:01:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B00D2184F;
        Wed,  1 Nov 2023 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698800481; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Scl/o8gKJcHv4TzzDIWxdel+REbpoagEpcQ1ANoph9E=;
        b=riY1Cu97Wofn7/Go8f2B7RJ2iiF+AzP6IkqsFUHv1SOLR6rq4pZa2EypGw1wDGocFTKaoQ
        FFWN+7ajBFiGPtOGgTMc5ZrNN67dwST9R/cTlbOuBLWGeQ3YB4/wqjf3mAg0XN8s09ys+b
        2qtPBfw8rNUWzKHXIqn2TZKNPbTRFF0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698800481;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Scl/o8gKJcHv4TzzDIWxdel+REbpoagEpcQ1ANoph9E=;
        b=vzpVLswD07dwGXjF1UQwJifvIPchgB2fcCbntKEVFhRfxGv2j4CmtkQRMNYs889wrypxot
        7D72uFSJC83AKUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C5CF138EF;
        Wed,  1 Nov 2023 01:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2eAoFV2jQWUQOwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 01 Nov 2023 01:01:17 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Subject: [PATCH 4/6] nfsd: allow lock state ids to be revoked and then freed
Date:   Wed,  1 Nov 2023 11:57:11 +1100
Message-ID: <20231101010049.27315-5-neilb@suse.de>
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

Revoking state through 'unlock_filesystem' now revokes any lock states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 13484a9cef21..c2e064f6c7c4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1708,7 +1708,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned short sc_types;
 
-	sc_types = 0;
+	sc_types = NFS4_LOCK_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1719,8 +1719,33 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
 								  sc_types);
 			if (stid) {
+				struct nfs4_ol_stateid *stp;
+
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case NFS4_LOCK_STID:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  LOCK_STATEID_MUTEX);
+					if (stid->sc_type == NFS4_LOCK_STID) {
+						struct nfs4_lockowner *lo =
+							lockowner(stp->st_stateowner);
+						struct nfsd_file *nf;
+
+						nf = find_any_file(stp->st_stid.sc_file);
+						if (nf) {
+							get_file(nf->nf_file);
+							filp_close(nf->nf_file,
+								   (fl_owner_t)lo);
+							nfsd_file_put(nf);
+						}
+						release_all_access(stp);
+						stid->sc_type =
+							NFS4_ADMIN_REVOKED_LOCK_STID;
+						atomic_inc(&clp->cl_admin_revoked);
+					}
+					mutex_unlock(&stp->st_mutex);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -4656,8 +4681,17 @@ nfsd4_find_existing_open(struct nfs4_file *fp, struct nfsd4_open *open)
 static void nfsd_drop_revoked_stid(struct nfs4_stid *s)
 {
 	struct nfs4_client *cl = s->sc_client;
+	struct nfs4_ol_stateid *stp;
+	bool unhashed;
 
 	switch (s->sc_type) {
+	case NFS4_ADMIN_REVOKED_LOCK_STID:
+		stp = openlockstateid(s);
+		unhashed = unhash_lock_stateid(stp);
+		spin_unlock(&cl->cl_lock);
+		if (unhashed)
+			nfs4_put_stid(s);
+		break;
 	default:
 		spin_unlock(&cl->cl_lock);
 	}
-- 
2.42.0

