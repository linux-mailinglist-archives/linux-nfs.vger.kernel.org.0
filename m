Return-Path: <linux-nfs+bounces-4898-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038A930F17
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 09:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C82B20BD2
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Jul 2024 07:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E80C13AD11;
	Mon, 15 Jul 2024 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TkqNtHi8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iia96VLe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TkqNtHi8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Iia96VLe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24649175A6
	for <linux-nfs@vger.kernel.org>; Mon, 15 Jul 2024 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721029709; cv=none; b=UmB0Hf0iR26oDXnB/bg3bJnJrKqWGwYsxgIOJeTFXG3nskNbXxCp9VgPH14/rhA9NzjYoTZ/bq6cvInIhnuMU8WULf+sLjpSzi6YuhHcDgdvUWPUkwNQlJouobkrFyxSRy17vKM5yIMu69pc2Nt2vKhrXMj1XioVhfzZbmT1VsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721029709; c=relaxed/simple;
	bh=VvoEjtc3fDoIvHWknjtpZZmysx5tdv49snIFKNA6w6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIPReUGl2DpenIM24sqw3qu7JD83xiBHyHlRdGjZSACSp/jiyyI7bLskbmdzQME7TGg2IGBCV7LcWEMv9IdwDcqUiKhuI8v9X+pLy6sHYxciozlQzcfRBWzPwWl3G3umK8JvQXFE+4duZ8PooJIy//Gomp/DSkVqU7SQnT/esb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TkqNtHi8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Iia96VLe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TkqNtHi8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Iia96VLe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C0761F7FA;
	Mon, 15 Jul 2024 07:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfxkogkznY/FiY3BUtpurKcdlYdaAoakknz608gEtBw=;
	b=TkqNtHi8CE+iV56eX9Rer6e269g4N9ynDYFBRXzWURIuLW1P+o56ESmjTnAEvFj/0YB1lf
	RMQu0RpeTiGxovOU4u6Ce7ywvkmYOSdul3YG5MmngEispvb39sjrNp+Hm2ohGgg3+gaCF3
	DL6TKyPdvmbSzhretI9Gxm3tHxI4aJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfxkogkznY/FiY3BUtpurKcdlYdaAoakknz608gEtBw=;
	b=Iia96VLev8xPz9a4ZdtuoxktVvLUaMeCYRfFaXoYsW67jFsjo5/86EDIGltl1KdvYj/0eW
	xvoUNSN+MUPe84Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TkqNtHi8;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Iia96VLe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721029706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfxkogkznY/FiY3BUtpurKcdlYdaAoakknz608gEtBw=;
	b=TkqNtHi8CE+iV56eX9Rer6e269g4N9ynDYFBRXzWURIuLW1P+o56ESmjTnAEvFj/0YB1lf
	RMQu0RpeTiGxovOU4u6Ce7ywvkmYOSdul3YG5MmngEispvb39sjrNp+Hm2ohGgg3+gaCF3
	DL6TKyPdvmbSzhretI9Gxm3tHxI4aJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721029706;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfxkogkznY/FiY3BUtpurKcdlYdaAoakknz608gEtBw=;
	b=Iia96VLev8xPz9a4ZdtuoxktVvLUaMeCYRfFaXoYsW67jFsjo5/86EDIGltl1KdvYj/0eW
	xvoUNSN+MUPe84Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF37B137EB;
	Mon, 15 Jul 2024 07:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kAPIIEfUlGb2bQAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 15 Jul 2024 07:48:23 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Steve Dickson <steved@redhat.com>
Subject: [PATCH 06/14] sunrpc: don't take ->sv_lock when updating ->sv_nrthreads.
Date: Mon, 15 Jul 2024 17:14:19 +1000
Message-ID: <20240715074657.18174-7-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim];
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
X-Rspamd-Queue-Id: 4C0761F7FA

As documented in svc_xprt.c, sv_nrthreads is protected by the service
mutex, and it does not need ->sv_lock.
(->sv_lock is needed only for sv_permsocks, sv_tempsocks, and
sv_tmpcnt).

So remove the unnecessary locking.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 0d8588bc693c..f4fc3d82e2bb 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -721,10 +721,7 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
 	if (!rqstp)
 		return ERR_PTR(-ENOMEM);
 
-	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads += 1;
-	spin_unlock_bh(&serv->sv_lock);
-
 	pool->sp_nrthreads += 1;
 
 	/* Protected by whatever lock the service uses when calling
@@ -945,10 +942,7 @@ svc_exit_thread(struct svc_rqst *rqstp)
 	list_del_rcu(&rqstp->rq_all);
 
 	pool->sp_nrthreads -= 1;
-
-	spin_lock_bh(&serv->sv_lock);
 	serv->sv_nrthreads -= 1;
-	spin_unlock_bh(&serv->sv_lock);
 	svc_sock_update_bufs(serv);
 
 	svc_rqst_free(rqstp);
-- 
2.44.0


