Return-Path: <linux-nfs+bounces-9653-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEBCA1CF71
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BB9718873C6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C264D;
	Mon, 27 Jan 2025 01:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uI3VAnVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AmJceLAo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uI3VAnVu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AmJceLAo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A381A846F
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941055; cv=none; b=hgEA/mhXR8zYwTGukpbt7wpOJ3IW5t6K+h/qJfXM3/2DKAYt2tVtspHvFnVJBXhgmLTNOqjjtApsJ5jCeYmNXFqsAWiFIrbx7R9y0UGPKNnpNHr3cL8BeAUAzU6goKhfswh2kRslsd8E89tA37f1fiRHN/I7GADKzQvRoNXZ/e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941055; c=relaxed/simple;
	bh=hpVFIxNkTwoADFO3VTp3uOPYEl9E8pocDx3JeqjBxJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mo1kfhxwMFIlaih2Vu8OsHCmyozz+93lSrag7rqw/bCOfXukiJtglWT7f31/5Uhj7mzZdD3Vu4xucb/7JbYilOoehDLYwnJSNvwBVmL0Q+q0tviHuCT/s6PJt3GcCZB19J3GUIZr7l2a0vFbWdcybs1gYKM1fTazfheg1Upx/Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uI3VAnVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AmJceLAo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uI3VAnVu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AmJceLAo; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFF202115C;
	Mon, 27 Jan 2025 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyPkhG69o++iLuxVpbL32v/xCxj2DJj65/hX9+DWokk=;
	b=uI3VAnVuIFizI/IAcZ4BXvrp8BXUKCjOLZvo6UeN0bX+wPzd2TiQkdblghfZ6Py1bwXRq+
	KsaoemFM6ytuch4vIsso5RpJaZvn9qqLCsy7LhYMJ6GoTrzCr6wTk09BmDNqasWz4Cx0Oe
	dhbFgfzYtONjI2t5ETeIUhIAc0+IKQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyPkhG69o++iLuxVpbL32v/xCxj2DJj65/hX9+DWokk=;
	b=AmJceLAow0OIAQPzKLolIlIl7+kqHzDlbUWWb/YHPQiEY2zD3WOsH0Vw7Y+TJKe+299Faj
	2EHGFoLFhGYljIDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyPkhG69o++iLuxVpbL32v/xCxj2DJj65/hX9+DWokk=;
	b=uI3VAnVuIFizI/IAcZ4BXvrp8BXUKCjOLZvo6UeN0bX+wPzd2TiQkdblghfZ6Py1bwXRq+
	KsaoemFM6ytuch4vIsso5RpJaZvn9qqLCsy7LhYMJ6GoTrzCr6wTk09BmDNqasWz4Cx0Oe
	dhbFgfzYtONjI2t5ETeIUhIAc0+IKQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gyPkhG69o++iLuxVpbL32v/xCxj2DJj65/hX9+DWokk=;
	b=AmJceLAow0OIAQPzKLolIlIl7+kqHzDlbUWWb/YHPQiEY2zD3WOsH0Vw7Y+TJKe+299Faj
	2EHGFoLFhGYljIDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62EE413782;
	Mon, 27 Jan 2025 01:24:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ez8iBjnglmegCwAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:24:09 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 7/7] nfsd: filecache: give disposal lock a unique class name.
Date: Mon, 27 Jan 2025 12:20:38 +1100
Message-ID: <20250127012257.1803314-8-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250127012257.1803314-1-neilb@suse.de>
References: <20250127012257.1803314-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

There are at least three locks in the kernel which are initialised as

  spin_Lock_init(&l->lock);

This makes them hard to differential in /proc/lock_stat.

For the lock in nfsd/filecache.c introduce a variable with a more
descriptve name so we can:

  spin_lock_init(&nfsd_fcache_disposal->lock);

and easily identify this in /proc/lock_stat.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index eb95a53f806f..af95bc381753 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -867,12 +867,13 @@ __nfsd_file_cache_purge(struct net *net)
 static struct nfsd_fcache_disposal *
 nfsd_alloc_fcache_disposal(void)
 {
-	struct nfsd_fcache_disposal *l;
+	struct nfsd_fcache_disposal *l, *nfsd_fcache_disposal;
 
 	l = kmalloc(sizeof(*l), GFP_KERNEL);
 	if (!l)
 		return NULL;
-	spin_lock_init(&l->lock);
+	nfsd_fcache_disposal = l;
+	spin_lock_init(&nfsd_fcache_disposal->lock);
 	timer_setup(&l->timer, nfsd_file_gc_worker, 0);
 	INIT_LIST_HEAD(&l->recent);
 	INIT_LIST_HEAD(&l->older);
-- 
2.47.1


