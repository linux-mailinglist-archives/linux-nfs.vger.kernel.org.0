Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95DE349D9BB
	for <lists+linux-nfs@lfdr.de>; Thu, 27 Jan 2022 05:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236094AbiA0E7y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 Jan 2022 23:59:54 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44292 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiA0E7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 Jan 2022 23:59:53 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 86D21218E5;
        Thu, 27 Jan 2022 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643259592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAcoqnGfYY92T5Yl55ulImuSDryAJbckhKtTwJNvkMA=;
        b=bb5UOy1BjOJfduYRJAco+LZWeW9AXZWDwAHc+pMb4rF4b5okGCNQLYwL9rDhFKgrujdjsM
        eQf/+L/XwaIqCbsFnjaGHb5MtedqSwygo+YuFGm4pyiohanQmxiuIB2BgrRALIl7sOMP9i
        1ror4Cc9VbgkSL2UjmTLAcW3KkcQymg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643259592;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAcoqnGfYY92T5Yl55ulImuSDryAJbckhKtTwJNvkMA=;
        b=JTA3oFALjpR4DafEcgFrpe9lbEeFIn7ekF2b4eAsLibPEfdwC3JivN0I2j0pqhvoyxtJjq
        VhSpONwRc61BsIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF4DB13BCF;
        Thu, 27 Jan 2022 04:59:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IsPnGscm8mFIVgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 27 Jan 2022 04:59:51 +0000
Subject: [PATCH 3/4] nfsd: allow lock state ids to be revoked and then freed
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 27 Jan 2022 15:58:10 +1100
Message-ID: <164325949071.23133.937354557714722900.stgit@noble.brown>
In-Reply-To: <164325908579.23133.4781039121536248752.stgit@noble.brown>
References: <164325908579.23133.4781039121536248752.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Revoking state through 'unlock_filesystem' now revokes any lock states
found.  When the stateids are then freed by the client, the revoked
stateids will be cleaned up correctly.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfs4state.c |   43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 6854546ebd08..b1dc8ed1d356 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1113,7 +1113,8 @@ nfs4_put_stid(struct nfs4_stid *s)
 		return;
 	}
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
-	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID ||
+	    s->sc_type == NFS4_ADMIN_REVOKED_LOCK_STID)
 		atomic_dec(&clp->cl_admin_revoked);
 	s->sc_type = 0;
 	nfs4_free_cpntf_statelist(clp->net, s);
@@ -1169,7 +1170,8 @@ static void destroy_unhashed_deleg(struct nfs4_delegation *dp)
 void nfs4_unhash_stid(struct nfs4_stid *s)
 {
 	struct nfs4_client *clp = s->sc_client;
-	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID ||
+	    s->sc_type == NFS4_ADMIN_REVOKED_LOCK_STID)
 		atomic_dec(&clp->cl_admin_revoked);
 	s->sc_type = 0;
 }
@@ -1437,7 +1439,8 @@ static void put_ol_stateid_locked(struct nfs4_ol_stateid *stp,
 	}
 
 	idr_remove(&clp->cl_stateids, s->sc_stateid.si_opaque.so_id);
-	if (s->sc_type == NFS4_ADMIN_REVOKED_STID)
+	if (s->sc_type == NFS4_ADMIN_REVOKED_STID ||
+	    s->sc_type == NFS4_ADMIN_REVOKED_LOCK_STID)
 		atomic_dec(&clp->cl_admin_revoked);
 	s->sc_type = 0;
 	list_add(&stp->st_locks, reaplist);
@@ -1610,7 +1613,7 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 	unsigned int idhashval;
 	unsigned short sc_types;
 
-	sc_types = NFS4_OPEN_STID;
+	sc_types = NFS4_OPEN_STID | NFS4_LOCK_STID;
 
 	spin_lock(&nn->client_lock);
 	for (idhashval = 0; idhashval < CLIENT_HASH_MASK; idhashval++) {
@@ -1638,6 +1641,28 @@ void nfsd4_revoke_states(struct net *net, struct super_block *sb)
 					}
 					mutex_unlock(&stp->st_mutex);
 					break;
+				case NFS4_LOCK_STID:
+					stp = openlockstateid(stid);
+					mutex_lock_nested(&stp->st_mutex,
+							  LOCK_STATEID_MUTEX);
+					if (stid->sc_type == NFS4_LOCK_STID) {
+						struct nfs4_lockowner *lo =
+							lockowner(stp->st_stateowner);
+						struct nfsd_file *nf;
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
@@ -6261,6 +6286,7 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	struct nfs4_delegation *dp;
 	struct nfs4_ol_stateid *stp;
 	LIST_HEAD(reaplist);
+	bool unhashed;
 	struct nfs4_client *cl = cstate->clp;
 	__be32 ret = nfserr_bad_stateid;
 
@@ -6294,6 +6320,15 @@ nfsd4_free_stateid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		free_ol_stateid_reaplist(&reaplist);
 		ret = nfs_ok;
 		goto out;
+	case NFS4_ADMIN_REVOKED_LOCK_STID:
+		stp = openlockstateid(s);
+		spin_unlock(&s->sc_lock);
+		unhashed = unhash_lock_stateid(stp);
+		spin_unlock(&cl->cl_lock);
+		if (unhashed)
+			nfs4_put_stid(s);
+		ret = nfs_ok;
+		goto out;
 	case NFS4_REVOKED_DELEG_STID:
 		spin_unlock(&s->sc_lock);
 		dp = delegstateid(s);


