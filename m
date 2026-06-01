Return-Path: <linux-nfs+bounces-22177-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFrgBJDCHWrPdQkAu9opvQ
	(envelope-from <linux-nfs+bounces-22177-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:34:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A996234C8
	for <lists+linux-nfs@lfdr.de>; Mon, 01 Jun 2026 19:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 27A843027713
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jun 2026 17:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283673DE457;
	Mon,  1 Jun 2026 17:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PL3Ji+2c"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB33E1220;
	Mon,  1 Jun 2026 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780335098; cv=none; b=IFisKgVAbE85cgNmNi0cyj7V8wXzGIVURpHm3fHoT1dfdpt8fTYN05CBlVTb7/b3iUEdxGZRyyx1pBqlWo2Mf4cqiTeaC61tX+f/gdHuDjv5M9Dew525H33t1il0p+V0V5TwGIWca9velBxYf+01RhIXIPOsuU5wcqDT/ArCUCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780335098; c=relaxed/simple;
	bh=JnC/2ourKTNHmtFxJc84B3W+7hBsSIk7VRR8Jv40pdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJVjSjtYmUvHTG/SWpvYoWnVynPDa85BBmTCo4hQqouUdsRyCPqOZyAgcUcuhL1HhcQwB2PZja2kFiQvA7E2xSOb9tzANaLO6OCbW0E2Tqv7Qu6uDm7FKsetCmtd6HuB8kbyUryFbF+RG8xxJQGrXw3HaL+aL84v6MoTJWOQX7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PL3Ji+2c; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D01F0089F;
	Mon,  1 Jun 2026 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780335095;
	bh=uur/XWzh2Vx/jw0lVJDfyL9NUFvYWLGaQ9j78hmG7V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PL3Ji+2cmlVuCJgcRc8lbuSO/cuo+jRdw+cKcKTK2VNEggFVdFUtz5a4v0P6LP01D
	 4v4BrSfABHB/zcoF7lWa+lXlRMsaMl2h2AYxHp1sUwrkX47yjIhur6bzJyJ+j9ebwJ
	 r4wQIUVDQOzsU9yzAG6kkLVSZOxn5iO49Wci/OCTaolFADpK/0TUPxSzLRz4TjYIgy
	 4T+3QZPZqRTRXs1/htAUZTatqE2ZrEwFGpv9v8Oj8/TC6bMF073aDqbzXyvx6v1ZuM
	 b/GPS0gyHLnApyiM5l1uFSJ11caP4svPTe0r1FC/xqsfO2LdLbBLBsAuz5FP+qSSvC
	 Qac37Eg63mrgQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 01 Jun 2026 13:31:08 -0400
Subject: [PATCH 5/8] nfsd: widen nfsd_genl_rqstp address fields to
 sockaddr_storage
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-nfsd-testing-v1-5-d0f61e536df8@kernel.org>
References: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
In-Reply-To: <20260601-nfsd-testing-v1-0-d0f61e536df8@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Anna Schumaker <anna.schumaker@oracle.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Mike Snitzer <snitzer@kernel.org>
Cc: Chris Mason <clm@meta.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2906; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=JnC/2ourKTNHmtFxJc84B3W+7hBsSIk7VRR8Jv40pdw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqHcHtDmYuK3PLc28OyHqlC4tSmKX1mbr7USr8R
 5cMgerWasuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCah3B7QAKCRAADmhBGVaC
 Fe8OEACO9lA4XHsK7txI0+STT7trKALWXTxuWP05EsHpnGcE1CNIsA6K0nRNyFAPshVD4j+QKgV
 4gLaxbr0UGsDOqjDpYzC3RT5LscSK4IW0PsGOZ7zvKGc1UN5ZC2g1jgA/hYp3vqojEZsh8k6IB6
 JClKaPFoAoZeu+tfiKqr7fY5WNLzhVzp3x2AFakqZODDWekRX2Dmz8ngwbciqZg7E2woUub/0UM
 ah0Ai4lTg1M8hC7KW974Bj8AXuXk+M7qUTauo08JHYMbXv65PGwftH3kuLqp2DshubtMtcMv0AZ
 lGjIGTEQD+jUN8wlXGpnTzn4NuRVjc/OLn6j4nEeGygSgHdCW17wFPZ0sjISNSytLQ1/5kEf/Ys
 YPUbR2LexJUNi7psyqipPomZ83NB5vtIwJTwPyKaYAgLS6pvE73HcSxYM/FGxSpvt9av2Ksy4s9
 HlGQ/ejmZaTH0xKV2dk4VYm7aGD3IGR+Z2TB6x44BpnCwXPugYOFdpKs88PtcP2Pyk/iBLWOgy0
 pMV0uE4YShxEtH06TnIwSmj8FvrrvfF4vFspeDD1Myn0MWCZDHGjYjzuH4oRWqrTMW8QNzaLyGI
 vq3TFClZvfy9LP+D0CGPTi6rT5zhyKnu0XHEu8wL9KWeQcndnHEnkWEsffsiUh3t94Yd/2gSOW+
 GTE3eiiuk4s6W2g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22177-lists,linux-nfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 85A996234C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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


