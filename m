Return-Path: <linux-nfs+bounces-9919-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C469A2BA8F
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1013A774A
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AE014F9C4;
	Fri,  7 Feb 2025 05:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DME1VThq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kagxxzki";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DME1VThq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="kagxxzki"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F4D63D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905441; cv=none; b=A4N1giCwoDzZJ6Uv/D+V3DcGptnjcXk1eT+whrMV24PhTI5/1Ok7gKXBVW4JhQXqA4iJJCzemsc/J/JmGPjj6ls9mu8NEjzjqsIxL7gWK9Se1NmLxMx1+eNV4TJOfV71u6rr/PpZMDPLwin39hcIDqm9zL4SmlJv8sTKL60lrGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905441; c=relaxed/simple;
	bh=P58Z1clrmoR8B9QFLaCAYX5Z3bc0GI8/X9ODmnHVcCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=So1E/C1AyBKbw7np3tSNXlJTTVRPhrFwLyoKXwz6/KGdYGT937quekTK8+trwt/XlLtYToMDrcw8MXLsQj37TcPo3uxrr41FhiRD5gKMgzCgDe/Y0LupFLcXZpQYE73L5Gr5LcgoKipnR8CrBaTeaui4wM6qbGIk850299B3nVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DME1VThq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kagxxzki; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DME1VThq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=kagxxzki; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 04E9B1F38D;
	Fri,  7 Feb 2025 05:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI54pzrJtIgzOmCySuFeZgjbA1rlXuRQdxYMMtme1fw=;
	b=DME1VThqCMUlI++YfScAXu+wz43Ajfib8BZr0jpfzOkEXwytx/53xI1n8H0PElatzkyDRV
	vijfq4jGmmB8CVTpnOh7pAMljnDxRnf4upQQ1WHpkw+qwxhFO7NmgQhNHE7oWvRBVz/q6x
	2Vpvooyro1NJWdv61uBkyta2fgoHSDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI54pzrJtIgzOmCySuFeZgjbA1rlXuRQdxYMMtme1fw=;
	b=kagxxzkiJoYCufjD83sVLrpADmmiqdUgMBMmVnfXzRVYWjerXcN9/3iJIOFuySYmezqUN5
	g109zE9YYWYHvACg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI54pzrJtIgzOmCySuFeZgjbA1rlXuRQdxYMMtme1fw=;
	b=DME1VThqCMUlI++YfScAXu+wz43Ajfib8BZr0jpfzOkEXwytx/53xI1n8H0PElatzkyDRV
	vijfq4jGmmB8CVTpnOh7pAMljnDxRnf4upQQ1WHpkw+qwxhFO7NmgQhNHE7oWvRBVz/q6x
	2Vpvooyro1NJWdv61uBkyta2fgoHSDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905438;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI54pzrJtIgzOmCySuFeZgjbA1rlXuRQdxYMMtme1fw=;
	b=kagxxzkiJoYCufjD83sVLrpADmmiqdUgMBMmVnfXzRVYWjerXcN9/3iJIOFuySYmezqUN5
	g109zE9YYWYHvACg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A6A113694;
	Fri,  7 Feb 2025 05:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xXXJD1uXpWf2FgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:15 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/6] nfsd: filecache: remove race handling.
Date: Fri,  7 Feb 2025 16:15:11 +1100
Message-ID: <20250207051701.3467505-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250207051701.3467505-1-neilb@suse.de>
References: <20250207051701.3467505-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

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

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index a1cdba42c4fa..b13255bcbb96 100644
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


