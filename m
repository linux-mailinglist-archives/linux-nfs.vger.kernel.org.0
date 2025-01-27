Return-Path: <linux-nfs+bounces-9647-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E81A1CF6B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 02:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604D33A4D82
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Jan 2025 01:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EBB64D;
	Mon, 27 Jan 2025 01:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOMlKs/6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KwMECPvT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OOMlKs/6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KwMECPvT"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692717C61
	for <linux-nfs@vger.kernel.org>; Mon, 27 Jan 2025 01:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737941011; cv=none; b=oril8jhgdJDfOdNGF1uSU7Gjwa4QMm1GE/B1ZTGIKp2qRlXagALtXsmqNY8kMsUXopUIKLEXZb33A73Xl+luubjlwSYtw0VsDlyG54Lw8Tk0Aj0Myv0Oc3XEnCLjtt1ZdQ4llnuyY7YP7sJZI4oM5vK0aWFd0EbEAm3/2ypbe38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737941011; c=relaxed/simple;
	bh=3DNYhuzHNSR3CsewQyYh8Q6egmAkKnly1dssUXC+dGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCVAhjq4l8WnABmwePBrkZ5HhASL7DJvI5RwUsDGhpMPpp1zbTb9+53591bRL83Iaon91YNXgoPT3p9CAH3ZBCrdWy3zCcI3kTvEIVNbdhf0W5HyuSAIRkcSq4EZ8LVL9CF5+rqymUpsZ53gtXHgZC3/jg651bzCx5PO+OGDIF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOMlKs/6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KwMECPvT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OOMlKs/6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KwMECPvT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 74AEC2115F;
	Mon, 27 Jan 2025 01:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA8f+jALc4WeYOXCgaXMs89tCcT4PCwOc89tR4FZ6Tw=;
	b=OOMlKs/6QbKJRqrH46CuLgVboyzg8SYph7vwGh8oTZfUKoftmf1gXFZ1D/E9ejDoOSUyWv
	6NHywwpzAPRzU7C9wRuI+E+hij8t7aCJDeUdZp0lm9UM7GPg7upeiNkA82AokY+HAWDd7J
	A2yVEyZywUX/VTILThIs0QSdXWnTV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA8f+jALc4WeYOXCgaXMs89tCcT4PCwOc89tR4FZ6Tw=;
	b=KwMECPvTcHgBytmYFrnc8GfGclImy9/fHvs6uqIjG8gtvdQIY7v9GPdmMQPi782MvktRYe
	77NVnUgP8WhlmeBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="OOMlKs/6";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KwMECPvT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737941007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA8f+jALc4WeYOXCgaXMs89tCcT4PCwOc89tR4FZ6Tw=;
	b=OOMlKs/6QbKJRqrH46CuLgVboyzg8SYph7vwGh8oTZfUKoftmf1gXFZ1D/E9ejDoOSUyWv
	6NHywwpzAPRzU7C9wRuI+E+hij8t7aCJDeUdZp0lm9UM7GPg7upeiNkA82AokY+HAWDd7J
	A2yVEyZywUX/VTILThIs0QSdXWnTV7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737941007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RA8f+jALc4WeYOXCgaXMs89tCcT4PCwOc89tR4FZ6Tw=;
	b=KwMECPvTcHgBytmYFrnc8GfGclImy9/fHvs6uqIjG8gtvdQIY7v9GPdmMQPi782MvktRYe
	77NVnUgP8WhlmeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDBCD13782;
	Mon, 27 Jan 2025 01:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MW7qJwzglmdwfAAAD6G6ig
	(envelope-from <neilb@suse.de>); Mon, 27 Jan 2025 01:23:24 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/7] nfsd: filecache: remove race handling.
Date: Mon, 27 Jan 2025 12:20:32 +1100
Message-ID: <20250127012257.1803314-2-neilb@suse.de>
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
X-Rspamd-Queue-Id: 74AEC2115F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The race that this code tries to protect against is not interesting.
The code is problematic as we access the "nf" after we have given our
reference to the lru system.  While that take 2+ seconds to free things
it is still poor form.

The only interesting race I can find would be with
nfsd_file_close_inode_sync();
This is the only place that really doesn't want the file to stay on the
LRU when unhashed (which is the direct consequence of the race).

However for the race to happen, some other thread must own a reference
to a file and be putting in while nfsd_file_close_inode_sync() is trying
to close all files for an inode.  If this is possible, that other thread
could simply call nfsd_file_put() a little bit later and the result
would be the same: not all files are closed when
nfsd_file_close_inode_sync() completes.

If this was really a problem, we would need to wait in close_inode_sync
for the other references to be dropped.  We probably don't want to do
that.

So it is best to simply remove this code.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index e342b2e76882..f5a92ac3f16f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -371,20 +371,10 @@ nfsd_file_put(struct nfsd_file *nf)
 
 		/* Try to add it to the LRU.  If that fails, decrement. */
 		if (nfsd_file_lru_add(nf)) {
-			/* If it's still hashed, we're done */
-			if (test_bit(NFSD_FILE_HASHED, &nf->nf_flags)) {
-				nfsd_file_schedule_laundrette();
-				return;
-			}
-
-			/*
-			 * We're racing with unhashing, so try to remove it from
-			 * the LRU. If removal fails, then someone else already
-			 * has our reference.
-			 */
-			if (!nfsd_file_lru_remove(nf))
-				return;
+			nfsd_file_schedule_laundrette();
+			return;
 		}
+
 	}
 	if (refcount_dec_and_test(&nf->nf_ref))
 		nfsd_file_free(nf);
-- 
2.47.1


