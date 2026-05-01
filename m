Return-Path: <linux-nfs+bounces-21339-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBU6Gcy+9GkDEQIAu9opvQ
	(envelope-from <linux-nfs+bounces-21339-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:55:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2C24AD6AE
	for <lists+linux-nfs@lfdr.de>; Fri, 01 May 2026 16:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABBD305BDCA
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2026 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFFD3CFF4F;
	Fri,  1 May 2026 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC3TP10D"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E993CE4A6;
	Fri,  1 May 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777647099; cv=none; b=ukec4PeRgzdglxKE62PHIo84/WmRBADamRy5aVhvoWA3BVED8o8v55c2HlG3g13v9rNgoZcS/gnzVVAZHde7+in+6XaTWpjFPzR2DJZ3q7gXr346nfeqhJjo2/waNhmBTQTWtmTN6ZOCPl+W1dlfvOxzen35/y1OMNeghfy9WsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777647099; c=relaxed/simple;
	bh=2T3JGcNd+/XQP2Pn11yD19WPrggjG2IMkwq0Hu0uIzw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pqxO2Q03Ol0JtTwND5DSEBRCrtNMZU5hAf9nmp8VWI/ktSwV4gMaFwX8ixoFvGFcanzeDJTFi6TYv6/iC5rQN5AXZelC2FpScBVKG2oJ9PbM+mPlphLgt6pHVTWb9PZYP9y/gxIPQpgiaR6336CIUQLM71uSmdaMb9O4JikNw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC3TP10D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 849C6C2BCF4;
	Fri,  1 May 2026 14:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777647098;
	bh=2T3JGcNd+/XQP2Pn11yD19WPrggjG2IMkwq0Hu0uIzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lC3TP10DjkEY6CaN5D6HSZP3yDajcwLn4qUi7PX+qELdcjtPOsMNS71o0v/+mzErh
	 GHZKolK6eWDuv7OWhPUB2vnd/oF0LfpKIdRLtiaL7yOxCH6QrbhSMxJKFLyCIPmE3o
	 1TeYepHiTJ6eHoSWYUigfcdEAVeYpT8Egw0WTbOgRMXuwv5CVgzSj+muECaqu5ZOum
	 WtmejUN9cn5PjDRUdFJ2VyVV2THahh21hcGK4wVaFFBi6U9byIN1LJXAHONJ96QgCU
	 cA5WwlNWVBL/MT5wym+Vi+Ma8nzaMx4PeTWD1G33L9Y5ijOjai9l7/LGSdFaH9DRA7
	 g7fzTkQMxb23w==
From: Chuck Lever <cel@kernel.org>
Date: Fri, 01 May 2026 10:51:12 -0400
Subject: [PATCH 6/6] NFSD: Convert nfsd_export_shutdown() to
 sunrpc_cache_destroy_net()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-cache-uaf-fix-v1-6-a49928bf4817@oracle.com>
References: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
In-Reply-To: <20260501-cache-uaf-fix-v1-0-a49928bf4817@oracle.com>
To: Misbah Anjum N <misanjum@linux.ibm.com>, 
 Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Yang Erkun <yangerkun@huawei.com>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=9Lx8j3bkW1U0/I06utJXlLrhrDE5QF/icgJjUzwnHek=;
 b=kA0DAAoBM2qzM29mf5cByyZiAGn0vfCgtcQnorQpH1BYb4jHi1B0E8EEJ0q/5rISORjTB5fos
 4kCMwQAAQoAHRYhBCiy5bASht8kPPI+/jNqszNvZn+XBQJp9L3wAAoJEDNqszNvZn+XZAgP/2nO
 035u2vASCu0V2VAtBlP/zKVkuSdqutQyZuEqH5vaBGMze/u1gS6QF08SwIv/Wu2g6+J8829mQJu
 p7bwC7eLqaJLRQnkTzPyESgRfL75E1AAVEfCm76LaZW6EyYDpviksdecsuV3YtQeBW0H7bf+Bpx
 qnWEW4gOGEZuZnEm8T9j0b8eQQ3xZ+zkTCbDmmynu6NAPR4QsvHt5Q4GOlAs2j3Y54QoTV0KNaW
 ZLzadUWCQqSwwcSo4ahbhFwdI+Zc+a5xNtd09o3dwcVsWeePFxQVQBypf5sli4a0wJaRXohpAF7
 M1kxP0lgNu+j8cSaXNVFSyd3ah1kq5nYDHWRlE47vJAi5xmQGwAX5KlpcaO28YlAbAU1Gg9uKkv
 HvzIbznTR8g0HgJwCt1kweqqlX6GsV+fMvX7nLqn5yTl5c86qUHIlh5bvIvPFwxdc9QMCXODcF0
 08am+trgtPU7iKx+3R/2/pNBk6feNeI89LJtxXEETDeLFdqqJ1ZFGpXVkcn84sI9xyI2uOn7jVh
 2NryCeDCg+USUH8PTu7++d0pE6DFWXA3vNTqsAM6ibI5AdU9llnNHUG0/X7kSs685qu4mYuzfC9
 2uDPO+u2H+EMwpr9+8Sz9eJhGZh+BzjCzEmpEFmjCnKBWy0tBeyjv/EFU7ksPLvtg5vWMNtcUef
 8men1
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 0B2C24AD6AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21339-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

The earlier conversion to the shared sunrpc cache workqueue left
nfsd_export_shutdown() open-coding the unregister + drain + destroy
sequence to amortize a single rcu_barrier()+flush across both
caches. That micro-optimization runs only on namespace teardown
and module unload, neither of which is performance-sensitive.

Switch both caches to sunrpc_cache_destroy_net() so that the
canonical teardown idiom is applied uniformly. A future change to
the per-cache release callback that requires the cache_detail to
remain valid through the drain remains correct without per-call-site
auditing.

With the last external caller of sunrpc_cache_drain() gone, drop
the symbol export and the public declaration, and mark the
function static so the compiler can inline it into
sunrpc_cache_destroy_net().

Assisted-by: Claude:claude-opus-4-7[1m]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/export.c             | 8 ++------
 include/linux/sunrpc/cache.h | 1 -
 net/sunrpc/cache.c           | 7 ++-----
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
index 3c4340e743fa..c19f8e8c4f9e 100644
--- a/fs/nfsd/export.c
+++ b/fs/nfsd/export.c
@@ -2250,12 +2250,8 @@ nfsd_export_shutdown(struct net *net)
 
 	dprintk("nfsd: shutting down export module (net: %x).\n", net->ns.inum);
 
-	cache_unregister_net(nn->svc_expkey_cache, net);
-	cache_unregister_net(nn->svc_export_cache, net);
-	/* One drain covers both caches' deferred release work. */
-	sunrpc_cache_drain();
-	cache_destroy_net(nn->svc_expkey_cache, net);
-	cache_destroy_net(nn->svc_export_cache, net);
+	sunrpc_cache_destroy_net(nn->svc_expkey_cache, net);
+	sunrpc_cache_destroy_net(nn->svc_export_cache, net);
 	svcauth_unix_purge(net);
 
 	dprintk("nfsd: export shutdown complete (net: %x).\n", net->ns.inum);
diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 84802438a5fc..22c18eeb5a97 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -238,7 +238,6 @@ extern void cache_flush(void);
 extern void cache_purge(struct cache_detail *detail);
 #define NEVER (0x7FFFFFFF)
 extern void sunrpc_cache_queue_release(struct rcu_work *rwork);
-extern void sunrpc_cache_drain(void);
 extern int cache_register_net(struct cache_detail *cd, struct net *net);
 extern void cache_unregister_net(struct cache_detail *cd, struct net *net);
 
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index be7a0c8c416e..62ce334104d9 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1737,18 +1737,15 @@ void sunrpc_cache_queue_release(struct rcu_work *rwork)
 }
 EXPORT_SYMBOL_GPL(sunrpc_cache_queue_release);
 
-/**
- * sunrpc_cache_drain - drain pending cache release work
- *
+/*
  * Wait for outstanding RCU callbacks to enqueue their release
  * work, then flush that work to completion.
  */
-void sunrpc_cache_drain(void)
+static void sunrpc_cache_drain(void)
 {
 	rcu_barrier();
 	flush_workqueue(sunrpc_cache_wq);
 }
-EXPORT_SYMBOL_GPL(sunrpc_cache_drain);
 
 /**
  * sunrpc_cache_destroy_net - quiesce and tear down a per-net cache

-- 
2.53.0


