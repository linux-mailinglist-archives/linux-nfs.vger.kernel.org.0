Return-Path: <linux-nfs+bounces-17509-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B32CFAB72
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9043368DB6
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7BA3358AF;
	Tue,  6 Jan 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j82ynTYi"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B518133B6DF;
	Tue,  6 Jan 2026 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726008; cv=none; b=ctbJM2hjE7QT3akmWcIy8/2q/cWm3LK/TusNl12cHWW33KLFpkPAG+H/uVu2vXmKB7381wKapbGial1pWYq8OT8/5aHyiEXcyWC4JCeW4xsrk0ndlGSEWMRehdnWmax71o9/VJculgiFf+80IXmqoUpCmSosCgcRR/2Y7b1YaXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726008; c=relaxed/simple;
	bh=mwyhhRH6pzQr7weMb5AqsaR4ToxswDBoGg+67XdCruw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzQD+0IHFCJSs6B1Yt+4OJosMbWMjCNsD0d55q55NAkPIvRe/zrO6IpaIrr12k825pC6jWys95oryBB+qGNkHwf9TS/m0uiisqkmQrXhPv+5Hkz9s+pKNAP8pBl8lDhKVXyhds4L7G61ysIDcx1xXW5VwS8NOy/VmCFTg3nsO1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j82ynTYi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FF6C2BC86;
	Tue,  6 Jan 2026 19:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726008;
	bh=mwyhhRH6pzQr7weMb5AqsaR4ToxswDBoGg+67XdCruw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j82ynTYivl2axbCzDQr6S3a1d+0Jb1ZSrdgRkyzCP+9rhxg+KNxqYA3rGK2rOlPoX
	 mxwOXFqiUglG+0ceddxAZVe2Trefi/J7E5taGcD6JyPmk0W05lD8/fGr8hBcBHIl17
	 wnrYa0sjZaKM2XEZKNmyBwioGgKb2zrzcBueGGWnKWIRDoEx+KYtMkqxCL0/HFmojj
	 oCKBAJ9qqBYdQmQY3l7EukCDEKTdI5KmNMIipSrgJS8l9kjfZS5CL+IUDbAmTzPiCX
	 5WQCKLJFbXtKOJ/IzzR+GUOzlx68e2dDsF+ggJyhQY9JB/dvfwfW6CzNH5s8/SNqDJ
	 gNKL6RCSnzo/w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:44 -0500
Subject: [PATCH v2 2/8] sunrpc: remove special handling of NULL pool from
 svc_start/stop_kthreads()
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-2-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3170; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=mwyhhRH6pzQr7weMb5AqsaR4ToxswDBoGg+67XdCruw=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVuzJwJR8dFZGRgn3/gunxOR50q1i+lAiHiPl
 R+dADE224OJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1bswAKCRAADmhBGVaC
 Fa8DD/0Wcf+cMqSybon9tjXNQnF8UUr/x1boMjTxxpDE18wOTzUO6u+7wFK7FyCNiDYkd1y1cxH
 p5svI8gLP5iszH+qRob2udNLhs4OPIgoKCbF2w0FA6w85ER1FxRuZi/skz57qKkqVJzhG+e8dlk
 PS+o8uYN2reWDd9sqbJWRq75WX8uwf0typowzUxy3z44lpBapdovssdgaYr+1dQwUPzETFNgJu9
 IrSwAYXAdV+9jtYniRMSrvmGrEPh6piPHkvfmlcvxt5gDyCb3qyxVy9xryMdDMQM90f+XBiMbCi
 mt6AmIi3MMb/3l7R2ZQ5iX6Igx6GVlifH8GMIHp+I/3/Wuv5HI827hfoVpG+xNQ80TZeVALiXI2
 k+CxZYOQqh/tAgQzWOivcB+22xRvJoBbMqA5xBTtztaXlOe7irnfx15WBkzjVmQQIojeq4/Z4IY
 3WcSgo+swxqW0oOlbTYcrSbL64p7Vpzk1wgJB/rx2dyFLdvqLv7V/TcCKlyQLFbSkxeuDmJsx/U
 6JVdRiSs3NdqL66jneK1T6+rb222Bk1193qCzj9BdQavmA/WQ9aTyvTZQLeBelXiiyE+UyD2c1p
 fmkNBp3+7xSIOUUA0pu0jqSMhor4CeficT6H+jAqsG/0SA87v+3YvQDQ1mqjAPzXfwuUhGOFZWG
 bgOb9WZvI2AEo9w==
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
index cd9d4f8b75aeb6ffa08ce84a0b82da7fd37e6fbf..fd52ebec0655f2289d792f4aac02859d90d290fd 100644
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


