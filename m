Return-Path: <linux-nfs+bounces-2098-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0016786A34F
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4901C2508F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 23:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609D859B5F;
	Tue, 27 Feb 2024 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fK1RW/D6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4+YOQeup";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fK1RW/D6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="4+YOQeup"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D98759B68
	for <linux-nfs@vger.kernel.org>; Tue, 27 Feb 2024 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709075121; cv=none; b=eT5UOvkXQDZidTZJwlx/v1Qjuy9XkyZ8K1a3s/1/i71xVIi3ThFhyTAyjhYLaVvd3UzhSKrwIC6C/5WXff3BQRpwLJh2jgzlV9yy36LuAeZOSBLJ5GIgocUoarGYc9iHyoaUCrh3axb2OGG+5c0/43dh6gEwzWB/YW9XiTzNPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709075121; c=relaxed/simple;
	bh=e0mwxEjl3pDcB3a6YLIgwelPathMmAaPAuHINOd6c/E=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=cSFpUh/JbZmhABR0F3l/Opg3K5ugAH2LplT4KCon+m8kqAZuRA9Dz+/U8q8ISAQhDFBWwywF4KoGMev+8jclGkuirpV76BgDD4iSF4DdhswUY8XbqcNbDlOLnZ7enahtjTEzKoC8+7o0/l7xTRyxUL1h3wXBuFPtzSXwquivNYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fK1RW/D6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4+YOQeup; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fK1RW/D6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=4+YOQeup; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA51226D2;
	Tue, 27 Feb 2024 23:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709075117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0VN93ejAV7ECvj8CGH/oTUb7Q9vNyjvVr/xH4EoooA=;
	b=fK1RW/D68IBAwARVbEx009B+u6uzlE7GV39DlYA0o8hZhfTyGObKpZfjE7q8WkzhDsFcdq
	slsjxZxiFHXs6tJb8BAHLRx1IrW9PMTdIADAHwTKYnGcr3giVS1DDZcz0aYlVjqHv8uANn
	TAGi936CFmspZXi3YYe85FJ+zkkZPwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709075117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0VN93ejAV7ECvj8CGH/oTUb7Q9vNyjvVr/xH4EoooA=;
	b=4+YOQeupBGFmXw29GPayz4qHmHUBCPD70fgcHKnMgxTPgtwP4ARNn6FYeYMwRmU1L+PT8j
	IUi/NKbuVk4HEwCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709075117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0VN93ejAV7ECvj8CGH/oTUb7Q9vNyjvVr/xH4EoooA=;
	b=fK1RW/D68IBAwARVbEx009B+u6uzlE7GV39DlYA0o8hZhfTyGObKpZfjE7q8WkzhDsFcdq
	slsjxZxiFHXs6tJb8BAHLRx1IrW9PMTdIADAHwTKYnGcr3giVS1DDZcz0aYlVjqHv8uANn
	TAGi936CFmspZXi3YYe85FJ+zkkZPwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709075117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0VN93ejAV7ECvj8CGH/oTUb7Q9vNyjvVr/xH4EoooA=;
	b=4+YOQeupBGFmXw29GPayz4qHmHUBCPD70fgcHKnMgxTPgtwP4ARNn6FYeYMwRmU1L+PT8j
	IUi/NKbuVk4HEwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CE9D13ABA;
	Tue, 27 Feb 2024 23:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KO1EOKpq3mWzMAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Feb 2024 23:05:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH] NFS: remove sync_mode test from nfs_writepage_locked()
Date: Wed, 28 Feb 2024 10:05:07 +1100
Message-id: <170907510763.24797.12414304736328194537@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: *
X-Spam-Score: 1.66
X-Spamd-Result: default: False [1.66 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.76)[0.920];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.80%]
X-Spam-Flag: NO


nfs_writepage_locked() is only called from nfs_wb_folio() (since Commit
12fc0a963128 ("nfs: Remove writepage")) so ->sync_mode is always
WB_SYNC_ALL.

This means the test for WB_SYNC_NONE is dead code and can be removed.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/write.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index bb79d3a886ae..58adbb7709ba 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -667,10 +667,6 @@ static int nfs_writepage_locked(struct folio *folio,
 	struct inode *inode = folio_file_mapping(folio)->host;
 	int err;
 
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
-		return AOP_WRITEPAGE_ACTIVATE;
-
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0, false,
 			      &nfs_async_write_completion_ops);
-- 
2.43.0


