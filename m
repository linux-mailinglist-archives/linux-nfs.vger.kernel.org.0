Return-Path: <linux-nfs+bounces-22423-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UsuhIP9VKGqGCQMAu9opvQ
	(envelope-from <linux-nfs+bounces-22423-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:05:51 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8490B6632B1
	for <lists+linux-nfs@lfdr.de>; Tue, 09 Jun 2026 20:05:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=DNqt93nH;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22423-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22423-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 69F9E30A2B58
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jun 2026 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22BC331ED3;
	Tue,  9 Jun 2026 17:48:19 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95895331EB3;
	Tue,  9 Jun 2026 17:48:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781027299; cv=none; b=AnVYKFqDUQBaukWXQbkJ0UgMwHNsTk352n5l/9zwQI/wQs3r5qS6N2Yq52/7KUwVJEFMSa2mfz422JZ3QocS6pSKrNfqXuAqY1G++IEUyjmoBJHCkFolQ7YRl0oE/zo7MrgEpl8JcIfAv0B9tbAH6f6qceOy5VEybmtKZj0R9zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781027299; c=relaxed/simple;
	bh=vg4fY9NMrqXQTacxiPcA7z5kpGDoM2e/qZRwpMvCNoE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lPCTYIm95eyt4qyuTBweFmA04KlgM3NqtKuqi8CczAm/fNrrzTX6PBAgj2VfAHYnUoXIdbCjE/K8LUxj2J0S+eeT/RRtJYRtscXR3i7F/aXHicojlmMv9DAPcHhxMFapGluJ5lqMHXb7RRSJUABX9r0L8onhDioiaKAdNCAISvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNqt93nH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A8B1F00898;
	Tue,  9 Jun 2026 17:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781027298;
	bh=ry/cRm7P9iL5R89y7+BRhtURJNdG3ZaptPbdfKvXO8c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DNqt93nHkU9N59JF41phnPzRjoYYq3Ka6XKuyAnH19SFdcwaYoLcLCYv9LKXiorjT
	 Bt+qLRZjcZyO3thzIwWcYXq8w+HkOGrqrMT6ThICDvmd0tLodmas72GvFrALqoIvms
	 Lw0YVBFzF5hGk3P0pwSr1RuSKvP65c+k4BEJuC/GjbqbLndZVejJC7vAMnZ2DwtnYF
	 WQUeEeDNWsh+a4uKGHqPPTS3KZRsj/Zarf7PH25SsdF04pe5a89062nrGoi6zSbAvV
	 2RdESEV1RrGxX8iQP1G14G5Fd/Z6hQV6FIrYc0QFI39TuO2QbgW7vCl6t9TfHoK072
	 mghA5X9W2bZVA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 09 Jun 2026 13:47:37 -0400
Subject: [PATCH 16/19] nfsd: validate sockaddr length per family in
 listener_set
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-nfsd-testing-v1-16-e83acead2ae8@kernel.org>
References: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
In-Reply-To: <20260609-nfsd-testing-v1-0-e83acead2ae8@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, 
 Benjamin Coddington <bcodding@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, Qi Zheng <qi.zheng@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Muchun Song <muchun.song@linux.dev>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3261; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=vg4fY9NMrqXQTacxiPcA7z5kpGDoM2e/qZRwpMvCNoE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqKFG9FEpsKpWuu3HelMWnFM4EkrSMAUbGUvMK2
 s+KYl49I/iJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaihRvQAKCRAADmhBGVaC
 FQUgEACEtGp0vD3cmEsXfs45VMN2HVjUXUR6bfjkXXBoauhxfnNcYgGPDk0m1HEVxjpPq7jRWzw
 Duai8ZaNWbF2H5y0K+11AfyMrZyX+H4gkVE0yhos+sAuk/UJ4h7jrPMIgQK9L60D6ZsmXRFV1aH
 ISh4expqdjmUzL4tiEOuTQO/gWq49FR7Yv+Zy8QtZ6lr4TSMhSz8K4ysqRI8ih9UWpEFvzHmF90
 15Vfmo5+xg7soYoTt7IfdYV4gOHLvBbK29undxxBTHRX1EXoEo4y8E5g5sUJZ/3amzih4vd8+6V
 Kd0v6ORU7g2o2XK79Odl63u56FjUDMJrfxaA48KbejCReXO6bWjk3jYbqrFAJs5B0tLu+pXJZ+A
 KznXAPWgyvPMo1qJdU0YgUGS4v8IUYlj1DLhs2GsydmNlNAL9qYMj6lTtvhDhrZma7wUzT9Padq
 Q+8yzCk85Dg1zmbjw9n5yqbvC59soIGAzWoCWxYEfag6pVvaNn0Qg6veyZcPmbidWHpile/5ttp
 yw8i8JtdvHlZvinQ1Og0AXnRF6hNTk97ktsDytS3uHqKkYWHMSvWLOxlNCCxJ9LN1opgfP0gIQV
 orHGGMABEPPP7CNT7VOfQuf1V/FyJrKTI3+2aBj5zzdeKjTM6ibMVY/p4TUfavJzQ+/8VYF7kpU
 caL05BbsBerbxLw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:brauner@kernel.org,m:bcodding@redhat.com,m:donald.hunter@gmail.com,m:lorenzo@kernel.org,m:qi.zheng@linux.dev,m:akpm@linux-foundation.org,m:muchun.song@linux.dev,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:jlayton@kernel.org,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_TO(0.00)[kernel.org,oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,gmail.com,linux.dev,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-22423-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8490B6632B1

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


