Return-Path: <linux-nfs+bounces-22212-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BTthKEQEH2prdQAAu9opvQ
	(envelope-from <linux-nfs+bounces-22212-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:26:44 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 547056302EF
	for <lists+linux-nfs@lfdr.de>; Tue, 02 Jun 2026 18:26:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fiHMbtkA;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22212-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22212-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 643CA309331A
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jun 2026 16:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD86436C9E4;
	Tue,  2 Jun 2026 16:23:38 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28916368D68;
	Tue,  2 Jun 2026 16:23:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417418; cv=none; b=iJXx1lu5nkSwgurizD5lWBK/856Y+1XFV97D4kVq1s21NVVH2vS5SEUTRAR0G8Bxcz7rZ4gElBPX9Y3i0JULMs/uas/5Iw5hGYeZae40e6bwNmXE3XkWJ9tG7JuBFxzLbGxDMf6x43V7+Hn8TCInRp/egvb33nCXhYHYydkvKEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417418; c=relaxed/simple;
	bh=JnC/2ourKTNHmtFxJc84B3W+7hBsSIk7VRR8Jv40pdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D9UzU0EhMSUzRTchjo0FapipSb/1LHnCKRWzVE3m1byFNGirBmy5h7n6nmek9Nni9RCNRFxeai1thcSTuMBdk1zlEaQYH1KbROYex/BCeerDhg+HY0Dgh5Rlp6+q4/Gw2PPSDJq1GLHTNEqDobh7NltzN5n+ZkEl/Z5aYXnDMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiHMbtkA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639911F00899;
	Tue,  2 Jun 2026 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780417415;
	bh=uur/XWzh2Vx/jw0lVJDfyL9NUFvYWLGaQ9j78hmG7V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fiHMbtkAna/B0G7SV9/ZISiNnyuV3hE7ZDu+CdnJ+mRn5o2ghk6+CLalDIF9OSxf6
	 SZcK/0BsAdProamayUCi+1SQNU2G5crRO/3rhZFWPgmCmEHGlzUxWqpsDVXzfJ38+n
	 LnMQUHneZM3oeQSLCc8CAkxHsHp1aG0lMWAlcfXYMu1UF6edCtsM3HyvCd8LVUspAw
	 TdyBN/LbrGVGyE6wVlya8oMA9KopLHLabyUqs9go0JraKOJDQmaG8qbPjorE5QSbmd
	 aVfjsd0X6zZ5cPBvTpV4rA4mEaN28NnlL8FnMofwXcWZP2Hta0PTCO01+3aCKKazlT
	 eYam4Wt4jOOIA==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 02 Jun 2026 12:23:17 -0400
Subject: [PATCH v2 5/9] nfsd: widen nfsd_genl_rqstp address fields to
 sockaddr_storage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-nfsd-testing-v2-5-e4ea62e3cd5c@kernel.org>
References: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
In-Reply-To: <20260602-nfsd-testing-v2-0-e4ea62e3cd5c@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@meta.com>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JnC/2ourKTNHmtFxJc84B3W+7hBsSIk7VRR8Jv40pdw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHwN8P5WCvyacmiPr2qKwynKs91UiKOlNuPuAu
 uGmqeXoElWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah8DfAAKCRAADmhBGVaC
 FaKiD/sFOExLv8pQqzSE5crQTwY+JB5qVnvXSvR56vjNl0itIHvDYNexNw6i7//FkzhMjJRJCX6
 /aHW0VQugrY4dgtxe7SAZBNkTk73Qpz9ZSQTBu3gOCDXNxtbByyG0sdbn2L8Js64sQF1QsJr8b5
 nAj21uzuKp+fzHyE4kpmAvFqxmHHoUZQXoSwJeasMSjr/ISCuM+iMsCemNm4JFLNde6kdtPNhY1
 f8Uu3kjJKewEYOx/ZLDfKZGC8bwTICOmSFfK2xFX4AlaCjk4wKOmTIWly6gt5Qgn0yktOBKTCDz
 hDjofPv+YpypqOS/kKfSVOaBM9zwSIEttQhoJxT1V+uZfPrYRY38WiYJy89JR+/OXaDiLvksttA
 m89YknBXqxX5WYw9UkxbwZHbI4Xk+Mg8zkbKuLzy1aYFgm7N6kVW/5eeDVBBgpWLK7UmB6hm8MG
 oAkJhcqo0Z+tYFfJoYBLQtsznlUooAjuVNhPQ6cfrxXnx/BE3eNZL6jkMVq53LqJd2/P6KWsyrs
 o3hHV76KBBg17fdbERQBmZB7gfrw7G1S1DseCUes5B2lRt13IlWB+TdpmoY71oTpKjxCe5if/II
 m8EEOGhgBuEH4Mf5PmieR714wtNSHJyVnCDifaN+KFXqAfBD3MDxuLgHRyQC0m6Qr6zrmbgI/Js
 pslTGFGhRXWtiYA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:lorenzo@kernel.org,m:anna.schumaker@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:snitzer@kernel.org,m:viro@zeniv.linux.org.uk,m:clm@meta.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:trond.myklebust@hammerspace.com,m:jlayton@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-22212-lists,linux-nfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 547056302EF

struct nfsd_genl_rqstp declares rq_daddr and rq_saddr as plain
"struct sockaddr" (16 bytes). When an IPv6 NFS client is connected,
nfsd_genl_rpc_status_compose_msg() casts these fields to
"struct sockaddr_in6 *" (28 bytes) and reads sin6_addr at offset 8..24,
which extends 8 bytes past the end of the 16-byte sockaddr field into
the adjacent rq_flags member. The 16-byte nla_put_in6_addr then ships 8
bytes of truncated IPv6 address followed by 8 bytes of rq_flags to
userspace via the NFSD_A_RPC_STATUS_SADDR6/DADDR6 netlink attributes.

This is reachable by any unprivileged process in the network namespace
because NFSD_CMD_RPC_STATUS_GET uses GENL_CMD_CAP_DUMP without
GENL_ADMIN_PERM.

Fix by widening rq_daddr and rq_saddr to struct sockaddr_storage so the
IPv6 casts operate within bounds, copying sizeof(struct sockaddr_storage)
bytes in the memcpy calls so the full address is captured, and
zero-initializing the genl_rqstp stack variable to prevent leaking
uninitialized tail bytes through netlink.

Fixes: bd9d6a3efa97 ("NFSD: add rpc_status netlink support")
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfsctl.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 92f65ca6f667..6fee49a7787f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1414,8 +1414,8 @@ static int create_proc_exports_entry(void)
 unsigned int nfsd_net_id;
 
 struct nfsd_genl_rqstp {
-	struct sockaddr		rq_daddr;
-	struct sockaddr		rq_saddr;
+	struct sockaddr_storage	rq_daddr;
+	struct sockaddr_storage	rq_saddr;
 	unsigned long		rq_flags;
 	ktime_t			rq_stime;
 	__be32			rq_xid;
@@ -1450,7 +1450,7 @@ static int nfsd_genl_rpc_status_compose_msg(struct sk_buff *skb,
 			NFSD_A_RPC_STATUS_PAD))
 		return -ENOBUFS;
 
-	switch (genl_rqstp->rq_saddr.sa_family) {
+	switch (genl_rqstp->rq_saddr.ss_family) {
 	case AF_INET: {
 		const struct sockaddr_in *s_in, *d_in;
 
@@ -1527,7 +1527,7 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 		list_for_each_entry_rcu(rqstp,
 				&nn->nfsd_serv->sv_pools[i].sp_all_threads,
 				rq_all) {
-			struct nfsd_genl_rqstp genl_rqstp;
+			struct nfsd_genl_rqstp genl_rqstp = {};
 			unsigned int status_counter;
 
 			if (rqstp_index++ < cb->args[1]) /* already consumed */
@@ -1551,9 +1551,9 @@ int nfsd_nl_rpc_status_get_dumpit(struct sk_buff *skb,
 			genl_rqstp.rq_stime = rqstp->rq_stime;
 			genl_rqstp.rq_opcnt = 0;
 			memcpy(&genl_rqstp.rq_daddr, svc_daddr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_storage));
 			memcpy(&genl_rqstp.rq_saddr, svc_addr(rqstp),
-			       sizeof(struct sockaddr));
+			       sizeof(struct sockaddr_storage));
 
 #ifdef CONFIG_NFSD_V4
 			if (rqstp->rq_vers == NFS4_VERSION &&

-- 
2.54.0


