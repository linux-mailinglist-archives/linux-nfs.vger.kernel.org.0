Return-Path: <linux-nfs+bounces-8374-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 928E19E6405
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 03:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E46E283CB9
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2024 02:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91691552F5;
	Fri,  6 Dec 2024 02:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o3VQ/v7U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="VT714B5e";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WyaMRsZN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T0M9AoAE"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211221428E3
	for <linux-nfs@vger.kernel.org>; Fri,  6 Dec 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733451616; cv=none; b=jakzURbOJbXdKqX9iROSE+2UdVa8+YcOpcwp+h4fk2AHKwXKAT1Q6h+cRW7qrgFIl2BUecAccyuEGAKsCGO56kFfXYGMwwx2HibN5ukhH+fweF2PVVmx4ecVKjctHt5DEIeervaTWl9XKxHZWjPdy37v8DCFMpS/KtphSchPAgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733451616; c=relaxed/simple;
	bh=mgUkSi+iOmIPOrUFAnGg+mO7wfK2wHIOc4c6RGRrJPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvkAHPjmgPuAbBlrFngw1hLhn0M5xlvL2sOxTwCNCuPRxgdIRBJ5RGbd4H+Ez3a3gbnw5KzUNsW0uXLCpzEWyKPktXwf325XbQ2AG1CMwQYS+3/Sj9t/knjOYFQeqiIPE1gXPPUnQLWKMkG15bSl83IhDUTrDGj+bWlVBtiQgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o3VQ/v7U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=VT714B5e; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WyaMRsZN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T0M9AoAE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6C21F394;
	Fri,  6 Dec 2024 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+H+BSVv/PJGSn4Su4E/Gn+xx7zEXtD9QuI+AYe1ciA=;
	b=o3VQ/v7UiaPmeumXJRinfPCIUvQWplkkklo5KmXuWpV/0xPrat65hZmVYezULCVYsh51df
	/ET4CwZ/6HwG5gYD3OagIN4fA+N7CDn3q9PAjdoe7PtR6AF8AoPIGjZ/RczMXcKsWduOsN
	gMnh1UWIguvt1og6KPj8pgsucnPn0rw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451613;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+H+BSVv/PJGSn4Su4E/Gn+xx7zEXtD9QuI+AYe1ciA=;
	b=VT714B5eK9zS/9meahDzB5DgyigtEbDCXTn2VfDAq/KUUEQClFWQcFHpO13wCZIT3ywEDg
	yMMRRLRZP+VpAyAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=WyaMRsZN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T0M9AoAE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1733451612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+H+BSVv/PJGSn4Su4E/Gn+xx7zEXtD9QuI+AYe1ciA=;
	b=WyaMRsZNHQi00m5TPjob6hWtAPKJaf95WfoXy4MD41H1UXxQeN+tmVE36Q0sOj4pzHwBTo
	PfpTj43/Wiq3U60X0xSscUo9QAzoAuSg3qv0UQbzcBhSOC3pZPZvj+f+M6J3onjpkwmxkh
	19A4n5UhVxfmno/ks3WGW1ZTJipPdrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1733451612;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+H+BSVv/PJGSn4Su4E/Gn+xx7zEXtD9QuI+AYe1ciA=;
	b=T0M9AoAE0n12xO5LaJRRl/4P2Zqj3bAmbFOb95oPYuA1ulePNwns8TasYvsRRrIHX7o4hF
	sDunz1U4ltBW5CCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7C0713A15;
	Fri,  6 Dec 2024 02:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kgu8JlpfUmd6JAAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 06 Dec 2024 02:20:10 +0000
From: NeilBrown <neilb@suse.de>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 11/11] nfs: use wait_var_event_spinlock() to wait for nfsi->layout to change.
Date: Fri,  6 Dec 2024 13:15:37 +1100
Message-ID: <20241206021830.3526922-12-neilb@suse.de>
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
X-Rspamd-Queue-Id: 2A6C21F394
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The recently added interface wait_var_event_spinlock() is designed for
waiting for events that can only be checked under a spinlock.
This matches the requirements for waiting for nfsi->layout so we can
change to using wait_var_event_spinlock().

This avoids a use of plain wake_up_var() which always needs to be
checked for correct barrier usage.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/pnfs.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/fs/nfs/pnfs.c b/fs/nfs/pnfs.c
index 400f409f45fa..04be1165a1c5 100644
--- a/fs/nfs/pnfs.c
+++ b/fs/nfs/pnfs.c
@@ -306,7 +306,6 @@ void
 pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 {
 	struct inode *inode;
-	unsigned long i_state;
 
 	if (!lo)
 		return;
@@ -317,12 +316,11 @@ pnfs_put_layout_hdr(struct pnfs_layout_hdr *lo)
 		if (!list_empty(&lo->plh_segs))
 			WARN_ONCE(1, "NFS: BUG unfreed layout segments.\n");
 		pnfs_detach_layout_hdr(lo);
-		i_state = inode->i_state;
+		/* Notify pnfs_destroy_layout_final() that we're done */
+		if (inode->i_state & (I_FREEING | I_CLEAR))
+			wake_up_var_locked(lo, &inode->i_lock);
 		spin_unlock(&inode->i_lock);
 		pnfs_free_layout_hdr(lo);
-		/* Notify pnfs_destroy_layout_final() that we're done */
-		if (i_state & (I_FREEING | I_CLEAR))
-			wake_up_var(lo);
 	}
 }
 
@@ -795,23 +793,16 @@ void pnfs_destroy_layout(struct nfs_inode *nfsi)
 }
 EXPORT_SYMBOL_GPL(pnfs_destroy_layout);
 
-static bool pnfs_layout_removed(struct nfs_inode *nfsi,
-				struct pnfs_layout_hdr *lo)
-{
-	bool ret;
-
-	spin_lock(&nfsi->vfs_inode.i_lock);
-	ret = nfsi->layout != lo;
-	spin_unlock(&nfsi->vfs_inode.i_lock);
-	return ret;
-}
-
 void pnfs_destroy_layout_final(struct nfs_inode *nfsi)
 {
 	struct pnfs_layout_hdr *lo = __pnfs_destroy_layout(nfsi);
 
-	if (lo)
-		wait_var_event(lo, pnfs_layout_removed(nfsi, lo));
+	if (lo) {
+		spin_lock(&nfsi->vfs_inode.i_lock);
+		wait_var_event_spinlock(lo, nfsi->layout != lo,
+					&nfsi->vfs_inode.i_lock);
+		spin_unlock(&nfsi->vfs_inode.i_lock);
+	}
 }
 
 static bool
-- 
2.47.0


