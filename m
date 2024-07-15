Return-Path: <linux-nfs+bounces-4897-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BBA930F14
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BBDD281370
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4C1175A6;
	Mon, 15 Jul 2024 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m15JLQl0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m2DnhXSr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="m15JLQl0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m2DnhXSr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1A66AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029699; cv=none; b=YFRS4pMWBLslSn0pXha8cCMcGFrbr8z0TeGo2ikaRTslIxz0qo0LI+Ep53ZpAwtpwksSVk23dQRADcrdui3xE9mdU1WBRE+YoXJoBddZEB6e2U/axk2954t931MLBI5zphLGJE8UNdESorAhblmDQ01FraZA+Elvy4Dn4eO/q28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029699; c=relaxed/simple;
	bh=99Z/wZz4TmUVBP36hmX82NjN1edwTRO82OONO0MSXmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KGETT93q0XA/oFlnBnVKcVSvRXMJydR3k3p0NcSLJVREaeD9iPd3AA8dqJOy1t8YfDcDfj2n4sl7dPVvWXhyCE/+1fLRROl/oVJqMeHjDnbBbA0EdnxiZoa5U7yoxqCux2ITpIkUqEz7CHBtxQ95Yg/FQPB4zk/aU3/D+7lvigU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m15JLQl0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m2DnhXSr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=m15JLQl0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m2DnhXSr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6BC1A1F7B2;
	Mon, 15 Jul 2024 07:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znITT74L4Ep/dK3Tfsb6tWxfoOcXiEs8IHfp00tR+s0=;
	b=m15JLQl0vsp411jgVhBqjMb7sYUI0RQvOeIb0HP0kPMlSuPIq0Hs8wHcL99Hko1n0NR2NP
	9rOicBydsFeKAI7MlJ9Bvh3h2dICKVpJHStZoBnu+nfhyazHhbxvBPzY1Nm2UkoD3Cqt5/
	IAPlrMjdawCXnenJ8XzOBB0HuLRte30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znITT74L4Ep/dK3Tfsb6tWxfoOcXiEs8IHfp00tR+s0=;
	b=m2DnhXSryaLl9Ke/seLwCoFaZ5UbOHRrZLv4OHIbDgdtjAW832YWuuXqWY0r0mH+KlA8b2
	pXGGNBfDGwYPRYCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=m15JLQl0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m2DnhXSr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znITT74L4Ep/dK3Tfsb6tWxfoOcXiEs8IHfp00tR+s0=;
	b=m15JLQl0vsp411jgVhBqjMb7sYUI0RQvOeIb0HP0kPMlSuPIq0Hs8wHcL99Hko1n0NR2NP
	9rOicBydsFeKAI7MlJ9Bvh3h2dICKVpJHStZoBnu+nfhyazHhbxvBPzY1Nm2UkoD3Cqt5/
	IAPlrMjdawCXnenJ8XzOBB0HuLRte30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znITT74L4Ep/dK3Tfsb6tWxfoOcXiEs8IHfp00tR+s0=;
	b=m2DnhXSryaLl9Ke/seLwCoFaZ5UbOHRrZLv4OHIbDgdtjAW832YWuuXqWY0r0mH+KlA8b2
	pXGGNBfDGwYPRYCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04B31137EB;
	Mon, 15 Jul 2024 07:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WtQLKz3UlGbobQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:13 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 05/14] sunrpc: change sp_nrthreads from atomic_t to unsigned int.
Date: Mon, 15 Jul 2024 17:14:18 +1000
Message-ID: <20240715074657.18174-6-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240715074657.18174-1-neilb@suse.de>
References: <20240715074657.18174-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6BC1A1F7B2
X-Spam-Flag: NO
X-Spam-Score: 0.99
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.99 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spamd-Bar: /

sp_nrthreads is only ever accessed under the service mutex
  nlmsvc_mutex nfs_callback_mutex nfsd_mutex
so these is no need for it to be an atomic_t.

The fact that all code using it is single-threaded means that we can
simplify svc_pool_victim and remove the temporary elevation of
sp_nrthreads.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c           |  2 +-
 fs/nfsd/nfssvc.c           |  2 +-
 include/linux/sunrpc/svc.h |  4 ++--
 net/sunrpc/svc.c           | 31 +++++++++++--------------------
 4 files changed, 15 insertions(+), 24 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5b0f2e0d7ccf..d85b6d1fa31f 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1769,7 +1769,7 @@ int nfsd_nl_threads_get_doit(struct sk_buff *skb, struct genl_info *info)
 			struct svc_pool *sp = &nn->nfsd_serv->sv_pools[i];
 
 			err = nla_put_u32(skb, NFSD_A_SERVER_THREADS,
-					  atomic_read(&sp->sp_nrthreads));
+					  sp->sp_nrthreads);
 			if (err)
 				goto err_unlock;
 		}
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 4438cdcd4873..7377422a34df 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -641,7 +641,7 @@ int nfsd_get_nrthreads(int n, int *nthreads, struct net *net)
 
 	if (serv)
 		for (i = 0; i < serv->sv_nrpools && i < n; i++)
-			nthreads[i] = atomic_read(&serv->sv_pools[i].sp_nrthreads);
+			nthreads[i] = serv->sv_pools[i].sp_nrthreads;
 	return 0;
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e4fa25fafa97..99e9345d829e 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -33,9 +33,9 @@
  * node traffic on multi-node NUMA NFS servers.
  */
 struct svc_pool {
-	unsigned int		sp_id;	    	/* pool id; also node id on NUMA */
+	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	struct lwq		sp_xprts;	/* pending transports */
-	atomic_t		sp_nrthreads;	/* # of threads in pool */
+	unsigned int		sp_nrthreads;	/* # of threads in pool */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 072ad115ae3d..0d8588bc693c 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -725,7 +725,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
 
-	atomic_inc(&pool->sp_nrthreads);
+	pool->sp_nrthreads += 1;
 
 	/* Protected by whatever lock the service uses when calling
 	 * svc_set_num_threads()
@@ -780,31 +780,22 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
 	struct svc_pool *pool;
 	unsigned int i;
 
-retry:
 	pool = target_pool;
 
-	if (pool != NULL) {
-		if (atomic_inc_not_zero(&pool->sp_nrthreads))
-			goto found_pool;
-		return NULL;
-	} else {
+	if (!pool) {
 		for (i = 0; i < serv->sv_nrpools; i++) {
 			pool = &serv->sv_pools[--(*state) % serv->sv_nrpools];
-			if (atomic_inc_not_zero(&pool->sp_nrthreads))
-				goto found_pool;
+			if (pool->sp_nrthreads)
+				break;
 		}
-		return NULL;
 	}
 
-found_pool:
-	set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-	set_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	if (!atomic_dec_and_test(&pool->sp_nrthreads))
+	if (pool && pool->sp_nrthreads) {
+		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
 		return pool;
-	/* Nothing left in this pool any more */
-	clear_bit(SP_NEED_VICTIM, &pool->sp_flags);
-	clear_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-	goto retry;
+	}
+	return NULL;
 }
 
 static int
@@ -883,7 +874,7 @@ svc_set_num_threads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 	if (!pool)
 		nrservs -= serv->sv_nrthreads;
 	else
-		nrservs -= atomic_read(&pool->sp_nrthreads);
+		nrservs -= pool->sp_nrthreads;
 
 	if (nrservs > 0)
 		return svc_start_kthreads(serv, pool, nrservs);
@@ -953,7 +944,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	list_del_rcu(&rqstp->rq_all);
 
-	atomic_dec(&pool->sp_nrthreads);
+	pool->sp_nrthreads -= 1;
 
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
-- 
2.44.0


