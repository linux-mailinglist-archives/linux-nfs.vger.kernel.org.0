Return-Path: <linux-nfs+bounces-23065-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 88YMKmywS2o9YgEAu9opvQ
	(envelope-from <linux-nfs+bounces-23065-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:41:00 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18566711615
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 15:41:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lmPLvf+y;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23065-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23065-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403E8311D27A
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 13:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ECE41A77C;
	Mon,  6 Jul 2026 13:29:36 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E286D41612A;
	Mon,  6 Jul 2026 13:29:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344575; cv=none; b=m71kLZxtlud0OqJelrJ1elckQA/8MtGKikUj54qsoayWHfddwyoTZ8PL8QipPox6QJQyrJpWr+cg96Y3M02z1yXMiy3+mADSanCVk5p8FyV6WS2nCzoNQyMkP6+umqG25ZSHP7hfloUg/4JfxEKjxxF3VVDZEEDZPx2CoGhfA4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344575; c=relaxed/simple;
	bh=SaO89ZTbP0RWEomBSvJPZOazDpv9h6NbFJRWVvyGKWU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GquYPKyYxl+Slm+mSpqKZfallBPv0yK3h/fbrnvDZqPao1vPtWt7V00eYICwRLvi1z8mVPWYs2pgd/i1xXbE9s1XIbF+RAhSqRIpSqnoouzcWTUV0GOyfqrcT5QEdBX6kcp+iu6Ki636fQEb0t0cc70m6n39wYpKIZJcaROQwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmPLvf+y; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBE981F00A3D;
	Mon,  6 Jul 2026 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783344571;
	bh=gKqFNXUflmab9SYwoLwTqiTtKKgGz8fwrb8BvmgNfVQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lmPLvf+yMNCiOflatmfOEyS1DOEiju+OqttiNsnd+T/DYkdaVU2mhGXd2fdC8jiyR
	 ADxW+I/hlkEA+8mUNt9D1wGg5GHp/LpE6v7e+QgBoZFm3SqWBQKa7fYfN4k0xUnjpU
	 zYPequNs8jTiE4mMUkTg6PSa6suvCHGvFdJQF/i0QNjXPI6TD7/shs97eEsvLsF6Fo
	 2039xwWATRzx8kxTF0Pk/94uMFY/ikEkIZyNfD2sjbYRd3rsPZI8JwpsXYBDmwqZ6a
	 cMaH8xmkIuuBhMIwp2mY5l6VoNviZ3lIYj7d//ThPnkbom1z6hqD1yo6oCwWw9ctEi
	 26ckWFhv9XQJg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 06 Jul 2026 09:29:23 -0400
Subject: [PATCH v5 3/5] sunrpc: guarantee a thread per pool when
 auto-distributing
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-sunrpc-pool-mode-v5-3-6c4ee7cd89aa@kernel.org>
References: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
In-Reply-To: <20260706-sunrpc-pool-mode-v5-0-6c4ee7cd89aa@kernel.org>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 Chuck Lever <cel@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2586; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=SaO89ZTbP0RWEomBSvJPZOazDpv9h6NbFJRWVvyGKWU=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqS623lv6qooAFOnjAc6Ucq1V/az2miA8zeSUx+
 LF4r4EZq+2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCakuttwAKCRAADmhBGVaC
 FfdkD/4hC9gpPOBLvkxwhtNzJ16wyvSFPvCjDBFMQIiY6bc2k/a3Dcg/KWtmOIUHsLK94WN/dZo
 1Dztq8d3K3QYWxo3E+yZ46gP1bqzxnLZVwMFKfc3rF5+QwjGgPb2+iTQLAc6aO5CjnPTtsgpwyI
 z5k5puWaMR1QM5NwS6cnbLUUWq4dUFtg9dg1VupLfmwznBnhPFX1sNDpaCMDPEns/3iZVJSU1jL
 AmKqdC4ynzaaC1PCaU0gcE7OHOJVjkSl1+ynjgYp9t1WSqrOUphuie0OwVuzBYbbn0hWUytTU0/
 2xhZKZBsDAQ6t8cCU8gw5A2m9CZXW89+U4pTShikosvAs/VdHPix8wosHHZSroFzct5DWwt1Ot4
 hWSRt/7ohJ5kl7PgFoZoefFaHhoFTLWIUVjrihERYvsxDzk24ZyIosIkuyTXTo903pvANh0ky4s
 3f44GIISFalzQ6lMTXrsdjZHNuRKnYfygaZjyT/tGGLEjeoz5umakEaEF0NxXSdo7/IdB8lMrnM
 IJA3wUtv+ZzTf3v6AyUTLDOXr1SgZ6hbHvexyJt/gUGw3NwQh4GkYM8vFKmvkuepk8bHFPq7l6y
 pd4k0GagP0yxJkdA9fahiy/65ebYavpiA6sxJHWm2kfOa8IDhhCEzSp8jEvmLD3xh/fG5rJYdOh
 N9QxR/28uj+gfug==
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
	TAGGED_FROM(0.00)[bounces-23065-lists,linux-nfs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:trondmy@kernel.org,m:anna@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:cel@kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jlayton@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18566711615

svc_set_num_threads() spreads the requested thread count evenly across
the service's pools. In pernode mode each pool maps to a NUMA node, and
svc_pool_for_cpu() steers an incoming transport to the pool for the node
it arrived on. When fewer threads than pools are requested, even
distribution leaves some pools empty, and a transport steered to an
empty pool has no thread to service it.

Floor each pool at one thread when auto-distributing a non-zero count,
so no pool is left empty. Every pool maps to a node that had CPUs when
the pool map was built (svc_pool_map_init_pernode() only creates pools
for nodes returned by for_each_node_with_cpus()), so there is no pool
that should be left threadless. The resulting total may exceed the
requested count. This only affects the auto-distribute path (a
single-value array, i.e. svc_set_num_threads()); callers that set
per-pool counts explicitly via svc_set_pool_threads() are unchanged and
may still set a pool to zero.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
---
 net/sunrpc/svc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index b942845f82a3..2d1cdf55c561 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -840,6 +840,12 @@ EXPORT_SYMBOL_GPL(svc_set_pool_threads);
  * are multiple pools then the new threads or victims will be distributed
  * evenly among them.
  *
+ * When @nrservs is non-zero but smaller than the number of pools, even
+ * distribution would leave some pools empty. Since each pool maps to a
+ * NUMA node and only services transports steered to that node, every
+ * pool is instead guaranteed at least one thread. The resulting total
+ * may therefore exceed @nrservs.
+ *
  * Caller must ensure mutual exclusion between this and server startup or
  * shutdown.
  *
@@ -855,6 +861,16 @@ svc_set_num_threads(struct svc_serv *serv, unsigned int min_threads,
 	unsigned int remain = nrservs % serv->sv_nrpools;
 	int i, err = 0;
 
+	/*
+	 * Don't let a pool sit empty while threads are being
+	 * auto-distributed: a transport steered to its node would have
+	 * nothing to service it. Every pool maps to a CPU-bearing node,
+	 * so hand each one a thread. This may push the total above
+	 * @nrservs.
+	 */
+	if (base == 0 && nrservs != 0)
+		remain = serv->sv_nrpools;
+
 	for (i = 0; i < serv->sv_nrpools; ++i) {
 		struct svc_pool *pool = &serv->sv_pools[i];
 		int threads = base;

-- 
2.55.0


