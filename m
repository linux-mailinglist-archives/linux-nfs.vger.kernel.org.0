Return-Path: <linux-nfs+bounces-20528-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJqaAEqAymnX9QUAu9opvQ
	(envelope-from <linux-nfs+bounces-20528-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:14 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E70035C5F1
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 15:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12F7630A4C07
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Mar 2026 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044233D646A;
	Mon, 30 Mar 2026 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6pg3bjO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CC23D6469
	for <linux-nfs@vger.kernel.org>; Mon, 30 Mar 2026 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774877937; cv=none; b=fmy3jKepdhVQRSLyZ2zMTPlQaPg4DTow7OlwvrKta4ekLu0rYtGhadDtxDfypxnynKnN8BQRn+3FdfmaZn8H4PHWGmyuu+T8Xcb6u4OIgt/UTcREzR4bcb5Y+Fmc6JvgXa3WR61kSojVKABL5WHEIX3jT2ZkP1iO6AtM4PrSC9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774877937; c=relaxed/simple;
	bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTmPjwj+BOmLXE6VxxkoDGTN1BWR1m+dOBq7r7jjZQrJIOtTUU8F4qMLYfp/+QG+P9GjXJYK3e6iP6HthWmtOp5vU6uFw971K1jFO2E5gus6R/UXyfOVi2PcJRjEsXaMy2mf+Z1MJJwlCkSwh34KYVWkFrD99jZ9SXdds6fMoH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6pg3bjO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2793C2BCB1;
	Mon, 30 Mar 2026 13:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774877937;
	bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C6pg3bjO+kLtBnRqBN/MPBCngwYrHzzKXZmX/LbGp/shj9wLaMimqEnPcJ+dmYXFs
	 4znXRmrcInssRGNj9HoNsnxpLSYD2Kz/F/qri3tZgYrdzW/nUAPYYrFc8U3m2x2qS6
	 UJcn3Z+C5Gkgh/mbyYkJdxxKFdDGsNqMCNKmWsBbdVWdZcmLL6w2O3MPKb3cuFraD0
	 /oukqWknjHIXG9Wfsb2B/Q5069/0txGprtsRxpRaFyXxWOJNfTvRvZbPnV/Ycr1jf2
	 6LrYDyiRVHPfmCurbT+o1RL3s1KQYYrlpcuvE0c5UIcvoumQzg22eeGp4kxVw+wS23
	 66ZBBCC5SWdWw==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 30 Mar 2026 09:38:33 -0400
Subject: [PATCH nfs-utils v2 13/16] exportd/mountd: use cache type from
 notifications to target scanning
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-exportd-netlink-v2-13-cc9bd5db2408@kernel.org>
References: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
In-Reply-To: <20260330-exportd-netlink-v2-0-cc9bd5db2408@kernel.org>
To: Steve Dickson <steved@redhat.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4914; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ouy+RW48q5t0OgorK5gFptxTj+t2id9veLWFdSUKy6E=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpynzgT/Znf/BX52gqo52dW1fOxZrt6gEqWYvqW
 xh/esroZGuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacp84AAKCRAADmhBGVaC
 FeGlD/9E+LCjLqueWD5rQqqdBRsqCFvEXl72+owA444er/2zPn4kaE2pp9r/nDCdHi323o9hwkR
 rKdov+qeNGYxaS6sARoDppDvfeUHmDkH+/FWDc7u09RSP6ufFxolZod34Ij6Cl3s8CVus5dMGdg
 UYzpuS8rqVyOvDEqMk8v9R4X7VMWwaB+Y4vUG81MrsLAM9yBjuUeIOuXC7ZFbjijdjsiuKDum8W
 9l+8tLt/P75yixJVKPAlEoAHJ1LwowLLr0Fg5lywlhQtuNlNahhTwV9jdWLnyI0gCt7huupqeAw
 1uQq/PDKQd3XXTIzIo/COcBd7j0whnngWfSX9gezQHIZNsX0O3aBFuo/BLcXKjB1FntHyjEQ2ZA
 uEUT5BSSmAmvmAAqUtL0ndxBn6279OZuYND++CH3zKMCaYlVKesM9ID0HQMGzVj2/Q1TO/CbCF2
 QkHDyJDqareGkS7MT5D6BcNOmcoCB7hpKHeMCy4wMuZ6Fi5TWQxzXbrgnHEKVptiAxDZxx83UfU
 vcz9wRroAXPWEz0e522YdTj0IJ/3gOy24wgLC8oE9e5lfmVGfyTuv5NFl8KKDnTEZLhgtgkeWTs
 +2+ZkAwB7+6JCSEq15XsvBpnBecWln2erMlNedEJBaNxTXLLvRTiNdOuJp+relzNFQxEZ3YbAci
 91PgH843yca12OA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20528-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3E70035C5F1
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


