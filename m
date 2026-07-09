Return-Path: <linux-nfs+bounces-23211-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +ymXDkbvT2qYqgIAu9opvQ
	(envelope-from <linux-nfs+bounces-23211-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:58:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CAC734A53
	for <lists+linux-nfs@lfdr.de>; Thu, 09 Jul 2026 20:58:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=f4KBGU4f;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23211-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23211-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2121D310250A
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jul 2026 18:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698343C2799;
	Thu,  9 Jul 2026 18:48:02 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57543CB8EF;
	Thu,  9 Jul 2026 18:48:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622882; cv=none; b=hrZms3xfUriDZFOe8yYhSpa6GKVlO8MMd1ucCcTIPXk6ieeFCnsn07n6OiMAAeIZCaM/KSxl3JSbWahINmNgtiqLI1hZ04Gt1gy4yNxaWIdDiwzRVDHjr+uV0ALLFSUve/Ch0QokWFlxZra/PfLkfszyrZwd6/hYwbfi6tSlqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622882; c=relaxed/simple;
	bh=Nw46C2U3KNbMz6G+sdrSgGDxb3/rje5fck8cew7b8U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eybTIuKtE5vbt5H3iFotpGfcDacHvJu2SBZFzx6plgl9aQvPbwRodf71BN8QNrvAy+BPJo4Uo4njJG4zJk6qjioPws/as6J6xKWzJcXnIFHplR0FxroVpvvkDc3+wsq8RC6tfi99bKytcXLgEdrgLMiD5t23pdUnKlGjvzOSHDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4KBGU4f; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9C221F00A3A;
	Thu,  9 Jul 2026 18:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783622880;
	bh=mqNJ4devghARekp3lt8tlN7jE1x54HXNIDkMBX5ZKy4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f4KBGU4fLb4n/BsbWFSDdH9o+UNVYjsNC6glEFehWes4VENPMQFlF6w8s8gwrdIsY
	 8uXq6Fan4pTKM7D7lgJ3WWJjYqAwJhBvifMbNM1r4XW7QpGd213qjctU1uB6Kt0A5U
	 yFrK5TnXn5OKWuYgVqhBkPzg226gn0P63I7Tm8fdxF3STG6BFM4WIZvQj+QXCl8buB
	 dMAoemJvwu45zwLTAjuHif3cdXKSLr5jXZsmwOzLDBi0/9U/4WNRcLM8p/gUnvb+aA
	 r7IyDeP1eSLpWAH2llHjg0uq6b2fe9I0J3jcHpQ7IL9QfQzm5Fq8t19ag1ePeVRZ0F
	 HEEwMr2r79N9A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 09 Jul 2026 14:47:46 -0400
Subject: [PATCH v2 09/10] nfsd: make the copy offload stateid a first-class
 nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-nfsd-testing-v2-9-0a1ba233bf87@kernel.org>
References: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
In-Reply-To: <20260709-nfsd-testing-v2-0-0a1ba233bf87@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Andy Adamson <andros@netapp.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=10969; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Nw46C2U3KNbMz6G+sdrSgGDxb3/rje5fck8cew7b8U8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqT+zW6FoR4gzIELZhlEOoI75dUiH6p1yv1i39n
 6BsRxzBoyaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCak/s1gAKCRAADmhBGVaC
 FVWREAC1jvSQVviWWzzfCjd/20nB9j7UbF5WkjZWbXvJNcoXFMZ/mnRF3K7ZUIM1Bu2bbPOojfA
 pRUvFqrPJRycr53BWx2mIZhT17H+hv6G7mPRCB39pi0QZ7I1cMHn7jD5bbJk//91DCWtwlNuBvd
 j+boStxdCOtN0EDJkpJWXxbfsO9xX31WhsRHv5LygQsj1JtCN8HQYtmvoO6sgBMDT95vu1snGb3
 sdqo1NGyyOZqulytvUDqLsPPzaqvQz95oNw0S9Lvbk1WHEU8dZyLPeGobXnaplUn1mkP0nwrJK5
 6zmYLVEiFpxgMCJHO+p8T43RK2tNGlTEiVkJfYK8wht67avSP2pvwOiVnFF888tbLKQgf+aVKtF
 yTyraVTu98hZSiD7qsNX+z5q19FotfKeqSx+5Yo2gK3aMbQSLfs7ZGZbnfiI+TF0EeCcVhhCwvs
 628lJmTNGLii19F0pyOzOfG08Zji13rA1kjM7D7nUQW/wmiYE1kQGWXwYQP6oe9OkUj/sG9IKe/
 d6Gd2GGH+o9x3kCPEGaK0pSzzIl/7dbRDWpK8UQt/ukK/T+oVVUa5edE0/zVHNbw5w0G2zrWms2
 1H4BFRrDhrDNwJZ8EN25Uv+k4Op3j3nUMdll2JITsmm9ppBqF6qEmZxyrlB69eNvnAHdt2supyd
 rNRUvAEXDGeB3Lg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23211-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:andros@netapp.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A1CAC734A53

The async COPY offload stateid was a copy_stateid_t in the per-net
nn->s2s_cp_stateids IDR, sharing that table with COPY_NOTIFY stateids even
though every reader (laundromat, manage_cpntf_state()) accepts only
NFS4_COPYNOTIFY_STID. It was inserted there only to mint a unique so_id;
OFFLOAD_CANCEL and OFFLOAD_STATUS find the copy by walking
clp->async_copies.

Building on the nfsd4_async_copy split, promote it to a first-class
nfs4_stid (SC_TYPE_COPY) embedded at the head of nfsd4_async_copy and
allocated from the client's cl_stateids via nfs4_alloc_stid(). This:

  - makes the stateid per-client by construction rather than relying on a
    guessable cyclic id in a global table;

  - reuses the common id allocation, refcounting, and teardown
    (nfs4_put_stid() + sc_free), removing the bespoke
    nfs4_init_copy_state()/nfs4_free_copy_state(); and

  - leaves nn->s2s_cp_stateids exclusively for COPY_NOTIFY stateids.

The async-copy lifetime model is unchanged; nf4_put_copy() now drops the
stid's single reference, which removes it from cl_stateids and frees the
slab.

Per RFC 7862 Section 4.8 a copy offload stateid is valid only for
COPY/OFFLOAD_CANCEL/OFFLOAD_STATUS/CB_OFFLOAD, not FREE_STATEID or
TEST_STATEID, so find_stateid_locked() hides SC_TYPE_COPY and those paths
keep returning bad_stateid as before. Its seqid MUST NOT be zero, so set
si_generation to 1 (nfs4_alloc_stid() leaves it zero).

Follow-ups (not done here): NFS4_COPY_STID, the now-always-COPYNOTIFY
branch in nfs4_init_cp_state(), and the redundant cs_type checks in the
laundromat and manage_cpntf_state() are vestigial.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfs4proc.c  | 37 +++++++++++++-----------------
 fs/nfsd/nfs4state.c | 66 +++++++++++++++++++++++++++++++++++++++++------------
 fs/nfsd/state.h     |  4 ++--
 fs/nfsd/xdr4.h      |  2 +-
 4 files changed, 70 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7d44c85335c7..64cc830830e9 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1521,11 +1521,13 @@ static void nfs4_put_copy(struct nfsd4_async_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
-	/* Drop the task_struct reference taken in nfsd4_copy(). */
-	if (copy->copy_task)
-		put_task_struct(copy->copy_task);
-	kfree(copy->cp_copy.cp_src);
-	kfree(copy);
+	/*
+	 * Release the copy offload stateid. This drops the stid's sole
+	 * reference, which removes it from cl_stateids and frees the
+	 * nfsd4_async_copy via nfsd4_free_async_copy_stid(). The task_struct
+	 * pin and cp_src are released there.
+	 */
+	nfs4_put_stid(&copy->cp_stid);
 }
 
 static void release_copy_files(struct nfsd4_copy *copy);
@@ -2099,7 +2101,6 @@ static void release_copy_files(struct nfsd4_copy *copy)
  */
 static void cleanup_async_copy(struct nfsd4_async_copy *copy)
 {
-	nfs4_free_copy_state(copy);
 	release_copy_files(&copy->cp_copy);
 	nfs4_put_copy(copy);
 }
@@ -2258,7 +2259,13 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (nfsd4_copy_is_async(copy)) {
 		struct task_struct *task;
 
-		async_copy = kzalloc_obj(struct nfsd4_async_copy);
+		/*
+		 * Allocate the durable async copy. Its copy offload stateid is
+		 * a first-class nfs4_stid in cstate->clp->cl_stateids, minted
+		 * here and returned to the client; it outlives this COMPOUND and
+		 * is freed only when the background copy is torn down.
+		 */
+		async_copy = nfs4_alloc_copy_stid(cstate->clp);
 		if (!async_copy)
 			goto out_err;
 		async_copy->cp_copy.cp_nn = nn;
@@ -2273,19 +2280,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (!async_copy->cp_copy.cp_src)
 			goto out_dec_async_copy_err;
 		dup_copy_fields(copy, &async_copy->cp_copy);
-		/*
-		 * Register the copy stateid on the long-lived async_copy
-		 * rather than on the transient COMPOUND argument buffer
-		 * (&u->copy). nfs4_init_copy_state() installs a pointer to
-		 * the copy_stateid_t in nn->s2s_cp_stateids, and that pointer
-		 * outlives this call (it is removed only when the background
-		 * copy finishes). Pointing it at &u->copy would leave a stale
-		 * pointer into reused request memory that the laundromat and
-		 * OFFLOAD_CANCEL later dereference.
-		 */
-		if (!nfs4_init_copy_state(nn, async_copy))
-			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stid.sc_stateid,
 			sizeof(result->cb_stateid));
 		if ((READ_ONCE(copy->nf_dst->nf_file->f_mode) &
 			       FMODE_NOCMTIME) != 0)
@@ -2357,7 +2352,7 @@ find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
 	lockdep_assert_held(&clp->async_lock);
 
 	list_for_each_entry(copy, &clp->async_copies, copies) {
-		if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
+		if (memcmp(&copy->cp_stid.sc_stateid, stateid, NFS4_STATEID_SIZE))
 			continue;
 		return copy;
 	}
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 594cf392f61f..8ac76db31fbb 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -121,6 +121,7 @@ static struct kmem_cache *file_slab;
 static struct kmem_cache *stateid_slab;
 static struct kmem_cache *deleg_slab;
 static struct kmem_cache *odstate_slab;
+static struct kmem_cache *async_copy_slab;
 
 static void free_session(struct nfsd4_session *);
 
@@ -982,9 +983,41 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	return 1;
 }
 
-int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_async_copy *copy)
+/*
+ * sc_free callback for a copy offload stateid. Runs from nfs4_put_stid()
+ * once the stid's last reference is dropped and it has been removed from
+ * cl_stateids.
+ */
+static void nfsd4_free_async_copy_stid(struct nfs4_stid *stid)
+{
+	struct nfsd4_async_copy *copy =
+		container_of(stid, struct nfsd4_async_copy, cp_stid);
+
+	if (copy->copy_task)
+		put_task_struct(copy->copy_task);
+	kfree(copy->cp_copy.cp_src);
+	kmem_cache_free(async_copy_slab, copy);
+}
+
+/*
+ * Allocate the durable state for an asynchronous COPY. The copy offload
+ * stateid is a first-class nfs4_stid (SC_TYPE_COPY) living in the issuing
+ * client's cl_stateids IDR, so it is per-client by construction and shares
+ * the common stateid refcounting and teardown. It is never matched by the
+ * generic stateid lookups (find_stateid_locked() skips SC_TYPE_COPY);
+ * OFFLOAD_CANCEL/OFFLOAD_STATUS find it by walking clp->async_copies.
+ */
+struct nfsd4_async_copy *nfs4_alloc_copy_stid(struct nfs4_client *clp)
 {
-	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
+	struct nfs4_stid *stid;
+
+	stid = nfs4_alloc_stid(clp, async_copy_slab, nfsd4_free_async_copy_stid);
+	if (!stid)
+		return NULL;
+	stid->sc_type = SC_TYPE_COPY;
+	/* RFC 7862 Section 4.8: a copy offload stateid's seqid MUST NOT be 0 */
+	stid->sc_stateid.si_generation = 1;
+	return container_of(stid, struct nfsd4_async_copy, cp_stid);
 }
 
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
@@ -1024,19 +1057,6 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 	return NULL;
 }
 
-void nfs4_free_copy_state(struct nfsd4_async_copy *copy)
-{
-	struct nfsd_net *nn;
-
-	if (copy->cp_stateid.cs_type != NFS4_COPY_STID)
-		return;
-	nn = net_generic(copy->cp_copy.cp_clp->net, nfsd_net_id);
-	spin_lock(&nn->s2s_cp_lock);
-	idr_remove(&nn->s2s_cp_stateids,
-		   copy->cp_stateid.cs_stid.si_opaque.so_id);
-	spin_unlock(&nn->s2s_cp_lock);
-}
-
 /*
  * Drop the parent stid's reference on a cpntf entry that has already been
  * removed from sc_cp_list and the s2s_cp_stateids IDR. If a concurrent holder
@@ -3073,6 +3093,16 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 	ret = idr_find(&cl->cl_stateids, t->si_opaque.so_id);
 	if (!ret || !ret->sc_type)
 		return NULL;
+	/*
+	 * Copy offload stateids live in cl_stateids for id allocation and
+	 * refcounting, but they are not valid targets for the generic
+	 * stateid operations (FREE_STATEID, TEST_STATEID, I/O). Per RFC 7862
+	 * they are managed only via OFFLOAD_CANCEL/OFFLOAD_STATUS/CB_OFFLOAD,
+	 * which locate them through clp->async_copies. Hide them here so those
+	 * paths continue to return NFS4ERR_BAD_STATEID.
+	 */
+	if (ret->sc_type == SC_TYPE_COPY)
+		return NULL;
 	return ret;
 }
 
@@ -5408,6 +5438,7 @@ nfsd4_free_slabs(void)
 	kmem_cache_destroy(stateid_slab);
 	kmem_cache_destroy(deleg_slab);
 	kmem_cache_destroy(odstate_slab);
+	kmem_cache_destroy(async_copy_slab);
 }
 
 int
@@ -5434,8 +5465,13 @@ nfsd4_init_slabs(void)
 	odstate_slab = KMEM_CACHE(nfs4_clnt_odstate, 0);
 	if (odstate_slab == NULL)
 		goto out_free_deleg_slab;
+	async_copy_slab = KMEM_CACHE(nfsd4_async_copy, 0);
+	if (async_copy_slab == NULL)
+		goto out_free_odstate_slab;
 	return 0;
 
+out_free_odstate_slab:
+	kmem_cache_destroy(odstate_slab);
 out_free_deleg_slab:
 	kmem_cache_destroy(deleg_slab);
 out_free_stateid_slab:
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 4526b67c90d4..5dc4a473246e 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -121,6 +121,7 @@ struct nfs4_stid {
 #define SC_TYPE_LOCK		BIT(1)
 #define SC_TYPE_DELEG		BIT(2)
 #define SC_TYPE_LAYOUT		BIT(3)
+#define SC_TYPE_COPY		BIT(4)
 	unsigned short		sc_type;
 
 /* nn->deleg_lock protects sc_status for delegation stateids.
@@ -884,8 +885,7 @@ __be32 nfsd4_lookup_stateid(struct nfsd4_compound_state *cstate,
 			    struct nfs4_stid **s, struct nfsd_net *nn);
 struct nfs4_stid *nfs4_alloc_stid(struct nfs4_client *cl, struct kmem_cache *slab,
 				  void (*sc_free)(struct nfs4_stid *));
-int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_async_copy *copy);
-void nfs4_free_copy_state(struct nfsd4_async_copy *copy);
+struct nfsd4_async_copy *nfs4_alloc_copy_stid(struct nfs4_client *clp);
 struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
 			struct nfs4_stid *p_stid);
 void nfs4_put_stid(struct nfs4_stid *s);
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index f1c817e2f93c..cbd40bf3ee2a 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -784,13 +784,13 @@ struct nfsd4_copy {
  * never points into the request buffer.
  */
 struct nfsd4_async_copy {
+	struct nfs4_stid	cp_stid;	/* SC_TYPE_COPY, in cl_stateids */
 	struct nfsd4_copy	cp_copy;	/* operation params + result */
 
 	struct list_head	copies;		/* nfs4_client.async_copies */
 	struct task_struct	*copy_task;
 	refcount_t		refcount;
 	unsigned int		cp_ttl;
-	copy_stateid_t		cp_stateid;	/* s2s_cp_stateids IDR entry */
 	struct nfsd4_cb_offload	cp_cb_offload;
 };
 

-- 
2.55.0


