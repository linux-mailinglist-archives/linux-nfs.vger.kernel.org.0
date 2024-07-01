Return-Path: <linux-nfs+bounces-4480-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2795C91DD11
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 12:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576491C219C2
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DF812C52E;
	Mon,  1 Jul 2024 10:51:07 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6884D13
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831067; cv=none; b=oKrG54h3VGtQfxwn3YmV6RvmRXxUn9WUF7nOOW8ZBBsdov+vgBj1mgifqVRD89z2gAao63YwCYtpy/HguDitHVeJI+Ci2EcfFM4a8DJKIRhSklcg0UC8pBffzPgjBKHUGP7kvUDNUxRvHO0Bd0qxIZc+YMObZdLeHmFfpmSlWWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831067; c=relaxed/simple;
	bh=iGBynELGZMK2LYf8td7ocINQb+N7faDvcxMKhsg8yXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbsEHJWDN0s0ST229WlpdK7wYl4nGJ3Fc7NzvGnB/t39Ut9taMJKhkkfyZj+5epaqw+kjxYD8cCVyK08Z6oD/m01o+K1aF4C6wDmvRLkfeoZRyvQPt763da/0xRS6PM9FL1fEb8MstXSt/An86YOazhkApYwFmA7+tV4RVHuoec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 871851F8D6;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B15813A92;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bNILHhiKgmY4LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 10:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1EF89A084B; Mon,  1 Jul 2024 12:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 1/3] nfs: Drop pointless check from nfs_commit_release_pages()
Date: Mon,  1 Jul 2024 12:50:46 +0200
Message-Id: <20240701105056.25535-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617073525.10666-1-jack@suse.cz>
References: <20240617073525.10666-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1223; i=jack@suse.cz; h=from:subject; bh=iGBynELGZMK2LYf8td7ocINQb+N7faDvcxMKhsg8yXU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmgooFBr66GK4/afnDU6gguT+XVkHEYh88DQYr0djR 0rVo64KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZoKKBQAKCRCcnaoHP2RA2RzoB/ 0aNVG/7ylX2H5KitJwNkFrOscBmH2NGJddM/3X/y1edywIRS0Ko8gxVQbm9bLKryerRa8HB4f5Eh99 WA9J8QvT29FNR8rRhCy9RaWCGVc8urV3uh4jaYqPAc0U3mq14M8hSU17JsAv2OpXUZVSIVjg8r2jc2 Gdq/0YT00s2GSsexG9IkdAGKuKlngXVcH4gar03yZ912+WxbRW+4wWaqbjkzxfCF1cKFb0bqBsgIEQ 66K8Aul0aa3wTUnCTPiRDvxyRBALm7u4WbdcqddXYXcWTkzwPLTyVAnFPB204s+e4dlqwZIKaW7VK2 uoecYlXIkJxNEGWweVm5h7D8kz/8wC
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 871851F8D6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

nfss->writeback is updated only when we are ending page writeback and at
that moment we also clear nfss->write_congested. So there's no point in
rechecking congestion state in nfs_commit_release_pages(). Drop the
pointless check.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
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


