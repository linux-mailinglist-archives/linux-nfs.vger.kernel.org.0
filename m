Return-Path: <linux-nfs+bounces-3552-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7554F8FBDC2
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 23:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3409228532E
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jun 2024 21:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DCF14C5A0;
	Tue,  4 Jun 2024 21:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBhzzjru"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD14714C58E;
	Tue,  4 Jun 2024 21:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717535294; cv=none; b=t3L4McsEjFfiSDot1iL95NS2XS7bjJs19IQo7+u06zYeLHHfG/Y0uUTh4e24aZdnNiSJ2HdOGaBUNXkBkJZyhRzLyyztn55GMfRiHQpYczNd5qQv+AuFauPKS2Q0PjYeOSCNvm1anOR1MPkBkhfHp7n+XVWe2RvXfQwDrhCtqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717535294; c=relaxed/simple;
	bh=sFrRqAc+3keBolPqurYuDWuBor53GoaZSW/eQu5WwRQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPnvyWsXbLtEO/8e6pILEHbLiDPMmKkyXKxaj3nc1v+0LL7rXMjtufU7sLVHD+pzy3VRsOu/e/hQ4enpQVZle3vbAG50gf8riq1e5NZGkp2fp5O+K0HqKo3dzR6fjoCBvfnuyKktWD4Y1QO8Iv/QA2E7ozch8wiCgINUFZDktoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBhzzjru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C37C4AF07;
	Tue,  4 Jun 2024 21:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717535293;
	bh=sFrRqAc+3keBolPqurYuDWuBor53GoaZSW/eQu5WwRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZBhzzjruoMgvJ82bI1B2F3/lkMLVyjHevGZQzQNnA5ExMhoR+wssj/jlbR6BMGVdc
	 jpFiy826tbFvudlMOLfC/0tHCMQXamJ3HnDVEaagNm6a2RzBfIfobNaurSEKfmnCtg
	 wwCkWTDoZewBcYPJ9Cq7nWhvz6Qkzj+fQs/Kma3+nGh2Ies+VyWFm3DXA+GOssh4+r
	 1K4jWTML0WYDpXaEJUgXqlH36YPQs8xwTOy+oFRqUoRpSV3U7+5hJcQ5g6arVboXzA
	 jEOwG7NePdIcMj7AtuwXDFPqkw3EiCU0ecDv5na7vLEWTPdDyEEUmKmxT6KcWmx4w8
	 +9uElpDBUTHvw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 04 Jun 2024 17:07:54 -0400
Subject: [PATCH 1/3] sunrpc: fix up the special handling of sv_nrpools == 1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240604-nfsd-next-v1-1-8df686ae61de@kernel.org>
References: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
In-Reply-To: <20240604-nfsd-next-v1-0-8df686ae61de@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3747; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sFrRqAc+3keBolPqurYuDWuBor53GoaZSW/eQu5WwRQ=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBmX4I6jGBaHiLed47Nq4OTkhX5mdQ8z72L2PUIa
 fZsEN1KbLCJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZl+COgAKCRAADmhBGVaC
 Fc4RD/4gPmQVG9OjaHk8b7mAHgH/dSJ0XPclzIWo2jRBvH9P11pNTdu5PXHWlndYkS9ojbkqUaW
 mP58LTMIDJad/AO6zA95OE9p440Q3f/RzxlEKzLfObCMtWj9jwz8l93m50xCJP7zQbUjMRPFw1v
 0Ss9MeyX+UY7syphYUChk8cgWfI3pzzK9leQVi7hdx0AwYPeepfvwLCRRQSq/xsxlTDfSZr7bKp
 Gksnfw0bkkiyW8kegNWmlpNrpgv1ggYWPe48qQxccTzfXJwJHsfjXO3qnkxQLdXe8ZigvcYO6tB
 Af5CSoKemRPSBPMdIzyL/3AnZcIsZ0p/hwkqxPKqrsSP9likD9wcv69puuh0Nj4XJtcfrD0LSPd
 NhwWc3yG5vFsbTS5hIv/IK0w9UJQscrEnreAt8dfbiSvlz3yWqyflql5LhVJkWlUsdxyRJxUiwJ
 zHUQ/45GwpoKOVLg91fDNwMYnS5XKf9kodIUZQeq2907wWOaTOT+XyRQFOBiEHOh9jNMcOY/3f6
 t6PDebi0nqYswaY/ZsZ46+LrO85Dw85lRx7SuMjxgQImbJxtMBdOrRNPbSJXQP6o8hI821S+j7l
 mgU/nTfHaLdpiIM7rrPcxX+9j5t1A2St3z30QMT2M1QvaGBFnraxAujoJzOlS+T6k4MQniIXCRx
 QAMHR3syI1o0GyA==
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
2.45.1


