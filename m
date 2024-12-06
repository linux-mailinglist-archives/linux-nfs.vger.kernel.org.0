Return-Path: <linux-nfs+bounces-8377-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17FD9E6482
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA781884A7A
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818591E522;
	Fri,  6 Dec 2024 02:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jE1Scpd/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hW7h2SP7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jE1Scpd/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hW7h2SP7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE7140360
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733453880; cv=none; b=exK7HZB6dpGVxbHrWfkq+rr7eDxAzU2VN/dEk0KJgjnkwdlG0aupPaKucqm8WMD1GVkZkmemIJmcfUO2wpglO31P8eQyuDCeXeiKFFFBxsZh8JEkBrzCISJkaTXW+/6o9aBZo8cCl0Qj4M0D6cCKrnJnq6J+hp8c/4/F8KxXLmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733453880; c=relaxed/simple;
	bh=kpDHrP9ZbHmWILMNnWGKLsfrKLILwo70XhZBY0Hb5v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ho5+YJ8kD4Hc5U1NA/W/eZQZhaI1A+a0hgNsSqMua04h+jyyoElpuuCUUGu3WHWQktOUYAnGGiXetxJO9M+xydcXEJ1ONKTPpvUT5LkrwE0a8XLANtU9sMa7IN7iCfdcNpQg1BhweWHFGMZ1DFV6e8HXmqcnye31h+5WAgvs3+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jE1Scpd/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hW7h2SP7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jE1Scpd/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hW7h2SP7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 03FD11F38E;
	Fri,  6 Dec 2024 02:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntyVFw/plnxB1lVLpZe28z65vAsm2rkDJOrfGHtFHaM=;
	b=jE1Scpd/4poJLRHvLRzYYw7OMGJ8mxuOb7BHtfmSu+G4/tuJVQFJ8W5dYfkoOYlxtStgjG
	9kBhAUWDW6Ppzr3gUsGtUq0PpTlIAOaC5lQ6fu+SCM01pf7yzUb9YHuvs9LyO2rlih+TCG
	qvsLUv0PK+reYMKzumHfyIblNEug5DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntyVFw/plnxB1lVLpZe28z65vAsm2rkDJOrfGHtFHaM=;
	b=hW7h2SP7umCJZIlyw1IffT1CHB98R/rVI3GS/1QLU1iJxlMOMVEfjAlCtz8ossFse0ub2g
	VW5zWEamdevZL2Dw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="jE1Scpd/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hW7h2SP7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733453877; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntyVFw/plnxB1lVLpZe28z65vAsm2rkDJOrfGHtFHaM=;
	b=jE1Scpd/4poJLRHvLRzYYw7OMGJ8mxuOb7BHtfmSu+G4/tuJVQFJ8W5dYfkoOYlxtStgjG
	9kBhAUWDW6Ppzr3gUsGtUq0PpTlIAOaC5lQ6fu+SCM01pf7yzUb9YHuvs9LyO2rlih+TCG
	qvsLUv0PK+reYMKzumHfyIblNEug5DI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733453877;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntyVFw/plnxB1lVLpZe28z65vAsm2rkDJOrfGHtFHaM=;
	b=hW7h2SP7umCJZIlyw1IffT1CHB98R/rVI3GS/1QLU1iJxlMOMVEfjAlCtz8ossFse0ub2g
	VW5zWEamdevZL2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4F913647;
	Fri,  6 Dec 2024 02:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VwEkJDJoUmfELAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:57:54 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 2/2] sunrpc/svc: use store_release_wake_up()
Date: Fri,  6 Dec 2024 13:55:53 +1100
Message-ID: <20241206025723.3537777-3-neilb@suse.de>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206025723.3537777-1-neilb@suse.de>
References: <20241206025723.3537777-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 03FD11F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

svc_thread_init_status() contains an open-coded
store_release_wake_up().  It is cleaner to use that function directly
rather than needing to remember the barrier.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e68fecf6eab5..e4f09f58d58c 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -327,12 +327,7 @@ static inline bool svc_thread_should_stop(struct svc_rqst *rqstp)
  */
 static inline void svc_thread_init_status(struct svc_rqst *rqstp, int err)
 {
-	rqstp->rq_err = err;
-	/* memory barrier ensures assignment to error above is visible before
-	 * waitqueue_active() test below completes.
-	 */
-	smp_mb();
-	wake_up_var(&rqstp->rq_err);
+	store_release_wake_up(&rqstp->rq_err, err);
 	if (err)
 		kthread_exit(1);
 }
-- 
2.47.0


