Return-Path: <linux-nfs+bounces-23240-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ow2CfT7UGoi9gIAu9opvQ
	(envelope-from <linux-nfs+bounces-23240-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:04:36 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8650573B93B
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 16:04:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D4J27Uxt;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23240-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23240-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C74053027944
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jul 2026 14:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359A6345CDD;
	Fri, 10 Jul 2026 14:00:32 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFE834041C;
	Fri, 10 Jul 2026 14:00:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692032; cv=none; b=Kz1jlnUW4bKnaU40wn3ynwXOfsTPdKqh6D8hSIDD4JpykxRClBJ6oRtjK6/iYeSkCjHFhN3mDK2gjOD5Lkxd2JBsg51S5usI6qaSfgYA7ZMRIXMoXy62OI8Nbi0vARXrRT+vc8oBABder78cFnevLpZ8xfAd4nQ89hNVi4ZKDS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692032; c=relaxed/simple;
	bh=xO+67yzvJQEP74TYmnhzsWemh4tqiLQlakpgHkLS8jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTHFvRL+x7+FdOT92gkxap9iWw7t5fyuUIR+CL4cltUOtb/k2y5/AkVne3liGLNwH8+p3+JYxOdggZpCAsat2ZJ6obMQPCncmvVoeno5StJQw3pJbTujh4y17GXEQK8Bl/tWovGYJQbND4Er0MPrjUpVuRqWLBjx4IO9ONuxdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D4J27Uxt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1B3E1F00ACF;
	Fri, 10 Jul 2026 14:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783692030;
	bh=FXrkYWS4rSSAcsmHwGMmkhkihySZ15odoL3hM34tD00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=D4J27UxtfAMn0vVoi+KnDh30a2QRPbqcGpltBYBVbcY6UH42KQ6emok/ox2Ic99Ml
	 tbJrnV0CvXT9RVU1ip/GCBtDGuUDjO6i3tPRfPfFO6XB/b+Pki3ue5K7vV/vETBh37
	 FaMSLPNL+o1rbdKMBJmGCbuFBcn+EBz4U/w7RBUeKHg32TdRnWxoZKyPKwT8bCUu/4
	 Zivx2aBOtbz7MMpxPdVEK86LmcO2aPln6311tD8olAvkGii0yfyAnLoYKFyxY0vB+A
	 7nxnGCW5o5L09kT6/H/45jpfPfGu73t455fp1sp4D1rNgXxau9B3zDzjvj3fKVHh6a
	 9chCHDoezJEvQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 10 Jul 2026 10:00:13 -0400
Subject: [PATCH v3 09/10] nfsd: make the copy offload stateid a first-class
 nfs4_stid
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nfsd-testing-v3-9-a0ff7db6aa3e@kernel.org>
References: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
In-Reply-To: <20260710-nfsd-testing-v3-0-a0ff7db6aa3e@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=11274; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xO+67yzvJQEP74TYmnhzsWemh4tqiLQlakpgHkLS8jA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqUPr0Q7CjD4QrAa4YX2lYzhMQVE6nh4VkKwVNi
 BuqtI0jOOeJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCalD69AAKCRAADmhBGVaC
 FRJ/EACCzf9Hvrw+Vo3VfZZPE2SzaYIwQuj2nTdOkr0qtfP64lngnc6PZqAJ2y5zufuRMW+wXaR
 TLdKldbn9rTBGIBvAEMex1bOwMF6A1h/gQDWCPZktf1A0el7wy6QV442n+ZmBIovh+rSGwmB3j6
 ezB2LLhHIjj/sEBr9P5A1FBvhxH/S/u6qDgMAh2zWgm653AqNsiERyZUlaqXyGrR/iSrcjR69U7
 RZNI+X9tWmMFt09TG9lasopw9nkiRRcrSr8XQxL7s3baDljw7iWQAVmy2ko+k4nTGy9EGDvUm6R
 v9JxrCcTQz2q+8zetkpFlxxsHQVGJ+U1d+ncGD253j7z1v4hf0G6uYOorm9H6Mc1enCdo1yXjb0
 40Nugpj2LbSL8rYm+KCuPbf/aBYKIDND4AtryYCebT0E+arhVmmfs7flmY8CTn8YhxL8EFJBohN
 uZd8iPnSpyPMaA6kz5kaYqlQ4SSqUNb3+MrVxhOyUnx0CmaSfeJcRRj7L1DY2agKNV3ImDyUxBl
 FI4ZngtWQ+lTPgaMZ8zhqGFyfPtMYrJeAW+cbCf4fg8qVzJIqYhsIFXXjLb/uCmVF697xafWG7c
 t2l3u9/bFLUtZIYjTcd/ucV2dh2kz2tLkFLwyOIfDJgNvIpVK6viAADvg7m+ivfWsnS3EIhyTfi
 Vr0rGrnEl/1Bveg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23240-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8650573B93B

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
 fs/nfsd/nfs4proc.c  | 35 +++++++++++++-------------------
 fs/nfsd/nfs4state.c | 58 +++++++++++++++++++++++++++++++++++++++--------------
 fs/nfsd/state.h     |  4 ++--
 fs/nfsd/xdr4.h      |  2 +-
 4 files changed, 60 insertions(+), 39 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 9f897c4ffc16..14e1c56654ec 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1521,11 +1521,11 @@ static void nfs4_put_copy(struct nfsd4_async_copy *copy)
 {
 	if (!refcount_dec_and_test(&copy->refcount))
 		return;
-	/* Drop the task_struct pinned in nfsd4_copy(). */
-	if (copy->copy_task)
-		put_task_struct(copy->copy_task);
-	kfree(copy->cp_copy.cp_src);
-	kfree(copy);
+	/*
+	 * Drop the copy offload stateid's sole reference: removes it from
+	 * cl_stateids and frees the async_copy via nfsd4_free_async_copy_stid().
+	 */
+	nfs4_put_stid(&copy->cp_stid);
 }
 
 static void release_copy_files(struct nfsd4_copy *copy);
@@ -1558,11 +1558,6 @@ static struct nfsd4_async_copy *nfsd4_unhash_copy(struct nfs4_client *clp)
 		copy = list_first_entry(&clp->async_copies,
 					struct nfsd4_async_copy, copies);
 		refcount_inc(&copy->refcount);
-		/*
-		 * Unlinking hides the copy from the reaper, so drop its
-		 * s2s_cp_stateids entry here while cp_clp is still valid.
-		 */
-		nfs4_free_copy_state(copy);
 		/* Pairs with smp_load_acquire() in nfsd4_send_cb_offload(). */
 		smp_store_release(&copy->cp_copy.cp_clp, NULL);
 		if (!list_empty(&copy->copies))
@@ -1648,10 +1643,8 @@ void nfsd4_cancel_copy_by_sb(struct net *net, struct super_block *sb)
 		struct nfs4_client *clp = copy->cp_copy.cp_clp;
 
 		list_del_init(&copy->copies);
-		/* Reaper can't reach it; drop the s2s entry while cp_clp is valid. */
-		nfs4_free_copy_state(copy);
 		nfsd4_stop_copy(copy);
-		/* Drop the membership ref the reaper would have dropped. */
+		/* Reaper can't reach the unlinked copy; drop the membership ref here. */
 		nfs4_put_copy(copy);
 		nfsd4_put_client(clp);
 	}
@@ -2085,7 +2078,6 @@ static void release_copy_files(struct nfsd4_copy *copy)
  */
 static void cleanup_async_copy(struct nfsd4_async_copy *copy)
 {
-	nfs4_free_copy_state(copy);
 	release_copy_files(&copy->cp_copy);
 	nfs4_put_copy(copy);
 }
@@ -2226,7 +2218,12 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	if (nfsd4_copy_is_async(copy)) {
 		struct task_struct *task;
 
-		async_copy = kzalloc_obj(struct nfsd4_async_copy);
+		/*
+		 * Allocate the durable async copy. Its offload stateid is a
+		 * first-class nfs4_stid in clp->cl_stateids, returned to the
+		 * client and freed only when the background copy is torn down.
+		 */
+		async_copy = nfs4_alloc_copy_stid(cstate->clp);
 		if (!async_copy)
 			goto out_err;
 		async_copy->cp_copy.cp_nn = nn;
@@ -2240,10 +2237,7 @@ nfsd4_copy(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		async_copy->cp_copy.cp_src = kmalloc_obj(*async_copy->cp_copy.cp_src);
 		if (!async_copy->cp_copy.cp_src)
 			goto out_dec_async_copy_err;
-
-		if (!nfs4_init_copy_state(nn, async_copy))
-			goto out_dec_async_copy_err;
-		memcpy(&result->cb_stateid, &async_copy->cp_stateid.cs_stid,
+		memcpy(&result->cb_stateid, &async_copy->cp_stid.sc_stateid,
 			sizeof(result->cb_stateid));
 		/*
 		 * dup after writing cb_stateid; duplicating first would leave
@@ -2318,7 +2312,7 @@ find_async_copy_locked(struct nfs4_client *clp, stateid_t *stateid)
 	lockdep_assert_held(&clp->async_lock);
 
 	list_for_each_entry(copy, &clp->async_copies, copies) {
-		if (memcmp(&copy->cp_stateid.cs_stid, stateid, NFS4_STATEID_SIZE))
+		if (memcmp(&copy->cp_stid.sc_stateid, stateid, NFS4_STATEID_SIZE))
 			continue;
 		return copy;
 	}
@@ -2334,7 +2328,6 @@ find_async_copy(struct nfs4_client *clp, stateid_t *stateid)
 	copy = find_async_copy_locked(clp, stateid);
 	if (copy) {
 		refcount_inc(&copy->refcount);
-		nfs4_free_copy_state(copy);
 		/*
 		 * Mirror nfsd4_unhash_copy(): unlink and clear cp_clp under
 		 * async_lock so the reaper can't reach it. Caller drops the
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 1feda9eaf3a0..900aca361413 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -121,6 +121,7 @@ static struct kmem_cache *file_slab;
 static struct kmem_cache *stateid_slab;
 static struct kmem_cache *deleg_slab;
 static struct kmem_cache *odstate_slab;
+static struct kmem_cache *async_copy_slab;
 
 static void free_session(struct nfsd4_session *);
 
@@ -979,9 +980,35 @@ static int nfs4_init_cp_state(struct nfsd_net *nn, copy_stateid_t *stid,
 	return 1;
 }
 
-int nfs4_init_copy_state(struct nfsd_net *nn, struct nfsd4_async_copy *copy)
+/* sc_free for a copy offload stateid; runs from nfs4_put_stid(). */
+static void nfsd4_free_async_copy_stid(struct nfs4_stid *stid)
 {
-	return nfs4_init_cp_state(nn, &copy->cp_stateid, NFS4_COPY_STID, NULL);
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
+ * Allocate durable async COPY state. The offload stateid is a first-class
+ * nfs4_stid (SC_TYPE_COPY) in the client's cl_stateids, so it is per-client
+ * and uses the common refcounting/teardown. find_stateid_locked() hides it;
+ * OFFLOAD_CANCEL/OFFLOAD_STATUS find it via clp->async_copies.
+ */
+struct nfsd4_async_copy *nfs4_alloc_copy_stid(struct nfs4_client *clp)
+{
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
@@ -1013,19 +1040,6 @@ struct nfs4_cpntf_state *nfs4_alloc_init_cpntf_state(struct nfsd_net *nn,
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
  * Drop the parent's reference on an already-unlinked cpntf entry. If a
  * concurrent holder still owns a reference, its nfs4_put_cpntf_state() does
@@ -3047,6 +3061,14 @@ find_stateid_locked(struct nfs4_client *cl, stateid_t *t)
 	ret = idr_find(&cl->cl_stateids, t->si_opaque.so_id);
 	if (!ret || !ret->sc_type)
 		return NULL;
+	/*
+	 * Copy offload stateids live in cl_stateids only for id allocation and
+	 * refcounting; per RFC 7862 they are not valid targets for generic
+	 * stateid ops (FREE_STATEID, TEST_STATEID, I/O). Hide them so those
+	 * paths return NFS4ERR_BAD_STATEID.
+	 */
+	if (ret->sc_type == SC_TYPE_COPY)
+		return NULL;
 	return ret;
 }
 
@@ -5382,6 +5404,7 @@ nfsd4_free_slabs(void)
 	kmem_cache_destroy(stateid_slab);
 	kmem_cache_destroy(deleg_slab);
 	kmem_cache_destroy(odstate_slab);
+	kmem_cache_destroy(async_copy_slab);
 }
 
 int
@@ -5408,8 +5431,13 @@ nfsd4_init_slabs(void)
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
index 62311fb9351f..67491e2843fb 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -781,13 +781,13 @@ struct nfsd4_copy {
  * buffer.
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


