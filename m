Return-Path: <linux-nfs+bounces-20378-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GN3KNv9w2lXvQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20378-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:23:07 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51416327D78
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 16:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6BBA93035D6C
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194013F0A80;
	Wed, 25 Mar 2026 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJ4rHGIK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87953EE1E8;
	Wed, 25 Mar 2026 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449657; cv=none; b=hhb8o8D6kky64VNLGPiGMWiGjpDLw+XCEYJudgCqwhySFef71h8RyLtshSjVnrZHY1gJ2JzLxYZMgTHS0voExGHoScI6jzRW8napcvkXRjSMRcuhPUTnhNgwj8nE0OASV2ktVYr6vdpbQnLwo25situEhFFVa7B8leNizhXoDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449657; c=relaxed/simple;
	bh=z1a50sShHbXLrt+MAFH1HTdDE4R/esAqUantftctegA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W94Z1yDidCL87ZnVD+r10Sk3xIAFTX5XkuZ3V6vRXbfSmYas8sWMgWbdJZgpE1wZZ5ptlkWqJMB1Aj/OhBhR77AZOceQ9Pgim21owBWlFAV1WmdXpGoWJm/SBSvHEXXW/GzL7IdnLOSlwj9o0Y9gGoGy/ZC7W9mQh5tD/vVVEOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJ4rHGIK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B077FC2BCB3;
	Wed, 25 Mar 2026 14:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449657;
	bh=z1a50sShHbXLrt+MAFH1HTdDE4R/esAqUantftctegA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IJ4rHGIK7luNIfUIam2SXp/QusjJDas8FuEwzNNI6qjAzD9xIQE8r17mUJeJL+sJy
	 U8KpmltR3TiSBtIPYq2Z3u3QBhq2CofALLxvzPMmTZ8QEeigqJVFzEYRyRNIN2Fqct
	 z+DnaEEY94t+Suw1OYWAUX9FyCQ7lGB0fB2A//d7qo7wzo0tBBIULCG926zVoBJaCX
	 2HO5v1Jle/vN2zRAmjeFcyjnVT4BBtq2f/M5bpI4TMkF2Bd9gkKwljzuIAkrbHvaML
	 cFVaauHn8JQvUU3ACbx9CD8lYIfXrDbZF0XXOe9zPrplxZDmIahLtGKTmktCCXluIw
	 2OZ3JX4lCSzbw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:25 -0400
Subject: [PATCH v2 04/13] sunrpc: rename cache_pipe_upcall() to
 cache_do_upcall()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-4-067df016ea95@kernel.org>
References: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
In-Reply-To: <20260325-exportd-netlink-v2-0-067df016ea95@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Donald Hunter <donald.hunter@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1341; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=z1a50sShHbXLrt+MAFH1HTdDE4R/esAqUantftctegA=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/Pu5Bmosu3oHpACj8X6c/3sAR5ou/9/BofGi
 TVlWGjGXHuJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7gAKCRAADmhBGVaC
 Fa2ND/0cd0zYxSIw/WofuLVh5mteBJGnl7fZsxcsW/1ifWmWnqZcOVCffpn7gy+QaXejzd+cSuM
 v9hV/nujKyI33H5h9eMiKj8SMK041dF+b/WdEN977TYoUwMM1aAAUwY/j8tZ7cG/3CLQQIHX5BO
 K/Fmp1OXH01rC3lUb/eXpuFwiXPbT0IuQtglzwK1EkAhH3mtALqzDOVGehP6+uAB+sHOWYQqOl6
 xQWrTVH4tOarlhgtvPTTeQ8I0doCe6P7RAiuXNZLem9iaGXrrlUxPdH6FTWLoYKdI0o6+tAfj1c
 qC1QtFQPcHGTcF1HznCbZe7kdlHTRgHKARzilFn0USMvKs4JzFVHvJF3RRBokyv6riA7u2LZjQB
 wlLVoH18Ih1oO9npQUrC4m2vraQKEnOrw7qgL9uFoyjblOVAnyO5Tz6Uq8or77FQycBt94fizKh
 eS2O6MlxyBtOmiRKmcxcWPRZeD8sKMKeNBhK7J6Dci+NOheDGsOhWsVSJFcCpUHreV1FTb0xUvp
 3HjhfuciEKBsNWSy1YDvk+gYtX2gpnv8jtCqA49DWf6KcAG/eM1DGesH/KpsXUONimVwgQXHiHy
 DIQkc1Hz441fszwsaIVWs11J5kKSKIMWeJS+kwG9Zd7ZFl2emH0pm3FYy5atGRIArG7P7uBnxVt
 ZhEZZArOyP5+d0g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20378-lists,linux-nfs=lfdr.de];
	FREEMAIL_TO(0.00)[oracle.com,brown.name,redhat.com,talpey.com,davemloft.net,google.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51416327D78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename cache_pipe_upcall() to cache_do_upcall() in anticipation of the
addition of a netlink-based upcall mechanism.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/cache.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 1b97102790f6642fa649ad6aab94fcba8158fa8e..8a66128a1bfabca42b52f274ea34c1b594a5920b 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1195,12 +1195,12 @@ static bool cache_listeners_exist(struct cache_detail *detail)
 }
 
 /*
- * register an upcall request to user-space and queue it up for read() by the
- * upcall daemon.
+ * register an upcall request to user-space and queue it up to be fetched by
+ * the upcall daemon.
  *
  * Each request is at most one page long.
  */
-static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
+static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
 {
 	char *buf;
 	struct cache_request *crq;
@@ -1245,7 +1245,7 @@ int sunrpc_cache_upcall(struct cache_detail *detail, struct cache_head *h)
 {
 	if (test_and_set_bit(CACHE_PENDING, &h->flags))
 		return 0;
-	return cache_pipe_upcall(detail, h);
+	return cache_do_upcall(detail, h);
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_upcall);
 

-- 
2.53.0


