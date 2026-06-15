Return-Path: <linux-nfs+bounces-22560-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ajL/OgspMGr4PAUAu9opvQ
	(envelope-from <linux-nfs+bounces-22560-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:32:11 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2E4688676
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 18:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AY83ZrhT;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22560-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22560-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1585305A26E
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jun 2026 16:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517DC40E8D9;
	Mon, 15 Jun 2026 16:24:35 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9140B36A;
	Mon, 15 Jun 2026 16:24:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540675; cv=none; b=OOpzXiS4+K6C9/l3pbekYLZNnbhnEAG1JaEPkYq+WyQIGrtOR6vzL+kQafaLmllXmYXV3wpj6gY6PsAH9jEZLdxXtsHhMlpR8HydmsEZuBIn8Uyvh/pc8nf7oFIK6HC5EfqSX8jaZ9ArSbDi/uPOrA+e4AT1gtcUeriD61Ua3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540675; c=relaxed/simple;
	bh=7V3ua+B8FjqtNhtQOcx7fT3cBPlRqje+RDk/5A8O7mU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=VyfGr1Ptbt0MLmOM31Wgi22CfWbQl1MSeWRnb3Ybecqja6oT1e97/laspST4dj0Y4MXvO1CDH8wYX7UE1DhBM0tEygIsM3bo/INd0vuVnLXrCJHGw6C5pmhWQZiIpPtloLXYEQNDq3JGITNsUfbyAj0ZUNytKJyQYhuHUQMEi5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AY83ZrhT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F971F000E9;
	Mon, 15 Jun 2026 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781540673;
	bh=x5aOA4Jl8Fn84CJZ/ECvHI+0WIaat7FpZjeb+2TGUzk=;
	h=From:Date:Subject:To:Cc;
	b=AY83ZrhT0QwzBJrmApKCSIZHPZW/tHZDoOKZO4kSkAFSsQwrlLtxz+cVKLeKIpd30
	 ZE1JnqE1uIQy7cM4Yez/uFqYx+CN5sTgvM8sg3MdGgVLnDGdxJiSxKXcBbg6OkiqmD
	 mJRWNcnG+0WnDpng+7f9QeejU/QKN23MxvXYQ/zSnWvo6wQTKcwcgzTrFOVKx6AXd+
	 TDdHwJE4zoKCw4EDiBuiPwppU9K8uXV1Wn3NfuCYi4Vlo9al/RqtbUNMqP8z6f+Poj
	 TvkZhOkqYK8yAhgw5XslORiZBevmXDPexz9m4qRvK0fmsM3O+OcdmNa4AK0ebgLDia
	 tt3kenxvOyVuA==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 15 Jun 2026 12:24:24 -0400
Subject: [PATCH v4] nfsd: validate sockaddr length per family in
 listener_set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-nfsd-testing-v4-1-517fce448c85@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM3wqDIByG4VsJj+fwT5ruaPcxdmD5q2TDhoZsR
 Pc+CwbVDr8PnndCEYKDiC7FhAIkF93g8yhPBWp64zvAzuaNGGGSSKKwb6PFI8TR+Q5LpYxiJee
 NICiTV4DWvdfc7Z537+I4hM9aT3R5fyG9DyWKCQbFTQPGMgPq+oDg4XkeQoeWUmIbTelBs6xFr
 QmwSrbM6j/Nt1ocNMcUg64FFUArEOVOz/P8BY/GwWglAQAA
X-Change-ID: 20260608-nfsd-testing-688a82433c50
To: Chuck Lever <cel@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3673; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=7V3ua+B8FjqtNhtQOcx7fT3cBPlRqje+RDk/5A8O7mU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqMCc736VMMYw/eurre28QwsKS1brKjEi71QSuc
 juvPdoKMyyJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCajAnOwAKCRAADmhBGVaC
 FVKGD/9C8pD/avsHZonXq3nDTpegkbLSxxoKEoiq8WyMGlPQH598vlwk/jUyJmw3r/U0R/5q5xW
 IbFZ73O9Z3fdJtVPbjfVLUjPANAY+8cYRBKy2uUmRfyNAkixMY/qkwup0xLYw8FksIkh2VuMAVQ
 VsV5TyHyBIJZVb2fpApZocVG9Xd1G3RC1vg3aQmfnZ7xglnVhppHl4QfQ3Fd7McVYcFQurMPO6n
 afHjrOgniHBzFAdHUZEj1iP6y6FLpudC4zCClON4pQFbP29kcTdNwGAhClYJ26eiJ6snWWfh4jY
 ciTn7tVgs8O3nv/v+kb/ZFhTtb+BlH2YvoIAbekum/GPlLSLqjGRYc1tY6d9CpNYY1ylbwUWJU4
 6jFDaRjEsGEwi7aN4yjYKQNN1By4/Rz5r17iu5W8JJASSJ/0Hlyp6plNBLbLYi07xa6rP2OkVSp
 z/NxfoMVTpvqMrlqzfRue8k+QXSDkBHAbRuunzvXn+rO7W2LIAIcQlBbZCJtJX3OJqqq6SIGWus
 1FZQaYlt9NdIcyiWUZXKHcHxEte67oWnjBpxMDwh2jh+8atWM/nEuhSXViO3jPu2ujGQ1vt0ssC
 U41nH/oI8lNJMevpogMbgum5zI2JKdkS/8NlcetUb8d3u7S6HaOLm8bjMjub5HmaFCyfZf4xhGT
 pDKXNG30jmzGGew==
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
	TAGGED_FROM(0.00)[bounces-22560-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F2E4688676

nfsd_sock_nl_policy declares NFSD_A_SOCK_ADDR as a bare NLA_BINARY
attribute with no minimum length. A CAP_NET_ADMIN caller can send a
16-byte NFSD_A_SOCK_ADDR with sa_family=AF_INET6, causing a 12-byte
OOB read across three consumers (rpc_cmp_addr_port, svc_find_listener,
kernel_bind).

Validate the attribute length in both nlmsg_for_each_attr_type loops in
nfsd_nl_listener_set_doit(): first ensure it is large enough to read
sa_family, then require the full length for the address family
(sizeof(struct sockaddr_in) for AF_INET, sizeof(struct sockaddr_in6)
for AF_INET6), and reject any other family. This replaces the
open-coded "nla_len < sizeof(struct sockaddr)" check, which was too
short for AF_INET6.

In the listener-creation loop, report the error rather than silently
succeeding. Previously a malformed or unsupported address was skipped,
and if it was the only one supplied the call returned 0. Set -EINVAL
for a too-short address and -EAFNOSUPPORT for an unsupported family
before continuing, so userspace still sees the failure.

Fixes: 16a471177496 ("NFSD: add listener-{set,get} netlink command")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v4:
- Drop policy floor and do full inline validation
- Link to v3: https://lore.kernel.org/r/20260615-nfsd-testing-v3-1-e9b515e17e54@kernel.org
---
 fs/nfsd/nfsctl.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index f1ecbb13f642..069f37a3533e 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -2022,12 +2022,27 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
 			continue;
 
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(sa->sa_family))
+			continue;
+
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
@@ -2083,12 +2098,34 @@ int nfsd_nl_listener_set_doit(struct sk_buff *skb, struct genl_info *info)
 		if (!tb[NFSD_A_SOCK_ADDR] || !tb[NFSD_A_SOCK_TRANSPORT_NAME])
 			continue;
 
-		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(*sa))
-			continue;
-
 		xcl_name = nla_data(tb[NFSD_A_SOCK_TRANSPORT_NAME]);
 		sa = nla_data(tb[NFSD_A_SOCK_ADDR]);
 
+		if (nla_len(tb[NFSD_A_SOCK_ADDR]) < sizeof(sa->sa_family)) {
+			err = -EINVAL;
+			continue;
+		}
+
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


