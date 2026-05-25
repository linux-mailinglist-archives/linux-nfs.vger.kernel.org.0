Return-Path: <linux-nfs+bounces-21917-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGp2DP1CFGqmLQcAu9opvQ
	(envelope-from <linux-nfs+bounces-21917-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:25 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEF35CA98B
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 14:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44ABC301EC71
	for <lists+linux-nfs@lfdr.de>; Mon, 25 May 2026 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3031F382F2F;
	Mon, 25 May 2026 12:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPLSNEu6"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41D037FF64;
	Mon, 25 May 2026 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779712741; cv=none; b=SqsVGCfVyB4JpFXnr/nubxJmX1jIAlhDR8nDyT55eMQ7v1NAcIE+n+Y7NQEd24n5Fn3H8YkwdcARTAAGtz4bvK0L7g241414QM4dxenwzf24/dWwzrTNaZFfsj3PQUH3I/k5O+2EXq51VMJhod9TH5Jf6RqsTZU1PuRr7kJTNzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779712741; c=relaxed/simple;
	bh=lOHASzelpNwvAEmAG86+t5FwQeO+cIYotmZQw44qLCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SycWkTGSA4kIxobYyWMBPT2ZDZjPt5JCHSHrqR4WoEKdx0l9Yb9OvHIOKMe2PQVixJT1NUsPUbFavfN0krfBV/JiZoHSA/+isboxPp2uFnFyBJBRCXHndNXSuJHXIDVGQvFXYT75OhRvviGZXC3DuqeZW0W/nPXhv7zHzck3pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPLSNEu6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965A91F000E9;
	Mon, 25 May 2026 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779712739;
	bh=9JQ6Eiu80K+GOEC9U5hLFcrnSqv2viTghgU9ZaZvwyg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JPLSNEu6Kna8xnpgOehD+EScejuU/HX+xucO3gLjRpGHDBvv8FnPWaeq4Y1CLbHwe
	 gV6iww8iQGWclMrD4LBfzIInhcAGPdZzlth0Hqom9iiTmuFCSv4zXj3lkaeEvVxOXz
	 I7z8LZkxzwGl6QAzfATyzweOqI6crg66nf/gVpL4F6Sa6/PNFTMGOMkyhQa7+GmtmN
	 Y5+CDGkeOHtncvTfc977Ey4bpNoOwUZ/3vppXakxVi3mXLl6g8C3qJjWikG2aC44Yd
	 Jb4+DfDUwV5Y1G9Z5CuSBOQTc4jC6ni+Owng52xCFTkxmsdsEhNnTTrKvKzWgnNx6i
	 D3Farje9IA6nQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 25 May 2026 08:38:47 -0400
Subject: [PATCH v2 1/4] sunrpc: add per-netns per-procedure call counts to
 svc_stat
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-exportd-netlink-v2-1-40003fed450c@kernel.org>
References: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
In-Reply-To: <20260525-exportd-netlink-v2-0-40003fed450c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5305; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=lOHASzelpNwvAEmAG86+t5FwQeO+cIYotmZQw44qLCQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqFELg7Z3gs7P+yW9d+/54ljP3FutpBz97EEIQI
 yQPc+Caxo+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCahRC4AAKCRAADmhBGVaC
 Fe5cD/9f1hpiLpPhg7zl12RRhM7lMXIt5pgDKWsfO0Ib65/xkFzh8aMw1tFnVI6LuE7HRyjbEwm
 TSQy1gXf6OrPn8aXOe5HbpGDMBZj9Kj0e2Hy1GlcpE4i1sJcqqjv2J6Tfvw6KVlil7BxZUqJ757
 ntoJVyOC6DzUeBT9zASpnTTPaYp8e0zj9tPHVVf8dIN3HOlG9X+HppP+ywZD4Nu48HwjH3uzGeg
 eb0vQzTCjZ7HjsF8qE9ubwOyZuY4VNM2eTx+D5/X+5+LO874G3mWVVDHDCNjZaK1sKn2duQzRPb
 vfcHxZKq/of3VYfPeqS3raCuAuPiDGhYaVmfgMUdfi4+AQ6DbZot8Kbxf0tj0tjdQbcRhlY5bBV
 UAQ3mlxpyM4kl125gWmjj5L7pjhS0eDGFPmrOsjwYJROf0ZxpEn+NMt1H2gieFMUzGko8oep9Lf
 pDNzxNkmHVCwx849EByMINSgz4iTlC1wanaz1MDmkcfW3EKY7LkRSRe/Mz0jLwA/uF02fdEaRXq
 YtpMBeg7GWEBpMMlKOF9I112M9k/ntoLbMRvWmLFn2wi38RG40Gi/mrjmoPIedFEInDu9CUG2JL
 P5QT85n0NEXFW88IccAgT/IvSUpauxtL6UFdcckh+rKoBsXjk79S22cEVNmT2cvqw/17q7sZT5Z
 HXbAhHemtJ35/7g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21917-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9AEF35CA98B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The existing per-procedure call counts live in global
svc_version->vs_count[] arrays which are not network-namespace-aware.
Add per-netns equivalents in struct svc_stat so the upcoming netlink
stats interface can return namespace-scoped statistics.

Add a vs_count pointer array to struct svc_stat, along with
svc_stat_alloc_counts() and svc_stat_free_counts() helpers to manage
per-version percpu call count arrays.

Increment the per-net counter alongside the global one in
svc_generic_init_request(). Call the alloc/free helpers from
nfsd_net_init() and nfsd_net_exit().

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c             |  8 ++++++-
 include/linux/sunrpc/stats.h |  6 +++++
 net/sunrpc/stats.c           | 54 ++++++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/svc.c             |  7 ++++++
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 468aad8c3af9..3aaa67b322d5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2445,9 +2445,12 @@ static __net_init int nfsd_net_init(struct net *net)
 
 	memset(&nn->nfsd_svcstats, 0, sizeof(nn->nfsd_svcstats));
 	nn->nfsd_svcstats.program = &nfsd_programs[0];
+	retval = svc_stat_alloc_counts(&nn->nfsd_svcstats);
+	if (retval)
+		goto out_proc_error;
 	if (!nfsd_proc_stat_init(net)) {
 		retval = -ENOMEM;
-		goto out_proc_error;
+		goto out_svcstats_error;
 	}
 
 	for (i = 0; i < sizeof(nn->nfsd_versions); i++)
@@ -2465,6 +2468,8 @@ static __net_init int nfsd_net_init(struct net *net)
 #endif
 	return 0;
 
+out_svcstats_error:
+	svc_stat_free_counts(&nn->nfsd_svcstats);
 out_proc_error:
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
@@ -2505,6 +2510,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
 	kfree_sensitive(nn->fh_key);
 	nfsd_net_cb_shutdown(nn);
 	nfsd_proc_stat_shutdown(net);
+	svc_stat_free_counts(&nn->nfsd_svcstats);
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 	nfsd_idmap_shutdown(net);
 	nfsd_export_shutdown(net);
diff --git a/include/linux/sunrpc/stats.h b/include/linux/sunrpc/stats.h
index 3ce1550d1beb..087ade905e29 100644
--- a/include/linux/sunrpc/stats.h
+++ b/include/linux/sunrpc/stats.h
@@ -37,9 +37,15 @@ struct svc_stat {
 				rpcbadfmt,
 				rpcbadauth,
 				rpcbadclnt;
+
+	/* Per-version per-procedure call counts (per-cpu, per-netns) */
+	unsigned long __percpu	**vs_count;
 };
 
 struct net;
+int			svc_stat_alloc_counts(struct svc_stat *statp);
+void			svc_stat_free_counts(struct svc_stat *statp);
+
 #ifdef CONFIG_PROC_FS
 int			rpc_proc_init(struct net *);
 void			rpc_proc_exit(struct net *);
diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 7093e18ac26c..5bcecd2919b1 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -116,6 +116,60 @@ void svc_seq_show(struct seq_file *seq, const struct svc_stat *statp)
 }
 EXPORT_SYMBOL_GPL(svc_seq_show);
 
+/**
+ * svc_stat_alloc_counts - allocate per-netns per-version call count arrays
+ * @statp: svc_stat whose vs_count arrays should be allocated
+ *
+ * statp->program must be set before calling this.
+ *
+ * Returns zero on success, or a negative errno otherwise.
+ */
+int svc_stat_alloc_counts(struct svc_stat *statp)
+{
+	struct svc_program *prog = statp->program;
+	unsigned int i;
+
+	statp->vs_count = kcalloc(prog->pg_nvers,
+				  sizeof(unsigned long __percpu *),
+				  GFP_KERNEL);
+	if (!statp->vs_count)
+		return -ENOMEM;
+
+	for (i = 0; i < prog->pg_nvers; i++) {
+		if (!prog->pg_vers[i])
+			continue;
+		statp->vs_count[i] = __alloc_percpu(prog->pg_vers[i]->vs_nproc *
+					    sizeof(unsigned long),
+					    sizeof(unsigned long));
+		if (!statp->vs_count[i])
+			goto err;
+	}
+	return 0;
+err:
+	svc_stat_free_counts(statp);
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(svc_stat_alloc_counts);
+
+/**
+ * svc_stat_free_counts - free per-netns per-version call count arrays
+ * @statp: svc_stat whose vs_count arrays should be freed
+ */
+void svc_stat_free_counts(struct svc_stat *statp)
+{
+	struct svc_program *prog = statp->program;
+	unsigned int i;
+
+	if (!statp->vs_count)
+		return;
+
+	for (i = 0; i < prog->pg_nvers; i++)
+		free_percpu(statp->vs_count[i]);
+	kfree(statp->vs_count);
+	statp->vs_count = NULL;
+}
+EXPORT_SYMBOL_GPL(svc_stat_free_counts);
+
 /**
  * rpc_alloc_iostats - allocate an rpc_iostats structure
  * @clnt: RPC program, version, and xprt
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index ae9ec4bf34f7..bf7c57cbfa3d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1375,6 +1375,13 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	/* Bump per-procedure stats counter */
 	this_cpu_inc(versp->vs_count[rqstp->rq_proc]);
 
+	/* Bump per-net per-procedure stats counter */
+	if (rqstp->rq_server->sv_stats &&
+	    rqstp->rq_server->sv_stats->vs_count &&
+	    rqstp->rq_server->sv_stats->vs_count[rqstp->rq_vers])
+		this_cpu_inc(rqstp->rq_server->sv_stats->vs_count
+				[rqstp->rq_vers][rqstp->rq_proc]);
+
 	ret->dispatch = versp->vs_dispatch;
 	return rpc_success;
 err_bad_vers:

-- 
2.54.0


