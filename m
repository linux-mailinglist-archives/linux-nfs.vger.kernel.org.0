Return-Path: <linux-nfs+bounces-22102-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNIeLwXkGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22102-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95F60CEDE
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB61C3024A20
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0373AFD16;
	Sat, 30 May 2026 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlzXj3QL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC213C3BFD;
	Sat, 30 May 2026 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147180; cv=none; b=h7XNWCmjspCRvBvTf7sib378iqFGFo1XHQxXtxld7qnbqzcFUkaOQBqMGRKh5XH3QLcXKcibYvGgpBp1EWIgp81Mr6B6aPO/YPAuu1T83KYyPxaDS4+BwPMfx7vuKwOl235bl13vH8lng6/l6QZOUQQaKI2252HZ0lk1xuT2a2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147180; c=relaxed/simple;
	bh=uVs0ovhPONdj+jaVLIvw14XxurhtpfdRNc67sMGov74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tnKYFuTBHp0wH8EmClHIk/fEJbEpEdeMyFZu4JY3FZrl11mtGLIZFvvPdXDLceqkCzn7eyBeL/sWuawecHvNcHq93OGPrdjsRzd6W6V3WSmADofhNCRivXGfvowASyGA7lZHnhwAxPDYmkgYMLuLmu8yEa4ZJCf5UqzQnkXYCmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlzXj3QL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8452C1F0089C;
	Sat, 30 May 2026 13:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147178;
	bh=M+5wGtzS4e6NAu+j5ObGYbaTEVrdLRmUONcdzarv2nM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AlzXj3QL9rbptVcXXFy8Y3TNU77mxWUAB7fZRNM9vO7EIjbpS/NOyZXiqtv3r9tIv
	 CsaUOgqnP+8Ko6stCfAXkimVVBNtRUq4rMLQNQftoZCxHVcfRKvaIjLWn1GROraF3N
	 DTUXwOtw4i7HQ4xEgCSBqnMikc4MXr96zuHGaiGTWPKDf8vBz5dUv1ZQzR9/WYo/Gf
	 kvismieUAzesoCDkmUoDzQyL94WWjw+J+u6fqy/JgeEx6yAOceXPAhWfa/QIKR9GkH
	 h7aUAiL1zZqRNIf0IG7WLCzG1K+oPb6/MEztNYyp6maJqSXv5YGzlCNkyg9VaUyZbs
	 uTjqR3omAEUjg==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:20 -0400
Subject: [PATCH v2 4/9] nfsd: dedup nfs4_client_to_reclaim inserts
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-4-f27e8eb4d974@kernel.org>
References: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
In-Reply-To: <20260530-nfsd-fixes-v2-0-f27e8eb4d974@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "J. Bruce Fields" <bfields@fieldses.org>, 
 Scott Mayhew <smayhew@redhat.com>, 
 Trond Myklebust <Trond.Myklebust@netapp.com>, 
 Andreas Gruenbacher <agruen@suse.de>, Mike Snitzer <snitzer@kernel.org>, 
 Rick Macklem <rmacklem@uoguelph.ca>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11934; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=uVs0ovhPONdj+jaVLIvw14XxurhtpfdRNc67sMGov74=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPhse7vXSgjRtY6+ITL6d1u6P9Qd73CuJLCG
 nBN7y/dPBOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4QAKCRAADmhBGVaC
 FdH+EACRwFkbMiUiT21GrtzhHImpg9Gi2T62dJeHdNfYdJrJTNudwENiR8n163YvkqrJRf9deXv
 8tMZUpi6NnoeeKW800EDj3wnHOjtzcGvQkuM986IdRVJn2Pi05DjSi05otK/qk7TuYjV4zmqNM7
 iOsqMPW8D6DOTJxOMLumcsTskdXnBf331gZV+n53nYh5Kv0XCAWo8IQj7wCavSzpOQZb5fluf0v
 DGKexfFVTo1Jg0buOUnla5xPgh+ude2TaMaiQsCCfkAhe+Vx6R7MgN8Ak1lbV3ztXC7ktvi69Cz
 iawO8D5Nz6Jm98hpuJ0dXEpsBHsl/Q+OTehd3V/4JMRCC4Wdh74D9Ae+bAjEzxf5UNS5AxE84rq
 VntnpfsnwDIaGEF1DHngkGnl2AeOe6ndcGIXtwKt0RVfSZMhxBUQwoBoz/fL6PgMLXTdS5yRJq6
 Ndm+c7koVnwZcCABvx1GI1VaPksXNYAP9t+rUMFE0cn3lpAWFxFSGy1uQjE7F2uCEo/VDmPlDup
 vexh1uQzmnmO+xTp1reN3t1YHB9FykY8FCV4tl7FL/KQgzIcIFJO0f00roE2EUSmgHnrKMOWegj
 uN2QzRVWz+vw/q64pQHZlkRZ0DYp1wRLpkJ8zsks6sSx7safurZbx92voQ1N5YTbSMMBhGY7LLy
 MebibrF4yWSovdQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22102-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,name.data:url]
X-Rspamd-Queue-Id: 5E95F60CEDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nfs4_client_to_reclaim() unconditionally allocates a new
nfs4_client_reclaim, prepends it to reclaim_str_hashtbl[], and bumps
reclaim_str_hashtbl_size with no check for an existing entry for the
same client name.  After a reboot with a populated recovery directory
that inflates the counter by one for every client that reclaims:

    boot:    load_recdir()
               nfs4_client_to_reclaim(name)   /* entry #1, size++ */

    grace:   RECLAIM_COMPLETE
               __nfsd4_create_reclaim_record_grace()
                 nfs4_client_to_reclaim(name) /* entry #2, size++ */

inc_reclaim_complete() ends the grace period early only when

    atomic_inc_return(&nn->nr_reclaim_complete) ==
        nn->reclaim_str_hashtbl_size

With reclaim_str_hashtbl_size at 2N and nr_reclaim_complete capped at
N, the equality never holds and the fast end-of-grace path is dead.
The grace period always runs out the full 90-second laundromat timer,
and the shadow entry left in the hash table carries a dangling cr_clp
for any reader that walks it.

Fix nfs4_client_to_reclaim() to look the name up with
nfsd4_find_reclaim_client() first and, on a hit, fold the new
princhash into the existing record (if it lacks one) and return that
record without allocating or touching reclaim_str_hashtbl_size.  On
kmemdup() failure during the fold-in, return NULL so
__cld_pipe_inprogress_downcall() surfaces -EFAULT to nfsdcld, matching
the miss-path contract.

Add an rw_semaphore (reclaim_str_hashtbl_lock) to struct nfsd_net that
serialises all access to reclaim_str_hashtbl[] and
reclaim_str_hashtbl_size.  Writers (nfs4_client_to_reclaim,
nfs4_remove_reclaim_record callers) hold the write side; readers
(nfsd4_cld_check*, inc_reclaim_complete, clients_still_reclaiming,
nfs4_has_reclaimed_state, nfsd4_check_legacy_client) hold the read
side.  All call sites are in sleepable context, and none is a hot
path, so the rwsem cost is negligible.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld")
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h       |  6 ++++-
 fs/nfsd/nfs4recover.c | 36 ++++++++++++++++++++++++------
 fs/nfsd/nfs4state.c   | 61 ++++++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 37dfecb9d49d..47bbd4fb42b0 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -93,6 +93,7 @@ struct nfsd_net {
 	 */
 	struct list_head *reclaim_str_hashtbl;
 	int reclaim_str_hashtbl_size;
+	struct rw_semaphore reclaim_str_hashtbl_lock;
 	struct list_head *conf_id_hashtbl;
 	struct rb_root conf_name_tree;
 	struct list_head *unconf_id_hashtbl;
@@ -105,7 +106,10 @@ struct nfsd_net {
 	 * close_lru holds (open) stateowner queue ordered by nfs4_stateowner.so_time
 	 * for last close replay.
 	 *
-	 * All of the above fields are protected by the client_mutex.
+	 * reclaim_str_hashtbl[], reclaim_str_hashtbl_size are protected by
+	 * reclaim_str_hashtbl_lock.
+	 *
+	 * All of the remaining fields are protected by the client_mutex.
 	 */
 	struct list_head client_lru;
 	struct list_head close_lru;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c841da585142..d513971fb119 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -285,10 +285,12 @@ __nfsd4_remove_reclaim_record_grace(const char *dname, int len,
 		return;
 	}
 	name.len = len;
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	kfree(name.data);
 	if (crp)
 		nfs4_remove_reclaim_record(crp, nn);
+	up_write(&nn->reclaim_str_hashtbl_lock);
+	kfree(name.data);
 }
 
 static void
@@ -484,6 +486,7 @@ nfs4_legacy_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 
 	return 0;
 }
@@ -598,13 +601,16 @@ nfsd4_check_legacy_client(struct nfs4_client *clp)
 		goto out_enoent;
 	}
 	name.len = HEXDIR_LEN;
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	kfree(name.data);
 	if (crp) {
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 		crp->cr_clp = clp;
-		return 0;
 	}
+	up_read(&nn->reclaim_str_hashtbl_lock);
+	kfree(name.data);
+	if (crp)
+		return 0;
 
 out_enoent:
 	return -ENOENT;
@@ -1176,6 +1182,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1191,6 +1198,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data!\n",
 				__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1201,9 +1209,11 @@ nfsd4_cld_check(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1215,6 +1225,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	struct cld_net *cn = nn->cld_net;
 #endif
 	struct nfs4_client_reclaim *crp;
+	unsigned int princhashlen;
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
@@ -1222,6 +1233,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1237,6 +1249,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data\n",
 					__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1247,23 +1260,31 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
-	if (crp->cr_princhash.len) {
+	princhashlen = crp->cr_princhash.len;
+	if (princhashlen) {
 		u8 digest[SHA256_DIGEST_SIZE];
+		u8 *pdata;
 
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
-		if (principal == NULL)
+		if (principal == NULL) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 		sha256(principal, strlen(principal), digest);
-		if (memcmp(crp->cr_princhash.data, digest,
-				crp->cr_princhash.len))
+		pdata = crp->cr_princhash.data;
+		if (memcmp(pdata, digest, princhashlen)) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 	}
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1362,6 +1383,7 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 	set_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bc5216bb08ff..5bbc1d2b964a 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2779,14 +2779,21 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 
 	if (!test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags))
 		return;
-	if (!nfsd4_find_reclaim_client(clp->cl_name, nn))
+
+	down_read(&nn->reclaim_str_hashtbl_lock);
+	if (!nfsd4_find_reclaim_client(clp->cl_name, nn)) {
+		up_read(&nn->reclaim_str_hashtbl_lock);
 		return;
+	}
 	if (atomic_inc_return(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size) {
+		up_read(&nn->reclaim_str_hashtbl_lock);
 		printk(KERN_INFO "NFSD: all clients done reclaiming, ending NFSv4 grace period (net %x)\n",
 				clp->net->ns.inum);
 		nfsd4_end_grace(nn);
+		return;
 	}
+	up_read(&nn->reclaim_str_hashtbl_lock);
 }
 
 static void expire_client(struct nfs4_client *clp)
@@ -7097,10 +7104,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 
 	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
 		return false;
-	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
-			atomic_read(&nn->nr_reclaim_complete) ==
-			nn->reclaim_str_hashtbl_size)
-		return false;
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags)) {
+		int size;
+
+		down_read(&nn->reclaim_str_hashtbl_lock);
+		size = nn->reclaim_str_hashtbl_size;
+		up_read(&nn->reclaim_str_hashtbl_lock);
+		if (atomic_read(&nn->nr_reclaim_complete) == size)
+			return false;
+	}
 	if (!test_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
 		return false;
 	clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
@@ -9270,9 +9282,13 @@ bool
 nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn)
 {
 	struct nfs4_client_reclaim *crp;
+	bool found;
 
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	return (crp && crp->cr_clp);
+	found = (crp && crp->cr_clp);
+	up_read(&nn->reclaim_str_hashtbl_lock);
+	return found;
 }
 
 /*
@@ -9285,10 +9301,39 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
+
+	/*
+	 * A reclaim record for this client name may already exist (for
+	 * example, populated at boot from the recovery directory before
+	 * an in-grace RECLAIM_COMPLETE or an nfsdcld downcall delivers
+	 * the same name). Dedup here so reclaim_str_hashtbl_size stays
+	 * equal to the number of distinct client names; inc_reclaim_complete
+	 * relies on that equality to end the grace period via the fast path.
+	 */
+	crp = nfsd4_find_reclaim_client(name, nn);
+	if (crp) {
+		if (princhash.len && crp->cr_princhash.len == 0) {
+			void *pdata = kmemdup(princhash.data, princhash.len,
+					      GFP_KERNEL);
+			if (pdata) {
+				crp->cr_princhash.data = pdata;
+				crp->cr_princhash.len = princhash.len;
+			} else {
+				dprintk("%s: failed to allocate memory for princhash.data!\n",
+					__func__);
+				crp = NULL;
+			}
+		}
+		up_write(&nn->reclaim_str_hashtbl_lock);
+		return crp;
+	}
+
 	name.data = kmemdup(name.data, name.len, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
+		up_write(&nn->reclaim_str_hashtbl_lock);
 		return NULL;
 	}
 	if (princhash.len) {
@@ -9297,6 +9342,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 			dprintk("%s: failed to allocate memory for princhash.data!\n",
 				__func__);
 			kfree(name.data);
+			up_write(&nn->reclaim_str_hashtbl_lock);
 			return NULL;
 		}
 	} else
@@ -9316,6 +9362,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 		kfree(name.data);
 		kfree(princhash.data);
 	}
+	up_write(&nn->reclaim_str_hashtbl_lock);
 	return crp;
 }
 
@@ -9335,6 +9382,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 	struct nfs4_client_reclaim *crp = NULL;
 	int i;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->reclaim_str_hashtbl[i])) {
 			crp = list_entry(nn->reclaim_str_hashtbl[i].next,
@@ -9343,6 +9391,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 		}
 	}
 	WARN_ON_ONCE(nn->reclaim_str_hashtbl_size);
+	up_write(&nn->reclaim_str_hashtbl_lock);
 }
 
 /*

-- 
2.54.0


