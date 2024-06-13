Return-Path: <linux-nfs+bounces-3754-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF2906F69
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F541C22D93
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 12:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21915146591;
	Thu, 13 Jun 2024 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faRrTFjv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993B14658B;
	Thu, 13 Jun 2024 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718281018; cv=none; b=nACl+CbWNVv6zcVBkcUrDGU8P01dSJnV4qpXLbeOJspwy4i6A+3w39WCNEivCPbp8aE/29ZzNhhhuUjqLKLvPKcXcg4VZmMJkJwKwv6Jmw7wKzO0pOdv3Iv7jXXXOYikVPjtgcQMWinomJamwldroQxCpLWdfHIhTcAGtrSYVHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718281018; c=relaxed/simple;
	bh=ghg88iAsp3/i9GvYH8AftKpHuXPhVhmUoYTrJpEipyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JInMr4BmY7pUMNC2LEq5fvny/7GgX2a/3Oyi7H9k4g3IWyYnHxxein8/NfNN7XMLxPRBPnoXnnpyyFUjOQ2DdSYFp/5dz2ID2PwH9DV8TSQV+Z8juDG+KsS99R8YTkkP42GUSa/wD9ztHXqo+8L1qONiW6GDHRCZcWNLfk4Pdp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faRrTFjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25514C4AF52;
	Thu, 13 Jun 2024 12:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718281017;
	bh=ghg88iAsp3/i9GvYH8AftKpHuXPhVhmUoYTrJpEipyU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=faRrTFjvWA0Gx+Tgveq9/6Y6fhwNHY4nIjN3BzpSX+VFhXDrksHCmPwbfXUbVNS/6
	 OyunNm68wmgIlZrgNER8CL6ZEnqiIZQdFJSdBYOdvHNk9CGtAYp6h4UAKx/XO0U8ND
	 /ps2kXyUGNI3LqHyrecNUaNICw2TJTVo5Ew9OOwoXNu+EUAY2prHFwmjZkDYaFT/Lz
	 tvK/uz8c0bROEBAnVXpPi+yS9otKrR6PLIG6jiW3JWEUhp8/x63vwN+ymJ13SknL3B
	 yOvtyl7PCe1mNyJ/1FjK/Mn81n/w9gqpWqji97q1OnsOQPlffAUpv/p/3OY4Jy/Y8l
	 ibaHfvqlYmqxg==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 13 Jun 2024 08:16:38 -0400
Subject: [PATCH v2 1/5] sunrpc: fix up the special handling of sv_nrpools
 == 1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-nfsd-next-v2-1-20bf690d65fb@kernel.org>
References: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
In-Reply-To: <20240613-nfsd-next-v2-0-20bf690d65fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=ghg88iAsp3/i9GvYH8AftKpHuXPhVhmUoYTrJpEipyU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmauM1I+D7beomyTrYtILfYwqORRq83F8h9MZxV
 g8g/N+oUHGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZmrjNQAKCRAADmhBGVaC
 FYUIEACMtZL5vSZIl70OP2BUH9/+TZv2zJ+WcmE4PkNq0gQqiR9blN9sZOpGNK9B5Ux0UZnBIlc
 U6qrjqQ8CjxANOy9Ra0t+LWeo0tY/0TDhFamm0MbhMaqJ/RKLxTts8tiHDtAbE1eiE/crUXxRm7
 1mU1v0YRXkTujqLDfLtHVXxAraBHZPa+cglDnWDqGazEJzvopV48LUy1c9b1HtOC5A/JwQmIixN
 1OfvFRQDDOVrFcWpRUASKjSaJ1YfIfzwJwmayJBkkuiaTo3E28f8EVf0YUt2SnJCPzuQvWkVI0w
 /cSoqn5mppeDpwrDNJgJZVFOwS97BEZ4PuVCfyBWOKrLc8DmxFg1v0aeWaJTQWMwtIgH9sHxmjG
 0on2EniQcotanZLShHl6wQJa97Jfe1lJCnSjAzWYqSsaarMNAI2p7spmxYnJUhmh14opst1FzTz
 Z5uthQBdvzTnTz1ogD4s87lXRQoVEUxgKHyXsINj5gmoNbpZVSkBnPy1WUmpFkca9CnoKBzeLlx
 OLtz1hVSDKFIqT1MW0DbS8++rq+cj0KiUPlYfN0vd+inTE8yBNk0O8e4Crtjft1c2+7ouQfP+4U
 etRWYzC+3q0ANd2K4wHJu9V+p9yWv/980L0pZwq62MpEh4Pp6Fdp5GKbCukiS5eiG1kRmyfQwJh
 mhCedEMvzlMp0UQ==
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

Ideally we should prevent anyone from changing the pool mode while the
server is running, and nfsd does this if the server is in percpu or
pernode mode. Previously, you could change the pool_mode even if there
were nfsd's already running in "global" mode. This fixes that problem as
well.

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


