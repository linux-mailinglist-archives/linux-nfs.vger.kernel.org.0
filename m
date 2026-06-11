Return-Path: <linux-nfs+bounces-22509-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HT25EisVK2pw2QMAu9opvQ
	(envelope-from <linux-nfs+bounces-22509-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:06:03 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B48D5674F0E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 22:06:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="f6oJqt/E";
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22509-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22509-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D696B31A389E
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jun 2026 20:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD33A5429;
	Thu, 11 Jun 2026 20:01:23 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA13A0E93;
	Thu, 11 Jun 2026 20:01:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208083; cv=none; b=npbMewvni1hMoQSkdJytULNk751GorUivyHtk/StmN2nHNyYPO8BqvBs6eqIi7bLMbravoYCLb86ZN+M96C4p3WCpuTusWXWKPYT/ysCd9zMeksy5V5zWByDjO1VKcBILu51wyndrjMpJ/i42lGZK4cmddcmxmRE1RAA0iljdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208083; c=relaxed/simple;
	bh=vg4fY9NMrqXQTacxiPcA7z5kpGDoM2e/qZRwpMvCNoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOmQtEEsV3R744mTCaMljng+lIuFuxIFBm/OynzQXiYe5xvKcMCl/EYo/C15JIrSH/Qmp/qN0K6OURTZQGXc1TEUB9ucoV66rGB5e4upfqEzmrukeEMB5E1reQRpvP/nJpXpUzgZmNZHzEAtWCk32v4cIGT0ZlbhHAlA5JOmYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6oJqt/E; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40CF1F000E9;
	Thu, 11 Jun 2026 20:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781208081;
	bh=ry/cRm7P9iL5R89y7+BRhtURJNdG3ZaptPbdfKvXO8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f6oJqt/E0VpEkJVA/+RxNu/oRraUnUQairAmkph0g+GHG8zLj4GWnTBITIT/5tMxM
	 CsHkK7dXr5oKTRZ+ptj7U+g16aEQrT29b0SnRGlkf+VX/BftYytlI/jlSOqcEN3V/o
	 12OL7VJafXjq47niAHgKISHCJc1vSYVylHRZ2pymz44KrR9h6lLCi89EhOW74tKo95
	 PbMJSMPAAKLbZ9048gmQoVYyvVUzb3NmycoCkH6rtr9yZrxlxz0W5PHqdiP9TjFCru
	 E7MJ3mjptKJvkGGX3E23jFg9jXLU6iRLBv1uBte460+kxmBTO5SzenKkUHEFgx/1/g
	 wqNq8HKfZHFRw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 11 Jun 2026 16:00:58 -0400
Subject: [PATCH v2 15/21] nfsd: validate sockaddr length per family in
 listener_set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-nfsd-testing-v2-15-5b90e276f2d9@kernel.org>
References: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
In-Reply-To: <20260611-nfsd-testing-v2-0-5b90e276f2d9@kernel.org>
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vg4fY9NMrqXQTacxiPcA7z5kpGDoM2e/qZRwpMvCNoE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKxP/PSSOBSfilBEhqSJXdWlopfk+9YTzmEyKa
 rQyslDYXvaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaisT/wAKCRAADmhBGVaC
 Fe+TEACJzS9ohNfWCmRBOtEBl74NfdtvII5UHpvIYQ7coKs8TSgTE58ZZPxMumYw8n/3f3UdNG0
 pfQlm0oUt8zZMjucgrOvCdwoZKv+xy2MWncDIjUIiDPiBCp76Gq9IsxsLqrOOuPLE1mT/weqLdY
 gBpa/D3sXvONUb2DWBBKB4u5YXyNcWQZXkAzJkHQzmu3E/0d+ZYA2hOoNcIh9Or3IiPEwrt4nNr
 pHRqkhFHnsVmOd4QIsvpVk0B38V3mJiZxqfVwHaQX4VN+CBuKEVVwObz1eyJzuiV2Rtp4ymgZmm
 gdJdp9HZIaklcTMt1QrRTFNuynTx4+WDXp9xAWJGSJZ5+3iJjQoajIXb4UGri8HyTNnKxlzp43W
 Rg6yfrkGYqN4a3imXjAVez/2Jzn/KfwB2nkmxhPEDFGFBydaf6DBfFAT8mvOWU7hWKfHVJvOKjp
 joeeqyOvyDDClCgXoJhU+BerdY028nnabKmFFRPn/ebjBJFf4aTDp3DFylFGXV+abDBb0WZMEq1
 huUrxyoat3wGtJF5wmic5AAdHSbvOhpH0F0NcYwZSIUFz7/w6wNIViiPVDjhgfnwuVeosYsFhJd
 MszKErR/i3Ed3nhgBPKvTp9H/aaXbHXXaxBDPEIwaPw7c6nHWc3bT04HvvpyYgWWiUtPMbWjo7h
 2jcizxdcauw7uig==
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
	TAGGED_FROM(0.00)[bounces-22509-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B48D5674F0E

nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as bare NLA_BINARY
with no minimum length. A CAP_NET_ADMIN caller can send a 16-byte
NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte OOB
read across three consumers (rpc_cmp_addr_port, svc_find_listener,
kernel_bind).

Tighten the policy to NLA_POLICY_MIN_LEN(16) and add per-family
length validation in both nlmsg_for_each_attr_type loops.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 Documentation/netlink/specs/nfsd.yaml |  4 ++++
 fs/nfsd/netlink.c                     |  2 +-
 fs/nfsd/nfsctl.c                      | 30 ++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/netlink/specs/nfsd.yaml b/Documentation/netlink/specs/nfsd.yaml
index 8f36fadd68f7..9677ba19ffcd 100644
--- a/Documentation/netlink/specs/nfsd.yaml
+++ b/Documentation/netlink/specs/nfsd.yaml
@@ -156,6 +156,10 @@ attribute-sets:
       -
         name: addr
         type: binary
+        # 16 == sizeof(struct sockaddr_in); AF_INET6 callers
+        # validate the full sockaddr_in6 length in nfsctl.c.
+        checks:
+          min-len: 16
       -
         name: transport-name
         type: string
diff --git a/fs/nfsd/netlink.c b/fs/nfsd/netlink.c
index fbee3676d253..6570960034f1 100644
--- a/fs/nfsd/netlink.c
+++ b/fs/nfsd/netlink.c
@@ -37,7 +37,7 @@ const struct nla_policy nfsd_fslocations_nl_policy[NFSD_A_FSLOCATIONS_LOCATION +
 };
 
 const struct nla_policy nfsd_sock_nl_policy[NFSD_A_SOCK_TRANSPORT_NAME + 1] = {
-	[NFSD_A_SOCK_ADDR] = { .type = NLA_BINARY, },
+	[NFSD_A_SOCK_ADDR] = NLA_POLICY_MIN_LEN(16),
 	[NFSD_A_SOCK_TRANSPORT_NAME] = { .type = NLA_NUL_STRING, },
 };
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index ab10692ee937..f3b3154b16c5 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2016,6 +2016,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
+		switch (sa->sa_family) {
+		case AF_INET:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in))
+				continue;
+			break;
+		case AF_INET6:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in6))
+				continue;
+			break;
+		default:
+			continue;
+		}
+
 		/* Put back any matching sockets */
 		list_for_each_entry_safe(xprt, tmp, &permsocks, xpt_list) {
 			/* This shouldn't be possible */
@@ -2077,6 +2092,21 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
+		switch (sa->sa_family) {
+		case AF_INET:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in))
+				continue;
+			break;
+		case AF_INET6:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in6))
+				continue;
+			break;
+		default:
+			continue;
+		}
+
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
 			if (delete)

-- 
2.54.0


