Return-Path: <linux-nfs+bounces-17060-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF40CB9F7C
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58CAD30BDA9B
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Dec 2025 22:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E2F2DA76D;
	Fri, 12 Dec 2025 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGe0pLN7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061B82D543E;
	Fri, 12 Dec 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579185; cv=none; b=HpYch7LZInXHHnOHNYuUI2I5oWdj+XYj6373FDQe9V1sxIEZYlJkuPsLAv/d8o7OjTEO2+CCNjPLxRCZPPxyz8lDnIKjMEv3+YHFLjhCHevO77cH2kULLvwx3WPPN5tgmiVkP0bOOovYGEWiI2TI9doq6wfuQT4Ph/MKcRI+RQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579185; c=relaxed/simple;
	bh=En+G5End2AK7R9Jp9jH88aqH0V7NIQgAbC6srDNX1fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNjxkcFG3RxdR8PvBOBtaoh4M2AT5QYfJZ9AhngvqM7vfiYEr76Wf1LPP5WkfH8oGWate/J9rYpKdI9IptLrt2sbwV+uF9X/Vw6xizlk4ziL8RfrGp8YEUAsFAihvrDaTUzvMlYzZAQqOATfJoTPuSbSoEzfCCG0WR887cWHRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NGe0pLN7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575C1C19422;
	Fri, 12 Dec 2025 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765579184;
	bh=En+G5End2AK7R9Jp9jH88aqH0V7NIQgAbC6srDNX1fM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NGe0pLN7ypbCZzN9Rtkjv/nE5/IdxxzMMg/0EdKBGw+ZXvj7udEj4MUDRMNeKWPDn
	 ZE6vELmQbTADxggSpmzXMGY/jgwiuE7IT6FlY8uG7oyCqiXxW4sRVQv+baxECx0vpo
	 gZN/RxzHH+NIZUr7bCRZQueGHTZ26126D6rtU81gy4Cjl77i4auE64Xaw4XiPJGIic
	 derMC/A86Vs9GBT8uNUNoPrxYuuiMy5tmvukGIYzwQ9AoHIYeMVgS6h+/BmG6BUmWV
	 5Aub2TBJbg8Upt0KAEMYfZXMNal6Pzoe1Z3Q4P8BXmF7EvY5/V0x7ie2ii4bX/IY/R
	 CcnjcvvBGxZEA==
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 13 Dec 2025 07:39:14 +0900
Subject: [PATCH RFC 2/6] sunrpc: remove special handling of NULL pool from
 svc_start/stop_kthreads()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251213-nfsd-dynathread-v1-2-de755e59cbc4@kernel.org>
References: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
In-Reply-To: <20251213-nfsd-dynathread-v1-0-de755e59cbc4@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=En+G5End2AK7R9Jp9jH88aqH0V7NIQgAbC6srDNX1fM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpPJmoAa2yTOUtJ6P9idQv872HMKEYxxzFgfI04
 OPhnOXdIXKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaTyZqAAKCRAADmhBGVaC
 FVxnD/9nn+oTWCUNdxFkMZY7aCdTLByi1MSUP0/2eoTVNdqOcXtpKk9kkxXK1u01YJs3vuPDTS9
 TU34miZWs3ICC9MzmUdv/ZSPR/7O1oyBMoRqdZ5OvhoGkcGtvjfteVCdx3u6HXmUbYWkOml/wxk
 cytr8EOZ0isvKX1fNI8LejYaEyN0yKH0wIyxh48dve57H9U4feO7aqQErqnVpE+7432DGQCDg46
 f9GufuwY0TPvW0Ry6w7duTH979aNQrzdTAro2n8NlbMZaXRbYtxQ2ucHf+J15jXP7DHIOSEGeUO
 fcn0Qr+HY7dzfvIBflVWD9WgYkmOfvBqi87ZvAT8n1XmtEco9lAW/QLtmWPIzNuX3xO5WrhyBa0
 GQSLogZu+Nu2gBs5zIC4J1/YEQp/POiBZOzSIfE/ZbTaN/zUmripHl2kfFqzkRHhU+MPsjrB6Ry
 xZuI5EJhMBn77T1qpIDuK7QvpepDDP2wrW0I7gcLs1aOIATY6PejLMy5mhoIHquTIsz56vUKi0d
 Pmqb28lkHcKx4vAdMcWqBFYLQZWVriRpCZk0/xFkp9vNvXejblqC/L/4/4cDDnLiPz2GkJkBtr0
 Jk28tEOvCIiIqu0H5Ecgh+vIoby9NN5jVjNWgeUz7KihTPZAXTKxWOh9oYjNvJiYdCVjGbwhiwq
 q3JgvvlcPBqJSgA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that svc_set_num_threads() handles distributing the threads among
the available pools, remove the special handling of a NULL pool pointer
from svc_start_kthreads() and svc_stop_kthreads().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/sunrpc/svc.c | 53 +++++++----------------------------------------------
 1 file changed, 7 insertions(+), 46 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 3fe5a7f8e57e3fa3837265ec06884b357d5373ff..3484c587a108e6f34e5c23edaf8f3a3c169c9e4a 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -763,53 +763,19 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
-static struct svc_pool *
-svc_pool_next(struct svc_serv *serv, struct svc_pool *pool, unsigned int *state)
-{
-	return pool ? pool : &serv->sv_pools[(*state)++ % serv->sv_nrpools];
-}
-
-static struct svc_pool *
-svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
-		unsigned int *state)
-{
-	struct svc_pool *pool;
-	unsigned int i;
-
-	pool = target_pool;
-
-	if (!pool) {
-		for (i = 0; i < serv->sv_nrpools; i++) {
-			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
-			if (pool->sp_nrthreads)
-				break;
-		}
-	}
-
-	if (pool && pool->sp_nrthreads) {
-		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
-		return pool;
-	}
-	return NULL;
-}
-
 static int
 svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
 	struct svc_rqst	*rqstp;
 	struct task_struct *task;
-	struct svc_pool *chosen_pool;
-	unsigned int state = serv->sv_nrthreads-1;
 	int node;
 	int err;
 
 	do {
 		nrservs--;
-		chosen_pool = svc_pool_next(serv, pool, &state);
-		node = svc_pool_map_get_node(chosen_pool->sp_id);
+		node = svc_pool_map_get_node(pool->sp_id);
 
-		rqstp = svc_prepare_thread(serv, chosen_pool, node);
+		rqstp = svc_prepare_thread(serv, pool, node);
 		if (!rqstp)
 			return -ENOMEM;
 		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
@@ -821,7 +787,7 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 
 		rqstp->rq_task = task;
 		if (serv->sv_nrpools > 1)
-			svc_pool_map_set_cpumask(task, chosen_pool->sp_id);
+			svc_pool_map_set_cpumask(task, pool->sp_id);
 
 		svc_sock_update_bufs(serv);
 		wake_up_process(task);
@@ -840,16 +806,11 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 static int
 svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 {
-	unsigned int state = serv->sv_nrthreads-1;
-	struct svc_pool *victim;
-
 	do {
-		victim = svc_pool_victim(serv, pool, &state);
-		if (!victim)
-			break;
-		svc_pool_wake_idle_thread(victim);
-		wait_on_bit(&victim->sp_flags, SP_VICTIM_REMAINS,
-			    TASK_IDLE);
+		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
+		svc_pool_wake_idle_thread(pool);
+		wait_on_bit(&pool->sp_flags, SP_VICTIM_REMAINS, TASK_IDLE);
 		nrservs++;
 	} while (nrservs < 0);
 	return 0;

-- 
2.52.0


