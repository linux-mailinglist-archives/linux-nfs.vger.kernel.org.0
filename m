Return-Path: <linux-nfs+bounces-5183-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D294004E
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 23:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9CD28311F
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2024 21:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C271891AA;
	Mon, 29 Jul 2024 21:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K0eHMlEy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IxQVE8jU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="K0eHMlEy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IxQVE8jU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97421186E29
	for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2024 21:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722288172; cv=none; b=F8ThZPaso6OsoWBPl5Sq3uTKMrXo1QhDCd+afQAA2HtFCzsP0qbwaLbheztmYZAcIWq9YxSOaqVK3vunRCmO+TsR8AMYL9Wi9QiRklJxunvHXbH6PCb6cAzI3MC3yIncbuAqycNKkIIsjyMF56kEMzGSRZOdFIlrKNWnOfHIRco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722288172; c=relaxed/simple;
	bh=FzyOlBl0UUq8N5HLUIjZKwZxVQP0eJswvUvoCf7aPqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJR1sj5Fn5wafPOaN4QLysPaLrmZHtM33OUlRbGaeh0BuHaf9iXiQMHTVqsUj+pfL/z0FhOiXOwiOdp/bLBzU6mvSBEgEzeNiz/eVPVmEUB3pzoJpX2UWHWBLL09GyaT2TubSXk5KaSMcIUYmgPSZWubyIj07+Z6JPv2a2RYSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K0eHMlEy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IxQVE8jU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=K0eHMlEy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IxQVE8jU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B7CA21FBDB;
	Mon, 29 Jul 2024 21:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722288168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp76BDRusRW7r/r/iuCS47Y3786u6RETwt6xyJVlybU=;
	b=K0eHMlEyLPOa9q1H+l7gXVUYPrU7ny+HsVbcnotBWJi5IqFYav7A3c/+ltVfxyDAI1mSPJ
	Z9S0t8FdL1pU3PS3niRgkvJGwXFylMnAe8zTeXXAhUg2r2p/USvp9akm3Xmw73HjmiddiM
	+k0yEzRnnItLlmiPt/zuKokfldJ55o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722288168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp76BDRusRW7r/r/iuCS47Y3786u6RETwt6xyJVlybU=;
	b=IxQVE8jUDgHaktwZbi8cdFTG/SyHKz7YTZpqXOHH/P7ugK6iFQ9ADrd12OMcgzYiLlaUoS
	F0H9eDcRtq93IeAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=K0eHMlEy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=IxQVE8jU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1722288168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp76BDRusRW7r/r/iuCS47Y3786u6RETwt6xyJVlybU=;
	b=K0eHMlEyLPOa9q1H+l7gXVUYPrU7ny+HsVbcnotBWJi5IqFYav7A3c/+ltVfxyDAI1mSPJ
	Z9S0t8FdL1pU3PS3niRgkvJGwXFylMnAe8zTeXXAhUg2r2p/USvp9akm3Xmw73HjmiddiM
	+k0yEzRnnItLlmiPt/zuKokfldJ55o0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1722288168;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sp76BDRusRW7r/r/iuCS47Y3786u6RETwt6xyJVlybU=;
	b=IxQVE8jUDgHaktwZbi8cdFTG/SyHKz7YTZpqXOHH/P7ugK6iFQ9ADrd12OMcgzYiLlaUoS
	F0H9eDcRtq93IeAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0FA0138A7;
	Mon, 29 Jul 2024 21:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xgOfFSYIqGbvVwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 29 Jul 2024 21:22:46 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/2] sunrpc: merge svc_rqst_alloc() into svc_prepare_thread()
Date: Tue, 30 Jul 2024 07:19:41 +1000
Message-ID: <20240729212217.30747-2-neilb@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729212217.30747-1-neilb@suse.de>
References: <20240729212217.30747-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B7CA21FBDB
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]

The only caller of svc_rqst_alloc() is svc_prepare_thread().  So merge
the one into the other and simplify.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index e3e7c514a30c..ae31ffea7a14 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -678,7 +678,7 @@ svc_rqst_free(struct svc_rqst *rqstp)
 }
 
 static struct svc_rqst *
-svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
+svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 {
 	struct svc_rqst	*rqstp;
 
@@ -706,21 +706,6 @@ svc_rqst_alloc(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!svc_init_buffer(rqstp, serv->sv_max_mesg, node))
 		goto out_enomem;
 
-	return rqstp;
-out_enomem:
-	svc_rqst_free(rqstp);
-	return NULL;
-}
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
 	serv->sv_nrthreads += 1;
 	pool->sp_nrthreads += 1;
 
@@ -730,6 +715,10 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	list_add_rcu(&rqstp->rq_all, &pool->sp_all_threads);
 
 	return rqstp;
+
+out_enomem:
+	svc_rqst_free(rqstp);
+	return NULL;
 }
 
 /**
@@ -810,8 +799,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
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


