Return-Path: <linux-nfs+bounces-20189-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHbgH9gfuGlYZAEAu9opvQ
	(envelope-from <linux-nfs+bounces-20189-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:56 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D71C029C2C3
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 16:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB47301A3A1
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Mar 2026 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC763033F8;
	Mon, 16 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB5kROMl"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225A73A1A3F;
	Mon, 16 Mar 2026 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674117; cv=none; b=RBj1I9Oyf2kWcir2cJM2stP49U1uJMmSxz7ZiGTnAOK5lamuSTjn0Bxm6sdyBr7xqN45XoAkjUzXLgia6kkjLR9s7FwgDz4/zGdGwePExj3dp5iyalw4El9YcL/Boup5WVNgy4Pu6KL6tJ6ka3CzWZeYXzGDPMUuk1TtEi8t5Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674117; c=relaxed/simple;
	bh=GBY2gRkFAZM9XwvOjqnzxklHseW2P36+SjSSJPoy2cw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jSJ8TjBMLnXPghgwlkbed9bkpXiVgAVlEpcrX0aj3FEJ4BADkBiv4E3FqoqxNU9/7mKj9Zdhe5/SaAyaQnvuXCHhWUSTgoqeKt/lCc9hg4LK2GLZ1XblAGPzaKFhTaiyxIIQ2aeBuya/Vbh0V9ibsoukvVgOfOqrK5ayrcmCcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB5kROMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF00C2BCB2;
	Mon, 16 Mar 2026 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773674117;
	bh=GBY2gRkFAZM9XwvOjqnzxklHseW2P36+SjSSJPoy2cw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cB5kROMlU7UOftvc/9KDCVdXnwdRebVy/I0JEc+ZyQbRcktrQ+F9r5Aj9hYx7P6RR
	 6CUppoQANwe46j6a6jp9YG5WosIG4UyKpmMMPJy/wpVIf5kfnFRSmvkGgpmL39CTLK
	 JXsDBW0Ck7OX1cRp0cy/UvwgRrjvCwJjKr5EWUc1IgNoTRTPwB2D3VqbSZi1HMVYzD
	 2MINfsvCImj8xwlHV/VdJ1Z5OSBlRPM0OJgrOWT36x45sNGPFtZFlBM8065XwqQU+o
	 v1KIssukD0giIcurn8MEAzVbLOHrmECsNEUJJZlXO70kyJfhLgmH3V/POTD6waeMnr
	 tuJH1vylv1yxQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 16 Mar 2026 11:14:39 -0400
Subject: [PATCH 05/14] sunrpc: add a cache_notify callback
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-exportd-netlink-v1-5-6125dc62b955@kernel.org>
References: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
In-Reply-To: <20260316-exportd-netlink-v1-0-6125dc62b955@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1715; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GBY2gRkFAZM9XwvOjqnzxklHseW2P36+SjSSJPoy2cw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpuB574PtozW+tMf3NB2jAg9fVS9f2DLJNG0P6c
 006MGdR0EGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCabgeewAKCRAADmhBGVaC
 FZdlEACFwAc86uZLqNE8pJA6RscNRlFFg++4gjJLNLyvq+cwKsKCusXsRYD5VCXA0F+iTUItHNk
 QeHl4TN2xTjM7dBFAtdXqUyozlQ2zenw9RQsmkTGhLj+8fTfH/Vbgqx34M+KLRzUQKstnvQXpHt
 DEAizU8PqjYsSPO+wAorfkx7I4LEINyQuC4bY5IU9XJq65zBz+Q6bKZJedkCLDO6vnWwpkIsB4P
 s+9zVQ/dgFQcCBx139ZVgyYOeS+3V9sObZdKADsPk96a+QJuo0jiO/Hy8dJLAL6hSDI43HZK76C
 ZtHBAW8mMIdUpHbs1PrN6yNq7O7zI9vJjZ4m2Eddq7eMch5O3wU1tFk0MzvaC9DwR33zrzVNGjT
 Ib+BIrBDRabxG9KaLrE91UNzBKbNOyjnZuw+UMW1GhaQr3KTtmHc6+uuaS4r3mHYE9yYqg3zQZM
 U605kWhsnNsoE5VwnGPT/lRedizolpaaZ5c9sS8JAbrdr5ZrVCWVO4s87TYdVW5fOom5rRc3Yjn
 GSxoepO0fdK3+YpZonDKqLRgdpbTcFXlx5c7M/Nbj48sRv4Ul8A+yO/olceb4aQwSgHogX4mK+i
 rjFUjaADON+0VJXNDR2fuTW/RMIKLC7lxCXGRTNXVmcGz+3xCm3Ut1e84IR3d22qfFWzyXojhaN
 7wa4C0ng4Dps/iQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20189-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D71C029C2C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A later patch will be changing the kernel to send a netlink notification
when there is a pending cache_request. Add a new cache_notify operation
to struct cache_detail for this purpose.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h | 3 +++
 net/sunrpc/cache.c           | 3 +++
 2 files changed, 6 insertions(+)

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
index 7081b6e0e9090d2ba7da68c1f36b4c170fb228cb..819f12add8f26562fdc6aaa200f55dec0180bfbc 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -33,6 +33,7 @@
 #include <linux/sunrpc/cache.h>
 #include <linux/sunrpc/stats.h>
 #include <linux/sunrpc/rpc_pipe_fs.h>
+#include <net/genetlink.h>
 #include <trace/events/sunrpc.h>
 
 #include "netns.h"
@@ -1239,6 +1240,8 @@ static int cache_do_upcall(struct cache_detail *detail, struct cache_head *h)
 		/* Lost a race, no longer PENDING, so don't enqueue */
 		ret = -EAGAIN;
 	spin_unlock(&detail->queue_lock);
+	if (detail->cache_notify)
+		detail->cache_notify(detail, h);
 	wake_up(&detail->queue_wait);
 	if (ret == -EAGAIN) {
 		kfree(buf);

-- 
2.53.0


