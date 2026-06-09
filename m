Return-Path: <linux-nfs+bounces-22401-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EcLrKrxDKGogBQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22401-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:47:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 129F466292C
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 18:47:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CoKaWt4r;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22401-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22401-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D30A320A4AE
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 16:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F82B3B0AED;
	Tue,  9 Jun 2026 16:16:04 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314A3AEF58;
	Tue,  9 Jun 2026 16:16:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021763; cv=none; b=TgG5mz7MJ4cjYXmVObSlmoDHh+Y0xfoPNp2o8mFq+/hnaDKk/JqezwfurYOE00VB+nWQXR6dXOUJAcwAG+VdIOFGJNuD4DY6ETskW0CYeJeHI8KN4d6+ku2P25s2LAGMrdv6C8RWk091Apz/WLsIqLssv7dt9n0o/mNvcaVmapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021763; c=relaxed/simple;
	bh=gPdb5PUAM0BrK0h035CNZn7Y2sMbtCb/Yg/pqJKIr1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iE65QgbSkAD/BZvDBryRPMW43grJJkgJZoS+l8YJSlO2rRW2BZGluJDOia0vpAwe1ZrJD/CnPszuPcbvziNK9+vjaYV8M6qZt7vHFp3b0e4cKnw4h0x/SeKX+ItuBbxWD03eU6jr2jfNZ1SqbrzN9vRj12OIO7zVr1RyTiJqaj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoKaWt4r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818061F00893;
	Tue,  9 Jun 2026 16:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021762;
	bh=fytm80oB2xd9RMPARuKQ+D3B+SOn9ysuLpBxELajWi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CoKaWt4rGvfKOrEdz3Hp2SHQwJNZuaijQd4CDS5t+fREvv6fbHK3k+p47LVJgu4yF
	 iUrHO3Ga2S8yDZmMZEGBTKhADr2B9tPcrhXy9jTp4YAjOA2sO0oHNlxAYX3ovncxm+
	 KH3hr6oSDCYIvHJPpBDSgWnFvK/7vIs9MxJVWuTAaGW3OH7OAtnwaHWZ1kl3M3ovfX
	 ZQXAGAu6WlNNhV+d1kcbsk9IXAO2k3tgcQbBv2pEBMGwRJROZIFQjDZCeAiTPMtIEY
	 A0OBpVlXq0q3gTSO5NC01FD6Q+Y00Ob7ISyaK3I1+EkiNiO7LH7O5oNtSM+3yu3i7g
	 dFsprYgKy7S6Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 12:15:54 -0400
Subject: [PATCH v3 1/4] sunrpc: add per-netns per-procedure call counts to
 svc_stat
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-exportd-netlink-v3-1-aa5508a5bb1d@kernel.org>
References: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
In-Reply-To: <20260609-exportd-netlink-v3-0-aa5508a5bb1d@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5361; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=gPdb5PUAM0BrK0h035CNZn7Y2sMbtCb/Yg/pqJKIr1Q=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKDw/RNF5b3LqP8YrkHkUAZBGifnnjm5l3vMp0
 EGTQ+7Hh9qJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaig8PwAKCRAADmhBGVaC
 FUyMD/4kx0KsnzRKg0Pm7CBb/heJ01VAVWLiVUyOslgcESOuDDF3VrR6k9GFTkEYVPy+UVi5YaY
 sYxQDu4r+Ls2h62Pebv+N3ZVK3N1A3tNQOpkNz3tkzTgOb+r1EN+BhKhMwgFw70FHj49RjA8Nej
 lukgbzZnWqE5gyjHyLYF3XDcR7akpQKg2XGraiDV4nKkR5g2ddbQsAEVh/s+1ysFu6jJzJ8F22n
 nIAuIAC9yQHDXG81NhG1RDyU9vGbH/DNKpcYiKNN3/W5+KIf71HWvBwb6icCW19q+qgb8uJZUjE
 kUeALlKOlJOmRUoj/+cjHs+aBPrpkAHJUnbyeWM+7VskWbH9l9Fmm/D0XF48AqCQwfapSqFQ6ir
 9g2y3587PmjFBMHuOhYbuqhASlJfsToV/GWAw0WCYfcQTR/nuGYUR7GZA0y7EevoYeLuc0ly3Y/
 BSqV0nmhvAanBUksfppEr+hn0PZIBabkY1DKPVHRys63/7I1iDjxLDEbvgq7JFsJZqGtAccVyyr
 rsxJoqmBvctP4bGZrG5/8vjRBBtzKAS8KNdQ3JUWFc9gvJkcU+KOqkN4KXUrFHCAaV6opPpqN+U
 sNHzyg9SSPVbkyR4LndO/ju2d6odevPMPUHa87ix7bu5UQlVs1Eu3LeGcvmybh093jHZM03DTC+
 N1sIVjmH7iWAGTw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22401-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 129F466292C

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
 net/sunrpc/svc.c             |  8 +++++++
 4 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index c06d25c06f06..7b802d335501 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2436,9 +2436,12 @@ static __net_init int nfsd_net_init(struct net *net)
 
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
@@ -2456,6 +2459,8 @@ static __net_init int nfsd_net_init(struct net *net)
 #endif
 	return 0;
 
+out_svcstats_error:
+	svc_stat_free_counts(&nn->nfsd_svcstats);
 out_proc_error:
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
@@ -2496,6 +2501,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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
index 009373737ea9..200b57e633dd 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1408,6 +1408,14 @@ svc_generic_init_request(struct svc_rqst *rqstp,
 	/* Bump per-procedure stats counter */
 	this_cpu_inc(versp->vs_count[rqstp->rq_proc]);
 
+	/* Bump per-net per-procedure stats counter */
+	if (rqstp->rq_server->sv_stats &&
+	    rqstp->rq_server->sv_stats->program == progp &&
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


