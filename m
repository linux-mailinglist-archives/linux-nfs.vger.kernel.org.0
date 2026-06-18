Return-Path: <linux-nfs+bounces-22677-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2+lQLickNGqKPgYAu9opvQ
	(envelope-from <linux-nfs+bounces-22677-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:00:23 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 155116A1B97
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 19:00:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="LmO/iPcc";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22677-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22677-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10F9C30A64BE
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jun 2026 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C896340418;
	Thu, 18 Jun 2026 16:58:26 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD534388E;
	Thu, 18 Jun 2026 16:58:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781801906; cv=none; b=QCLuM/kNz/BSz9ycCpBGiRwptPw9xr+TJux4DbMuaTplrQWmrbhqK4cQs58iYcrzT+QI/DVNuH5qk8nJbGMmNKcUqqSWMn/0XYqx2zi9SO++bRK0nI9kMTl3wfWpFueNX3TrgbXrquC5IRcBGj+Dj0aMBRXtPPcsNwROeNq1+iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781801906; c=relaxed/simple;
	bh=85JSTLrWU67+wZ+eYmpiuUehEMVVfVOjPuIMNmp50cI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J1LH10ScbUwHhcgf9rPdcRGj8DJCyYwNAO0feujtMzmN1/sbrBekjSzxbyUopfE/Bua4TgzXDCH04Xe9c1nCUVJSufZ+Wp8mOBufZG44zaQfQfYfUq5BADR95R8Pl8H87aBVhY+mv5jSfl2vvz8K9hXo11IBldYshUQ9mFOyFvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmO/iPcc; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F02511F00ACA;
	Thu, 18 Jun 2026 16:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781801904;
	bh=4nKi25cSA3GUIr79XIFIDSKcVCYd7KFd/5uewFjh6BA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LmO/iPcc6NNhboVgs2nDcIVLQO0AstCATPdfZoelvMYfbKpNSnrml7vuMFqqX/8fL
	 pJmxAPxmSZ2ufqChyGf+L/tz6eoh+5ub9E8wz+V/cDsy4FdoqvtwHtCyND+NXGmkEe
	 Pz+CTATcwKfWOmR9htuYmdniDrmvaF4/pMEaDIzEwgvkWrN8st6ZUconaVt8r+oWyi
	 x4XlMuZHYitxDXEW72wnWbs9gsY2YRKuuYijY85h7iZKxcjIz0zaHjmGirYgRuWeWm
	 aSqeGUKnYhfpvDikYFRvaRGkBIR21oew0U5D01W/5xeVqQzTcJMFr4U3H6SiJ1TBSk
	 FM5RrybVXMltg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 18 Jun 2026 12:58:00 -0400
Subject: [PATCH v5 6/6] nfsd: export NFSv4 callback op stats via netlink
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-exportd-netlink-v5-6-e9aef947af3d@kernel.org>
References: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
In-Reply-To: <20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org>
To: NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Steve Dickson <steved@redhat.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2917; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=85JSTLrWU67+wZ+eYmpiuUehEMVVfVOjPuIMNmp50cI=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqNCOohHc+sWAOmYLVMoeaJWOO55DYxqLu2VfoQ
 BcaC16wl4KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajQjqAAKCRAADmhBGVaC
 Fag8D/9XW10A+/13/OEyHwwHd64f+5Xy+tfAqXzkaXLHwT2G3lOKpD/r3AggCqLzBJ0J0C7JFcX
 JbQ0M3OWtNQrE9fj2lqdq+6jd0ZoLD0n8XIpfcUSFIr9qFxea69BGt0B2AOGSWbsSGlJmhzN+ib
 W/aqHDSmVqE69aEqQpy43oOxWQt3XBvKJpAdi19jldTJFcFQx5xOA/DejbAY7LvPhpb9zaDi6Ph
 EaBKreWRwW4S6DxSpMio6xPGpQodwfZ0lnbLTHNVRrpvMdq1KUDwwYZZxNnpe+aK7tw6IKnR0bh
 5+Nq4iSlkTF/6WFCeMjiG5rL/CydDGwUjKYn9VqZ5TsB1qgebItGmSlWulWIt/dikXpVU0r8kEZ
 H8VW0v0kQvioBlla9fpm+RDU5FueZ2WNH9uc6VhIqEY0k7qdpbIVcW8DZXQSSvk+/VmlbGKs1C4
 GqSQoop3WybFugw/FfqZJ1FUcl4qwNLTXDjfYVWlomP559DJ20hzHkGwe0yK2ix+jtUk/hGR1oy
 TZsNjMPPcKiJkrSCLnUAw33jrbJSaRkADKLGKePLvS/9TX1TMaaUmHGcBhQtFzqq8aaWpbPX39M
 9jz+vIEMhlJTyXQREtJX2jMnPaIi4YR8KpeLS4IyaiZId++8TM9qxKQ7D10pjrPv7egml3UC5IM
 29nrC7XlrsMLmIw==
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
	TAGGED_FROM(0.00)[bounces-22677-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 155116A1B97

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
 fs/nfsd/nfsctl.c                      | 23 +++++++++++++++++++++++
 include/uapi/linux/nfsd_netlink.h     |  1 +
 3 files changed, 30 insertions(+)

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
index 9bedbe7096c3..674fab6a86a5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2476,6 +2476,29 @@ int nfsd_nl_server_stats_get_dumpit(struct sk_buff *skb,
 			}
 		}
 
+#ifdef CONFIG_NFSD_V4
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
+#endif
+
 		genlmsg_end(skb, hdr);
 		cb->args[0] = 1;
 	}
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


