Return-Path: <linux-nfs+bounces-7380-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86219ABBBA
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 04:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06BE7B21BE0
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFEC45C1C;
	Wed, 23 Oct 2024 02:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Reb+8l4h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+7vtrqy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Reb+8l4h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g+7vtrqy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B543AB9
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 02:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651408; cv=none; b=BeOmqj9EeSwtUr3TRIKVXa46jCfunCGhtB2yc+f7WJw0zATrVh8DXoD90ICKIygzdHqrCQMBEjFxlXUwM+SSQuaBfIp9QzxgdYsgZH/MDB2l2fvakjlLAtIgaKXv1kvnLX9C0SOrGCY6UGk9yrVVnl0Okfb1jgDnWDzxwMmxA4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651408; c=relaxed/simple;
	bh=RLkKmu7UbbwjjBlkUh0fXZrdQdGhUfIsOQSIMhyehCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtxgugrJbUre9jNOPc10gXOhSRV0kAFSAleyhMygODaWscIWowIt/+3yH+rMCUwBz9WaiZqJyis1lbOISK6bPHDQV24KchLcmSJn7QOl8nZqqs2yYDFRAsuHzVy8tOgjjTkFTc7KK1lDuBWwkb2AmDNBqYSxsdXmv6yqJSJsQPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Reb+8l4h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+7vtrqy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Reb+8l4h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g+7vtrqy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBBE41FD6C;
	Wed, 23 Oct 2024 02:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MrjqwMdeSgI+QnmJd87IgiWz2gslumvoKMQSlvZtT4=;
	b=Reb+8l4hd+q5dAVR6oZLhUx/IvxdxawHsILXpSg7uzoxej4SEQPTDZ6NznpFTz4IIIFyuH
	WeUxLKYbk4uLIjcxY+R/zH6U80/it5F9p6nNtZVAfvE/a6jJf4T/FhBdB/XIpGEk9aWvG/
	bGZqbsRCpZEUx/49kLO9wuGR0ZRQm9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MrjqwMdeSgI+QnmJd87IgiWz2gslumvoKMQSlvZtT4=;
	b=g+7vtrqy0MIa9v9vuLhWEgthk8/nLCTyj4+gSKRHy7aPgNL3B5kfYKdK7yieO7M9ejSi55
	h8H5Cb7S9/P0HyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MrjqwMdeSgI+QnmJd87IgiWz2gslumvoKMQSlvZtT4=;
	b=Reb+8l4hd+q5dAVR6oZLhUx/IvxdxawHsILXpSg7uzoxej4SEQPTDZ6NznpFTz4IIIFyuH
	WeUxLKYbk4uLIjcxY+R/zH6U80/it5F9p6nNtZVAfvE/a6jJf4T/FhBdB/XIpGEk9aWvG/
	bGZqbsRCpZEUx/49kLO9wuGR0ZRQm9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MrjqwMdeSgI+QnmJd87IgiWz2gslumvoKMQSlvZtT4=;
	b=g+7vtrqy0MIa9v9vuLhWEgthk8/nLCTyj4+gSKRHy7aPgNL3B5kfYKdK7yieO7M9ejSi55
	h8H5Cb7S9/P0HyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5CF413A63;
	Wed, 23 Oct 2024 02:43:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YzvUGspiGGdNOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 02:43:22 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 6/6] sunrpc: introduce possibility that requested number of threads is different from actual
Date: Wed, 23 Oct 2024 13:37:06 +1100
Message-ID: <20241023024222.691745-7-neilb@suse.de>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241023024222.691745-1-neilb@suse.de>
References: <20241023024222.691745-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

New fields sp_nractual and sv_nractual track how many actual threads are
running.  sp_nrhtreads and sv_nrthreads will be the number that were
explicitly request.  Currently nractually == nrthreads.

sv_nractual is used for sizing UDP incoming socket space - in the rare
case that UDP is used.  This is because each thread might need to keep a
request in the skbs.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |  6 ++++--
 net/sunrpc/svc.c           | 22 +++++++++++++++-------
 net/sunrpc/svcsock.c       |  2 +-
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 9d288a673705..3f2c90061b4a 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,7 +36,8 @@
 struct svc_pool {
 	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	struct lwq		sp_xprts;	/* pending transports */
-	unsigned int		sp_nrthreads;	/* # of threads in pool */
+	unsigned int		sp_nrthreads;	/* # of threads requested for pool */
+	unsigned int		sp_nractual;	/* # of threads running */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
@@ -71,7 +72,8 @@ struct svc_serv {
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
 	unsigned int		sv_nprogs;	/* Number of sv_programs */
-	unsigned int		sv_nrthreads;	/* # of server threads */
+	unsigned int		sv_nrthreads;	/* # of server threads requested*/
+	unsigned int		sv_nractual;	/* # of running threads */
 	unsigned int		sv_max_payload;	/* datagram payload size */
 	unsigned int		sv_max_mesg;	/* max_payload + 1 page for overheads */
 	unsigned int		sv_xdrsize;	/* XDR buffer size */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index bd4f02b34f44..d332f9d3d875 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -781,8 +781,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
 	}
 
 	if (pool && pool->sp_nrthreads) {
-		set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
-		set_bit(SP_NEED_VICTIM, &pool->sp_flags);
+		if (pool->sp_nrthreads <= pool->sp_nractual) {
+			set_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
+			set_bit(SP_NEED_VICTIM, &pool->sp_flags);
+			pool->sp_nractual -= 1;
+			serv->sv_nractual -= 1;
+		}
 		return pool;
 	}
 	return NULL;
@@ -803,6 +807,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		chosen_pool = svc_pool_next(serv, pool, &state);
 		node = svc_pool_map_get_node(chosen_pool->sp_id);
 
+		serv->sv_nrthreads += 1;
+		chosen_pool->sp_nrthreads += 1;
+
+		if (chosen_pool->sp_nrthreads <= chosen_pool->sp_nractual)
+			continue;
+
 		rqstp = svc_prepare_thread(serv, chosen_pool, node);
 		if (!rqstp)
 			return -ENOMEM;
@@ -812,8 +822,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);
 		}
-		serv->sv_nrthreads += 1;
-		chosen_pool->sp_nrthreads += 1;
+		serv->sv_nractual += 1;
+		chosen_pool->sp_nractual += 1;
 
 		rqstp->rq_task = task;
 		if (serv->sv_nrpools > 1)
@@ -850,6 +860,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			    TASK_IDLE);
 		nrservs++;
 	} while (nrservs < 0);
+	svc_sock_update_bufs(serv);
 	return 0;
 }
 
@@ -955,13 +966,10 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 void
 svc_exit_thread(struct svc_rqst *rqstp)
 {
-	struct svc_serv	*serv = rqstp->rq_server;
 	struct svc_pool	*pool = rqstp->rq_pool;
 
 	list_del_rcu(&rqstp->rq_all);
 
-	svc_sock_update_bufs(serv);
-
 	svc_rqst_free(rqstp);
 
 	clear_and_wake_up_bit(SP_VICTIM_REMAINS, &pool->sp_flags);
diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 825ec5357691..191dbc648bd0 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -588,7 +588,7 @@ static int svc_udp_recvfrom(struct svc_rqst *rqstp)
 	     * provides an upper bound on the number of threads
 	     * which will access the socket.
 	     */
-	    svc_sock_setbufsize(svsk, serv->sv_nrthreads + 3);
+	    svc_sock_setbufsize(svsk, serv->sv_nractual + 3);
 
 	clear_bit(XPT_DATA, &svsk->sk_xprt.xpt_flags);
 	err = kernel_recvmsg(svsk->sk_sock, &msg, NULL,
-- 
2.46.0


