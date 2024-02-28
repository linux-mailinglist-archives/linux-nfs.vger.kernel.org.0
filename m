Return-Path: <linux-nfs+bounces-2102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD37186A45E
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5578F1F2BB4A
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Feb 2024 00:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DB3363;
	Wed, 28 Feb 2024 00:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OUw4FIzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C0lDIc9m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OUw4FIzy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C0lDIc9m"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D03184
	for <linux-nfs@vger.kernel.org>; Wed, 28 Feb 2024 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079902; cv=none; b=SySj2HRj+PIeyGmMopmXZsEyzwXd++dkMZnR6tlxAx1wgbC+c7ulF83ZcWamZZFe0WeZUhPrI870FyMuPRNk/OPCBwHkUtO5oyCI26APEMY/i99PFr1/0PLknNa75QzdQm6mTQau1LjtivGF0Kvm1qcFuW0EaiVz3AK1y1fy1Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079902; c=relaxed/simple;
	bh=igJyEQTpVNTdKf7KAHb0EcAe4ePu0xrKZf0E1P3VQ9s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=jeX8aRgEsbAhIS92ROfG9WmMQy+5wv0tEkjZpi7/Sq6En1oUgQYpl57fbxTQqvSsK0JnzicZwV+LS+KEBT6aPPlVmmTp+aCfFPqyQdQ2IAefVQUkbSDMv23qOaV3/8kyZ8kxan/QSneOxojToPqhzkYwCYXA/4AZshhw1vWT++g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OUw4FIzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C0lDIc9m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OUw4FIzy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C0lDIc9m; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 133DD22837;
	Wed, 28 Feb 2024 00:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709079899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=np7Bgl/K1HiTGRZETEpBk0qEuVap46E8TdO05uQ4SN4=;
	b=OUw4FIzy1yogFhAXwXToJtzrx2YNSpK32a8vwQ9+dSpRdStogBSbnYr8/cVNDelgkdmmEJ
	LjosvaOkqJGxFbTVZpZmtCt3Cjq90cuUiuombIBtZ477wy7m4UkQo886FL54Nu9O96XdyR
	geqSNQRIgPeoDiZOM4O2a82Q7T0EjCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709079899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=np7Bgl/K1HiTGRZETEpBk0qEuVap46E8TdO05uQ4SN4=;
	b=C0lDIc9mbYIbhbHHEljNy7ju08rwAH8BPM8USerEYXlW2wsHwls3cZglqAg780iurSW5bl
	fdnnGaj4J7IoImAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709079899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=np7Bgl/K1HiTGRZETEpBk0qEuVap46E8TdO05uQ4SN4=;
	b=OUw4FIzy1yogFhAXwXToJtzrx2YNSpK32a8vwQ9+dSpRdStogBSbnYr8/cVNDelgkdmmEJ
	LjosvaOkqJGxFbTVZpZmtCt3Cjq90cuUiuombIBtZ477wy7m4UkQo886FL54Nu9O96XdyR
	geqSNQRIgPeoDiZOM4O2a82Q7T0EjCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709079899;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=np7Bgl/K1HiTGRZETEpBk0qEuVap46E8TdO05uQ4SN4=;
	b=C0lDIc9mbYIbhbHHEljNy7ju08rwAH8BPM8USerEYXlW2wsHwls3cZglqAg780iurSW5bl
	fdnnGaj4J7IoImAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AE5013A58;
	Wed, 28 Feb 2024 00:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /g3LC1l93mXcQAAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 28 Feb 2024 00:24:57 +0000
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
Subject: [PATCH] NFS: avoid infinite loop in pnfs_update_layout.
Date: Wed, 28 Feb 2024 11:24:53 +1100
Message-id: <170907989347.24797.3598114887801119723@noble.neil.brown.name>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[39.99%]
X-Spam-Flag: NO


If pnfsd_update_layout() is called on a file for which recovery has
failed it will enter a tight infinite loop.

NFS_LAYOUT_INVALID_STID will be set, nfs4_select_rw_stateid() will
return -EIO, and nfs4_schedule_stateid_recovery() will do nothing, so
nfs4_client_recover_expired_lease() will not wait.  So the code will
loop indefinitely.

Break the loop by testing the validity of the open stateid at the top of
the loop.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/pnfs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 0c0fed1ecd0b..a5cc6199127f 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -1999,6 +1999,14 @@ pnfs_update_layout(struct inode *ino,
 	}
 
 lookup_again:
+	if (!nfs4_valid_open_stateid(ctx->state)) {
+		trace_pnfs_update_layout(ino, pos, count,
+					 iomode, lo, lseg,
+					 PNFS_UPDATE_LAYOUT_INVALID_OPEN);
+		lseg = ERR_PTR(-EIO);
+		goto out;
+	}
+
 	lseg = ERR_PTR(nfs4_client_recover_expired_lease(clp));
 	if (IS_ERR(lseg))
 		goto out;
-- 
2.43.0


