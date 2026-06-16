Return-Path: <linux-nfs+bounces-22625-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AoGDArlGMWq5fwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22625-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:51:05 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51368F9A8
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:51:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OMxL0V1E;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22625-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22625-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D1731FC480
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE598367B95;
	Tue, 16 Jun 2026 12:45:46 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BC239E6C;
	Tue, 16 Jun 2026 12:45:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613946; cv=none; b=uVuqYNTWMJ9PrxclKO+5cjXhXJ4B0YF4O3NOJhA6NHpbTRGiU4DBZrEHqHqp4URps0tV6LIsalk24yWrG06FlmUvpGle8bvCdLR+m1BEZjMSVbxG5hPMLSDkd7TPrPWbsE3DDT8uzR8QePaEr3JT4BPAobgBqcLbvLQRnTsXGBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613946; c=relaxed/simple;
	bh=KZgToN0i1gMbI5vQga8B4nQkwpSgV9eroO58XYOzkTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp5jbLmfM7+fsQTq+u0w93a1bVk4+hXmSK2R79vCfEO6utkYpVSFSH5jHXhBMH4kAiSnJCjtdfzh5aYs4t11j+DmGgSYzIfT8j8og0lcxlvBvk4iQA4gwgqjwtTCDXy7/WqT2dYlU7Cbsfmic8mfsBiwv4k/ThiatFPsQINfX9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMxL0V1E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0D21F00A3E;
	Tue, 16 Jun 2026 12:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613945;
	bh=hD03CktBmJm9PueyGnisOj08erlSq9J3gQrM2AtOTWU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OMxL0V1ENbkE/3X7Nm6J1vC0g2JRqSbqty0y4GQgpSP2vYWi8qUECPlM6VZox+Soz
	 TakSOmFRZ1n312NhPqkXSceUjjdOjGgowokSS7vs5QgImPjoyI21WX13dbKEs/8ffi
	 oFGqKnoP8/al7uyJHRPx+/YOA6ayYB9vAfpN6TGZZNNQEp/ICfMhEqpp3weLWRHseT
	 egaGqMgQAKk5KwwsOIPRxbhLuEm6eaWbkXCEzpIEmhmNPga6IRb4gD7/7JdteWmE7K
	 xDllqF5RfHzqWJBQWxHhTHpt4jxnIoOr8KjxBBd8wXT6KtPW4HkDLUTJfqOUQtTwKx
	 WLl2JF4/K2p+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 08:45:33 -0400
Subject: [PATCH v4 1/4] sunrpc: add per-netns per-procedure call counts to
 svc_stat
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-exportd-netlink-v4-1-03505aee3883@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
In-Reply-To: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5361; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=KZgToN0i1gMbI5vQga8B4nQkwpSgV9eroO58XYOzkTo=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMUV2s6ZtwOowvWV0fOtjpHMATKiF0oCD+aWf0
 O6lP6ZIpf2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajFFdgAKCRAADmhBGVaC
 FXl6D/0WsC6QblageKl1lOnWncOHtEPbWfA6ZQ3tOmC/neuhVdGsiLrzMnzJ6jI06yTPZCUyq/G
 KbF0pBCXxm+jDgJqhlcFgoBGyg6qvME9lKjXqKa9bXcAe8ajll9quiXogm3n9E30tlwQiRjiBXx
 2txuNWbCTdXEGg+XA0fDoSO2zj2TAC9fWxqYd+FUSuXO4gzQXC7qpGuTPoSm3pEPNwEENPgy7hB
 Ed7jM9iwjrJ+i4XN0ucf7o/7yjdHCeDjbynYX+ud2Ae6xIzJCehlSPHoVStFOTt7l9RDiCSgPCd
 vT3gYBG0gvh6UZHe5bIfCx1OIvOkf9sbkOXUkEfUasKOJI+HrjrQXDcBbpin2f+syd8DJbNcO8B
 cY9aawh7in0E8ew3vluBCu8iR/Gfu/d0VxYrbicBL2hnMNomHOgETOGkGG/+NMZRLjThZOCKcWQ
 65MAzbr4bHwN3xSlqm18KPofcgbtPzPYYQTT5hsWEym0IpbL9uTm9AdUsMhR9rIfBcNDA3lE23e
 hPqrKr0CC/6wl7RPJlgw4RYnyVaOtnEXQNO+UWKLQ2UC7/7bjnk1imKBROhFcy1h9cwCVQ8e2xr
 InvZJ4ZH1X89+eSDZo0SClmoqQprMAovPE+1tTM0thO2XpMy0pJD/SJBi2CnpJbAebokMj8+Bqe
 /sEFP5tekN7yxRA==
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
	TAGGED_FROM(0.00)[bounces-22625-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C51368F9A8

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
index caf59421f8f4..601301e34fc7 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2514,9 +2514,12 @@ static __net_init int nfsd_net_init(struct net *net)
 
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
@@ -2534,6 +2537,8 @@ static __net_init int nfsd_net_init(struct net *net)
 #endif
 	return 0;
 
+out_svcstats_error:
+	svc_stat_free_counts(&nn->nfsd_svcstats);
 out_proc_error:
 	percpu_counter_destroy_many(nn->counter, NFSD_STATS_COUNTERS_NUM);
 out_repcache_error:
@@ -2574,6 +2579,7 @@ static __net_exit void nfsd_net_exit(struct net *net)
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
index dd80a2eaaa74..f748004835f7 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -1438,6 +1438,14 @@ svc_generic_init_request(struct svc_rqst *rqstp,
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


