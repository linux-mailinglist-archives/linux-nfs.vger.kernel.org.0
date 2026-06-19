Return-Path: <linux-nfs+bounces-22696-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hRU3Hu1fNWqluQYAu9opvQ
	(envelope-from <linux-nfs+bounces-22696-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:27:41 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B05E6A6AAD
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 17:27:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="BfZB/uza";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22696-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22696-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 66D48302D76D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 15:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73383B47CA;
	Fri, 19 Jun 2026 15:26:58 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59573B42F6;
	Fri, 19 Jun 2026 15:26:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882818; cv=none; b=YQokIB83ljHzVsjXVL3R0zDPIDCUZcbo+zYolpzDdbpgTrnp6u1WvQ6BPiA7qn6bIzxNLGSNP7OWCIWSN1E4JNMWvdJk6op+vzYNuK+1aR9pt7g6o6CfhZ9B4GKv/szb9jP98ne82bbuG2SPeEt10QfN87YDU+fr/VOPQekODr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882818; c=relaxed/simple;
	bh=xU26qzKXVQ6Ov2COMssVEMqAmP8aCUy/3Z7sYD5LQVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhbiRKj97MUlOM2R6vpJLVYInz8Evx5eAy1kx1pa54aggG/8twO7yeyt+jROZbq/7NH2Ekth/SgTrvVFrr97v/bXi/3+NXnHqEKBRSGBocgPmpBlg3plG3mokT9226ck9nf9IQVFOWryYfjEpWwl25AwipjI6XPL23jlFWMWBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfZB/uza; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7EE1F00A3A;
	Fri, 19 Jun 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781882817;
	bh=h4jpxfI+k22sGViG4YCP6Ofd4nWrWUMW33yxPtceVjo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BfZB/uzaynh9RVDGvtNwVUoU8sHcnxXJYU/AP0PnM+HcLhvfubEw73nltWXB4yPcN
	 M9RalN2HehTfjd3scA74ZuEF6Yv4s1rpoLQrotLDokt3xPfw+bHZZlheB2T7KbtOJF
	 1bdvpYFjBzYXedN+ACJx0291a0AeyJzjM3cvP9DlNEdg+vgqyYlCyQNHKpOS1sIueS
	 +xJKBVn7fBKzU9pCGBivm3jG3dTgBsgLamntwsH1s6XQ2kxhv/lOk31fu3edAANY7s
	 9eVItfHEvrdMS6pB+GFv87UvCRqjqZ/a8iacTx1xR/PyDA75IsulAWQjQRTMYtRAQv
	 vc0kf4++IbtMw==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 19 Jun 2026 11:26:41 -0400
Subject: [PATCH v6 6/6] nfsd: export NFSv4 callback op stats via netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-exportd-netlink-v6-6-ddef3499793c@kernel.org>
References: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
In-Reply-To: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2962; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xU26qzKXVQ6Ov2COMssVEMqAmP8aCUy/3Z7sYD5LQVY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNV+4/BxVyAms3UfuLyZfRJ4CRV5etUFIpR5GU
 b/asfVX8taJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajVfuAAKCRAADmhBGVaC
 FRevD/wNRfHbov3OAFB9qubV5QJd56MoI1IHNawb7HnILyfS/v68ZWCvy03lHh2ACwQ9U2jc26j
 6JDhzBehniI9MkzqiOjAFYjkO5dAIzyrNwog4qXzL0G4uffs4RVTPxA3Ngj8pM/r4VseowO6TS4
 L9Z5bPNnbdHquAXVBTlJrm8tqzuH3l00wdYieqkV7pIqOKePdZfIsQFNeOJkZ1yzUJthJPypBLx
 SYE3oJRYdsgjcm7YR9A9Ti9hrus/9Wc3D7rHuHSKX11tKTZuJGBErPIsXX2AAsScAaXd2/Cjg2Q
 F0E+jdAuLAKAOSYsqP87SUK1gZKAyxckFcgtPoRE7JsFqMxjq78/OYrMzWAsL13JJTijY6h9JvE
 Gue2KNGUMS2XCZaJvI/faM5+PoRcKFwO4wBkkWQzJXPMAINnjrHeVIUFsAB2w2WuLkIRu1SopS/
 7ygZ/4kDM79xApFZOdNJ2amksf0K6ngifLHMRpaHeKhJpa8QbgIKwQvAVtG4wqgJRPTq2vDx7w1
 zjnDNMosRliN6HY39ajcYMZxlVpTHKwiQMG3Lt9OMExgQ1xO0k84lMRYqZGbt4n8+4Wq248Wcwz
 XEVCR2mj4gB0Ch/prwkENB5fEintbKL8eONPHtDE0CoOj5wZBohqdrD+MCwFxY4bjaeGHtVpnr/
 v1TcQxqTxi7I4DA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22696-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B05E6A6AAD

Add a proc4cb-ops nested attribute to the server-stats netlink dump,
reusing the existing server-proc-entry (op/count) layout. The first dump
message emits one entry per callback opcode (OP_CB_GETATTR..OP_CB_OFFLOAD)
from the per-netns callback counters; the set is small and fits alongside
the scalar stats, so no extra paging is needed.

This lets nfsstat report NFSv4 backchannel operation counts over netlink,
including CB_GETATTR which corresponds to the procfs wdeleg_getattr line.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  6 ++++++
 fs/nfsd/nfsctl.c                      | 21 +++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 3 files changed, 28 insertions(+)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 2a89d355ee7b..642268819c6f 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -410,6 +410,11 @@ attribute-sets:
         type: nest
         nested-attributes: server-proc-entry
         multi-attr: true
+      -
+        name: proc4cb-ops
+        type: nest
+        nested-attributes: server-proc-entry
+        multi-attr: true
 
 operations:
   list:
@@ -621,6 +626,7 @@ operations:
             - proc3-ops
             - proc4-ops
             - proc4ops-ops
+            - proc4cb-ops
 
 mcast-groups:
   list:
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 4710415790e2..6e941d8d08e1 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2475,6 +2475,27 @@ int nfsd_nl_server_stats_get_dumpit(struct sk_buff *skb,
 		}
 
 #ifdef CONFIG_NFSD_V4
+		/* NFSv4 callback (backchannel) per-operation counts */
+		for (int op = OP_CB_GETATTR; op <= OP_CB_OFFLOAD; op++) {
+			struct nlattr *nest;
+			u64 cnt;
+
+			cnt = percpu_counter_sum_positive(
+				&nn->cb_counter[op]);
+
+			nest = nla_nest_start(skb,
+					NFSD_A_SERVER_STATS_PROC4CB_OPS);
+			if (!nest)
+				goto err_cancel;
+			if (nla_put_u32(skb, NFSD_A_SERVER_PROC_ENTRY_OP, op) ||
+			    nla_put_u64_64bit(skb, NFSD_A_SERVER_PROC_ENTRY_COUNT,
+					      cnt, NFSD_A_SERVER_PROC_ENTRY_PAD)) {
+				nla_nest_cancel(skb, nest);
+				goto err_cancel;
+			}
+			nla_nest_end(skb, nest);
+		}
+
 		/* NFSv4 individual operation counts */
 		for (int i = 0; i <= LAST_NFS4_OP; i++) {
 			struct nlattr *nest;
diff --git a/include/uapi/linux/nfsd_netlink.h b/include/uapi/linux/nfsd_netlink.h
index 3d076d173b1d..87da1d0bb21e 100644
--- a/include/uapi/linux/nfsd_netlink.h
+++ b/include/uapi/linux/nfsd_netlink.h
@@ -254,6 +254,7 @@ enum {
 	NFSD_A_SERVER_STATS_PROC3_OPS,
 	NFSD_A_SERVER_STATS_PROC4_OPS,
 	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
+	NFSD_A_SERVER_STATS_PROC4CB_OPS,
 
 	__NFSD_A_SERVER_STATS_MAX,
 	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)

-- 
2.54.0


