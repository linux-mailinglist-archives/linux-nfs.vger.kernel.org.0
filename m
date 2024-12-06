Return-Path: <linux-nfs+bounces-8365-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FC9E63F6
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EAC8283E34
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8621428E3;
	Fri,  6 Dec 2024 02:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aqd8ZJpL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UzlC98a+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Aqd8ZJpL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UzlC98a+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AE92AE9A
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451549; cv=none; b=St97FSWshq8F+O6Pmb3SNI/UXggYYKgoKNTo+wXPkqoVZn1F0vv1cK4/WZN80raVKk3prwl5XSD3J7QexzRml3OeMgdvbMpHPLbq0N9rtyJYbrVzsl4FhQhCtRvHmvkg8N6keWYUFnrDAhgl8PPqcTBGOGf4ZpybbVxLP2C/C60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451549; c=relaxed/simple;
	bh=+YbWomCgnXXpUgzZuxQJh5i08zVqfcGb9CqxEHAzE/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxtXRg0xbN8lX0mf/Pyve7p9rplRdlmU5gu/my9exVov/u6UQndd/91B1kL0uKMBGbVCb85p5gkO6bTb1kczBfD15Wm60wa4JioSHicLe8SUJ/B6FE5lUCF2LOjXX2DMS3bxK1BXhDWK7I7Ib2LL9iL2x4L2m1/yGdpNsGH5u3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aqd8ZJpL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UzlC98a+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Aqd8ZJpL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UzlC98a+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B12F21167;
	Fri,  6 Dec 2024 02:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNBC1gB/qOTmoV+IZiYV63k8b5K0HavsTnvteNXsQ44=;
	b=Aqd8ZJpLBtgS+I0VVNBzqwDpWtu6a6D7ONnXPz4vUqrwatJJMB9O5GR99IxFCBhymusAOV
	7JAHRkGMSvPcINtMeQlrWaUjY1HJywelUoYFnS9Zi/TjceMcShfoIrDN0fs1zqXyN+OtTK
	PkXxsXRWWSAUINwlYSbWKM4buJtZbMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNBC1gB/qOTmoV+IZiYV63k8b5K0HavsTnvteNXsQ44=;
	b=UzlC98a+ve9nVX1wBAbiEcG+X9nAI0jd26xmc4Owo3l0HZfJKEVn0KDe2VqLcIy6A18nbE
	jcVRbKbJM0sx/OCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNBC1gB/qOTmoV+IZiYV63k8b5K0HavsTnvteNXsQ44=;
	b=Aqd8ZJpLBtgS+I0VVNBzqwDpWtu6a6D7ONnXPz4vUqrwatJJMB9O5GR99IxFCBhymusAOV
	7JAHRkGMSvPcINtMeQlrWaUjY1HJywelUoYFnS9Zi/TjceMcShfoIrDN0fs1zqXyN+OtTK
	PkXxsXRWWSAUINwlYSbWKM4buJtZbMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451546;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNBC1gB/qOTmoV+IZiYV63k8b5K0HavsTnvteNXsQ44=;
	b=UzlC98a+ve9nVX1wBAbiEcG+X9nAI0jd26xmc4Owo3l0HZfJKEVn0KDe2VqLcIy6A18nbE
	jcVRbKbJM0sx/OCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0615B13A15;
	Fri,  6 Dec 2024 02:19:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0a9AKxhfUmckJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:04 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 02/11] sunrpc: use clear_and_wake_up_bit() for XPRT_LOCKED.
Date: Fri,  6 Dec 2024 13:15:28 +1100
Message-ID: <20241206021830.3526922-3-neilb@suse.de>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

wake_up_bit() requires a full memory barrier between the bit being
cleared and wake_up_bit() being called, else a race can result in wake
up not being sent despite another task preparing to wait.

Some paths between the clear_bit and the wake_up_bit do not have a full
barrier, such as when xprt_reserve_xprt() finds that XPRT_WRITE_SPACE is
set and clears XPRT_LOCKED before returning to xprt_release_write and
thence xprt_autoclose().

This doesn't appear to be a problem in practice as no failure reports
are known, but it seems prudent to send the wakeup immediately after the
bit is cleared and to use clear_and_wake_up_bit() which includes the
required barriers.

In most cases, if nothing is waiting for the bit the waitqueue_active()
test in wake_up_bit() will mean this does minimal extra work - though as
the waitqueue can be shared, this is not guaranteed.

Using clear_and_wake_up_bit() makes the code "obviously correct".

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprt.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 09f245cda526..40385362e982 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -248,7 +248,7 @@ static void xprt_clear_locked(struct rpc_xprt *xprt)
 {
 	xprt->snd_task = NULL;
 	if (!test_bit(XPRT_CLOSE_WAIT, &xprt->state))
-		clear_bit_unlock(XPRT_LOCKED, &xprt->state);
+		clear_and_wake_up_bit(XPRT_LOCKED, &xprt->state);
 	else
 		queue_work(xprtiod_workqueue, &xprt->task_cleanup);
 }
@@ -744,7 +744,6 @@ static void xprt_autoclose(struct work_struct *work)
 	clear_bit(XPRT_CLOSE_WAIT, &xprt->state);
 	xprt->ops->close(xprt);
 	xprt_release_write(xprt, NULL);
-	wake_up_bit(&xprt->state, XPRT_LOCKED);
 	memalloc_nofs_restore(pflags);
 }
 
@@ -911,7 +910,6 @@ void xprt_unlock_connect(struct rpc_xprt *xprt, void *cookie)
 	xprt_schedule_autodisconnect(xprt);
 out:
 	spin_unlock(&xprt->transport_lock);
-	wake_up_bit(&xprt->state, XPRT_LOCKED);
 }
 EXPORT_SYMBOL_GPL(xprt_unlock_connect);
 
-- 
2.47.0


