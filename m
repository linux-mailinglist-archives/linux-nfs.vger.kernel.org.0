Return-Path: <linux-nfs+bounces-8364-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A99E63F5
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC15284690
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140FA2AE9A;
	Fri,  6 Dec 2024 02:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jEb+/j43";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2onqoU0b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jEb+/j43";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2onqoU0b"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61845144D0A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451541; cv=none; b=vE6DX/PWu9skcuuqy1OLMs2cJ3uixLtbG5PDtnjHEA6EyQ1lE5msTEi2POf7BXBfIPaF4WBZQtBUKlw1ud7f+2e0+uuuLvig1rQgFBVVfM64gRp+wkjJLHI3VB6SCDAVEkqhdOIebdc+a/pgx0GFDoVvlcuppFdKlynDir3NpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451541; c=relaxed/simple;
	bh=SA3JW+AA26fE0F/SCgxbjIalWKn4xyp6uWrjWeaubbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzEbK8nZg9EDxH/rQ9wYwsnN8PLS2VRRSdhYmugFlgJRKkwipenVBJEKq4IRm+oHi2VDbj/pomkB9mByk3jSCYVFc7GYpRJk4iPXMhmvsDWf2Vgy7kesF2BRdvu7V7KMl37vejGS9jCiwNanvqCBHnV2MA51D5SzzKAiSllP2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jEb+/j43; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2onqoU0b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jEb+/j43; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2onqoU0b; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 937E221167;
	Fri,  6 Dec 2024 02:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgamCzczPldmZUFP0T+S22CFvHf/ibs+mRyZ0EnLDQM=;
	b=jEb+/j43RIXIZxCgxmUSOKlVAFmca6ZSvppKJ/WoMXtgwJ1HrGNn+mASmqo1tjPMhRHJvp
	mU7RJnWcUaVWuPPGlKDIAvjKcaWRXwpc853FC3B5CvebLgnS5XmHA1GJ/LGKC+6n2S9rGg
	pDmSPRsEnqPQyGwJ0BqXA1SnIQksEzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgamCzczPldmZUFP0T+S22CFvHf/ibs+mRyZ0EnLDQM=;
	b=2onqoU0bn1JsTNSIUWYSzY8rk7XNSexa4ig2drTdP0+EBntBh374FHTInQhlvrLmXPLCKJ
	hh+Dc403RuNE43Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jEb+/j43";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=2onqoU0b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgamCzczPldmZUFP0T+S22CFvHf/ibs+mRyZ0EnLDQM=;
	b=jEb+/j43RIXIZxCgxmUSOKlVAFmca6ZSvppKJ/WoMXtgwJ1HrGNn+mASmqo1tjPMhRHJvp
	mU7RJnWcUaVWuPPGlKDIAvjKcaWRXwpc853FC3B5CvebLgnS5XmHA1GJ/LGKC+6n2S9rGg
	pDmSPRsEnqPQyGwJ0BqXA1SnIQksEzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgamCzczPldmZUFP0T+S22CFvHf/ibs+mRyZ0EnLDQM=;
	b=2onqoU0bn1JsTNSIUWYSzY8rk7XNSexa4ig2drTdP0+EBntBh374FHTInQhlvrLmXPLCKJ
	hh+Dc403RuNE43Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5DD4F13A15;
	Fri,  6 Dec 2024 02:18:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsAXBRBfUmceJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:18:56 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 01/11] sunrpc: remove explicit barrier from rpc_make_runnable()
Date: Fri,  6 Dec 2024 13:15:27 +1100
Message-ID: <20241206021830.3526922-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206021830.3526922-1-neilb@suse.de>
References: <20241206021830.3526922-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 937E221167
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The wake_up_bit() interface is fragile as a barrier is often required
as is present here.  clear_and_wake_up_bit() is a more robust interface
as it includes the barrier and is appropriate here.

This patch rearranges the code slightly and makes use of
clear_and_wake_up_bit().  This removes some of the need to understand
barriers.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/sched.h |  2 ++
 net/sunrpc/sched.c           | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index fec1e8a1570c..76e1c0194376 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -168,6 +168,8 @@ enum {
 #define RPC_IS_QUEUED(t)	test_bit(RPC_TASK_QUEUED, &(t)->tk_runstate)
 #define rpc_set_queued(t)	set_bit(RPC_TASK_QUEUED, &(t)->tk_runstate)
 #define rpc_clear_queued(t)	clear_bit(RPC_TASK_QUEUED, &(t)->tk_runstate)
+#define rpc_clear_and_wake_queued(t)	clear_and_wake_up_bit(RPC_TASK_QUEUED,	\
+							      &(t)->tk_runstate)
 
 #define RPC_IS_ACTIVATED(t)	test_bit(RPC_TASK_ACTIVE, &(t)->tk_runstate)
 
diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index cef623ea1506..1b710ffc7ad6 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -361,17 +361,14 @@ EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
 static void rpc_make_runnable(struct workqueue_struct *wq,
 		struct rpc_task *task)
 {
-	bool need_wakeup = !rpc_test_and_set_running(task);
-
-	rpc_clear_queued(task);
-	if (!need_wakeup)
-		return;
-	if (RPC_IS_ASYNC(task)) {
+	if (rpc_test_and_set_running(task))
+		rpc_clear_queued(task);
+	else if (RPC_IS_ASYNC(task)) {
+		rpc_clear_queued(task);
 		INIT_WORK(&task->u.tk_work, rpc_async_schedule);
 		queue_work(wq, &task->u.tk_work);
 	} else {
-		smp_mb__after_atomic();
-		wake_up_bit(&task->tk_runstate, RPC_TASK_QUEUED);
+		rpc_clear_and_wake_queued(task);
 	}
 }
 
-- 
2.47.0


