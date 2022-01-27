Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1458149D9BA
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 05:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236095AbiA0E7t (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 23:59:49 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44080 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiA0E7s (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 23:59:48 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D1DA218E8;
        Thu, 27 Jan 2022 04:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643259587; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAyYFRFbqVs3ttE0Jk7k2AtafmN+5suCAaIm4G6c5tw=;
        b=t9EQEs7W2KGsC5CHJNjgXIM7w1R70D0UOTY4yVSaFj3xH1KMh1WzBCb3dNLu5CU5Its7zK
        DW+FrtRqCCbIB80vA7NDpwhLcd04VB++McwyrM2U8mPeOqqHtIlvEf00isHphFqtRP0zs8
        ZwMj2vTRq0dZqiyP3ph6a5KlRXufjek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643259587;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GAyYFRFbqVs3ttE0Jk7k2AtafmN+5suCAaIm4G6c5tw=;
        b=tJX87Npq1XHSHtbMO0/Ln7bwvWkisZY9b28PBOSzrvgHlg6VMvGZO31gavIPB89uqVS5CD
        qk06RxnysdG2RXBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74C3C13BCF;
        Thu, 27 Jan 2022 04:59:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f3N0DMIm8mE2VgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 04:59:46 +0000
Subject: [PATCH 2/4] nfsd: allow open state ids to be revoked and then freed
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 15:58:10 +1100
Message-ID: <164325949070.23133.8692722614255991208.stgit@noble.brown>
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Revoking state through 'unlock_filesystem' now revokes any open states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Possibly the related lock states should be revoked too, but a
subsequent patch will do that for all lock state on the superblock.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c |   37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index ad02b4ebe1b6..6854546ebd08 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1113,6 +1113,9 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+		atomic_dec(&clp->cl_admin_revoked);
+	s->sc_type = 0;
 	nfs4_free_cpntf_statelist(clp->net, s);
 	spin_unlock(&clp->cl_lock);
 	s->sc_free(s);
@@ -1165,6 +1168,9 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
 
 void nfs4_unhash_stid(struct nfs4_stid *s)
 {
+	struct nfs4_client *clp = s->sc_client;
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+		atomic_dec(&clp->cl_admin_revoked);
 	s->sc_type = 0;
 }
 
@@ -1431,6 +1437,9 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
 	}
 
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+		atomic_dec(&clp->cl_admin_revoked);
+	s->sc_type = 0;
 	list_add(&stp->st_locks, reaplist);
 }
 
@@ -1601,7 +1610,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned short sc_types;
 
-	sc_types = 0;
+	sc_types = NFS4_OPEN_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1612,8 +1621,23 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 			struct nfs4_stid *stid = find_one_sb_stid(clp, sb,
 								  sc_types);
 			if (stid) {
+				struct nfs4_ol_stateid *stp;
+
 				spin_unlock(&nn->client_lock);
 				switch (stid->sc_type) {
+				case NFS4_OPEN_STID:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  OPEN_STATEID_MUTEX);
+					if (stid->sc_type == NFS4_OPEN_STID) {
+						release_all_access(stp);
+						stid->sc_type =
+							NFS4_ADMIN_REVOKED_STID;
+						atomic_inc(&clp->cl_admin_revoked);
+						/* FIXME revoke the locks */
+					}
+					mutex_unlock(&stp->st_mutex);
+					break;
 				}
 				nfs4_put_stid(stid);
 				spin_lock(&nn->client_lock);
@@ -6235,6 +6259,8 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	stateid_t *stateid = &free_stateid->fr_stateid;
 	struct nfs4_stid *s;
 	struct nfs4_delegation *dp;
+	struct nfs4_ol_stateid *stp;
+	LIST_HEAD(reaplist);
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
@@ -6259,6 +6285,15 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		spin_unlock(&cl->cl_lock);
 		ret = nfsd4_free_lock_stateid(stateid, s);
 		goto out;
+	case NFS4_ADMIN_REVOKED_STID:
+		stp = openlockstateid(s);
+		spin_unlock(&s->sc_lock);
+		if (unhash_open_stateid(stp, &reaplist))
+			put_ol_stateid_locked(stp, &reaplist);
+		spin_unlock(&cl->cl_lock);
+		free_ol_stateid_reaplist(&reaplist);
+		ret = nfs_ok;
+		goto out;
 	case NFS4_REVOKED_DELEG_STID:
 		spin_unlock(&s->sc_lock);
 		dp = delegstateid(s);


