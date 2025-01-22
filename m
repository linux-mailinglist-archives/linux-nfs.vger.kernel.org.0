Return-Path: <linux-nfs+bounces-9452-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B11A18AD7
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 04:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4AAC3A3C9C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Jan 2025 03:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559D3136351;
	Wed, 22 Jan 2025 03:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nGvKF17F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZIzsyoZX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nGvKF17F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ZIzsyoZX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8221FAA
	for <linux-nfs@vger.kernel.org>; Wed, 22 Jan 2025 03:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737518203; cv=none; b=bCNvq9Rw/8sDx5m1gKM+29lJhxw8MBTjrdicmWX9IZRmcJy8qnSYyGB7OsOi2YG7VO9D5OJ8arGitCTbQI3RyZb+tmy9umrdpzhzzlR3wcX0Eyqu8YLSUpw8cCi+DOQDzJjEQC7Ynf9jaYGgQ3HwVWYZTympQlOi06GU2hfApr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737518203; c=relaxed/simple;
	bh=2OB1K81pQOWnf/9hNKIJxwqZa+LBSAB2TQ9OBDbM8Jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtDS1h91IMPmAhT832t8/egQAEKpQ+przUqLNkzub9BUgpBa+kkr51+opM3eZ3iVunMn8vW7YJ/EDL8KvUivgAKNA93qJsV6FHbLOGYvXYuXD6j1JUGo4aBu1zw8/aUBBRo5UxSDIATp2DePlE0W+qczueZ8qqWFnsmsuSaspuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nGvKF17F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZIzsyoZX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nGvKF17F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ZIzsyoZX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AA3FB1F78B;
	Wed, 22 Jan 2025 03:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3N0XTN+VLDtnHeRjOVo6Ik84WaCNtUaFaIQ4msW+mU=;
	b=nGvKF17FfKQzeuyg4tNuWkM0ZAZ2259ZT7x4byk1B37x4Vni05jWA17GnrAF3FLG84HqDA
	+cpEmoxov8YkrGkIwZhV4aKY4ldmB1vCCc5bEtAx97p6mhuqxaGX2z1xL/CRWQ/fkuwsax
	h64gtwyaaJwk5DHZvbQFn7wK6nETG6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3N0XTN+VLDtnHeRjOVo6Ik84WaCNtUaFaIQ4msW+mU=;
	b=ZIzsyoZXEiyrkttRYZYawaznIxHceXpIoo3UJzDWGdQW0s42a6II0pGWBK7AHSGuPzzzeM
	10+Mjk7RByTwFYDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nGvKF17F;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZIzsyoZX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1737518198; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3N0XTN+VLDtnHeRjOVo6Ik84WaCNtUaFaIQ4msW+mU=;
	b=nGvKF17FfKQzeuyg4tNuWkM0ZAZ2259ZT7x4byk1B37x4Vni05jWA17GnrAF3FLG84HqDA
	+cpEmoxov8YkrGkIwZhV4aKY4ldmB1vCCc5bEtAx97p6mhuqxaGX2z1xL/CRWQ/fkuwsax
	h64gtwyaaJwk5DHZvbQFn7wK6nETG6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1737518198;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B3N0XTN+VLDtnHeRjOVo6Ik84WaCNtUaFaIQ4msW+mU=;
	b=ZIzsyoZXEiyrkttRYZYawaznIxHceXpIoo3UJzDWGdQW0s42a6II0pGWBK7AHSGuPzzzeM
	10+Mjk7RByTwFYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 889FF136A1;
	Wed, 22 Jan 2025 03:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y0RkD3RskGfIWQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 22 Jan 2025 03:56:36 +0000
From: NeilBrown <neilb@suse.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 1/4] nfsd: filecache: use nfsd_file_dispose_list() in nfsd_file_close_inode_sync()
Date: Wed, 22 Jan 2025 14:54:07 +1100
Message-ID: <20250122035615.2893754-2-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122035615.2893754-1-neilb@suse.de>
References: <20250122035615.2893754-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA3FB1F78B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

nfsd_file_close_inode_sync() contains an exactly copy of
nfsd_file_dispose_list().

This patch removes it and calls nfsd_file_dispose_list() instead.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/filecache.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index fcd751cb7c76..d8f98e847dc0 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -682,17 +682,12 @@ nfsd_file_close_inode(struct inode *inode)
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


