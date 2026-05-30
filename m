Return-Path: <linux-nfs+bounces-22101-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHn7Kw/kGmqS9ggAu9opvQ
	(envelope-from <linux-nfs+bounces-22101-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E203860CEEE
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 15:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6FB19301906F
	for <lists+linux-nfs@lfdr.de>; Sat, 30 May 2026 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E67C3C4154;
	Sat, 30 May 2026 13:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvdOlHSl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EDC3C3C06;
	Sat, 30 May 2026 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780147179; cv=none; b=IhFXRNplfBAWRYItoAMUontiHP0wdkUM/NX2OZ5uPG8ykXjQc8N96sxD+m3YgarcY6lCr/fyaKZCbs53vVyig7Zbm5FKnhedDspDSRafttkWJXOS1aMsVDQCOSb2b7LIc3PP86uafp3zZ7CI6FcgbHAC9uJnjb6CuPg2qnIcN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780147179; c=relaxed/simple;
	bh=6Jg2QEBnKvdkwDkYlbnJqOX6yDaZBREEszUiDD31pas=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eI7sMFQ9MFZxb3uYfj1ix2Cfaj4YWPAbaCg7BRqoXd6sejAkb0ZXzRLAM2dxHrJ0wswSKG4klcnZLPMJQK4+8wzBM01IXtzXy24rVfPlWfiWyd3RScTey0pdKWrQJw87AZhGJzzVMSkl9ttDcV97u16h/quBXlJOOpSPJF+QxCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvdOlHSl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30CB1F00899;
	Sat, 30 May 2026 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780147177;
	bh=72YHRXi5QzkT6R4V3TMOaZ3tdbbBBf4DkzC4TacddQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JvdOlHSlyOuWWH28trFIfhcR3vdIk5pbDE8yv/tXJzKE7iq9/cAggrgo5FGQxNRcg
	 FUjtBnLXil1DPKCe7RaBgfgSJ2uck1px/XqZsu/vgxqvxSKyIweut1Td3omo0jOhSs
	 /im0KaiA7SfTrlbC50y9p9/wO9SwoSKMyILJsnngSFVvukpnOa7+lQhT5MEyzFrxzA
	 J9qSxCN6zg8l15DNPCe5UHA+VsmAd9pZyyzyauVwRw6RUAwNLjv+xSe2Cuf83D3IwB
	 EC0d1R/Q70/QDMsEM+HrNsZOrsluiV6tu9YIdGVT5mQ6+J6jb6k/SK9wIoI+xQMNtP
	 udorDqLQipikQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:19 -0400
Subject: [PATCH v2 3/9] nfsd: convert nfsd_net boolean flags to unsigned
 long flags word
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-nfsd-fixes-v2-3-f27e8eb4d974@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13720; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=t4y30JyLGCagVZA4QvlQFVEBQz3ko6mGCP6Zwaxeylw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqGuPhTH2mSTmBiNnMowSmrsKSiUnsgLs5a4RuI
 I5vMpzwgr2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahrj4QAKCRAADmhBGVaC
 FXdxEACM73TyC4mErVvhhEgj7mZ3qBT+p2aLkZPqfw3+U8vILCYnS5yvTQav5at3cUQNc2/EgbN
 RmHCvAD6+5QmXmlnM0a4AiUcICrQYrxln23cmnfKH+2h3mriwGlUfiUk+umeNbSQh3XnBdsMmd4
 5pxozLWlSE4gGgrA5WUlIk4T1dhtABUcM5xMebPtuoQ5zP0YvTnAkV0x/WRyLTEcB8Sf45e31X7
 ZsVLqW78LLiQrPHyyhCoYS9+gyuIUylz4SPopURWzo6tvyePl4POm0By59BM8RIe9ZQycHRXlIw
 PFerRWUGFKLqBdAyZasdGS0PMGKKexyoVW4MvWwbdmcTZz5CNv7oDjLEXIWy8WE6vrw9Fji7V3W
 oa6SHuNXnVguMixVrHiEUa8Avb1+6o8MMjx02hYYT5PpwWb3BjGyuD57pk3i8tDyfhGyeVLQzNv
 78zxn+YSL2i7b/gag10DgLsi5zXy0uCm++wYvMTiW+XZXA9vaaSaXwPG01K/A+QRzDk8uchGcM9
 IlhxDr8JTeZeYLLfjftwyywerrUMKoT4t9nxt4AJhy2GlbbL1K8IQw40k+i9/wMQmKQmY7ojgD6
 L6L/RyAR42J1d9ULLY3YaqGE1WOmFd4r2U/xMZhNt4CCoh8agLhwXJUWf4MLLuMJdbgh8H235Gw
 np3k9pDEeAnn9OQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22101-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E203860CEEE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chris Mason <clm@meta.com>

nfsd_net contains several boolean fields that are accessed from
concurrent contexts without serialization.  In particular,
nfsd4_end_grace() guards its drain path with a plain bool:

    if (nn->grace_ended)
            return;
    nn->grace_ended = true;

The read and the write are independent, and nothing in struct
nfsd_net serializes them.  At least two contexts can reach this
code with no lock held:

    laundromat path
      laundry_wq kworker
        nfs4_laundromat()
          nfsd4_end_grace()

    RECLAIM_COMPLETE path
      nfsd compound kthread
        nfsd4_reclaim_complete()
          inc_reclaim_complete()
            nfsd4_end_grace()

Both callers can observe grace_ended == false on different CPUs,
both store true, and both proceed into nfsd4_record_grace_done(),
which invokes the active client_tracking_ops->grace_done callback.
For tracking ops that drain reclaim_str_hashtbl (legacy_tracking_ops
via nfsd4_recdir_purge_old, and the cld v1+ ops via
nfsd4_cld_grace_done), grace_done calls nfs4_release_reclaim(),
which walks every bucket of reclaim_str_hashtbl with no lock and
calls nfs4_remove_reclaim_record() (list_del + kfree) on each
entry.  Two concurrent walkers corrupt the list and double-free
every nfs4_client_reclaim.  A concurrent nfsd4_find_reclaim_client()
iterating the same bucket reads through freed memory.

A third call site exists in nfs4_state_start_net() on the
skip_grace startup path, but it runs under nfsd_mutex before any
client has connected and before the laundromat's first delayed
work fires, so it cannot race with the two callers above.

Replace the scattered boolean fields in nfsd_net with a single
unsigned long flags word and an enum nfsd_net_flag for the bit
positions.  The grace_ended race is fixed by using
test_and_set_bit(), which is atomic on all architectures.  The
remaining flags (grace_end_forced, in_grace, somebody_reclaimed,
track_reclaim_completes, nfsd_net_up, lockd_up) are converted to
use test_bit/set_bit/clear_bit for consistency.  This avoids
sub-word cmpxchg issues on architectures like Hexagon that only
support word-sized atomic operations.

Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld")
Assisted-by: kres:claude-opus-4-7
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
---
 fs/nfsd/netns.h       | 19 +++++++++++--------
 fs/nfsd/nfs4proc.c    |  2 +-
 fs/nfsd/nfs4recover.c | 12 ++++++------
 fs/nfsd/nfs4state.c   | 40 ++++++++++++++++++++++++----------------
 fs/nfsd/nfsctl.c      |  2 +-
 fs/nfsd/nfssvc.c      | 22 +++++++++++-----------
 6 files changed, 54 insertions(+), 43 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 27da1a3edacb..37dfecb9d49d 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -28,6 +28,16 @@ struct cld_net;
 struct nfsd_net_cb;
 struct nfsd4_client_tracking_ops;
 
+enum nfsd_net_flag {
+	NFSD_NET_GRACE_ENDED,
+	NFSD_NET_GRACE_END_FORCED,
+	NFSD_NET_IN_GRACE,
+	NFSD_NET_SOMEBODY_RECLAIMED,
+	NFSD_NET_TRACK_RECLAIM_COMPLETES,
+	NFSD_NET_UP,
+	NFSD_NET_LOCKD_UP,
+};
+
 enum {
 	/* cache misses due only to checksum comparison failures */
 	NFSD_STATS_PAYLOAD_MISSES,
@@ -66,8 +76,7 @@ struct nfsd_net {
 	struct cache_detail *nametoid_cache;
 
 	struct lock_manager nfsd4_manager;
-	bool grace_ended;
-	bool grace_end_forced;
+	unsigned long flags;
 	time64_t boot_time;
 
 	struct dentry *nfsd_client_dir;
@@ -117,19 +126,13 @@ struct nfsd_net {
 	spinlock_t blocked_locks_lock;
 
 	struct file *rec_file;
-	bool in_grace;
 	const struct nfsd4_client_tracking_ops *client_tracking_ops;
 
 	time64_t nfsd4_lease;
 	time64_t nfsd4_grace;
-	bool somebody_reclaimed;
 
-	bool track_reclaim_completes;
 	atomic_t nr_reclaim_complete;
 
-	bool nfsd_net_up;
-	bool lockd_up;
-
 	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 5f2b9bfc3a84..9473aeb53f72 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -667,7 +667,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
 	if (reclaim && !status)
-		nn->somebody_reclaimed = true;
+		set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 out:
 	if (open->op_filp) {
 		fput(open->op_filp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 6ea25a52d2f4..c841da585142 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -167,7 +167,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 	end_creating(dentry);
 out:
 	if (status == 0) {
-		if (nn->in_grace)
+		if (test_bit(NFSD_NET_IN_GRACE, &nn->flags))
 			__nfsd4_create_reclaim_record_grace(clp, dname, nn);
 		vfs_fsync(nn->rec_file, 0);
 	} else {
@@ -317,7 +317,7 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 	nfs4_reset_creds(original_cred);
 	if (status == 0) {
 		vfs_fsync(nn->rec_file, 0);
-		if (nn->in_grace)
+		if (test_bit(NFSD_NET_IN_GRACE, &nn->flags))
 			__nfsd4_remove_reclaim_record_grace(dname,
 					HEXDIR_LEN, nn);
 	}
@@ -373,7 +373,7 @@ nfsd4_recdir_purge_old(struct nfsd_net *nn)
 {
 	int status;
 
-	nn->in_grace = false;
+	clear_bit(NFSD_NET_IN_GRACE, &nn->flags);
 	if (!nn->rec_file)
 		return;
 	status = mnt_want_write_file(nn->rec_file);
@@ -455,7 +455,7 @@ nfsd4_init_recdir(struct net *net)
 
 	nfs4_reset_creds(original_cred);
 	if (!status)
-		nn->in_grace = true;
+		set_bit(NFSD_NET_IN_GRACE, &nn->flags);
 	return status;
 }
 
@@ -1362,7 +1362,7 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
-	nn->track_reclaim_completes = true;
+	set_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
 	return 0;
@@ -1373,7 +1373,7 @@ nfs4_cld_state_shutdown(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->track_reclaim_completes = false;
+	clear_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	kfree(nn->reclaim_str_hashtbl);
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 9503859918ac..bc5216bb08ff 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2777,7 +2777,7 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (!nn->track_reclaim_completes)
+	if (!test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags))
 		return;
 	if (!nfsd4_find_reclaim_client(clp->cl_name, nn))
 		return;
@@ -5309,8 +5309,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
-	nn->somebody_reclaimed = false;
-	nn->track_reclaim_completes = false;
 	nn->clverifier_counter = get_random_u32();
 	nn->clientid_base = get_random_u32();
 	nn->clientid_counter = nn->clientid_base + 1;
@@ -7022,12 +7020,21 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
-	/* do nothing if grace period already ended */
-	if (nn->grace_ended)
+	/*
+	 * nfsd4_end_grace() can be entered concurrently from the
+	 * laundromat workqueue and from an nfsd compound thread
+	 * handling RECLAIM_COMPLETE.  Without serialization, both
+	 * callers can observe grace_ended==false and proceed into
+	 * nfsd4_record_grace_done().  For tracking ops whose
+	 * grace_done drains reclaim_str_hashtbl, that results in
+	 * list corruption and a double free of every
+	 * nfs4_client_reclaim entry.  Use an atomic test-and-set so
+	 * exactly one caller proceeds.
+	 */
+	if (test_and_set_bit(NFSD_NET_GRACE_ENDED, &nn->flags))
 		return;
 
 	trace_nfsd_grace_complete(nn);
-	nn->grace_ended = true;
 	/*
 	 * If the server goes down again right now, an NFSv4
 	 * client will still be allowed to reclaim after it comes back up,
@@ -7068,10 +7075,10 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
 {
 	if (!nn->client_tracking_ops)
 		return false;
-	if (READ_ONCE(nn->grace_ended))
+	if (test_bit(NFSD_NET_GRACE_ENDED, &nn->flags))
 		return false;
 	/* laundromat_work must be initialised now, though it might be disabled */
-	WRITE_ONCE(nn->grace_end_forced, true);
+	set_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	/* mod_delayed_work() doesn't queue work after
 	 * nfs4_state_shutdown_net() has called disable_delayed_work_sync()
 	 */
@@ -7088,15 +7095,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	time64_t double_grace_period_end = nn->boot_time +
 					   2 * nn->nfsd4_lease;
 
-	if (READ_ONCE(nn->grace_end_forced))
+	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
 		return false;
-	if (nn->track_reclaim_completes &&
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
 			atomic_read(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size)
 		return false;
-	if (!nn->somebody_reclaimed)
+	if (!test_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
 		return false;
-	nn->somebody_reclaimed = false;
+	clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 	/*
 	 * If we've given them *two* lease times to reclaim, and they're
 	 * still not done, give up:
@@ -8887,7 +8894,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
-			nn->somebody_reclaimed = true;
+			set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 		break;
 	case FILE_LOCK_DEFERRED:
 		kref_put(&nbl->nbl_kref, free_nbl);
@@ -9413,8 +9420,8 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
-	nn->grace_ended = false;
-	nn->grace_end_forced = false;
+	clear_bit(NFSD_NET_GRACE_ENDED, &nn->flags);
+	clear_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
 	INIT_LIST_HEAD(&nn->client_lru);
@@ -9500,7 +9507,8 @@ nfs4_state_start_net(struct net *net)
 	nfsd4_client_tracking_init(net);
 	/* safe for laundromat to run now */
 	enable_delayed_work(&nn->laundromat_work);
-	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
+	    nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
 	       nn->nfsd4_grace, net->ns.inum);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 468aad8c3af9..92f65ca6f667 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1111,7 +1111,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%c\n",
-			 nn->grace_ended ? 'Y' : 'N');
+			 test_bit(NFSD_NET_GRACE_ENDED, &nn->flags) ? 'Y' : 'N');
 }
 
 #endif
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index be0add971c2d..551d3cf51036 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -351,7 +351,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int ret;
 
-	if (nn->nfsd_net_up)
+	if (test_bit(NFSD_NET_UP, &nn->flags))
 		return 0;
 
 	ret = nfsd_startup_generic();
@@ -364,11 +364,11 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 		goto out_socks;
 	}
 
-	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
+	if (nfsd_needs_lockd(nn) && !test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 		ret = lockd_up(net, cred);
 		if (ret)
 			goto out_socks;
-		nn->lockd_up = true;
+		set_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 	}
 
 	ret = nfsd_file_cache_start_net(net);
@@ -386,7 +386,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_reply_cache;
 
-	nn->nfsd_net_up = true;
+	set_bit(NFSD_NET_UP, &nn->flags);
 	return 0;
 
 out_reply_cache:
@@ -394,9 +394,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
-	if (nn->lockd_up) {
+	if (test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 		lockd_down(net);
-		nn->lockd_up = false;
+		clear_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 	}
 out_socks:
 	nfsd_shutdown_generic();
@@ -407,7 +407,7 @@ static void nfsd_shutdown_net(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	if (nn->nfsd_net_up) {
+	if (test_bit(NFSD_NET_UP, &nn->flags)) {
 		percpu_ref_kill_and_confirm(&nn->nfsd_net_ref, nfsd_net_done);
 		wait_for_completion(&nn->nfsd_net_confirm_done);
 
@@ -415,18 +415,18 @@ static void nfsd_shutdown_net(struct net *net)
 		nfs4_state_shutdown_net(net);
 		nfsd_reply_cache_shutdown(nn);
 		nfsd_file_cache_shutdown_net(net);
-		if (nn->lockd_up) {
+		if (test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 			lockd_down(net);
-			nn->lockd_up = false;
+			clear_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 		}
 		wait_for_completion(&nn->nfsd_net_free_done);
 	}
 
 	percpu_ref_exit(&nn->nfsd_net_ref);
 
-	if (nn->nfsd_net_up)
+	if (test_bit(NFSD_NET_UP, &nn->flags))
 		nfsd_shutdown_generic();
-	nn->nfsd_net_up = false;
+	clear_bit(NFSD_NET_UP, &nn->flags);
 }
 
 static DEFINE_SPINLOCK(nfsd_notifier_lock);

-- 
2.54.0


