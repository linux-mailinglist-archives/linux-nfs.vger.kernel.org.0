Return-Path: <linux-nfs+bounces-2099-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D8486A39B
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:30:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9181C24D0D
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Feb 2024 23:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0805756B71;
	Tue, 27 Feb 2024 23:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zcta26qI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j4p7Zg2K";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zcta26qI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j4p7Zg2K"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FFC57885;
	Tue, 27 Feb 2024 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076220; cv=none; b=ZuBSrL38/WSNxjrLdcPOd/TDnZDMR0j5ImSyACF/LhFoqVqGwk83AkS/aBWf4p4GfvFxPqllzyZfXEbPEnPeuHm03tBvGgt6a3iE+bGpue1CiSh8cKvuTf6E3AGDYkoPX7ff7ibfdOwnZibqea68W3M2BpzVCUcqH4vbvq3G3Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076220; c=relaxed/simple;
	bh=n046FSJK9fhTIOJ2BKJ9rHNDMv6GIfRX+GwAQgZ68X8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=Ky0FDBx/mYPZV+XsQTZCwQl0kMCEQf4pNNBNXOKtm3cekQ9cUhcY3rBZIMUmYSr3JCz+3lzf5OfKoO9TDG4MG0evdDv0MlkLms4uKSGXovacJv//OWHyLFiGqSjd6de4We6Kwe4LQIwiEWV64YKaaSlXlfgdqp1XPtRlvpitr6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zcta26qI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j4p7Zg2K; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zcta26qI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j4p7Zg2K; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B10A22800;
	Tue, 27 Feb 2024 23:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrrdcIaUT6vzVsHCWVuHjUJYXaTcM6v3YeIiB66OlG4=;
	b=zcta26qISI4PsSUCEVMBcUfxUu+8bT5JknngZYtKbFiLLBJDNlWqw9PVUFX3Ep1o5FbAiW
	4GQseqLAlUwVUN9VP/AhOZ1Qc2Ahzg87ZMiresQBBaUD/Sau5nli0mx3YjKnbiTHgwlB3k
	CcTLB+7r8u1GDvyxK9UG6qOVKyN3+5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrrdcIaUT6vzVsHCWVuHjUJYXaTcM6v3YeIiB66OlG4=;
	b=j4p7Zg2Kd/2sClHfmYNJrKDjBwIzghXo3cipjS4hkwXqiVddaYOnOxOUZKGTnvSnr9JlxY
	688fSKZj/ohAvZDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709076217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrrdcIaUT6vzVsHCWVuHjUJYXaTcM6v3YeIiB66OlG4=;
	b=zcta26qISI4PsSUCEVMBcUfxUu+8bT5JknngZYtKbFiLLBJDNlWqw9PVUFX3Ep1o5FbAiW
	4GQseqLAlUwVUN9VP/AhOZ1Qc2Ahzg87ZMiresQBBaUD/Sau5nli0mx3YjKnbiTHgwlB3k
	CcTLB+7r8u1GDvyxK9UG6qOVKyN3+5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709076217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xrrdcIaUT6vzVsHCWVuHjUJYXaTcM6v3YeIiB66OlG4=;
	b=j4p7Zg2Kd/2sClHfmYNJrKDjBwIzghXo3cipjS4hkwXqiVddaYOnOxOUZKGTnvSnr9JlxY
	688fSKZj/ohAvZDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B03A13ABA;
	Tue, 27 Feb 2024 23:23:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yPH2N/Zu3mU/NAAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 27 Feb 2024 23:23:34 +0000
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
Cc: linux-nfs@vger.kernel.org
Subject:
 [PATCH stable 6.6 and 6.7] NFS: Fix data corruption caused by congestion.
Date: Wed, 28 Feb 2024 10:23:31 +1100
Message-id: <170907621128.24797.4390391329078744015@noble.neil.brown.name>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zcta26qI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=j4p7Zg2K
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.21 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.20)[71.39%]
X-Spam-Score: -5.21
X-Rspamd-Queue-Id: 2B10A22800
X-Spam-Flag: NO


when AOP_WRITEPAGE_ACTIVATE is returned (as NFS does when it detects
congestion) it is important that the folio is redirtied.
nfs_writepage_locked() doesn't do this, so files can become corrupted as
writes can be lost.

Note that this is not needed in v6.8 as AOP_WRITEPAGE_ACTIVATE cannot be
returned.  It is needed for kernels v5.18..v6.7.  Prior to 6.3 the patch
is different as it needs to mention "page", not "folio".

Reported-and-tested-by: Jacek Tomaka <Jacek.Tomaka@poczta.fm>
Fixes: 6df25e58532b ("nfs: remove reliance on bdi congestion")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/write.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index b664caea8b4e..9e345d3c305a 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -668,8 +668,10 @@ static int nfs_writepage_locked(struct folio *folio,
 	int err;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
+	    NFS_SERVER(inode)->write_congested) {
+		folio_redirty_for_writepage(wbc, folio);
 		return AOP_WRITEPAGE_ACTIVATE;
+	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGE);
 	nfs_pageio_init_write(&pgio, inode, 0, false,
-- 
2.43.0


