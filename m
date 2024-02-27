Return-Path: <linux-nfs+bounces-2100-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD0B86A3A0
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF901C25266
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 23:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0A58231;
	Tue, 27 Feb 2024 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="c/LVuXnd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xJUfV6NS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wPnjUElR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sa75unVR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC8558200;
	Tue, 27 Feb 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076359; cv=none; b=fvdnOg+gt2ZNfxoW7wXwCt0UM4tlgPDHE44K5huSFuRqez341Oymb1bVN5wZZxXuPLIUo+3v7j3AxmKei4C3bkZB+FG63C7TNQ3xzqjNQAhm7oS8r8UGcXOeYy3BJYdUVR+RSOOvyzSVmBbuU4LWjkO6CAN51HtCJ1AaSKk14P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076359; c=relaxed/simple;
	bh=AEf1gpZiNu/8Da6o7+1FPM6KvYB5XGpOqOLGqNoPh8I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=U93IrjwHznztmu+7LTTWdQbIGT2UrEDU1eE2WchCISHdhb3ZT6FJwPyBNUfPpFdQJMB0BB2ACDF337ed+D2C/cWy51LyKGDEHW8qcYmjE3+leu2RWPmcr8FZShFL6ymP6wNS2jxKdrN3f7ntrQG7TJgKuPLsmnDLFTLHeyF9RIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=c/LVuXnd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xJUfV6NS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wPnjUElR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sa75unVR; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D10021F453;
	Tue, 27 Feb 2024 23:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUo1Lmwh7qTNT/9WsS+S6D9aEegzP0TKGCitjsP75Us=;
	b=c/LVuXndvRCb92BV/Lmy9AwuIvZDKANUSpZo4Vi9Sknb17cnLdEQ7UCA0HpY1OPemSud1S
	XpZKe4d+mmNFlMzKGWBKQ0MQOgb37U2nowyVIx/eQ/aMoe54H9Y8V1nA2nS/qBTmqEgJat
	4hFBaGbWqEppXOKiD/eR+YMFxuf/tPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076356;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUo1Lmwh7qTNT/9WsS+S6D9aEegzP0TKGCitjsP75Us=;
	b=xJUfV6NScYcptXCEMAazlof+mLjYP/tdbzvYKBgsBWW0CI1Ds8Ycev/hsP6Bf6mHoY1ocI
	gdVtyo8zOqM4JpBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUo1Lmwh7qTNT/9WsS+S6D9aEegzP0TKGCitjsP75Us=;
	b=wPnjUElRjRSZeZHdCnszerg5CepUFZX9PcP4nDVvfnXYyxMjK3hllAWBBCqQEZCKsLuteL
	nXUzK6a9pwrapiVJmKnQXudJyfOKx+qQQZn/Nlws0tItjCllFOTIOYUAz0oNL7W7dfWrm8
	cW3yxHSGEQRMT4XGjHZRnAJTOpoWwAQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076355;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aUo1Lmwh7qTNT/9WsS+S6D9aEegzP0TKGCitjsP75Us=;
	b=sa75unVRQrmEo/y6ooENv+u4KFrjev4nMTfeclIXUElj23+rCTc7bJ8Vcf/bn3gTPED2JB
	wniVOFvuKDtCeMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D7A13ABA;
	Tue, 27 Feb 2024 23:25:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 18t0DYFv3mW0NAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Feb 2024 23:25:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: stable@vger.kernel.org, Trond Myklebust <trond.myklebust@hammerspace.com>,
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,  Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Subject: [PATCH stable 6.1] NFS: Fix data corruption caused by congestion.
Date: Wed, 28 Feb 2024 10:25:49 +1100
Message-id: <170907634991.24797.14120500624611379941@noble.neil.brown.name>
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wPnjUElR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sa75unVR
X-Spamd-Result: default: False [-4.12 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[poczta.fm];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,poczta.fm];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.31)[75.34%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D10021F453
X-Spam-Level: 
X-Spam-Score: -4.12
X-Spam-Flag: NO


when AOP_WRITEPAGE_ACTIVATE is returned (as NFS does when it detects
congestion) it is important that the page is redirtied.
nfs_writepage_locked() doesn't do this, so files can become corrupted as
writes can be lost.

Note that this is not needed in v6.8 as AOP_WRITEPAGE_ACTIVATE cannot be
returned.  It is needed for kernels v5.18..v6.7.  From 6.3 onward the patch
is different as it needs to mention "folio", not "page".

Reported-and-tested-by: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Fixes: 6df25e58532b ("nfs: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index f41d24b54fd1..6a0606668417 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -667,8 +667,10 @@ static int nfs_writepage_locked(struct page *page,
 	int err;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
+	    NFS_SERVER(inode)->write_congested) {
+		redirty_page_for_writepage(wbc, page);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0,
-- 
2.43.0


