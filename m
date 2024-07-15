Return-Path: <linux-nfs+bounces-4900-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A891C930F1D
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60884281346
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257AF6AB8;
	Mon, 15 Jul 2024 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QDuLgegs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6LGtjzE+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="QDuLgegs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6LGtjzE+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97671175A6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029721; cv=none; b=DR7BSA9EsbpL8Pw21q7SOMqFYYvmJ2G1Da4GC+zimUCujNCE2CQbCwyuV+mAIFsDXIYMl1wMkea1NDNOxEfdXRXpemQxptTNov4qi7doXiXgSSVh2fZKLNcneajq/MF4Esly241zcZmiee4lrEt5XEzMfL5rNC6QsbSeTbGiLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029721; c=relaxed/simple;
	bh=jbe3R80TgjNy421fNmKGFS8ZOzHZJkUbxgEj1dygTKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e44om9A5PqpnzQfkroN9g8FPuJwYVqJLxe/yu1w+QtS1uPRwJxs4cvAc/mrv8jzh0f64E/fcDbiIfpd9S/dEFJRh4ma9u3+bLmwWBDdeNeMmjeyc/Hvgm19ww8UFjR6Duze8IH59mIJWz4TZIsRAH96Sw5oey/erS6S/frXmtPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QDuLgegs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6LGtjzE+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=QDuLgegs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6LGtjzE+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C17B81F7B2;
	Mon, 15 Jul 2024 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsecy/yC1BWeMJJWw1HEobEKDsEPySMCLYSyZ8CMAKc=;
	b=QDuLgegsq6KhIe0rMYyCXmAO9u1FuGCZxx+jDGGB5iqJbS+EXYHIchaxEVj9ZhPWt5Po0D
	9xFI46gGeFd8d2WG5Z011kmh6+HRlAPoMd9v/QjaxZUQPxhOtsr4GbXgOiDz2YYHNfBBhx
	pUFE44CZbvevFidlqI41UwQ7TNVONTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsecy/yC1BWeMJJWw1HEobEKDsEPySMCLYSyZ8CMAKc=;
	b=6LGtjzE+TxgYfkwntwA41IZRblJYrEdci6maRaXsdUz8x3gRD/8VZ0p1y+rJms7vg8ZIjI
	DEMPOkt9DIXxq4AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QDuLgegs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6LGtjzE+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsecy/yC1BWeMJJWw1HEobEKDsEPySMCLYSyZ8CMAKc=;
	b=QDuLgegsq6KhIe0rMYyCXmAO9u1FuGCZxx+jDGGB5iqJbS+EXYHIchaxEVj9ZhPWt5Po0D
	9xFI46gGeFd8d2WG5Z011kmh6+HRlAPoMd9v/QjaxZUQPxhOtsr4GbXgOiDz2YYHNfBBhx
	pUFE44CZbvevFidlqI41UwQ7TNVONTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029717;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gsecy/yC1BWeMJJWw1HEobEKDsEPySMCLYSyZ8CMAKc=;
	b=6LGtjzE+TxgYfkwntwA41IZRblJYrEdci6maRaXsdUz8x3gRD/8VZ0p1y+rJms7vg8ZIjI
	DEMPOkt9DIXxq4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6460C137EB;
	Mon, 15 Jul 2024 07:48:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ey3wBlPUlGYHbgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:35 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 08/14] SUNRPC: move nrthreads counting to start/stop threads.
Date: Mon, 15 Jul 2024 17:14:21 +1000
Message-ID: <20240715074657.18174-9-neilb@suse.de>
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
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Queue-Id: C17B81F7B2

sp_nrthreads and sv_nrthreads are the number of threads that have been
explicitly requested.  Future patches will allow extra threads to be
created as needed.

So move the updating of these fields to code which is for updating
configuration rather that code that is for starting/stopping threads.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index f4fc3d82e2bb..d814b2cfa84f 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -721,9 +721,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
 
-	serv->sv_nrthreads += 1;
-	pool->sp_nrthreads += 1;
-
 	/* Protected by whatever lock the service uses when calling
 	 * svc_set_num_threads()
 	 */
@@ -818,6 +815,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);
 		}
+		serv->sv_nrthreads += 1;
+		chosen_pool->sp_nrthreads += 1;
 
 		rqstp->rq_task = task;
 		if (serv->sv_nrpools > 1)
@@ -840,6 +839,8 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		victim = svc_pool_victim(serv, pool, &state);
 		if (!victim)
 			break;
+		victim->sp_nrthreads -= 1;
+		serv->sv_nrthreads -= 1;
 		svc_pool_wake_idle_thread(victim);
 		wait_on_bit(&victim->sp_flags, SP_VICTIM_REMAINS,
 			    TASK_IDLE);
@@ -941,8 +942,6 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	list_del_rcu(&rqstp->rq_all);
 
-	pool->sp_nrthreads -= 1;
-	serv->sv_nrthreads -= 1;
 	svc_sock_update_bufs(serv);
 
 	svc_rqst_free(rqstp);
-- 
2.44.0


