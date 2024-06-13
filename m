Return-Path: <linux-nfs+bounces-3783-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB42907B8B
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51EDD1C23C56
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61D914D439;
	Thu, 13 Jun 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrfWbtnx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81A14D420;
	Thu, 13 Jun 2024 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303682; cv=none; b=Hmvk2PoopljImCwhU4SCeSN35kjjmbHp9+TO41BlQ4vbEsjgBmdp+FTULnWRLZ/Ocn40e0DMpj0qT3Xqx5ODdkBeAhEPorkzCCh/lqJfPFu8fXl4gWWUw4D5XrOA/Y2KbdPCKaW9Pq3QOQivWzAZnfFVpzJDfgugKoRqzlyhIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303682; c=relaxed/simple;
	bh=P0z7CPlefmV2nykZZ/K60TZR1AJ3MxzaUNXJ+hqBQ6M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gNQLfPEBcslpiDJmYGVOYfyH9ibhJm8n3X3LBmdUfE4Vv4+wYHF0CQoeCwKjNC8MzYUUY8y+jvaT/xYIXRx+TBy7EAhwTRvDq7bwAKBsOxJfJnpZsVjV/+fUBsutvHXUeUcmPrFw6icuDC2+24oSi9z3j4f5W9J4UW8y9hXikXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrfWbtnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B7AC32786;
	Thu, 13 Jun 2024 18:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718303682;
	bh=P0z7CPlefmV2nykZZ/K60TZR1AJ3MxzaUNXJ+hqBQ6M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrfWbtnxSLaOj/jShzfV/Zz8Er0gv11B1Wu2660ohd8gzPkLR1DlwFpvntr7fDqW6
	 zG5ukM6RxqlPJMf1Gl1zhUJ9Q+opfVYOgMvSx0ZKeNX/5FYXsOfaGsE7NKQvqColpt
	 MwHTMqGzdbJfhIUreMvEgesASjJVbmN+sN6bVno8/z9Z7Cqf2xPchh2tOoTDAnS+Bt
	 19SsAxex+Kgjv/KbO0eKyA/e72Gmas5mShuthQn7e0OavN3zzubDHqSyA6n0PRZQNX
	 xZ+ilhgtm4CjYCnFpvGth5zWRyC0WcRBpkVbQ9KvYDyE8mc0Wk5/PmAVkXOgigVZwt
	 xwwZQjyj8WnHg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 14:34:30 -0400
Subject: [PATCH v3 1/5] sunrpc: fix up the special handling of sv_nrpools
 == 1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v3-1-3b51c3c2fc59@kernel.org>
References: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
In-Reply-To: <20240613-nfsd-next-v3-0-3b51c3c2fc59@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4030; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=P0z7CPlefmV2nykZZ/K60TZR1AJ3MxzaUNXJ+hqBQ6M=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmazu+tAFgD3CcatPdHqafaoo+CrTqYJ/+lmSBE
 f4mbUzukHiJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZms7vgAKCRAADmhBGVaC
 FdUUEAC91/Mbies3cnsrpyhHq380clmNMWy+ebmriaiOiQdMwguLWI/SJCX1E9+flCl+vDl0odg
 R70l6M0PTsC68QYe9zhx3svjA+yUoQfv2ann2+sj2wkASKxsfBVCx4JE7QALOpdaU7YqyyrDpO2
 nMkxblsauPl1xbGiyAMmaEnD9P+3lVwszF1fRl3fte6ZA6KxFdPrnzCiPG0Xoj8a4X/XAVPk4ja
 zZ7RsgApB+sZ1PKwSERvlFBxY00o1xQ+cxf2V40sxfC2JAlt3jnmqMXeApsOuEala779p3r6LhP
 3DAsD7Gir9868aLKrgwv139lcdSb9xbjQXFl3V9oFPMQ1H2PB6WKy+8vyhMcuZ8zwRqNknMdeVb
 0yqBgl2YeabjZC7CF6SSbEq3VflDBRbUuRfzajhjXKHdH5OwzmGtWpUCSLCAffj2JYedU1skDKa
 lKHTSJizQ8P75MveB3VI1hF9QO2LxNkIQXTZtwmDNg7cDHuwF5aIxazRN6i4JM0ouKQNI1fFuhQ
 XrCU74He6bUGh07vM73irKe3ShZQrC32OiL4X/pOfKSKCOaN+mrjTYixeJYqQZiXQMWgwW8fVnv
 seZvn6ZHI1bniszYpAqdkoikx5Ob/V4JZnD5xAKylp+8E3V8E1cw/WkhZwZYuGVHHjSE3lPcpd1
 qaiXpnR6WwgFitQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Only pooled services take a reference to the svc_pool_map. The sunrpc
code has always used the sv_nrpools value to detect whether the service
is pooled.

The problem there is that nfsd is a pooled service, but when it's
running in "global" pool_mode, it doesn't take a reference to the pool
map because it has a sv_nrpools value of 1. This means that we have
two separate codepaths for starting the server, depending on whether
it's pooled or not.

Fix this by adding a new flag to the svc_serv, that indicates whether
the serv is pooled. With this we can have the nfsd service
unconditionally take a reference, regardless of pool_mode.

Note that this is a behavior change for
/sys/module/sunrpc/parameters/pool_mode. Usually this file does not
allow you to change the pool-mode while there are nfsd threads running,
but if the pool-mode is "global" it's allowed. My assumption is that
this is a bug, since it probably should never have worked this way.

This patch changes the behavior such that you get back EBUSY even
when nfsd is running in global mode. I think this is more reasonable
behavior, and given that most people set this today using the module
parameter, it's doubtful anyone will notice.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/svc.h |  1 +
 net/sunrpc/svc.c           | 26 +++++++-------------------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 23617da0e565..d0433e1642b3 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -85,6 +85,7 @@ struct svc_serv {
 	char *			sv_name;	/* service name */
 
 	unsigned int		sv_nrpools;	/* number of thread pools */
+	bool			sv_is_pooled;	/* is this a pooled service? */
 	struct svc_pool *	sv_pools;	/* array of thread pools */
 	int			(*sv_threadfn)(void *data);
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 2b4b1276d4e8..f80d94cbb8b1 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -250,10 +250,8 @@ svc_pool_map_get(void)
 	int npools = -1;
 
 	mutex_lock(&svc_pool_map_mutex);
-
 	if (m->count++) {
 		mutex_unlock(&svc_pool_map_mutex);
-		WARN_ON_ONCE(m->npools <= 1);
 		return m->npools;
 	}
 
@@ -275,32 +273,21 @@ svc_pool_map_get(void)
 		m->mode = SVC_POOL_GLOBAL;
 	}
 	m->npools = npools;
-
-	if (npools == 1)
-		/* service is unpooled, so doesn't hold a reference */
-		m->count--;
-
 	mutex_unlock(&svc_pool_map_mutex);
 	return npools;
 }
 
 /*
- * Drop a reference to the global map of cpus to pools, if
- * pools were in use, i.e. if npools > 1.
+ * Drop a reference to the global map of cpus to pools.
  * When the last reference is dropped, the map data is
- * freed; this allows the sysadmin to change the pool
- * mode using the pool_mode module option without
- * rebooting or re-loading sunrpc.ko.
+ * freed; this allows the sysadmin to change the pool.
  */
 static void
-svc_pool_map_put(int npools)
+svc_pool_map_put(void)
 {
 	struct svc_pool_map *m = &svc_pool_map;
 
-	if (npools <= 1)
-		return;
 	mutex_lock(&svc_pool_map_mutex);
-
 	if (!--m->count) {
 		kfree(m->to_pool);
 		m->to_pool = NULL;
@@ -308,7 +295,6 @@ svc_pool_map_put(int npools)
 		m->pool_to = NULL;
 		m->npools = 0;
 	}
-
 	mutex_unlock(&svc_pool_map_mutex);
 }
 
@@ -553,9 +539,10 @@ struct svc_serv *svc_create_pooled(struct svc_program *prog,
 	serv = __svc_create(prog, stats, bufsize, npools, threadfn);
 	if (!serv)
 		goto out_err;
+	serv->sv_is_pooled = true;
 	return serv;
 out_err:
-	svc_pool_map_put(npools);
+	svc_pool_map_put();
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(svc_create_pooled);
@@ -585,7 +572,8 @@ svc_destroy(struct svc_serv **servp)
 
 	cache_clean_deferred(serv);
 
-	svc_pool_map_put(serv->sv_nrpools);
+	if (serv->sv_is_pooled)
+		svc_pool_map_put();
 
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];

-- 
2.45.2


