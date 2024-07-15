Return-Path: <linux-nfs+bounces-4904-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D36930F22
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F6B1C21072
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676AD175A6;
	Mon, 15 Jul 2024 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OtmEte89";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="arz/tj4K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OtmEte89";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="arz/tj4K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAAB6AB8
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029752; cv=none; b=D4dJOheYwKUm/1lEod5lAPqd122iar/9vsmNCpuvv7x6fwFWxjktNM4a4ldB4E4jpM1t+xR92q7QPowSTL2bd7gyAJsdA4/A7CwLAiCwk64wCZFnubrRnkxH4jnGRuNdWWguJBCZ8/dVqmZuRfBJqVwHJLpWr5ftak791wej1W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029752; c=relaxed/simple;
	bh=4CavPxHnvjgwRqk3b5jd7+VUlCYG8HEpNIq2rFjgU/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te4HsJIHOdEcsYtZxRHVaOzUh5FqlsmVEzAaayOyc9kcunq1Z7dQbgqVWA7iHX7N7nibi8iGi/A5AJNlwod+nE7UPMJwPLJlG+PQXXCKlLSK6Eyf1VykGwVY/8KHdgTmcutz/JCboQBUfASWCyBOVlglVhR/moddqogMfNh88MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OtmEte89; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=arz/tj4K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OtmEte89; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=arz/tj4K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 08E1521A03;
	Mon, 15 Jul 2024 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxItJadAbe2VKEiMTtOyf0T3cnXp9s78Ly9lPd+I4FU=;
	b=OtmEte89xn/wf1uIUnJE7T08oC4tGTTTJr7UCgIccv1G51M4a6gDusSc1lFR6KsI/Qa2Dr
	BYI2tv/9WH1lwKnubA1xC2v4taej2UX3PpSIKgCz+hgA5PKjLbRloTBhw/ttRR26hSmVZU
	ZRCsvzzavyNGY6SQQ7K8Q0ojXgQaw44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxItJadAbe2VKEiMTtOyf0T3cnXp9s78Ly9lPd+I4FU=;
	b=arz/tj4KCXpC63HVUiHlxJuxWVRcF+FRXx8B5kg5ebwPJC9JsMDMa6gTSrviNkw1P62vgn
	xw6fdBB94zbNE2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029749; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxItJadAbe2VKEiMTtOyf0T3cnXp9s78Ly9lPd+I4FU=;
	b=OtmEte89xn/wf1uIUnJE7T08oC4tGTTTJr7UCgIccv1G51M4a6gDusSc1lFR6KsI/Qa2Dr
	BYI2tv/9WH1lwKnubA1xC2v4taej2UX3PpSIKgCz+hgA5PKjLbRloTBhw/ttRR26hSmVZU
	ZRCsvzzavyNGY6SQQ7K8Q0ojXgQaw44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029749;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yxItJadAbe2VKEiMTtOyf0T3cnXp9s78Ly9lPd+I4FU=;
	b=arz/tj4KCXpC63HVUiHlxJuxWVRcF+FRXx8B5kg5ebwPJC9JsMDMa6gTSrviNkw1P62vgn
	xw6fdBB94zbNE2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94FEE137EB;
	Mon, 15 Jul 2024 07:49:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wbHgEnLUlGZJbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:49:06 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 12/14] sunrpc: introduce possibility that requested number of threads is different from actual
Date: Mon, 15 Jul 2024 17:14:25 +1000
Message-ID: <20240715074657.18174-13-neilb@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

New fields sp_nractual and sv_nractual track how many actual threads are
running.  sp_nrhtreads and sv_nrthreads will be the number that were
explicitly request.  Currently nractually == nrthreads.

sv_nractual is used for sizing UDP incoming socket space - in the rare
case that UDP is used.  This is because each thread might need to keep a
request in the skbs.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |  4 +++-
 net/sunrpc/svc.c           | 22 +++++++++++++++-------
 net/sunrpc/svcsock.c       |  2 +-
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 0b414af448e0..363105fc6326 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -36,6 +36,7 @@ struct svc_pool {
 	unsigned int		sp_id;		/* pool id; also node id on NUMA */
 	struct lwq		sp_xprts;	/* pending transports */
 	unsigned int		sp_nrthreads;	/* # of threads in pool */
+	unsigned int		sp_nractual;	/* # of threads running */
 	struct list_head	sp_all_threads;	/* all server threads */
 	struct llist_head	sp_idle_threads; /* idle server threads */
 
@@ -69,7 +70,8 @@ struct svc_serv {
 	struct svc_program *	sv_program;	/* RPC program */
 	struct svc_stat *	sv_stats;	/* RPC statistics */
 	spinlock_t		sv_lock;
-	unsigned int		sv_nrthreads;	/* # of server threads */
+	unsigned int		sv_nrthreads;	/* # of server threads requested*/
+	unsigned int		sv_nractual;	/* # of running threads */
 	unsigned int		sv_maxconn;	/* max connections allowed or
 						 * '0' causing max to be based
 						 * on number of threads. */
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d814b2cfa84f..33c1a7793f63 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -785,8 +785,12 @@ svc_pool_victim(struct svc_serv *serv, struct svc_pool *target_pool,
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
@@ -806,6 +810,12 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		chosen_pool = svc_pool_next(serv, pool, &state);
 		node = svc_pool_map_get_node(chosen_pool->sp_id);
 
+		serv->sv_nrthreads += 1;
+		chosen_pool->sp_nrthreads += 1;
+
+		if (chosen_pool->sp_nrthreads <= chosen_pool->sp_nractual)
+			continue;
+
 		rqstp = svc_prepare_thread(serv, chosen_pool, node);
 		if (IS_ERR(rqstp))
 			return PTR_ERR(rqstp);
@@ -815,8 +825,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);
 		}
-		serv->sv_nrthreads += 1;
-		chosen_pool->sp_nrthreads += 1;
+		serv->sv_nractual += 1;
+		chosen_pool->sp_nractual += 1;
 
 		rqstp->rq_task = task;
 		if (serv->sv_nrpools > 1)
@@ -846,6 +856,7 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			    TASK_IDLE);
 		nrservs++;
 	} while (nrservs < 0);
+	svc_sock_update_bufs(serv);
 	return 0;
 }
 
@@ -937,13 +948,10 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
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
2.44.0


