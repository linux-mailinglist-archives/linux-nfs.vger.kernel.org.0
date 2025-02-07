Return-Path: <linux-nfs+bounces-9920-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD1A2BA90
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 06:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEDF918895D5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Feb 2025 05:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685F014F9C4;
	Fri,  7 Feb 2025 05:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tsgTtIXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N9bo/xDu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tsgTtIXZ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="N9bo/xDu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C830E63D
	for <linux-nfs@vger.kernel.org>; Fri,  7 Feb 2025 05:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738905447; cv=none; b=ZA7zWivBYt7L8/9QjB86TVOWE1HKMMcimHUmziiJRsSQfxC1u9UxQ7YzI/9vEQQCJiFOoThH0y6dJYcLuZ2po2ZS00wdfAX+w8qGxODDUNt85opyKovlTzTqNXhJk/seUu8vj0fGi9ZJT7nlvNB+fUTOBlc6/6BU6wSc6brbMs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738905447; c=relaxed/simple;
	bh=equMA7yXGGv1zxOSRqamOEKqs21phBtiEgE2QnzQYJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k78fPuFD28PsA4rjv7VTaPl0bLGj/4QANFZLp5DroVVbI/o2K853T/Kf5VqLUbBKcGWUa306k3nkc0CDk3GECzqCGbkiI9XTW0K5PtNjlKzpxzbLjYWiuBXHyE56IiPbWfbt3yM511kLQevNoL91VsP8rtPc2hmJu5BL6ghbiV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tsgTtIXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N9bo/xDu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tsgTtIXZ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=N9bo/xDu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 046F621133;
	Fri,  7 Feb 2025 05:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRIrh/TYxUKaMGRbEpT7gGZ3zPSuoMMG7o/Hi0VbAYY=;
	b=tsgTtIXZsjvEue0GU7uAFh+2tVduKGtTbJNrsg0AteoC/hOcab03oyovJMLGyYk3H2rhGm
	UynXxne3HJiDQIlSnJIKy4mjJ1Gt9mpnA22Y4dNOaV2Hkxtzgy6aMBM8bIBStB+uWNvHhN
	+FLjn12+si2nUnMqpvA9Kd51k4HIc+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRIrh/TYxUKaMGRbEpT7gGZ3zPSuoMMG7o/Hi0VbAYY=;
	b=N9bo/xDuY3hIkgofWK3tjWaO3KxjqMphYveqRK5waMQr+fzS5FWOe1MleQjk4+ktCPep8R
	bkKDY/FbCyns3SDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738905444; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRIrh/TYxUKaMGRbEpT7gGZ3zPSuoMMG7o/Hi0VbAYY=;
	b=tsgTtIXZsjvEue0GU7uAFh+2tVduKGtTbJNrsg0AteoC/hOcab03oyovJMLGyYk3H2rhGm
	UynXxne3HJiDQIlSnJIKy4mjJ1Gt9mpnA22Y4dNOaV2Hkxtzgy6aMBM8bIBStB+uWNvHhN
	+FLjn12+si2nUnMqpvA9Kd51k4HIc+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738905444;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tRIrh/TYxUKaMGRbEpT7gGZ3zPSuoMMG7o/Hi0VbAYY=;
	b=N9bo/xDuY3hIkgofWK3tjWaO3KxjqMphYveqRK5waMQr+fzS5FWOe1MleQjk4+ktCPep8R
	bkKDY/FbCyns3SDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81EBC13694;
	Fri,  7 Feb 2025 05:17:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LJ1NDWGXpWf6FgAAD6G6ig
	(envelope-from <neilb@suse.de>); Fri, 07 Feb 2025 05:17:21 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/6] nfsd: filecache: use nfsd_file_dispose_list() in nfsd_file_close_inode_sync()
Date: Fri,  7 Feb 2025 16:15:12 +1100
Message-ID: <20250207051701.3467505-3-neilb@suse.de>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

nfsd_file_close_inode_sync() contains an exactly copy of
nfsd_file_dispose_list().

This patch removes it and calls nfsd_file_dispose_list() instead.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index b13255bcbb96..7dc20143c854 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -666,17 +666,12 @@ nfsd_file_close_inode(struct inode *inode)
 void
 nfsd_file_close_inode_sync(struct inode *inode)
 {
-	struct nfsd_file *nf;
 	LIST_HEAD(dispose);
 
 	trace_nfsd_file_close(inode);
 
 	nfsd_file_queue_for_close(inode, &dispose);
-	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
-		list_del_init(&nf->nf_gc);
-		nfsd_file_free(nf);
-	}
+	nfsd_file_dispose_list(&dispose);
 }
 
 static int
-- 
2.47.1


