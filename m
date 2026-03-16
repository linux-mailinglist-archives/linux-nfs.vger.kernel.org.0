Return-Path: <linux-nfs+bounces-20188-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qB8zI1YfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20188-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:18:46 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5329C24C
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B04C30584CD
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652633A0B2F;
	Mon, 16 Mar 2026 15:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJf7bwd1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969939FCAF;
	Mon, 16 Mar 2026 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674116; cv=none; b=BI9eE3hd/u0i3gI8PfIgVI4JLXrRA54POiAGHs4V5ocONWudgCINvWT70Y4fNtATsSRVt8hYtraPXFHhOy/OlJmY3sOeclXd39pvjdmSoq/EMkLp1rTzsw6gu07HNK2pT2p2HU5kzFGtbq7jETfqQXhWMUXpDiZS2qR/tniigVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674116; c=relaxed/simple;
	bh=oeDUirb5QsxFfctXdbfNXappHx0QW4l5k81kduxUPCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jm15vxAn4FXL5jb946AOE/MwupQnvufZ1Q/EioAyKFjfz0qvgefOYwcw23+/+akh2lp79Ug0w/T61l0sjp8biVUBjmqaANOWL2Rbn5Wxe0not1kWBSBjhZzs1/U0terklWegB0qnqgXp4wLY1HFm5n1IN/zVOlFeSXPsOGjKD3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJf7bwd1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019A3C19421;
	Mon, 16 Mar 2026 15:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674115;
	bh=oeDUirb5QsxFfctXdbfNXappHx0QW4l5k81kduxUPCs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qJf7bwd1PNWYwmZGHDZ1nfwiLqpl/+ycN5OTtgMBpbFZD3lkrlUx/ynayAAp2mUj7
	 3iDcpd0aDbxdX5DQRXVxuGvdSGHuZBvJ5OzVFkywqofS0Lyd6AWdSw/f+7P1BTnAjm
	 ydLlKZN+NdX0HXi9PO+GSDsN2eYfKlX9ZEpwq6dnY9B2xrOVT5JCYE7sKin6EwIhCB
	 UDPBr34/eOzWyeUODAf9F/3x79O0cBPxv4KSZCLLaRLqWC/GkOIR1JsdBowhSN4LkV
	 gV6Vz7vOV9ilpKIAxOgMjLdBNDSZomtofDz+i/4WQxkzA6VJMd5tzMY0GUJ73O3J8u
	 kKUc2uqi2e3Qg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:38 -0400
Subject: [PATCH 04/14] sunrpc: rename cache_pipe_upcall() to
 cache_do_upcall()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-4-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1048; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=oeDUirb5QsxFfctXdbfNXappHx0QW4l5k81kduxUPCs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB57jy0B1ah7altKkzsgZGIf3x7vny8fUR4VU
 FP2MbzwMV2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgeewAKCRAADmhBGVaC
 FY+QD/0TeMGlfxugPjljX9MmLFU2/iHKs5qzhPxWHVikdSmhT8Gma7zheHBqV9RNh20b780FdYI
 0qgpO2Q96Sms0NCvZ0ErTcT3+F3oQ3Ln9H1PXmcE3oXba1HfMiTZHSKDNmFEYLT+36LmFvdtwEX
 PYlv5238avPrae/ZiAGDMgC0LQaNRnDQb0SQXqNeDcMvFQjG1ZTNN6NQXVwUWONJHguEb4yPD2H
 28tvfOMXVl1Sk2w4M0ePlvZnedOk7XX4L0i/Ie5b7Ni6C2+WzjGVsJPwlhIUviAb6Cv+0R8btea
 LUP+xB05fumUrptMkRaxE8MU0n3bIfntTwQrZ+1HON+lRg76vyqkq9/enEzn5seDuA5KfILljiC
 WZ7f9aqke6GgOpy21B8kzhGcJX5EJzE+BBw4XmnSNdFJiTiXq+j8g2FZ5dCYQUpgUJaa3Od1FfC
 oL4qsxWfQbK4sddp1C1zLWvs/gg5mChV2c6LvYAkZZ8ZFykW8dt9dNNsnXPgwxDbLkcgrBK2ZlA
 DeaN2MOROd/gRwd1SB0Q/6PqAuwCHhYyTdOek+dke1ZNBtRQ1qeZD+2zbg1g/UD2MExsdSXVldR
 jdU9bkWNAiHs+Ns+dBPA+N42C/6ZYrSvEnn4APVwXp4iCQF6Dn+TsdvZWYdbk9oKE9uG94c8Ukw
 uc5yKcsZ1ERQtsQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20188-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07F5329C24C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

...since it will also handle netlink upcalls.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 5e36f6404400aea5700d0893c00b6d69c1ec128e..7081b6e0e9090d2ba7da68c1f36b4c170fb228cb 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1206,7 +1206,7 @@ static bool cache_listeners_exist(struct cache_detail *detail)
  *
  * Each request is at most one page long.
  */
-static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
+static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
 {
 	char *buf;
 	struct cache_request *crq;
@@ -1251,7 +1251,7 @@ int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
 {
 	if (test_and_set_bit(CACHE_PENDING, &h->flags))
 		return 0;
-	return cache_pipe_upcall(detail, h);
+	return cache_do_upcall(detail, h);
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
 

-- 
2.53.0


