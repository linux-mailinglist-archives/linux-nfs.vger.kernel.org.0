Return-Path: <linux-nfs+bounces-9651-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFAA1CF6F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494EE18853D3
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002D25A64F;
	Mon, 27 Jan 2025 01:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b04gqQ09";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="co6VceD+";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tQMltoNX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="40aP6bN1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434E63B9
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941039; cv=none; b=JZrzBn6r9mRHNaQUQeDEtO8c9jl07GvAOeRZI0qCua4P4ra0cNrZXrzwDDIWNBIXZYepbjiYGIKzMFRpg//8aRreLN7Tu/Oi03AWAk9DnbgdvZ3O+CK3D55FPsboVxltdMpxcYmVZRZ7cgx9MrFvyAHEg/xJ8Fb6QWoumUxH8To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941039; c=relaxed/simple;
	bh=Q6gMICUKxtn76g9OSvu0xrLxkp9vwwrxxUB4dbDtNNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joAO1sTiAseXJVf1KQBFVToo4aZ/Rr9RZJST/4nqg/lsBczpHw+pe70JTlz3aoE1H2HqSG3IS8HJRFDjqxskwoHqECbkZfM+O6n1JOkRC8l8YsYmEOfXslOUAou5oDMqaAQa0fkqMh/O2cJli/wUc9kKzBvzzWHohegqotqIuqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b04gqQ09; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=co6VceD+; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tQMltoNX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=40aP6bN1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1C852115F;
	Mon, 27 Jan 2025 01:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ1A1OPOfoNZqH8/KSvUxQHtXalDCFAPQqPtj4zIwJk=;
	b=b04gqQ09/VHqict9pPS+e0gDn54kUVib+oUaCf4lOWVEZBGHtOcauR7RjRlh0kU0YIhJgu
	bzRiBmzUlMxoF9UtmWnQCYmTRX0mCtlD3eGuDD7l7NHJZBCSG5GHaA+6QSB9uVk2nMT1Fg
	4svketSguAd/0tLi1jJd7AsW+PZBEag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941036;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ1A1OPOfoNZqH8/KSvUxQHtXalDCFAPQqPtj4zIwJk=;
	b=co6VceD+mIpKlaI/gOnF4R+XY9Vt9BZJvUXoMWmVrJrmBGBGjsbsCaY86C8sQDs+Rgzjnu
	DOZ3q/o7+t93LSDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tQMltoNX;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=40aP6bN1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ1A1OPOfoNZqH8/KSvUxQHtXalDCFAPQqPtj4zIwJk=;
	b=tQMltoNXmDgH8hRRrN1bmunuq3+jN89yFWD/8QAeCeIQreXEBiGMm+GTDG919+6DnbCjxf
	tV598y+osNbbedquMsFRDh1F0uDIjpY68d2L6+z/LV/WqdWLBwR7Wcc2JTkvpZeAUzhgM3
	fNn0OpJDLSSe5P9qiHX2C1xdV7RXjzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZ1A1OPOfoNZqH8/KSvUxQHtXalDCFAPQqPtj4zIwJk=;
	b=40aP6bN1ir5/38s+MKCHWuLbo6k3L4h8XCMwghMTjViirpQ4HvNNgWEHiKS3o1Kdditd6w
	rdeA69oapoWolcAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8141613782;
	Mon, 27 Jan 2025 01:23:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QeBrDSnglmeEBgAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:53 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5/7] nfsd: filecache: document the arbitrary limit on file-disposes-per-loop
Date: Mon, 27 Jan 2025 12:20:36 +1100
Message-ID: <20250127012257.1803314-6-neilb@suse.de>
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
X-Rspamd-Queue-Id: F1C852115F
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Rather than having the bare number "8" use a named constant and explain
the tradeoffs that lead to the choice.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 1e90da507152..7264faa57280 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -493,6 +493,21 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 	}
 }
 
+/*
+ * Disposing of files can involve non-trivial work, and they
+ * can appear in batches.  So we don't want to try handling them
+ * all in one thread - if there are lots it would be better to allow
+ * several nfsd threads to handle them in parallel.
+ * On average one RPC request can create at most 1 file to be disposed
+ * so handling one each time around the nfsd loop should keep the list
+ * under control.  However there are often benefits of batching so
+ * 2 at a time will likely be more efficient than 1.  4 more so.
+ * We need to choose a number which will often handle all the files,
+ * but will allow other threads to help when the list gets long.
+ * The current choice is:
+ */
+#define NFSD_FILE_DISPOSE_BATCH	8
+
 /**
  * nfsd_file_net_dispose - deal with nfsd_files waiting to be disposed.
  * @nn: nfsd_net in which to find files to be disposed.
@@ -511,7 +526,8 @@ void nfsd_file_net_dispose(struct nfsd_net *nn)
 		int i;
 
 		spin_lock(&l->lock);
-		for (i = 0; i < 8 && !list_empty(&l->freeme); i++) {
+		for (i = 0; i < NFSD_FILE_DISPOSE_BATCH &&
+		     !list_empty(&l->freeme); i++) {
 			struct nfsd_file *nf = list_first_entry(
 				&l->freeme, struct nfsd_file, nf_lru);
 
-- 
2.47.1


