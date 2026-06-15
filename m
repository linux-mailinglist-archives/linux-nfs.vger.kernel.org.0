Return-Path: <linux-nfs+bounces-22558-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id J+/aKW7lL2q1IgUAu9opvQ
	(envelope-from <linux-nfs+bounces-22558-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 13:43:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D73F685C8B
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 13:43:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dP+Istka;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22558-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22558-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B9EA30182A4
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 11:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5179D3D9674;
	Mon, 15 Jun 2026 11:43:40 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E0A2F8EB0;
	Mon, 15 Jun 2026 11:43:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523820; cv=none; b=oSXLWZTAzBXGBFZixkkL8FDKN8kd2TOHiMt0IroQKmIflXYdd6GJcsYJxrIfhEKF4CJXAJaS9xQs3TiDY50feBLhv+5O2Gn6dbJkykKXLiO+OTRMCtlcO0Y413lv9EVG9QlGv9kQ0nkGc+EPDkQH2DuU26jThNdRX6HNXXAiQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523820; c=relaxed/simple;
	bh=vyCk7pS91Uax59VX1WZSazMfWYCJy5hK4qy/aePdk+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQR4OeJPkFW7qK1TTOwzSipKSqwKhRIZf21wY6NnwI3E9iaWWiOrr7iH18aLaEn8k4zbqpE2MNQoed1b0KgJn7ir658fLv5ygc1Y5lW6Fg0M8+zAhlxbpe/gmkLwacwoymqHIQbfY796I0WUBMV1MkzEAJEEKBrxiCOoyupEFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dP+Istka; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D381F00A3A;
	Mon, 15 Jun 2026 11:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781523818;
	bh=TBMPQ5a6D7EiHdxr1pquu+Llv8zJ3cXLm5ExSBxUWBI=;
	h=From:Date:Subject:To:Cc;
	b=dP+Istka/JVbGpwchPh7d0Q4qyb8RMIRdxEobRL+xA5uezt/8oEbrkYBfA39oC79O
	 I6f1vP2GtaKIE1LN4dKcaMb7rjJPIa4BomL0ByJ0yKHjc3EBuJa0uiUUIlkuYGLMvO
	 5E+uKa36OdxJD9iXi2e2pWMc8J9cE7nQrXrFGi5CpasI/1UoGGsAxExpbr+KlEPI3M
	 Gz9YMcWEGVWWuMb4dUAXFJ1tCzHDQXzncafsIcJmHqHnxW/GuqJ+AKajPhr3veULQO
	 rG6X104KEoSSI/3eDau31k9ulbGSuwx8ZzUMGokhDESxz7U11yLR0UDDBqgBGmcMWD
	 s4mVbXMZ2NaRg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jun 2026 07:43:34 -0400
Subject: [PATCH v3] nfsd: validate sockaddr length per family in
 listener_set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-nfsd-testing-v3-1-e9b515e17e54@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13M0QrCIBTG8VcZ5zpDj81cV71HdGHzbJNCQ4cUY
 ++eGwSty++D/2+CRNFRglM1QaTskgu+DLmroB2M74k5WzYgR8UV18x3ybKR0uh8z5TWRuNByrb
 mUJJnpM69Vu5yLXtwaQzxvepZLO8XarZQFowz0tK0ZCwa0uc7RU+PfYg9LFLGn1qIvxpLXd8aT
 nhUHdpmU8/z/AFAH7155wAAAA==
X-Change-ID: 20260608-nfsd-testing-688a82433c50
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4580; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vyCk7pS91Uax59VX1WZSazMfWYCJy5hK4qy/aePdk+8=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqL+VpaRdYMv/X8SQqCiIA5/UdUdQXAjOXMZUfK
 AAxFYIW9umJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCai/laQAKCRAADmhBGVaC
 FZWLEAC6vqmJbfqSVCb0CQvle9+2wMms+gazmKdvTyyArgevkohnH7VYzA0vpUYUgGL0gO1qzbe
 DpnuQwJGHcXo2f6ce/QYQUEphE8H63c9ffijj64694vV1km1xomg0PwNaUhalDOPg4zCu/ghUJN
 7t10uPcOQ+zB+5O7E1Jf1mof7VC4dFq6//eKjOBYIv8nrzjTszIUKjj02cleAMfT32TGWn7Dj2P
 iCirC9MRvFmkFa3PzQhm9dR72H3Ix4UGSJupGQ62c7GhpUjuR/KhD7lnJJtS+W/QYN6C3pSGrRz
 qKHPxMYgQdcGL5ttgktznXVzxtOYNjAw+rPVw/cwxibYBoHShe5pClKU1zHZqgljnevulwhls+X
 1LbAC786MVeuCdN2Za2deXXKO2a9An6tzwiewptvhwSJSvEi1+/oRiax2k23I5Jk6ayk0OP1E4G
 Gw/LuK/tjQlkyPBLcKua0E25MVvtZYIl/QuF7bSneKxNJioDQ0TQn6eRvObif/HwnjOWZYsCt8d
 QByAl1unKxAJmR7H/E4JuL78YC132Nkb1zHw/FuxJ3Fke9NQQbK1EkRl2LVSqyEja5nhDw3nrUb
 JKEIOGXWB+6je5SOf65Ti+d46fgC3gpl4afYJeUp06lzLWt3raDSi5pGOyrGcNyCIJfDSENL1Q1
 +GjD4XvllFDKrMQ==
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
	TAGGED_FROM(0.00)[bounces-22558-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D73F685C8B

nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as bare NLA_BINARY
with no minimum length. A CAP_NET_ADMIN caller can send a 16-byte
NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte OOB
read across three consumers (rpc_cmp_addr_port, svc_find_listener,
kernel_bind).

Tighten the policy to NLA_POLICY_MIN_LEN(16) so that nla_parse_nested()
rejects anything shorter than a struct sockaddr, and add per-family
length validation in both nlmsg_for_each_attr_type loops to cover the
larger struct sockaddr_in6. The new policy floor subsumes the open-coded
"nla_len < sizeof(struct sockaddr)" check, so drop it from both loops.

In the listener-creation loop, report the error rather than silently
succeeding. Previously an unsupported family reached
svc_xprt_create_from_sa(), which returned -EAFNOSUPPORT to userspace;
simply skipping the malformed attribute would instead return 0. Set
-EAFNOSUPPORT for unsupported families and -EINVAL for a too-short
address before continuing, so userspace still sees the failure.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
This version fixes the error handling so that an invalid address passed
from userland will properly cause a -EINVAL return.
---
 Documentation/netlink/specs/nfsd.yaml |  4 ++++
 fs/nfsd/netlink.c                     |  2 +-
 fs/nfsd/nfsctl.c                      | 41 ++++++++++++++++++++++++++++++-----
 3 files changed, 40 insertions(+), 7 deletions(-)

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
index f1ecbb13f642..64e9cdd17628 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2022,12 +2022,24 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
 			continue;
 
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
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
@@ -2083,12 +2095,29 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
 			continue;
 
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
+		switch (sa->sa_family) {
+		case AF_INET:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in)) {
+				err = -EINVAL;
+				continue;
+			}
+			break;
+		case AF_INET6:
+			if (nla_len(tb[NFSD_A_SOCK_ADDR]) <
+			    sizeof(struct sockaddr_in6)) {
+				err = -EINVAL;
+				continue;
+			}
+			break;
+		default:
+			err = -EAFNOSUPPORT;
+			continue;
+		}
+
 		xprt = svc_find_listener(serv, xcl_name, net, sa);
 		if (xprt) {
 			if (delete)

---
base-commit: 332e2f4f37b213f231be1ab5ddc17e2052383b60
change-id: 20260608-nfsd-testing-688a82433c50

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


