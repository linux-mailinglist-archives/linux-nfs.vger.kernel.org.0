Return-Path: <linux-nfs+bounces-7375-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AF49ABBB4
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 04:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CE491C2292A
	for <lists+linux-nfs@lfdr.de>; Wed, 23 Oct 2024 02:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2D49659;
	Wed, 23 Oct 2024 02:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rJviWy2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lzXNj9xm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rJviWy2t";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lzXNj9xm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F12132103
	for <linux-nfs@vger.kernel.org>; Wed, 23 Oct 2024 02:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729651372; cv=none; b=EisdzC5mBmc80YKOJ7nQWqPETSlLSCGp6PbnCFN0vS0q/IBHobydKlt4ePPOXMwCEBVRx9NfhhwX94Qf7c4KTMNHmrdCZATWJW8ZX/rJbQAicYLgHJtD+LWYzgOnjtj9R2zcHYW1Urdgk/KHy9lSkMthRymN/4olFZ3BpzEGAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729651372; c=relaxed/simple;
	bh=R0QWJCHGnLosegOS6+CDcchbtgV6xLPMRHXQpughKFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0SnJ9vHMN9zouYHQ2dftHhyb6Vdjx25hUoHAn9VP0fV99PZQtLrBTYKsS35P668dmX8gxqTxsvlH8hqNc9y47kUAZ9oMe3Z05vsA8N3pS7RrkMpSJoRCggaWoRrR+ekWsddDpxxz8l9NXxq61Xex5hABEX2n3wmLSbFvcQ0jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rJviWy2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lzXNj9xm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rJviWy2t; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lzXNj9xm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 288F41F83F;
	Wed, 23 Oct 2024 02:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh5mvXC8c4OCgkYvqWMXEw+6Hi8aQ6F5ZL1ewgBnx1Q=;
	b=rJviWy2t6xA6uFfIu6J6t6D4LbJjRCxHoJgtpLW6xE9DHiueuOWVOS9nMpJgHcNWlbAOha
	yX2w5n6ndllp5toqbKHZkEOmMEe347b95y9v++ioxJ6NTIFpFJLLAYQ81UHc3DpjEvwATV
	5LHVojLYcWW/51EXb+17a9uVsRLzLSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh5mvXC8c4OCgkYvqWMXEw+6Hi8aQ6F5ZL1ewgBnx1Q=;
	b=lzXNj9xmYMV9cWgltw1Q51OKqOwcQ8oeCrdlkosxXHI6hKaSmkkpEbTt0SXcGxk8sD4NDp
	qnOSTRauXnBgTiBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729651369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh5mvXC8c4OCgkYvqWMXEw+6Hi8aQ6F5ZL1ewgBnx1Q=;
	b=rJviWy2t6xA6uFfIu6J6t6D4LbJjRCxHoJgtpLW6xE9DHiueuOWVOS9nMpJgHcNWlbAOha
	yX2w5n6ndllp5toqbKHZkEOmMEe347b95y9v++ioxJ6NTIFpFJLLAYQ81UHc3DpjEvwATV
	5LHVojLYcWW/51EXb+17a9uVsRLzLSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729651369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jh5mvXC8c4OCgkYvqWMXEw+6Hi8aQ6F5ZL1ewgBnx1Q=;
	b=lzXNj9xmYMV9cWgltw1Q51OKqOwcQ8oeCrdlkosxXHI6hKaSmkkpEbTt0SXcGxk8sD4NDp
	qnOSTRauXnBgTiBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1270513A63;
	Wed, 23 Oct 2024 02:42:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fY+NLqZiGGcjOgAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 23 Oct 2024 02:42:46 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/6] SUNRPC: move nrthreads counting to start/stop threads.
Date: Wed, 23 Oct 2024 13:37:01 +1100
Message-ID: <20241023024222.691745-2-neilb@suse.de>
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
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
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

sp_nrthreads and sv_nrthreads are the number of threads that have been
explicitly requested.  Future patches will allow extra threads to be
created as needed.

So move the updating of these fields to code which is for updating
configuration rather that code that is for starting/stopping threads.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 79879b7d39cb..bd4f02b34f44 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -713,9 +713,6 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 
 	rqstp->rq_err = -EAGAIN; /* No error yet */
 
-	serv->sv_nrthreads += 1;
-	pool->sp_nrthreads += 1;
-
 	/* Protected by whatever lock the service uses when calling
 	 * svc_set_num_threads()
 	 */
@@ -815,6 +812,8 @@ svc_start_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 			svc_exit_thread(rqstp);
 			return PTR_ERR(task);
 		}
+		serv->sv_nrthreads += 1;
+		chosen_pool->sp_nrthreads += 1;
 
 		rqstp->rq_task = task;
 		if (serv->sv_nrpools > 1)
@@ -844,6 +843,8 @@ svc_stop_kthreads(struct svc_serv *serv, struct svc_pool *pool, int nrservs)
 		victim = svc_pool_victim(serv, pool, &state);
 		if (!victim)
 			break;
+		victim->sp_nrthreads -= 1;
+		serv->sv_nrthreads -= 1;
 		svc_pool_wake_idle_thread(victim);
 		wait_on_bit(&victim->sp_flags, SP_VICTIM_REMAINS,
 			    TASK_IDLE);
@@ -959,8 +960,6 @@ svc_exit_thread(struct svc_rqst *rqstp)
 
 	list_del_rcu(&rqstp->rq_all);
 
-	pool->sp_nrthreads -= 1;
-	serv->sv_nrthreads -= 1;
 	svc_sock_update_bufs(serv);
 
 	svc_rqst_free(rqstp);
-- 
2.46.0


