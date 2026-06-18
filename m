Return-Path: <linux-nfs+bounces-22676-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lOpaLg0kNGpzPgYAu9opvQ
	(envelope-from <linux-nfs+bounces-22676-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:59:57 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 154BF6A1B89
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 18:59:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IsK1owvO;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22676-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22676-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D00FB30918CB
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6211D343895;
	Thu, 18 Jun 2026 16:58:25 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3773358DA;
	Thu, 18 Jun 2026 16:58:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801905; cv=none; b=ZO5XhAvGY/kTFOmL7JqzH2mFZwKDJxdmOiwBlWg9lv2n30/+WhsMmCZGcsHJfsHGyaIlrWkhJjxRP+k7S3BehSqLHDLh8R7iZeEEiQoM/0XuEeQNfmaGK00FCZigaLJ+DbaYdC1nEkCz5QkAIfzT/1Wb7WXu4BmpeA57v4Du1/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801905; c=relaxed/simple;
	bh=AG25dq1u5+J5bt3dAYQ7G6FpeKdCO857E6znffoe0ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RRXBI60TY0Fu6Xy2Nn2PAJ5Kz64nqoNgsXz9cE185cEAXhJe9JUrXlLP1fzCu+wFgwLAXU+9P44kyEQ8VuTDXTD1+IyJ978wcJQo7LXeDLXF7mFbWYsuoE53C1S8l0FEF/5u9a2CTp+VXDPJPUHiWgxNcboOagSxkyTlU5uc0os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsK1owvO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89091F00AC4;
	Thu, 18 Jun 2026 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801903;
	bh=MF/8R+a/8ljP/9KGqhDNsln8YItfNmiXaulLs/xsSB0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IsK1owvOkMkrmYPWscpZGqhzxE56vrH4NN6RiTZSRxMa0C76lrc93qK0En+2yzzqg
	 +jJt8ftp+DsjbpDngrT5WB2pkp5USsIqchubXLBjAP8/VOHmEMCCaDrVB4dlDPkSF1
	 k1cr9IbIluPPgNdxbtOwvn13AbajlZ+bS3sq/Oxnj4cJ70t1kIR1M+F8LcwXi6dEuY
	 gObRGJ1SzbxSPQe+y2y3eyC3iV+pdhotQwzeV11eDARb1/jAvQ1PzDojHi+aiOAz3Z
	 aPlmifYHKhpHsradXNFV3iHxTmqcD/8SK6WnX0qH+s3S+Bl7kb+nUTY9BFJwEZUIpx
	 yXsdUqNInWPpw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 18 Jun 2026 12:57:59 -0400
Subject: [PATCH v5 5/6] nfsd: count NFSv4 callback operations per netns
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-exportd-netlink-v5-5-e9aef947af3d@kernel.org>
References: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
In-Reply-To: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6552; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=AG25dq1u5+J5bt3dAYQ7G6FpeKdCO857E6znffoe0ZM=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGo0I6ejw6LUlatR83KNctm9PFGFCgyRgjb8SEtQimGiYv+tA
 okCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJqNCOnAAoJEAAOaEEZVoIV94QQAMms
 d14/tdfBsDpPsYnb2ClkUGkHgwYvEtt9sc4ObygOtMFyoitNXG8xml63Zvuxg5f2Y3TvbAQxUdH
 Qz1tqRVCfdrX8cxDQyw/EIL0yuhzCaqauGQMf9zAAf9sgjGFbAllxMRx3qJ5xZPqs4nix8IWM9E
 3hyoowLWxLf2jX3fVwM2NmX42vRm6A7uY2S4Tq2dBAOUcSDWPWhSvicKhdiDufDQ5a7gkcz7Y3d
 X3oYKgfvSiD44wdlW6J5eOqfXKuT5kfDMzpdUwweQfWy+j+UZhy5/YHfz92fIpsGXJ3rckK82Hy
 f3guzKVfgCZNGYaIfBspcOrpuGScE72VM14LZv0jxEsqvyAYtjrPUWuoIO2hUN1K9xlLINSPKI9
 81fR4lA/lpcjZi4bDHQMFte6VajPdUAhM8A7GkiA/Wgzd1dpLdgKojEHBLAomQinard7LLoltj4
 8WIZ7AaUNu8mHp5EeBCF4jkXIZGC/EAvyQQzDHaVM6vY9uuAVTqiAIplxGzqZzAxYDwfsZVEJTm
 aiCHfYjRlp+jwed0Ii+q/mtqeOozN4EnS61ViZhMFiv61XtjHov2ZfFJa5mkH/VsOgF2yX1HXiG
 sxk98oCynnQ3UrGXFkPL9EZ10bgw1EIVaNuwZATyNjGcgXli2riaW93u3fKthlZjfV0TiBJ7XRn
 5DbVC
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22676-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 154BF6A1B89

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
 fs/nfsd/nfs4callback.c |  7 ++++++-
 fs/nfsd/nfs4state.c    |  2 --
 fs/nfsd/nfsctl.c       | 14 ++++++++++++++
 fs/nfsd/stats.c        |  2 +-
 fs/nfsd/stats.h        |  5 +++--
 6 files changed, 35 insertions(+), 7 deletions(-)

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
index 71dcb448fa0a..9cbcccc26b35 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -1925,8 +1925,13 @@ bool nfsd4_run_cb(struct nfsd4_callback *cb)
 
 	nfsd41_cb_inflight_begin(clp);
 	queued = nfsd4_queue_cb(cb);
-	if (!queued)
+	if (queued) {
+		if (cb->cb_ops)
+			nfsd_stats_cb_op_inc(net_generic(clp->net, nfsd_net_id),
+					     cb->cb_ops->opcode);
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
index dde026473806..9bedbe7096c3 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2717,6 +2717,13 @@ static __net_init int nfsd_net_init(struct net *net)
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
@@ -2745,6 +2752,10 @@ static __net_init int nfsd_net_init(struct net *net)
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
@@ -2785,6 +2796,9 @@ static __net_exit void nfsd_net_exit(struct net *net)
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


