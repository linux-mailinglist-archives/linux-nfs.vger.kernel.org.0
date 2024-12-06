Return-Path: <linux-nfs+bounces-8369-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CB19E63FE
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425E5284685
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078F1428E3;
	Fri,  6 Dec 2024 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eFTAEE98";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r19Y3XNL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eFTAEE98";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="r19Y3XNL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED411553A7
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451575; cv=none; b=eTlTfOa/77Ou/cyVnQzEVuBDwUzkeh6aI7b0LJDM3i+cWFdDkxQHkQ+LeV1Q6ZDQzDOl78Q7BIaIKqe5P1TM0uLpsYUEghcuUK+yfU2lPQ9hdaybCS3gKlhjup+04IQCaijzEs8icTUBBpzzq9C/Hcg30CWCORcDowRiBbcdqMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451575; c=relaxed/simple;
	bh=DWZ/St+CP0QuIRVM1V/Cb8VydQulV9D4NKJot5WxD30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZN+q0KRd/AcHZDWpiRfTT9WFH2h2dzJrWnODV3GbZUtemfkqbYEXMiE98kLtxH+Y66CdcPDsZLx58O0Nz4JxvMpF1fbnVizE9RP1hMgMDS7zRSbzyNKxVs9Ur1GcplScDO6vHggiQjHn1SlmoyC+cIyF5MRbQBoIcSO6lPiarc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eFTAEE98; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r19Y3XNL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eFTAEE98; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=r19Y3XNL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C96591F38E;
	Fri,  6 Dec 2024 02:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svBMtH4AAINyjWLO4QEAx/fGIJOMR3kJWC34oxf54gE=;
	b=eFTAEE982d8ObNVjWza+WHCuVKB3Y33rISjsgYPVi+9mK67RFC5bvaxWdgpG0D/POUaw5Z
	A/duCmwGyJsFOMa9OwPWzbF35t0lWAw6zRF0L+kFe9Rdla4mU9i8Yc9losyOYuZ4we25Xq
	k4QJF589urRyKIi/xl1qZoCcIGAflsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svBMtH4AAINyjWLO4QEAx/fGIJOMR3kJWC34oxf54gE=;
	b=r19Y3XNLHqz2tfuh1LAIkJ/1T0SFt5pLHoMohkO0QX6VsCEW1DrtEi1L1aEZR6TtgmovJy
	2ha/DXQ0SubMxYBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eFTAEE98;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=r19Y3XNL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451572; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svBMtH4AAINyjWLO4QEAx/fGIJOMR3kJWC34oxf54gE=;
	b=eFTAEE982d8ObNVjWza+WHCuVKB3Y33rISjsgYPVi+9mK67RFC5bvaxWdgpG0D/POUaw5Z
	A/duCmwGyJsFOMa9OwPWzbF35t0lWAw6zRF0L+kFe9Rdla4mU9i8Yc9losyOYuZ4we25Xq
	k4QJF589urRyKIi/xl1qZoCcIGAflsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451572;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svBMtH4AAINyjWLO4QEAx/fGIJOMR3kJWC34oxf54gE=;
	b=r19Y3XNLHqz2tfuh1LAIkJ/1T0SFt5pLHoMohkO0QX6VsCEW1DrtEi1L1aEZR6TtgmovJy
	2ha/DXQ0SubMxYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92CB613A15;
	Fri,  6 Dec 2024 02:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E6wAEjNfUmdCJAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:19:31 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 06/11] nfs: use store_release_wake_up() for clearing d_fsdata
Date: Fri,  6 Dec 2024 13:15:32 +1100
Message-ID: <20241206021830.3526922-7-neilb@suse.de>
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
X-Rspamd-Queue-Id: C96591F38E
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The barrier provided by smp_store_release() is before the store, while
wake_up_var() needs a full barrier *after* the store.

The new store_release_wake_up() interface encodes all the barriers
making this sort of bug harder to write.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/dir.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 492cffd9d3d8..ded86facef8f 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1837,9 +1837,7 @@ static void block_revalidate(struct dentry *dentry)
 
 static void unblock_revalidate(struct dentry *dentry)
 {
-	/* store_release ensures wait_var_event() sees the update */
-	smp_store_release(&dentry->d_fsdata, NULL);
-	wake_up_var(&dentry->d_fsdata);
+	store_release_wake_up(&dentry->d_fsdata, NULL);
 }
 
 /*
-- 
2.47.0


