Return-Path: <linux-nfs+bounces-5062-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CD093CD21
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 06:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D7011F22535
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 04:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E642135B;
	Fri, 26 Jul 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXOxuNdD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="275w3RpU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AXOxuNdD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="275w3RpU"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D326AFB
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 04:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721966408; cv=none; b=Izx8bcSebo8XWLQkLVYlTyx5tLAgERNVIHqN8W2OAPaEZptm1hPxRyMyG0N/547wN8HJDnihoAtpAEcNg+eSU3W+kgB3+AkdU7FL6BaEHk2ly1ku0HoeSSApgCPrFLujaW5PrWBzemveQoPbOqEC3DF17nJbsvwcyjgiBweSM5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721966408; c=relaxed/simple;
	bh=OKjvT3oIWOX2TAN7FOL4Tsyi/zVnGYjB824YHo0m66Q=;
	h=Content-Type:MIME-Version:From:To:cc:Subject:Date:Message-id; b=VmLDRZzrwJMn5vKUBOAYXdwyoirAfmZKuQIgcd8UswayDm0tMcqE3U295PZF8APC8WALpxS7Jy4CkcXRisgM85zWZUB+RkzRELg8kyk12JUmZseGoQy7s+yFtGuuLYFkgiULF5f73yWFf7AR4yRrR6wViBfvYezFsk/rAFZveBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXOxuNdD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=275w3RpU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=AXOxuNdD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=275w3RpU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6A551FC85;
	Fri, 26 Jul 2024 04:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721966404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qPFBa4I76Q7mJ7Xqwy7AyB66tN74n0/wfGqgFIS3gYU=;
	b=AXOxuNdDsMa8nlOsi32R3pm4JwSejAZ4+HhhyNKnKs8COUuKvKQl2oADAjR15cxjztXRyj
	GTrxhPRiuRFj2ZDTMNU2Fcmcz8xVkbeMiBt27pFtOh1vT+cdX4MLENyksvHO1Ab5mgSg5z
	qtDO3SKsEo4LSzSVTGWiWDMJyk+zXSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721966404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qPFBa4I76Q7mJ7Xqwy7AyB66tN74n0/wfGqgFIS3gYU=;
	b=275w3RpUTTie17w0XLbeUE1OFcevYOA/XDw75dEetYE5g5huSjMyP0vyjz5xiX4Le5jl2j
	/JXSHTf0ZE4RpnDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1721966404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qPFBa4I76Q7mJ7Xqwy7AyB66tN74n0/wfGqgFIS3gYU=;
	b=AXOxuNdDsMa8nlOsi32R3pm4JwSejAZ4+HhhyNKnKs8COUuKvKQl2oADAjR15cxjztXRyj
	GTrxhPRiuRFj2ZDTMNU2Fcmcz8xVkbeMiBt27pFtOh1vT+cdX4MLENyksvHO1Ab5mgSg5z
	qtDO3SKsEo4LSzSVTGWiWDMJyk+zXSE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1721966404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qPFBa4I76Q7mJ7Xqwy7AyB66tN74n0/wfGqgFIS3gYU=;
	b=275w3RpUTTie17w0XLbeUE1OFcevYOA/XDw75dEetYE5g5huSjMyP0vyjz5xiX4Le5jl2j
	/JXSHTf0ZE4RpnDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44C9013939;
	Fri, 26 Jul 2024 04:00:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8WBaOkEfo2Z7bQAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 26 Jul 2024 04:00:01 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>, "Jeff Layton" <jlayton@kernel.org>
cc: "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
 "Olga Kornievskaia" <kolga@netapp.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Steve Dickson" <steved@redhat.com>
Subject: [PATCH] sunrpc: document locking rules for svc_exit_thread()
Date: Fri, 26 Jul 2024 13:59:55 +1000
Message-id: <172196639503.18529.16126598330625338469@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-1.10 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Spam-Flag: NO
X-Spam-Score: -1.10



The locking required for svc_exit_thread() is not obvious, so document
it in a kdoc comment.

Signed-off-by: NeilBrown <neilb@suse.de>
---

Rather than repost patch 5/14 of my recent set for dynamic thread
management, I decided to provide this as an independent patch which
could usefully be inserted into the series before 5/14.  That will make
that patch easier to understand/review.

NeilBrown


 net/sunrpc/svc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index 26b6e73fc0de..4c3df893c532 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -955,6 +955,20 @@ void svc_rqst_release_pages(struct svc_rqst *rqstp)
 	}
 }
 
+/**
+ * svc_exit_thread - finalise the termination of a sunrpc server thread
+ * @rqstp: the svc_rqst which represents the thread.
+ *
+ * When a thread started with svc_new_thread() exits it must call
+ * svc_exit_thread() as its last act.  This must be done with the
+ * service mutex held.  Normally this is held by a DIFFERENT thread, the
+ * one that is calling svc_set_num_threads() and which will wait for
+ * SP_VICTIM_REMAINS to be cleared before dropping the mutex.  If the
+ * thread exits for any reason other than svc_thread_should_stop()
+ * returning %true (which indicated that svc_set_num_threads() is
+ * waiting for it to exit), then it must take the service mutex itself,
+ * which can only safely be done using mutex_try_lock().
+ */
 void
 svc_exit_thread(struct svc_rqst *rqstp)
 {
-- 
2.44.0


