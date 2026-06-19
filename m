Return-Path: <linux-nfs+bounces-22695-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xs29MBlgNWq6uQYAu9opvQ
	(envelope-from <linux-nfs+bounces-22695-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:28:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3296B6A6AC4
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:28:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MLb3QSUj;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22695-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22695-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4B523043380
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 15:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43733B42F5;
	Fri, 19 Jun 2026 15:26:57 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D9C3B14BF;
	Fri, 19 Jun 2026 15:26:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882817; cv=none; b=BHRm718m1nQguaZM7UdWW8I3KNwJOrEa7q802GL8w/RuwQPERRRic5J3zrnN/wIDBtNJJK5BQ6R4PF2vbTHRFDww0ic1yF000r2vxq3VWLjEAb+3tLRaEZzFakvfWsk/zZC8AAGlTHQrUiWhaA6xcQ4zki6kbhaQqqdjH/Rb35g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882817; c=relaxed/simple;
	bh=AfWT6iqjZZ3/54U4I8X/Ze5Vcl/XKDZilQH90UOg2EE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlrgoxriBj+VeGCv9BvROuO58GQUFnwzHNwHhJjiuyWwMNTjwPMqNog+nwiCB7pKNm5GJDLdOnXWls/Dp2BRT2GtQVR1y1oSfNCspElmM/d1aqCKcWN3gHBrLotniC8YtP5/oIQoy+oz7Ftud25w14oQy2FABz8MyT53Xm/+Crg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MLb3QSUj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A061F000E9;
	Fri, 19 Jun 2026 15:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781882816;
	bh=SuOCWRILm4Nl8tZG3NYkifnjxP6I9ZIMSynOCGAkVb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MLb3QSUjBZrVmgrIcScsSUAg9d7SEU5aqfojwzSgN2TSLHc92XqFRbITQhLobNJwh
	 gm+sv4HRpBJLyH7//ahj6INQAhyfNIt00Df340zvvpEmM+XmxMJqcv9gwD8+1+xUHw
	 TUnJur4YCMl8kEqmHrIhtR4v1yTl8DAc5A/RsojGslzrN+z6GJeJTt5hW8JW+Wr+9x
	 uObHSTOYXIZF6zr6eeMTF9t0S0p6oSPG6w+b20cfLuy2n2f10Nfpoq3s+iwIFZ107f
	 NWrOhY/c2g65iDM/mDvPN6N9qR4g6qGqPpQEVkCWtEyGyrkCOHTpBtL0W6Z8GZFjnV
	 F+GsPgcAOwnEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 11:26:40 -0400
Subject: [PATCH v6 5/6] nfsd: count NFSv4 callback operations per netns
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-exportd-netlink-v6-5-ddef3499793c@kernel.org>
References: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
In-Reply-To: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7380; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AfWT6iqjZZ3/54U4I8X/Ze5Vcl/XKDZilQH90UOg2EE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNV+4U3wY6EDqhdHmPnReU5rs5fafY/zqGmczi
 ONUltCsjGCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajVfuAAKCRAADmhBGVaC
 FRqMD/kBpx8rPaOZQ7pbaMjQBc10bzUvgcculaPb5RYazExWSMETWU/mtapGeWR+fV0yzSWWtaE
 01NCG3Wob6CnUN5G/ovfyDIw4V/b9Z9/wKNt20YCXKvXTGbNZITl954YIbbq5IiJOlcf3dtJOS1
 Da2BtaCrpaCT0jfJ85X9WWSbFeI60IjI2eF6bFUsljh1/4rrX1FsYBu0h7G1CZA8pSARFcV0BWj
 rgXQFQbeZm6n8zfUGfZEYAKxgUYHTqOod7ows7OXMjUYGFxWXX6kjRPU9cuunHDpfr+xNHHnAso
 rjo/LRVRDG9PcNHeJGi67geicvJdDvI2Onn1ObTJaMsAJoGhq0N9rxqr38duIwN/X7t4x2ay3Gx
 dvcf/OZsfY8cjOnDCTYqOSXLTvDu5VlI+WyFz6GVPhZXq6K4JZDYUVNJj4gVRmM0TzlclKUxiXt
 IxGpdasSOsUaoDYpGMBlL10MoOoBejBpLIEK48S/2DH9a+4FMqy3qmgPRvWQg+NW/h1QNP36AAm
 Bs3UORhSVfKhnIWDWc0v8HLO61FIac8tT9lXpR7J2p2sgpENKSTiaf4H6LjVyRankWzGAUswt4o
 EwTZV9Dc8MiV95K13XUJ/b+csCPH6Karfqrlf79ofk9VeF0LTv7SAdZ7wrGgmkK6RKNteutZ4HM
 Imq7gAbfZnVStGw==
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
	TAGGED_FROM(0.00)[bounces-22695-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3296B6A6AC4

The NFS server tracks per-operation call counts for the forward channel
(proc4ops) but keeps no statistics for the NFSv4 backchannel (callback)
operations it sends to clients.

Add a per-netns array of percpu counters for callback operations, indexed
by RFC 8881 callback opcode (OP_CB_GETATTR..OP_CB_OFFLOAD), and bump the
relevant counter in nfsd4_run_cb(), which is hit exactly once per callback
that is actually queued.

CB_GETATTR is sent when a GETATTR conflicts with an outstanding write
delegation, which is roughly what the dedicated wdeleg_getattr counter
tracked. The two are not identical: the old counter incremented on every
such conflict, whereas the CB_GETATTR counter only counts callbacks that
are actually queued, so concurrent conflicts that coalesce onto an
already in-flight CB_GETATTR are now counted once rather than once per
conflict. Report the procfs "wdeleg_getattr" line from the CB_GETATTR
counter and drop the now-redundant NFSD_STATS_WDELEG_GETATTR counter, its
helper, and its increment site.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/netns.h        | 12 +++++++++++-
 fs/nfsd/nfs4callback.c | 22 +++++++++++++++++++++-
 fs/nfsd/nfs4state.c    |  2 --
 fs/nfsd/nfsctl.c       | 14 ++++++++++++++
 fs/nfsd/stats.c        |  2 +-
 fs/nfsd/stats.h        |  5 +++--
 6 files changed, 50 insertions(+), 7 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 03724bef10a7..37daba0d4747 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -53,11 +53,16 @@ enum {
 	NFSD_STATS_FIRST_NFS4_OP,	/* count of individual nfsv4 operations */
 	NFSD_STATS_LAST_NFS4_OP = NFSD_STATS_FIRST_NFS4_OP + LAST_NFS4_OP,
 #define NFSD_STATS_NFS4_OP(op)	(NFSD_STATS_FIRST_NFS4_OP + (op))
-	NFSD_STATS_WDELEG_GETATTR,	/* count of getattr conflict with wdeleg */
 #endif
 	NFSD_STATS_COUNTERS_NUM
 };
 
+/*
+ * Per-netns NFSv4 callback (backchannel) per-operation counters, indexed
+ * directly by RFC 8881 callback opcode (OP_CB_GETATTR..OP_CB_OFFLOAD).
+ */
+#define NFSD_STATS_CB_OPS_NUM	(OP_CB_OFFLOAD + 1)
+
 /*
  * Represents a nfsd "container". With respect to nfsv4 state tracking, the
  * fields of interest are the *_id_hashtbls and the *_name_tree. These track
@@ -198,6 +203,11 @@ struct nfsd_net {
 	/* Per-netns stats counters */
 	struct percpu_counter    counter[NFSD_STATS_COUNTERS_NUM];
 
+#ifdef CONFIG_NFSD_V4
+	/* Per-netns NFSv4 callback (backchannel) per-operation counters */
+	struct percpu_counter    cb_counter[NFSD_STATS_CB_OPS_NUM];
+#endif
+
 	/* sunrpc svc stats */
 	struct svc_stat          nfsd_svcstats;
 
diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 71dcb448fa0a..b171257da6ba 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1921,12 +1921,32 @@ void nfsd4_init_cb(struct nfsd4_callback *cb, struct nfs4_client *clp,
 bool nfsd4_run_cb(struct nfsd4_callback *cb)
 {
 	struct nfs4_client *clp = cb->cb_clp;
+	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+	const struct nfsd4_callback_ops *ops = cb->cb_ops;
+	u32 minorversion = clp->cl_minorversion;
 	bool queued;
 
+	/*
+	 * Snapshot the opcode, minorversion, and the per-net pointer before
+	 * queuing: once nfsd4_queue_cb() has queued the work, the callback (and
+	 * the object that embeds it) may be processed and freed concurrently, so
+	 * neither cb nor clp can be dereferenced afterward.
+	 */
 	nfsd41_cb_inflight_begin(clp);
 	queued = nfsd4_queue_cb(cb);
-	if (!queued)
+	if (queued) {
+		if (ops)
+			nfsd_stats_cb_op_inc(nn, ops->opcode);
+		/*
+		 * Minorversion > 0 callbacks prepend a CB_SEQUENCE op (see
+		 * encode_cb_sequence4args()); count it like the forechannel
+		 * counts SEQUENCE, so it isn't perpetually reported as zero.
+		 */
+		if (minorversion > 0)
+			nfsd_stats_cb_op_inc(nn, OP_CB_SEQUENCE);
+	} else {
 		nfsd41_cb_inflight_end(clp);
+	}
 	return queued;
 }
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index b830aed7ae39..8f8da1312231 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -9904,7 +9904,6 @@ __be32
 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 			     struct nfs4_delegation **pdp)
 {
-	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct nfsd_thread_local_info *ntli = rqstp->rq_private;
 	struct file_lock_context *ctx;
 	struct nfs4_delegation *dp = NULL;
@@ -9944,7 +9943,6 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct dentry *dentry,
 		return 0;
 	}
 
-	nfsd_stats_wdeleg_getattr_inc(nn);
 	refcount_inc(&dp->dl_stid.sc_count);
 	ncf = &dp->dl_cb_fattr;
 	nfs4_cb_getattr(&dp->dl_cb_fattr);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f0514d8149cd..4710415790e2 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2691,6 +2691,13 @@ static __net_init int nfsd_net_init(struct net *net)
 	if (retval)
 		goto out_repcache_error;
 
+#ifdef CONFIG_NFSD_V4
+	retval = percpu_counter_init_many(nn->cb_counter, 0, GFP_KERNEL,
+					  NFSD_STATS_CB_OPS_NUM);
+	if (retval)
+		goto out_cb_counter_error;
+#endif
+
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_programs[0];
 	retval = svc_stat_alloc_counts(&nn->nfsd_svcstats);
@@ -2719,6 +2726,10 @@ static __net_init int nfsd_net_init(struct net *net)
 out_svcstats_error:
 	svc_stat_free_counts(&nn->nfsd_svcstats);
 out_proc_error:
+#ifdef CONFIG_NFSD_V4
+	percpu_counter_destroy_many(nn->cb_counter, NFSD_STATS_CB_OPS_NUM);
+out_cb_counter_error:
+#endif
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
 	nfsd_idmap_shutdown(net);
@@ -2759,6 +2770,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	nfsd_net_cb_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
 	svc_stat_free_counts(&nn->nfsd_svcstats);
+#ifdef CONFIG_NFSD_V4
+	percpu_counter_destroy_many(nn->cb_counter, NFSD_STATS_CB_OPS_NUM);
+#endif
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
diff --git a/fs/nfsd/stats.c b/fs/nfsd/stats.c
index f7eaf95e20fc..35d9a5571946 100644
--- a/fs/nfsd/stats.c
+++ b/fs/nfsd/stats.c
@@ -63,7 +63,7 @@ static int nfsd_show(struct seq_file *seq, void *v)
 			   percpu_counter_sum_positive(&nn->counter[NFSD_STATS_NFS4_OP(i)]));
 	}
 	seq_printf(seq, "\nwdeleg_getattr %lld",
-		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));
+		percpu_counter_sum_positive(&nn->cb_counter[OP_CB_GETATTR]));
 
 	seq_putc(seq, '\n');
 #endif
diff --git a/fs/nfsd/stats.h b/fs/nfsd/stats.h
index e4efb0e4e56d..f90cd565f7cb 100644
--- a/fs/nfsd/stats.h
+++ b/fs/nfsd/stats.h
@@ -68,9 +68,10 @@ static inline void nfsd_stats_drc_mem_usage_sub(struct nfsd_net *nn, s64 amount)
 }
 
 #ifdef CONFIG_NFSD_V4
-static inline void nfsd_stats_wdeleg_getattr_inc(struct nfsd_net *nn)
+static inline void nfsd_stats_cb_op_inc(struct nfsd_net *nn, u32 opcode)
 {
-	percpu_counter_inc(&nn->counter[NFSD_STATS_WDELEG_GETATTR]);
+	if (opcode >= OP_CB_GETATTR && opcode <= OP_CB_OFFLOAD)
+		percpu_counter_inc(&nn->cb_counter[opcode]);
 }
 #endif
 #endif /* _NFSD_STATS_H */

-- 
2.54.0


