Return-Path: <linux-nfs+bounces-22627-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KizzCPJFMWpgfwUAu9opvQ
	(envelope-from <linux-nfs+bounces-22627-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:47:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9E268F8B7
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 14:47:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OQwmajHG;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22627-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22627-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2CA5F302C866
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Jun 2026 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2D936D9F9;
	Tue, 16 Jun 2026 12:45:49 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18C036A01E;
	Tue, 16 Jun 2026 12:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613949; cv=none; b=BUwzrz7fdsYAOrZXSrBxq6rrdtubZ2/Bt+G0lXd1BtI9Kg+kpZqIQohBIMEBypi3CnbcSeRL16Km0n2f4uA7Q2TLmUCJ7FfqNcrB5oNp8RAJVxUpej+iP6n8ZL4mzuBoGbymvyVYAFsbiaViwEYChov9IEx0w3esgdskj7f9BQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613949; c=relaxed/simple;
	bh=w7f/rMjOMUF+UOkeGA5evsQpx5Oyx4NhjfmCTddSyF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nKmrr18Bev2OMa0yRoHo1+qsvqfxojQVEn6VTqvqmkbe7zn9wzGpFmXOXnEgdHOZ+tPNqpGYTR1yqtr/aRazeGvA/pfWgrpeFFkFXBCJJjUErsWm0Ri0NK7/4X0B83evBVvAOQzybmTp1QQJjA4y6FgsjmudXTOaDh/yqTUxkco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQwmajHG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA4F21F00A3E;
	Tue, 16 Jun 2026 12:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781613947;
	bh=1ShGgoDPwvWyjPowsDgk24M2VLl0PfPSUU8JW9ud2e0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=OQwmajHGNWfHY6FOavjLxRGEy25uoD4I68k+4ZRjvSs1chchwozwssIqxwaT2LMap
	 jPg6tXuRSRoTF+RoKQs9NRY9ugs3JrH2zbcae++wjIhwImHCAUKIsrTSq2DrzIWLUW
	 TYJDsPum+3Z6EGo1lg4WENhndHZ9cD+eC6sTNlwspE66H1oFpsTgp8BI/kmu2lvSed
	 p1lAW4jueaEEFVWDf/FctAIqzyf+Wo9nQDa34S5FZ/+HqQx0EUxEluzLLT6E90wOhL
	 ryT+zTQVJ0CBVBT8Pzy7KnYJfQZzK7uXtEvIdMwxRcPAnQNktOG2h92XqJ9b0ESX3k
	 +UbelAdnMasLA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 16 Jun 2026 08:45:35 -0400
Subject: [PATCH v4 3/4] nfsd: implement server-stats-get netlink handler
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-exportd-netlink-v4-3-03505aee3883@kernel.org>
References: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
In-Reply-To: <20260616-exportd-netlink-v4-0-03505aee3883@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=12989; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=w7f/rMjOMUF+UOkeGA5evsQpx5Oyx4NhjfmCTddSyF8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMUV2AQwCu4DPzfDI4OfLHpj5UNl1YaWjNzl2p
 2lE2SytdIqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajFFdgAKCRAADmhBGVaC
 FWUPD/4q4l6lFiypTM2lQ9CyDweyAGqEJuKy0s9ph67wCUZiVwlxmXt+Qu54yWSKKrpbMlCNcxK
 g3u6V7+m1fsSM/C/2zYH50SO77uOXUDGUeev5/m7qRTYe2ghq8Y2zOf/juCatBuib2BEURbbXBC
 MbQHjTeMJqKYp4vMYX6qrv2tk6J/Czb0UHctqpxvmvCpZhqgn5R8LJCove1Dsknxyzcy0JepLBT
 Z0IU8HCkFMaY40A+BsK1lSBcz0exdG5G5gxD7GiixbrjNWylwL0EH/dz/UNoLeeayaWB0roM+td
 3APk1ZRlurSmFbDDbiP27BobaO528mwl/cqlaNHaySAdc0gm8WTJf4lQMs52Ux1Yc/MIBjHqtWu
 05CqOmt0kH0cYglqqZxHlN0PZGvpZ10TMLCx2/obQu+JS6NPq9/L7c1uowKTVlMMUlRiYjqIgCw
 BZpcVNMak8u6UHvEHcuP1t0hLKFVHZKG0DukpVhiSpXktZ8dfPCOUFOdUZ1ieB/zO8q1OX3QImF
 Csj58OkqpWqGFMjPpz/S8Weg4Mq+BgS4qW6zhgJgwi1uoQXnWIagi8DAaotD/mA3Vh5+IFkugsd
 pHgyD+4ZgezMInYLX7j1xCCL6JmVOfjVUY98TFRD3SNyMrDU8QzUQ0kLOdmipuKdlkRv9bPYQoh
 NJhJAuv0nZGzLuQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22627-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9A9E268F8B7

Implement nfsd_nl_server_stats_get_dumpit() which exposes the
NFS server statistics currently available via /proc/net/rpc/nfsd
through the nfsd generic netlink family.

The handler uses a dump operation to stream statistics across
multiple netlink messages:

  - First message: all scalar stats (reply cache, filehandle,
    IO, network, RPC) plus per-version procedure counts
    (proc2/3/4-ops) using per-netns vs_count arrays.

  - Subsequent messages: NFSv4 per-operation counts
    (proc4ops-ops), one entry per message, using cb->args[0]
    to track the current operation index across dump calls.

This allows nfsstat to retrieve server statistics via netlink
with a procfs fallback for older kernels.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml | 105 +++++++++++++++++
 fs/nfsd/netlink.c                     |   5 +
 fs/nfsd/netlink.h                     |   2 +
 fs/nfsd/nfsctl.c                      | 206 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  35 ++++++
 5 files changed, 353 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8f36fadd68f7..2a89d355ee7b 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -330,6 +330,86 @@ attribute-sets:
           of which client holds the state. Intended for use after
           all clients have been unexported from a given path,
           enabling the underlying filesystem to be unmounted.
+  -
+    name: server-proc-entry
+    attributes:
+      -
+        name: op
+        type: u32
+      -
+        name: count
+        type: u64
+      -
+        name: pad
+        type: pad
+  -
+    name: server-stats
+    attributes:
+      -
+        name: rc-hits
+        type: u64
+      -
+        name: rc-misses
+        type: u64
+      -
+        name: rc-nocache
+        type: u64
+      -
+        name: pad
+        type: pad
+      -
+        name: fh-stale
+        type: u64
+      -
+        name: io-read
+        type: u64
+      -
+        name: io-write
+        type: u64
+      -
+        name: netcnt
+        type: u32
+      -
+        name: netudpcnt
+        type: u32
+      -
+        name: nettcpcnt
+        type: u32
+      -
+        name: nettcpconn
+        type: u32
+      -
+        name: rpccnt
+        type: u32
+      -
+        name: rpcbadfmt
+        type: u32
+      -
+        name: rpcbadauth
+        type: u32
+      -
+        name: rpcbadclnt
+        type: u32
+      -
+        name: proc2-ops
+        type: nest
+        nested-attributes: server-proc-entry
+        multi-attr: true
+      -
+        name: proc3-ops
+        type: nest
+        nested-attributes: server-proc-entry
+        multi-attr: true
+      -
+        name: proc4-ops
+        type: nest
+        nested-attributes: server-proc-entry
+        multi-attr: true
+      -
+        name: proc4ops-ops
+        type: nest
+        nested-attributes: server-proc-entry
+        multi-attr: true
 
 operations:
   list:
@@ -516,6 +596,31 @@ operations:
         request:
           attributes:
             - path
+    -
+      name: server-stats-get
+      doc: dump NFS server statistics
+      attribute-set: server-stats
+      dump:
+        reply:
+          attributes:
+            - rc-hits
+            - rc-misses
+            - rc-nocache
+            - fh-stale
+            - io-read
+            - io-write
+            - netcnt
+            - netudpcnt
+            - nettcpcnt
+            - nettcpconn
+            - rpccnt
+            - rpcbadfmt
+            - rpcbadauth
+            - rpcbadclnt
+            - proc2-ops
+            - proc3-ops
+            - proc4-ops
+            - proc4ops-ops
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index fbee3676d253..eba8b353f412 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -225,6 +225,11 @@ static const struct genl_split_ops nfsd_nl_ops[] = {
 		.maxattr	= NFSD_A_UNLOCK_EXPORT_PATH,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
+	{
+		.cmd	= NFSD_CMD_SERVER_STATS_GET,
+		.dumpit	= nfsd_nl_server_stats_get_dumpit,
+		.flags	= GENL_CMD_CAP_DUMP,
+	},
 };
 
 static const struct genl_multicast_group nfsd_nl_mcgrps[] = {
diff --git a/fs/nfsd/netlink.h b/fs/nfsd/netlink.h
index af41aa0d4a65..027e2953db26 100644
--- a/fs/nfsd/netlink.h
+++ b/fs/nfsd/netlink.h
@@ -42,6 +42,8 @@ int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_ip_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_filesystem_doit(struct sk_buff *skb, struct genl_info *info);
 int nfsd_nl_unlock_export_doit(struct sk_buff *skb, struct genl_info *info);
+int nfsd_nl_server_stats_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb);
 
 enum {
 	NFSD_NLGRP_NONE,
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 601301e34fc7..f165f0023c70 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2329,6 +2329,212 @@ int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info)
 	return 0;
 }
 
+static int nfsd_nl_fill_proc_ops(struct sk_buff *skb, int attr,
+				 unsigned long __percpu *counts,
+				 unsigned int nproc)
+{
+	struct nlattr *nest;
+	unsigned int j;
+	int k;
+
+	for (j = 0; j < nproc; j++) {
+		unsigned long count = 0;
+
+		for_each_possible_cpu(k)
+			count += per_cpu(counts[j], k);
+
+		nest = nla_nest_start(skb, attr);
+		if (!nest)
+			return -EMSGSIZE;
+		if (nla_put_u32(skb, NFSD_A_SERVER_PROC_ENTRY_OP, j) ||
+		    nla_put_u64_64bit(skb, NFSD_A_SERVER_PROC_ENTRY_COUNT,
+				      count, NFSD_A_SERVER_PROC_ENTRY_PAD)) {
+			nla_nest_cancel(skb, nest);
+			return -EMSGSIZE;
+		}
+		nla_nest_end(skb, nest);
+	}
+
+	return 0;
+}
+
+/**
+ * nfsd_nl_server_stats_get_dumpit - dump NFS server statistics
+ * @skb: reply buffer
+ * @cb: netlink metadata and command arguments
+ *
+ * cb->args[0] tracks the current NFSv4 operation index for proc4ops.
+ * A value of 0 means we haven't started yet. We emit all scalar stats
+ * and per-version procedure counts in the first message, then emit
+ * proc4ops entries filling as many as will fit per message.
+ *
+ * Returns the size of the reply or a negative errno.
+ */
+int nfsd_nl_server_stats_get_dumpit(struct sk_buff *skb,
+				    struct netlink_callback *cb)
+{
+	struct net *net = sock_net(skb->sk);
+	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	struct svc_stat *statp = &nn->nfsd_svcstats;
+	struct svc_program *prog = statp->program;
+	int start = cb->args[0];
+	void *hdr;
+
+	/*
+	 * cb->args[0] == 0: first call, emit scalar stats + procN counts
+	 * cb->args[0] > 0: emit proc4ops entries starting from args[0] - 1
+	 * cb->args[0] < 0: done
+	 */
+	if (start < 0)
+		return 0;
+
+	if (start == 0) {
+		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+				  cb->nlh->nlmsg_seq, &nfsd_nl_family,
+				  NLM_F_MULTI, NFSD_CMD_SERVER_STATS_GET);
+		if (!hdr)
+			return -ENOBUFS;
+
+		/* Reply cache stats */
+		{
+			u64 hits, misses, nocache;
+
+			hits = percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_HITS]);
+			misses = percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_MISSES]);
+			nocache = percpu_counter_sum_positive(&nn->counter[NFSD_STATS_RC_NOCACHE]);
+			if (nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_RC_HITS,
+					hits, NFSD_A_SERVER_STATS_PAD) ||
+			    nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_RC_MISSES,
+					misses, NFSD_A_SERVER_STATS_PAD) ||
+			    nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_RC_NOCACHE,
+					nocache, NFSD_A_SERVER_STATS_PAD))
+				goto err_cancel;
+		}
+
+		/* Filehandle stats */
+		if (nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_FH_STALE,
+				percpu_counter_sum_positive(&nn->counter[NFSD_STATS_FH_STALE]),
+				NFSD_A_SERVER_STATS_PAD))
+			goto err_cancel;
+
+		/* IO stats */
+		{
+			u64 rd, wr;
+
+			rd = percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_READ]);
+			wr = percpu_counter_sum_positive(&nn->counter[NFSD_STATS_IO_WRITE]);
+			if (nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_IO_READ,
+					rd, NFSD_A_SERVER_STATS_PAD) ||
+			    nla_put_u64_64bit(skb, NFSD_A_SERVER_STATS_IO_WRITE,
+					wr, NFSD_A_SERVER_STATS_PAD))
+				goto err_cancel;
+		}
+
+		/* Network stats */
+		if (nla_put_u32(skb, NFSD_A_SERVER_STATS_NETCNT,
+				statp->netcnt) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_NETUDPCNT,
+				statp->netudpcnt) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_NETTCPCNT,
+				statp->nettcpcnt) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_NETTCPCONN,
+				statp->nettcpconn))
+			goto err_cancel;
+
+		/* RPC stats */
+		if (nla_put_u32(skb, NFSD_A_SERVER_STATS_RPCCNT,
+				statp->rpccnt) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_RPCBADFMT,
+				statp->rpcbadfmt) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_RPCBADAUTH,
+				statp->rpcbadauth) ||
+		    nla_put_u32(skb, NFSD_A_SERVER_STATS_RPCBADCLNT,
+				statp->rpcbadclnt))
+			goto err_cancel;
+
+		/* Per-version procedure counts */
+		if (statp->vs_count) {
+			static const int proc_attrs[] = {
+				[2] = NFSD_A_SERVER_STATS_PROC2_OPS,
+				[3] = NFSD_A_SERVER_STATS_PROC3_OPS,
+				[4] = NFSD_A_SERVER_STATS_PROC4_OPS,
+			};
+			unsigned int i;
+
+			for (i = 0; i < prog->pg_nvers &&
+			     i < ARRAY_SIZE(proc_attrs); i++) {
+				if (!prog->pg_vers[i] ||
+				    !statp->vs_count[i])
+					continue;
+				if (!proc_attrs[i])
+					continue;
+				if (nfsd_nl_fill_proc_ops(skb,
+						proc_attrs[i],
+						statp->vs_count[i],
+						prog->pg_vers[i]->vs_nproc))
+					goto err_cancel;
+			}
+		}
+
+		genlmsg_end(skb, hdr);
+		cb->args[0] = 1;
+	}
+
+#ifdef CONFIG_NFSD_V4
+	/* NFSv4 individual operation counts */
+	{
+		int i = (start > 0) ? start - 1 : 0;
+
+		for (; i <= LAST_NFS4_OP; i++) {
+			struct percpu_counter *ctr;
+			struct nlattr *nest;
+			u64 cnt;
+
+			ctr = &nn->counter[NFSD_STATS_NFS4_OP(i)];
+			cnt = percpu_counter_sum_positive(ctr);
+
+			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
+					  cb->nlh->nlmsg_seq,
+					  &nfsd_nl_family, NLM_F_MULTI,
+					  NFSD_CMD_SERVER_STATS_GET);
+			if (!hdr) {
+				cb->args[0] = i + 1;
+				goto out;
+			}
+
+			nest = nla_nest_start(skb,
+					NFSD_A_SERVER_STATS_PROC4OPS_OPS);
+			if (!nest) {
+				genlmsg_cancel(skb, hdr);
+				cb->args[0] = i + 1;
+				goto out;
+			}
+			if (nla_put_u32(skb, NFSD_A_SERVER_PROC_ENTRY_OP,
+					i) ||
+			    nla_put_u64_64bit(skb,
+					NFSD_A_SERVER_PROC_ENTRY_COUNT,
+					cnt,
+					NFSD_A_SERVER_PROC_ENTRY_PAD)) {
+				nla_nest_cancel(skb, nest);
+				genlmsg_cancel(skb, hdr);
+				cb->args[0] = i + 1;
+				goto out;
+			}
+			nla_nest_end(skb, nest);
+			genlmsg_end(skb, hdr);
+		}
+	}
+#endif
+
+	cb->args[0] = -1;
+out:
+	return skb->len;
+
+err_cancel:
+	genlmsg_cancel(skb, hdr);
+	return -EMSGSIZE;
+}
+
 int nfsd_cache_notify(struct cache_detail *cd, struct cache_head *h, u32 cache_type)
 {
 	struct genlmsghdr *hdr;
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index f5b75d5caba9..3d076d173b1d 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -225,6 +225,40 @@ enum {
 	NFSD_A_UNLOCK_EXPORT_MAX = (__NFSD_A_UNLOCK_EXPORT_MAX - 1)
 };
 
+enum {
+	NFSD_A_SERVER_PROC_ENTRY_OP = 1,
+	NFSD_A_SERVER_PROC_ENTRY_COUNT,
+	NFSD_A_SERVER_PROC_ENTRY_PAD,
+
+	__NFSD_A_SERVER_PROC_ENTRY_MAX,
+	NFSD_A_SERVER_PROC_ENTRY_MAX = (__NFSD_A_SERVER_PROC_ENTRY_MAX - 1)
+};
+
+enum {
+	NFSD_A_SERVER_STATS_RC_HITS = 1,
+	NFSD_A_SERVER_STATS_RC_MISSES,
+	NFSD_A_SERVER_STATS_RC_NOCACHE,
+	NFSD_A_SERVER_STATS_PAD,
+	NFSD_A_SERVER_STATS_FH_STALE,
+	NFSD_A_SERVER_STATS_IO_READ,
+	NFSD_A_SERVER_STATS_IO_WRITE,
+	NFSD_A_SERVER_STATS_NETCNT,
+	NFSD_A_SERVER_STATS_NETUDPCNT,
+	NFSD_A_SERVER_STATS_NETTCPCNT,
+	NFSD_A_SERVER_STATS_NETTCPCONN,
+	NFSD_A_SERVER_STATS_RPCCNT,
+	NFSD_A_SERVER_STATS_RPCBADFMT,
+	NFSD_A_SERVER_STATS_RPCBADAUTH,
+	NFSD_A_SERVER_STATS_RPCBADCLNT,
+	NFSD_A_SERVER_STATS_PROC2_OPS,
+	NFSD_A_SERVER_STATS_PROC3_OPS,
+	NFSD_A_SERVER_STATS_PROC4_OPS,
+	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
+
+	__NFSD_A_SERVER_STATS_MAX,
+	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)
+};
+
 enum {
 	NFSD_CMD_RPC_STATUS_GET = 1,
 	NFSD_CMD_THREADS_SET,
@@ -244,6 +278,7 @@ enum {
 	NFSD_CMD_UNLOCK_IP,
 	NFSD_CMD_UNLOCK_FILESYSTEM,
 	NFSD_CMD_UNLOCK_EXPORT,
+	NFSD_CMD_SERVER_STATS_GET,
 
 	__NFSD_CMD_MAX,
 	NFSD_CMD_MAX = (__NFSD_CMD_MAX - 1)

-- 
2.54.0


