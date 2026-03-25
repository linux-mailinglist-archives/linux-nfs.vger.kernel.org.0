Return-Path: <linux-nfs+bounces-20379-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFeZOs/3w2nPvAQAu9opvQ
	(envelope-from <linux-nfs+bounces-20379-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:57:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0F7327468
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 15:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFE433043003
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2026 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAFE3F0ABB;
	Wed, 25 Mar 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtR0VpPk"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610793EFD3B;
	Wed, 25 Mar 2026 14:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774449659; cv=none; b=UeTv/2a9+xH3ongYREhmjkvdXu/kBVf/oWZx7WTyXANtDRzd98vxma/H2TzaxgrUv/miEioNnbafI9mGZQcwDVVqK9AevzLo69fwnSxoob7Fi84iY5O8jUWO0LiQIICTBbxGg2ouPy/YVedszdKJzVdrms0f4PQOIqJKgU+8uSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774449659; c=relaxed/simple;
	bh=1AKPKcydftHop5CQp8Iwo1zeSc7b5Z2FWQsZ75X7nWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNFNRWC4kie40LlFev26UtT0V6JOZJ67nEUj44W/nD8uAFZVRpuAyQr04RJcLDRM8SLyqboyCdgq4/GXZFIQzqc5YhDXpqb6ydSC7DH4khajXVFr2wCSuCKyOoYvHqMl6rUhLRidQSdwj8REaLSegkmw7YjZyRA6BYdJR/2j5ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtR0VpPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B06C4CEF7;
	Wed, 25 Mar 2026 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774449659;
	bh=1AKPKcydftHop5CQp8Iwo1zeSc7b5Z2FWQsZ75X7nWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QtR0VpPkyZjdoD4F1UG3c+2efbEQ4bCoWzZETMhvg7xyQUJhvx+Lk5JOcwEsJNX2I
	 0D2VH/1xcWLNJP+vQdxFZB0LSCLP1g0a0otQOJNJVKh9vvSHIVCkyO/Uao+4yvaxr8
	 QSGKSwLjHB/9w83xwmIkTt2do7l120WSXKz7PQBEdDfKCgFLtGHBu0501ZiiHFFHbs
	 VKNN8yMHvTkT6H3Fxj1mhspjcMxS0X+EhOFpJlDVzFu2ggchW/SSGRudjaWlJ31xQ4
	 ntLFR3L3GhvpraLGIpwJa7NYrlT6XY+1+1idbh4J3rgVa8T+zxCGehVnk1ZjvfLvxD
	 TXvvAC479yisg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 25 Mar 2026 10:40:26 -0400
Subject: [PATCH v2 05/13] sunrpc: add a cache_notify callback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-exportd-netlink-v2-5-067df016ea95@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1AKPKcydftHop5CQp8Iwo1zeSc7b5Z2FWQsZ75X7nWw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpw/PuMNLtOswekS40u/7k9/vOEW6PhAWumjoLR
 aUdI4T0eOGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCacPz7gAKCRAADmhBGVaC
 Ff5QD/0d0j0M06Nq0/dYUOn/kGW93mmPkvDM6lNvqGW/aDIJTQLWXllEsmCLwgTtXLmutUOzQch
 lSVppYwI+huB2VUKcTfs4ZLSeEb0f8KZJFg6aBN1VG2m08A0TfpEZEVo3ccH126U90UeR2UoRL2
 aRi0mtJbjMvY7Y3eLh3fb3LIjfkONklW5PhDhS2W9ppIXifpqHOc4l6fvWJ9Cncf0QqU6lk+TTs
 uc0YttDh+oVYa4SUGRYKd3u9AopYiMQ3HPnaZBdxBrpLwHujqs46j7g+31KNCgZXN9zxqEwwuqa
 A2RM1emehdUo/1mHwMuTH4mEsFMEKhPVpmMhgZ2q+S89cpsmhrAHY3GXvhItbvMHnYPKVilUUcj
 LdJs+2VMnUThVVApaJGNTMooMgnMLrA7aQDu+xRm7B4/Bg/akkJqJ3DUINvowMBM2i9GDIb8xx1
 sTj5MjyDU0tgEC5/8ocnB/6pNs+oTRJTkympkL7X1TTanR88jCxMWnsWlVblgWZXN1cadv/QG2x
 IX20zPYSj5Z6fFWuIwQeoA7EzMDy2YhkQG5LWCMYiUbeZOFHn/0PJz3S38ufSpFI0NbERn0DG7V
 VxZXMR4rhn2Lksi36t8Jk1FG0WaqI5xk1foOQk4khRX0zXJgS1jucNMi9FPwWukEjO5GvwiYxlK
 kjmkq+mEF1q9d2A==
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
	TAGGED_FROM(0.00)[bounces-20379-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 8B0F7327468
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A later patch will be changing the kernel to send a netlink notification
when there is a pending cache_request. Add a new cache_notify operation
to struct cache_detail for this purpose.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h | 3 +++
 net/sunrpc/cache.c           | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 80a3f17731d8fbc1c5252a830b202016faa41a18..c358151c23950ab48e83991c6138bb7d0e049ace 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -80,6 +80,9 @@ struct cache_detail {
 	int			(*cache_upcall)(struct cache_detail *,
 						struct cache_head *);
 
+	int			(*cache_notify)(struct cache_detail *cd,
+						struct cache_head *h);
+
 	void			(*cache_request)(struct cache_detail *cd,
 						 struct cache_head *ch,
 						 char **bpp, int *blen);
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 8a66128a1bfabca42b52f274ea34c1b594a5920b..a182a179a1bfdb883ceda417a5809d967659be5d 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1233,6 +1233,8 @@ static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
 		/* Lost a race, no longer PENDING, so don't enqueue */
 		ret = -EAGAIN;
 	spin_unlock(&detail->queue_lock);
+	if (ret != -EAGAIN && detail->cache_notify)
+		detail->cache_notify(detail, h);
 	wake_up(&detail->queue_wait);
 	if (ret == -EAGAIN) {
 		kfree(buf);

-- 
2.53.0


