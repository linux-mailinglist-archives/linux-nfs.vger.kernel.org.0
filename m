Return-Path: <linux-nfs+bounces-3746-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5B99066C3
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E6C1F22459
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 08:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37153142658;
	Thu, 13 Jun 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzCWfOjZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NjGoWyJf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Iysvj9RQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EQ7RWIdb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148B4142627
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267322; cv=none; b=eZwU2AM7KWtrkFYlZzueGSDeo7njQof784SW8cYxwvWZiWmtJSe5Q/VJLA8bl++DF/uBNo3NIlJ+8CIF0fXzkVdJaS54f+EfAQ6FuAwbe81lPJpumMgpY2l4VWjS/k3CStGV02s5xLZKKhYBrZf8+03UQw1VHe+slmSy/IGTfLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267322; c=relaxed/simple;
	bh=BOOXcQyyrcRDp1avX+twre5ldUqhQzRZ5CzX8/W4OtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EGenDLHpkollVPVrEHsPNxW5aYgrL9MmleAp2jioDyN/3DNDroaTg68Yp2wt+RKwiZsWHtZ0NSPJnf9fYIozlwZ0GXJLRuOFz+Hr0kfNqAdHpD2FhCyto3sSYYxyN8ANPIQoaHyaXuAtCEGRQRN07k4KGyMw0/ZQ7Wl8BK3FMI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzCWfOjZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NjGoWyJf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Iysvj9RQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EQ7RWIdb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E55DE350EC;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy1oMQ7hbYL3cewFkWjvf7wnviigrne+bNEArHf9amM=;
	b=pzCWfOjZik47g6dGJ7FSnnVKiOu+85q3EdjK5jQBtdwDkd2KFhLHFBaEQr9ufiX/r3hO/m
	osd68iCNs4A0EfXIi5AyotzhAnRKeyO+nLRL+ULJ/7tNNDibJerX1uP3JIr0iXNRn8nACZ
	5MQdaIQZQq9UAHx0Oo+3+dDnX0nqk2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy1oMQ7hbYL3cewFkWjvf7wnviigrne+bNEArHf9amM=;
	b=NjGoWyJf6r5Br4am0gNvFy5oTkaBp8wRu6/fbQWznAYNhGUiTRbxVq9kKUWbjHjO4/e34Q
	RjHDXUdyEkZusfAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Iysvj9RQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EQ7RWIdb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy1oMQ7hbYL3cewFkWjvf7wnviigrne+bNEArHf9amM=;
	b=Iysvj9RQObQFYRzFZQvYh73JfdEXIKntKv8l9M5GX4iDWDTwAxzy6Tif8G57CiNcjVnpSR
	rg5h5lMoK3yccPvTNayTdevXqkU0EYEa3sBSjDbRNbikKT0C6daOyF17amCap7YC/w+t6c
	Re2XmzEf1i+6MwyE8Cgcnla6H1AnRDI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uy1oMQ7hbYL3cewFkWjvf7wnviigrne+bNEArHf9amM=;
	b=EQ7RWIdb92qI0ps9/f8IJAaOtjoJVMNpF65RNOXt4b7P65qzIgWfUyVZXfRRJjdAxuUWz4
	8BrQlGQK13JiIsAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D901113AA0;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZevvNLStamY9XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 08:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79A37A082D; Thu, 13 Jun 2024 10:28:21 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] nfs: Drop pointless check from nfs_commit_release_pages()
Date: Thu, 13 Jun 2024 10:28:17 +0200
Message-Id: <20240613082821.849-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240612153022.25454-1-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129; i=jack@suse.cz; h=from:subject; bh=BOOXcQyyrcRDp1avX+twre5ldUqhQzRZ5CzX8/W4OtQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmaq2hKxU+UB2pPUbePY/qWx+kRuZSeXtTLlIRW82x IM0z/HqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZmqtoQAKCRCcnaoHP2RA2amyB/ 0dbAXoBmLklndtVK2kkpuk/Ukd9lKkizAVWC5fCNKA+9sK7qprgVzlgU3fDXQduUdJOGrt8XdU68Iv 9btwyfsoMPcEJ3IjXmQPnM1MNLB759AZD5uTt0cq7fgBNvXKa+LJCOh222LZ7cDGf0pD1O9DKMlpeu m3vR7c35L+wkaoBX2MHZlePe1zuFtTyG4a8EzENAiomzHA9AnM8nfjNziqnQu9zjuJwIDZD/WJeybC z3sTRNYqHu8E9cHOLmNKv4uBeNlxXFO4DQ0YT7ZD3qWASSs3lypiOQ7S6K3QanPEZDTgh46koQ/A6p WgsKA8g4zSj3xW53YkN1o6OS5/8U9b
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E55DE350EC
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

nfss->writeback is updated only when we are ending page writeback and at
that moment we also clear nfss->write_congested. So there's no point in
rechecking congestion state in nfs_commit_release_pages(). Drop the
pointless check.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/write.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 5fc12a721ec3..c6255d7edd3c 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1837,7 +1837,6 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 	struct nfs_page	*req;
 	int status = data->task.tk_status;
 	struct nfs_commit_info cinfo;
-	struct nfs_server *nfss;
 	struct folio *folio;
 
 	while (!list_empty(&data->pages)) {
@@ -1880,9 +1879,6 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		/* Latency breaker */
 		cond_resched();
 	}
-	nfss = NFS_SERVER(data->inode);
-	if (atomic_long_read(&nfss->writeback) < NFS_CONGESTION_OFF_THRESH)
-		nfss->write_congested = 0;
 
 	nfs_init_cinfo(&cinfo, data->inode, data->dreq);
 	nfs_commit_end(cinfo.mds);
-- 
2.35.3


