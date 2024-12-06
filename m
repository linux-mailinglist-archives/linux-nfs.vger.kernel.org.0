Return-Path: <linux-nfs+bounces-8370-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2709E6400
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC01882826
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F05156871;
	Fri,  6 Dec 2024 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fdfa36Zy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4/fQRaMK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Fdfa36Zy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4/fQRaMK"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FED15B0F2
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451580; cv=none; b=Nqd3qfEUFMZFm5FxcFyWcuxjGZFLoj/eblfQVV65KxDZ54dOvVTltXKs1Dkl4gqLZ9SeZqIGLjNj6p4uJlbUQ/i+MLd7Ms9seXH6g5UjqM/qp1rrQZAQC9MjULP7wGClSUgjyGBMM81kmkeEvlRfE7ZQUK0y7JYQuWhR/IGQ+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451580; c=relaxed/simple;
	bh=cVNSAV/8JQMWoju+MYo2Yf/t7TMOEgLlhBSFGtjzZ1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/nup21ltIDmyMK++havAUzlW1+GPanAGwC2Zdmdy9g+ZFGycftoLCLXyKVUkgwP3g4zPZC3qkUQH7QQJ0vDMZHofCwjHAA18D8ybyyemT1lq6T4krGXIivgB/R0VIQqL232MKWEJ+E+trgMjCjm9lcpwDgcMJJG+23kyNmDygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fdfa36Zy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4/fQRaMK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Fdfa36Zy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4/fQRaMK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D36121167;
	Fri,  6 Dec 2024 02:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb/uGc2lPIIxNp5vwEKRcfwzOVAv9zyFlaa3o15TvQ=;
	b=Fdfa36Zy7YdxOhjTAWV0ivW40Ycp7b2dowlAEmt3F9gOxyI5xX5ZkmMsrUFJVCzvS3mkW+
	pULfPSEBAWBZl83NuM2C7sRBV/1X1n+aGVNYVCX/xyOaujZMC7KztB2Kyl6vHHfTbB2v/b
	oKaHKdeaODUVdUzOcKRS462w5cMykdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb/uGc2lPIIxNp5vwEKRcfwzOVAv9zyFlaa3o15TvQ=;
	b=4/fQRaMK3AIjdUspzqcBrKrqCsr4YI1HsUFo6O5+ue0JMDJhKuwIvaKIZvO6dicryeU6pP
	J5RPp3ECo8ArqJCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb/uGc2lPIIxNp5vwEKRcfwzOVAv9zyFlaa3o15TvQ=;
	b=Fdfa36Zy7YdxOhjTAWV0ivW40Ycp7b2dowlAEmt3F9gOxyI5xX5ZkmMsrUFJVCzvS3mkW+
	pULfPSEBAWBZl83NuM2C7sRBV/1X1n+aGVNYVCX/xyOaujZMC7KztB2Kyl6vHHfTbB2v/b
	oKaHKdeaODUVdUzOcKRS462w5cMykdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UNb/uGc2lPIIxNp5vwEKRcfwzOVAv9zyFlaa3o15TvQ=;
	b=4/fQRaMK3AIjdUspzqcBrKrqCsr4YI1HsUFo6O5+ue0JMDJhKuwIvaKIZvO6dicryeU6pP
	J5RPp3ECo8ArqJCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4480713A15;
	Fri,  6 Dec 2024 02:19:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0ZF6OjdfUmdSJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:35 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 07/11] sunrpc: discard rpc_wait_bit_killable()
Date: Fri,  6 Dec 2024 13:15:33 +1100
Message-ID: <20241206021830.3526922-8-neilb@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

rpc_wait_bit_kill() currently differs from bit_wait() in the it returns
-ERESTARTSYS rather then -EINTR.  The sunrpc and nfs code never really
care about the difference.  The error could get up to user-space but it
is only generated when a process is being killed, in which case there is
no user-space to see the difference.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sched.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index 1b710ffc7ad6..0618dc586009 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -274,14 +274,6 @@ void rpc_destroy_wait_queue(struct rpc_wait_queue *queue)
 }
 EXPORT_SYMBOL_GPL(rpc_destroy_wait_queue);
 
-static int rpc_wait_bit_killable(struct wait_bit_key *key, int mode)
-{
-	schedule();
-	if (signal_pending_state(mode, current))
-		return -ERESTARTSYS;
-	return 0;
-}
-
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
 static void rpc_task_set_debuginfo(struct rpc_task *task)
 {
@@ -343,7 +335,7 @@ static int rpc_complete_task(struct rpc_task *task)
 int rpc_wait_for_completion_task(struct rpc_task *task)
 {
 	return out_of_line_wait_on_bit(&task->tk_runstate, RPC_TASK_ACTIVE,
-			rpc_wait_bit_killable, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
+			bit_wait, TASK_KILLABLE|TASK_FREEZABLE_UNSAFE);
 }
 EXPORT_SYMBOL_GPL(rpc_wait_for_completion_task);
 
@@ -982,12 +974,12 @@ static void __rpc_execute(struct rpc_task *task)
 		/* sync task: sleep here */
 		trace_rpc_task_sync_sleep(task, task->tk_action);
 		status = out_of_line_wait_on_bit(&task->tk_runstate,
-				RPC_TASK_QUEUED, rpc_wait_bit_killable,
+				RPC_TASK_QUEUED, bit_wait,
 				TASK_KILLABLE|TASK_FREEZABLE);
 		if (status < 0) {
 			/*
 			 * When a sync task receives a signal, it exits with
-			 * -ERESTARTSYS. In order to catch any callbacks that
+			 * -EINTR. In order to catch any callbacks that
 			 * clean up after sleeping on some queue, we don't
 			 * break the loop here, but go around once more.
 			 */
-- 
2.47.0


