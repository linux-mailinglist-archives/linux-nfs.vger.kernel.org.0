Return-Path: <linux-nfs+bounces-22563-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jbbzDxdFMGp7QgUAu9opvQ
	(envelope-from <linux-nfs+bounces-22563-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 20:31:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFC36892D9
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 20:31:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=C6t9u+BH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22563-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22563-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98977301E7CD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6AC357CE8;
	Mon, 15 Jun 2026 18:31:34 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833BC31327F;
	Mon, 15 Jun 2026 18:31:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548294; cv=none; b=kuQ/HoytTobp6+AaqEwsnmJRxR+llVzSFeIp0FB+ROGNV8yrlQA3J9VC6MJQVci5tUXRm4W0CsD7h0mVzu14ZFi03wlt8U8wtrvvOpTbn4EW527WGvZfWNy9iJisBxygqou7yvnvnyJE+mgX3OfTXhfsEpjt7DVMPKJDfVMv0cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548294; c=relaxed/simple;
	bh=hv5XSAzn2QuLNwopXSE8XxeYS3Q+0ItVQHV0h4Z40G4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RGhsQ/MwOJ6rljXMuDENnIFs3KR2418L4CpnJnFG1I6F+Ymhpa8JtGsEjrDvbRxGWf0l6Az6ZcfY8WShc3pO5WHDmMAtJ9sz2bmmGty50Ym+ng7ovNDycJm9/9EsfknLw1Wo+oPaAyfik1A3Bh7eRe/9YeR2by5wG4BTKhYv3d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6t9u+BH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 680E21F000E9;
	Mon, 15 Jun 2026 18:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781548293;
	bh=NyDepvujhljvpSGrQj5fnKUOZiYIHTZpk+MwNUQ3A+g=;
	h=From:Date:Subject:To:Cc;
	b=C6t9u+BHONrMzHkIsrKIM6JFzD50A3kvmJW71oDfpGm2g4iHxVO0GMnzQ97k/jQdh
	 WZTXFHUw4liH5/MpFCSeWI3PHl8nozamwid+AMziShHVdDzuue6KUlwbjcqQh2ylYv
	 l+nZBOH7hgAgVdotBTXxuYkwIcqK1IrKj2w5OOAxeCjdunyXsNjG9zdKSb9UBewy60
	 b0F/I+xDoxqQRUCkukFj+X6j4MrtGatQ2K4q44pQDu+5EQW0V/ypjuCnY4ZZebp6sG
	 rqayKGlzNLOfL62bOxeWB8i37tXAIL59oP7bLrxmBENzhZ5mmnXOhHnAlv7AZCAgTU
	 A4HRjOFjj+lkg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jun 2026 14:31:25 -0400
Subject: [PATCH v5] nfsd: validate sockaddr length per family in
 listener_set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-nfsd-testing-v5-1-188d75aedda0@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33MSwrCMBSF4a2UjI3kddvUkfsQBzG5aYOSSlKCI
 t27URB8gMNz4PtvJGMKmMmmuZGEJeQwxTpg1RA7mjggDa5uIphoWcs0jT47OmOeQxxoq7XRQkl
 pgZFKzgl9uDxzu33dY8jzlK7PeuGP9xXqP0OFU0ZRS2PROGFQb4+YIp7WUxrIo1TEm+b8S4uq4
 dAzFF3rhet/tHzX8KUl5RT7A3BA3iGoH63+aVU18M5bVEpbDR96WZY75uIExWMBAAA=
X-Change-ID: 20260608-nfsd-testing-688a82433c50
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5716; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hv5XSAzn2QuLNwopXSE8XxeYS3Q+0ItVQHV0h4Z40G4=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMEUAE/ITMjnriPFDjEQWMjIhrCwqna4wSZaeE
 6JW+f0c7UWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajBFAAAKCRAADmhBGVaC
 FUNyEADTNRgYJeO61BA8zXbTf5i6t0Zahb4Lc7q26CI2Uh6zIDTRJXQvcOD+GdnZT3yySAgWj7c
 vRx70+ZCJvR+LacbR+FuD7OQJqMi7EWNj6l5us8I0Vnfym0aYeExVeyCbF2N0tvrb5510sS44wz
 Nz3YyKmc7PipfKkztnnq/xFo1+gjw7a/fcHYHudwStRk9DbgoYo20pH2i5onCofzTC85YoxbVQI
 DPN/1GB5j6VInV9TLsPhzZI2e6F7beURwo3SJaF3Up13Y6NvkvJLt2G9494avCNqmryupTWIyfe
 oVUx0KZ9axgujQY1hSbQTbSYPxJwSsGj4AA/v8HyXO7l9ei6+4yg1bBQajVHGgaVywum3AlKuYa
 x8yO5nnZiXan3Br13P27GfPSVUlRfhBlCGLno9FkAApcUIIK/pI7ww83BhEtse8ZGhTp2NkJk5g
 vBI0WAMSB8GJQt8UGfp3bmGEV/aKxODv5yOs1k05OTRrzV6aa00i5yOAr2q2Y4gADBE3Blv6i0N
 i3sH6aGeBaXOmBJ/f1Y4LlQR1QKsLAzK7TVkGQXyLGal86mI8MH2kzvTdzZ91ZyEisixRXhaAWm
 O0PmpUMXAjxMT40J4WHfSAVVYHr7QpavyXlklcG/BFfjQu3P959z6ulomArjyv7WQ/Wx6Iqar8C
 eTKTOMgoNZ4Y8Vg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22563-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ADFC36892D9

nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as a bare NLA_BINARY
attribute with no minimum length. A CAP_NET_ADMIN caller can send a
16-byte NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte
OOB read across three consumers (rpc_cmp_addr_port, svc_find_listener,
kernel_bind).

nfsd_nl_listener_set_doit() also parsed and validated each listener
entry inline in two separate loops, interleaved with mutating the
running listener configuration. The validation was duplicated, used an
open-coded "nla_len < sizeof(struct sockaddr)" check that was too short
for AF_INET6, and handled a malformed entry inconsistently depending on
which loop noticed it.

Add an nfsd_nl_validate_listeners() helper that walks the entire list
once and confirms each entry parses, carries both an address and a
transport name, and is long enough for its address family
(sizeof(struct sockaddr_in) for AF_INET, sizeof(struct sockaddr_in6)
for AF_INET6, -EAFNOSUPPORT otherwise). Call it before taking
nfsd_mutex or creating the serv, so a malformed request fails cleanly
with no side effects.

Since every entry is known valid by the time the two existing loops
run, drop the redundant presence and per-family length checks from
both, leaving only the nla_parse_nested() call needed to extract the
data.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v5:
- Vet the entire listener list before making any changes
- Link to v4: https://lore.kernel.org/r/20260615-nfsd-testing-v4-1-517fce448c85@kernel.org

Changes in v4:
- Drop policy floor and do full inline validation
- Link to v3: https://lore.kernel.org/r/20260615-nfsd-testing-v3-1-e9b515e17e54@kernel.org
---
 fs/nfsd/nfsctl.c | 77 +++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f1ecbb13f642..b34adebec43a 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1971,6 +1971,60 @@ int nfsd_nl_version_get_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
+/**
+ * nfsd_nl_validate_listeners - sanity-check the listener list from userland
+ * @info: netlink metadata and command arguments
+ *
+ * Walk every NFSD_A_SERVER_SOCK_ADDR attribute and confirm that each entry
+ * is well-formed: it parses against the policy, carries both an address and
+ * a transport name, and the address is long enough for its family. Doing
+ * this up front lets the callers below assume every entry is valid and
+ * guarantees we make no changes when the request is malformed.
+ *
+ * Return 0 if every entry is valid, or a negative errno otherwise.
+ */
+static int nfsd_nl_validate_listeners(struct genl_info *info)
+{
+	const struct nlattr *attr;
+	int rem;
+
+	nlmsg_for_each_attr_type(attr, NFSD_A_SERVER_SOCK_ADDR, info->nlhdr,
+				 GENL_HDRLEN, rem) {
+		struct nlattr *tb[NFSD_A_SOCK_MAX + 1];
+		struct sockaddr *sa;
+		int err;
+
+		err = nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
+				       nfsd_sock_nl_policy, info->extack);
+		if (err < 0)
+			return err;
+
+		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
+			return -EINVAL;
+
+		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(sa->sa_family))
+			return -EINVAL;
+
+		switch (sa->sa_family) {
+		case AF_INET:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in))
+				return -EINVAL;
+			break;
+		case AF_INET6:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in6))
+				return -EINVAL;
+			break;
+		default:
+			return -EAFNOSUPPORT;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * nfsd_nl_listener_set_doit - set the nfs running sockets
  * @skb: reply buffer
@@ -1989,6 +2043,15 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 	bool delete = false;
 	int err, rem;
 
+	/*
+	 * Validate the entire listener list before making any changes, so a
+	 * malformed request fails cleanly without creating a serv or touching
+	 * the existing listeners.
+	 */
+	err = nfsd_nl_validate_listeners(info);
+	if (err)
+		return err;
+
 	mutex_lock(&nfsd_mutex);
 
 	err = nfsd_create_serv(net);
@@ -2015,16 +2078,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		const char *xcl_name;
 		struct sockaddr *sa;
 
+		/* validated up front in nfsd_nl_validate_listeners() */
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
 
-		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
-			continue;
-
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
@@ -2076,16 +2134,11 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		struct sockaddr *sa;
 		int ret;
 
+		/* validated up front in nfsd_nl_validate_listeners() */
 		if (nla_parse_nested(tb, NFSD_A_SOCK_MAX, attr,
 				     nfsd_sock_nl_policy, info->extack) < 0)
 			continue;
 
-		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
-			continue;
-
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 

---
base-commit: 332e2f4f37b213f231be1ab5ddc17e2052383b60
change-id: 20260608-nfsd-testing-688a82433c50

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


