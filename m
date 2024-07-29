Return-Path: <linux-nfs+bounces-5124-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8C293EB18
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 04:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C29EB2096C
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 02:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759E34AED1;
	Mon, 29 Jul 2024 02:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFxJfoK2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYbjLAmV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qFxJfoK2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vYbjLAmV"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69491B86D6
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722219711; cv=none; b=bY3g7YJODEaRi4j3UcTzYDTe4TvMU1yKmw9eCIwJy9TBwLPNiMW7wDCPdx4HUBRO6MX2M6p0itdBiGQsWtZ7uBzmeeE5rGUX0RXhjiBATTxF5MUQ+v3hcjGM5pECNnJGPEEy9fvM9X1ciItjLkjSyL1sLQFuz3aW0O8atZ2tqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722219711; c=relaxed/simple;
	bh=7/SwZmY3VyeUlGh3AwOWWE9m6kQoqiFL6r6tXpKYdK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUE8lfdxiLn4E8Xt76I1R21BGxPiEefhXaopbinPBMG5NPIaDDxtbL6gVgZ+nhK2NkwK6au+L2JW9uao5n5WFF1JnKsJ0gMXjlqFGdjyJ0j7oIqALwusD1bPjT9HfhtcJmHiMixS5UAT3+jq/DhEKyYBMYbLGBG4wZaJTmwMtK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFxJfoK2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYbjLAmV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qFxJfoK2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vYbjLAmV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B043A1F76E;
	Mon, 29 Jul 2024 02:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiRjc+teGG4xrmHHPEd9Ykd5Imy84Zc8fGnDk1bsD9U=;
	b=qFxJfoK2hFVd22VNSw7Fv2PYPkGrqGXOv3sgJlrVkFhvL0ICoGC92aBuK2fFxQtghi6LpK
	COtxQnLeNGoAXAmAeq+mSRc7cX4ONUo5WsViyg8Mmcm5aSSdLcjuogKQHVZt5VeBPf8i5Y
	FiFgrVvBi/7YC9i7MgSwzklNreHQb/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiRjc+teGG4xrmHHPEd9Ykd5Imy84Zc8fGnDk1bsD9U=;
	b=vYbjLAmVrr+2wVGSk5uhuFQQQByI0YIUSVxk7tROhJ8XIc3PAtf/uFgJeO7VwBvPcFkGj9
	3KO0S0ZftIOcJXCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qFxJfoK2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vYbjLAmV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722219707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiRjc+teGG4xrmHHPEd9Ykd5Imy84Zc8fGnDk1bsD9U=;
	b=qFxJfoK2hFVd22VNSw7Fv2PYPkGrqGXOv3sgJlrVkFhvL0ICoGC92aBuK2fFxQtghi6LpK
	COtxQnLeNGoAXAmAeq+mSRc7cX4ONUo5WsViyg8Mmcm5aSSdLcjuogKQHVZt5VeBPf8i5Y
	FiFgrVvBi/7YC9i7MgSwzklNreHQb/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722219707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yiRjc+teGG4xrmHHPEd9Ykd5Imy84Zc8fGnDk1bsD9U=;
	b=vYbjLAmVrr+2wVGSk5uhuFQQQByI0YIUSVxk7tROhJ8XIc3PAtf/uFgJeO7VwBvPcFkGj9
	3KO0S0ZftIOcJXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86ED113704;
	Mon, 29 Jul 2024 02:21:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MZwcD7n8pmbaHQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 02:21:45 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
Date: Mon, 29 Jul 2024 12:18:20 +1000
Message-ID: <20240729022126.4450-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729022126.4450-1-neilb@suse.de>
References: <20240729022126.4450-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B043A1F76E
X-Spam-Score: -2.81
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

From: NeilBrown <neil@brown.name>

The only caller of svc_rqst_alloc() is svc_prepare_thread().  So merge
the one into the other and simplify.

Signed-off-by: NeilBrown <neil@brown.name>
---
 include/linux/sunrpc/svc.h |  2 --
 net/sunrpc/svc.c           | 28 ++++++++--------------------
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 23617da0e565..01383ea077ad 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -403,8 +403,6 @@ void svc_rpcb_cleanup(struct svc_serv *serv, struct net *net);
 int svc_bind(struct svc_serv *serv, struct net *net);
 struct svc_serv *svc_create(struct svc_program *, unsigned int,
 			    int (*threadfn)(void *data));
-struct svc_rqst *svc_rqst_alloc(struct svc_serv *serv,
-					struct svc_pool *pool, int node);
 bool		   svc_rqst_replace_page(struct svc_rqst *rqstp,
 					 struct page *page);
 void		   svc_rqst_release_pages(struct svc_rqst *rqstp);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index d9cda1e53a01..c0e91bea72e7 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -633,8 +633,8 @@ svc_release_buffer(struct svc_rqst *rqstp)
 			put_page(rqstp->rq_pages[i]);
 }
 
-struct svc_rqst *
-svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
+static struct svc_rqst *
+svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
 
@@ -662,22 +662,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
 		goto out_enomem;
 
-	return rqstp;
-out_enomem:
-	svc_rqst_free(rqstp);
-	return NULL;
-}
-EXPORT_SYMBOL_GPL(svc_rqst_alloc);
-
-static struct svc_rqst *
-svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
-{
-	struct svc_rqst	*rqstp;
-
-	rqstp = svc_rqst_alloc(serv, pool, node);
-	if (!rqstp)
-		return ERR_PTR(-ENOMEM);
-
 	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads += 1;
 	spin_unlock_bh(&serv->sv_lock);
@@ -690,6 +674,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
 
 	return rqstp;
+
+out_enomem:
+	svc_rqst_free(rqstp);
+	return NULL;
 }
 
 /**
@@ -779,8 +767,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		node = svc_pool_map_get_node(chosen_pool->sp_id);
 
 		rqstp = svc_prepare_thread(serv, chosen_pool, node);
-		if (IS_ERR(rqstp))
-			return PTR_ERR(rqstp);
+		if (!rqstp)
+			return -ENOMEM;
 		task = kthread_create_on_node(serv->sv_threadfn, rqstp,
 					      node, "%s", serv->sv_name);
 		if (IS_ERR(task)) {
-- 
2.44.0


