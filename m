Return-Path: <linux-nfs+bounces-20212-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOX/GvcguGmdZQEAu9opvQ
	(envelope-from <linux-nfs+bounces-20212-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:43 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A78F429C458
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4EC630BD2AD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5233A2576;
	Mon, 16 Mar 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi2AlDrd"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B644C3A6B8A
	for <linux-nfs@vger.kernel.org>; Mon, 16 Mar 2026 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674227; cv=none; b=di244ReXS1/hgkjXaET9L+DFbPro8q4bBjCMNZ1ttnh/1fqFAt5QRkckmtLKOTgs5DyNWUPQFgg41FUaeYL2kINk2Myfua1pAiI8eqxclbnlboT4Ef6JT3SnNC04Cs2hFi1+IqSi9BP3BJwSfguu7fvvnuYFXa/A3dwvPDTlNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674227; c=relaxed/simple;
	bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VQKhiljeV1Yf3i4eQYhfU5cExsO5wJ+HISZuAerdLen8FQGxMk3suIYtRqmk8dWaNB4gwatlXbfmJfFIyCe5ivkTkbBP0CqVstQiMTlMi3TcPbm8+NbXNYWFTCmO1AS45FsMkIvdDauJJfAH9+osAf8ycOpf1dy3/2MxX9SzJ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi2AlDrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0551C2BC9E;
	Mon, 16 Mar 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674227;
	bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hi2AlDrdlAhlBLgsYdpekHyWwJWSt/K97pHg32RH2NLxY3TfruOA4ZaDpWLVBBFVU
	 HAevauDvJBLZSUOUacWRQ3m7wOzi7lq2g7Im8MwQk/nGZp6YwZUCGNLY42aoDEJBYI
	 XH/dzBHJ1VhA48a4961Z1pqCatJrzoLrtZ4eQjar50nw/tzMpSG9GHvshcL7K6ny07
	 nLupUw/8gdXYqD3cJ5NDLV+pahWrDaW35nnx9OHtihDZFfozGk3iaVCYjClIvGAYt/
	 c6OdaZl4L4fZSD6AIdBVx4GZFySrB2mnV4M+YfmMZqqtyPiA7mPFFQQVyKSaVIQlPd
	 ESj9xuBMnE3cw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:16:51 -0400
Subject: [PATCH nfs-utils 13/17] exportd/mountd: use cache type from
 notifications to target scanning
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-13-9a408a0b389d@kernel.org>
References: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-9a408a0b389d@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB7imdpTNS8q7e+WT6Iux2fEtBHhRKBoevvdb
 Nd+dMe+HhaJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabge4gAKCRAADmhBGVaC
 FRLcD/9sOQYbiyQEpvsHgxpBcqkPBxGPoesWBbRTsdUEVPaEWha88svQQnJusPM+PNw/YEGH6N7
 Yw5cvXUI8o9mIzuwOH1UZFk6X/MBfgmuqHfiyOj9WvVnJ6z2FG7NuoszW09JaR8P6D3yGNYiYXJ
 Mn9iYSEorni0TujqjV0SPhuI93hyTgmTJwfYsMZsltLcMZo2y305X7AGjqDqTHSFGQ2a9ljKUSF
 eFVp8WSkdqKd4BNa5x1RE+4QLcXqCXjCpazt5Ra/D4HbPynwkCDS2peS8J6eoo8Ex9IUXFcLeMW
 15DoPp5rPhaxGb4gN5bDRs8de2jnUpbB9Q10y687CE/d+K2ukRMukoGWacrfq7rKyYsbiB7zslx
 tuRfU0ag/PGtQ3Yt4CgqYSsHM+WXGKPPfD4zOJZT0YD6Dm/Falr88HnSR2Q2Mmy3TZQ5wIcg/wr
 gPQnutDUHEppWIcbmJolyJvi4aR6ao34FoyvdnSLwv6cykWLKKSxAO+nJ7m5IzVYlBAwwljPZbf
 NU1pbu2g2fWNnxF21SzlrluGBcp8ZwkznTDbagiwPFgy0xwbMUOBHrQYiwSGMJ0TnGtad/C4f3y
 yrIVBSxHzKfSoOkGxwn5Q5a6BbhNFKzyKs4PhYsglmcXYzctRg3/nIja7tlkL3BU7u4TGF64V2d
 ugwNYn3pLYXdRfg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20212-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A78F429C458
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Parse the NFSD_A_CACHE_NOTIFY_CACHE_TYPE and
SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE attributes from netlink multicast
notifications to determine which specific caches have pending
requests. Only issue GET_REQS for the caches that actually need
servicing, avoiding unnecessary netlink round-trips.

If the notification can't be parsed, fall back to scanning all caches
for that family.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 support/export/cache.c | 81 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/support/export/cache.c b/support/export/cache.c
index 4261e1861215ea53183dd8ce14890b0195d841e8..5a2c5760cb5410845971ba831a9ae779d17a6d87 100644
--- a/support/export/cache.c
+++ b/support/export/cache.c
@@ -1180,22 +1180,45 @@ static int cache_nfsd_nl_open(void)
 			       &nfsd_nl_family);
 }
 
-static int nfsd_nl_notify_handler(struct nl_msg *UNUSED(msg), void *UNUSED(arg))
+static int nl_seq_check_handler(struct nl_msg *UNUSED(msg), void *UNUSED(arg))
 {
 	return NL_OK;
 }
 
-static void cache_nfsd_nl_drain(void)
+static int nfsd_notify_handler(struct nl_msg *msg, void *arg)
 {
+	unsigned int *cache_mask = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[NFSD_A_CACHE_NOTIFY_MAX + 1];
+
+	if (nla_parse(tb, NFSD_A_CACHE_NOTIFY_MAX,
+		      genlmsg_attrdata(gnlh, 0),
+		      genlmsg_attrlen(gnlh, 0), NULL) == 0 &&
+	    tb[NFSD_A_CACHE_NOTIFY_CACHE_TYPE])
+		*cache_mask |= nla_get_u32(tb[NFSD_A_CACHE_NOTIFY_CACHE_TYPE]);
+	else
+		*cache_mask = ~0U;
+
+	xlog(D_NETLINK, "nfsd_notify_handler: cache_mask=%x", *cache_mask);
+	return NL_OK;
+}
+
+static unsigned int cache_nfsd_nl_drain(void)
+{
+	unsigned int cache_mask = 0;
 	struct nl_cb *cb;
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	if (!cb)
-		return;
+		return ~0U;
 
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, nfsd_nl_notify_handler, NULL);
+	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM,
+		  nl_seq_check_handler, NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, nfsd_notify_handler,
+		  &cache_mask);
 	nl_recvmsgs(nfsd_nl_notify_sock, cb);
 	nl_cb_put(cb);
+	return cache_mask;
 }
 
 struct get_export_reqs_data {
@@ -1552,8 +1575,6 @@ static void cache_nl_process_export(void)
 	if (!msg)
 		goto out_free;
 
-	auth_reload();
-
 	for (i = 0; i < nreqs; i++) {
 		char *dom = reqs[i].client;
 		char *path = reqs[i].path;
@@ -1912,16 +1933,20 @@ out_free:
 
 static void cache_nfsd_nl_process(void)
 {
+	unsigned int cache_mask;
+
 	/* Drain pending nfsd notifications */
-	cache_nfsd_nl_drain();
+	cache_mask = cache_nfsd_nl_drain();
 
 	auth_reload();
 
 	/* Handle any pending svc_export requests */
-	cache_nl_process_export();
+	if (cache_mask & NFSD_CACHE_TYPE_SVC_EXPORT)
+		cache_nl_process_export();
 
 	/* Handle any pending expkey requests */
-	cache_nl_process_expkey();
+	if (cache_mask & NFSD_CACHE_TYPE_EXPKEY)
+		cache_nl_process_expkey();
 }
 
 /*
@@ -1942,17 +1967,40 @@ static int cache_sunrpc_nl_open(void)
 			       &sunrpc_nl_family);
 }
 
-static void cache_sunrpc_nl_drain(void)
+static int sunrpc_notify_handler(struct nl_msg *msg, void *arg)
 {
+	unsigned int *cache_mask = arg;
+	struct genlmsghdr *gnlh = nlmsg_data(nlmsg_hdr(msg));
+	struct nlattr *tb[SUNRPC_A_CACHE_NOTIFY_MAX + 1];
+
+	if (nla_parse(tb, SUNRPC_A_CACHE_NOTIFY_MAX,
+		      genlmsg_attrdata(gnlh, 0),
+		      genlmsg_attrlen(gnlh, 0), NULL) == 0 &&
+	    tb[SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE])
+		*cache_mask |= nla_get_u32(tb[SUNRPC_A_CACHE_NOTIFY_CACHE_TYPE]);
+	else
+		*cache_mask = ~0U;
+
+	xlog(D_NETLINK, "sunrpc_notify_handler: cache_mask=%x", *cache_mask);
+	return NL_OK;
+}
+
+static unsigned int cache_sunrpc_nl_drain(void)
+{
+	unsigned int cache_mask = 0;
 	struct nl_cb *cb;
 
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
 	if (!cb)
-		return;
+		return ~0U;
 
-	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, nfsd_nl_notify_handler, NULL);
+	nl_cb_set(cb, NL_CB_SEQ_CHECK, NL_CB_CUSTOM,
+		  nl_seq_check_handler, NULL);
+	nl_cb_set(cb, NL_CB_VALID, NL_CB_CUSTOM, sunrpc_notify_handler,
+		  &cache_mask);
 	nl_recvmsgs(sunrpc_nl_notify_sock, cb);
 	nl_cb_put(cb);
+	return cache_mask;
 }
 
 /*
@@ -2436,16 +2484,19 @@ out_free:
 
 static void cache_sunrpc_nl_process(void)
 {
+	unsigned int cache_mask;
+
 	/* Drain pending sunrpc notifications */
-	cache_sunrpc_nl_drain();
+	cache_mask = cache_sunrpc_nl_drain();
 
 	auth_reload();
 
 	/* Handle any pending ip_map requests */
-	cache_nl_process_ip_map();
+	if (cache_mask & SUNRPC_CACHE_TYPE_IP_MAP)
+		cache_nl_process_ip_map();
 
 	/* Handle any pending unix_gid requests */
-	if (manage_gids)
+	if (manage_gids && (cache_mask & SUNRPC_CACHE_TYPE_UNIX_GID))
 		cache_nl_process_unix_gid();
 }
 

-- 
2.53.0


