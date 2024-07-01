Return-Path: <linux-nfs+bounces-4483-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8228D91DD16
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 12:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E81C21A0A
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Jul 2024 10:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B4813DBB3;
	Mon,  1 Jul 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8TiqL7O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RDA01fM8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="E8TiqL7O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RDA01fM8"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDA12D1EA
	for <linux-nfs@vger.kernel.org>; Mon,  1 Jul 2024 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719831071; cv=none; b=HrfetrWs7MFhOA7W7L/JgbhYfyJv6IaWRvbmkxvYJbSLWrJ2BO/C/iU3aDugC0L9QyY0XlhCq8fjoDmq/1G0YXbz3sRY6AZf7Rw8uaSv6b2BCv5uuOKkMhv5ankpDFLnaVLX+sQh3nblmhZfgWr42zLBNpRCxJhNB/K4Z5KGLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719831071; c=relaxed/simple;
	bh=ji42WWCNenrN+kJSOYSr9QOs3fFhds4dbOa0us3qD2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MwDGfW8duphTCPjSa7tAmqe4BknpF1PZZmilGo/xQ8tDqPMvskl8ObjxKuAyFEq5Hgeo44MbX5JJ+pjXL0JIE/5ExD2RsdmiUesDYMl+KQdajubnLfhKkYmgoJqadgERBK0/Plx01HgXdSmPL8aN5DnuSY+IJn8rA5Z5efde2pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8TiqL7O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RDA01fM8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=E8TiqL7O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RDA01fM8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8D92221AE6;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQS8SqYUp2MnVycGj0ndZZM1N25CO36WSVxtjGhxQvg=;
	b=E8TiqL7OW7JRqcK43/cd7ptLWAowwK55h+SSkXjqWCPxTb3xxbzidvj5ah0RIySGqKZ+5/
	pNjkOB5jffKzD9Rw4ztsWJF74Ijw+wxxd5XIheBYU5G20tIgNF551NFMgtVJQFeY9+P7b8
	W/tbQH6VRbi5EKuYOLUlM9Z9OE8cgtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQS8SqYUp2MnVycGj0ndZZM1N25CO36WSVxtjGhxQvg=;
	b=RDA01fM8QtzzuVMAhLuoy5J0yV2njICB9KxTZ8Lu4gjVFNHQZ6lLvbEE+S6RjqSvmDA/HJ
	e2WoSrobE+lyZFDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719831064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQS8SqYUp2MnVycGj0ndZZM1N25CO36WSVxtjGhxQvg=;
	b=E8TiqL7OW7JRqcK43/cd7ptLWAowwK55h+SSkXjqWCPxTb3xxbzidvj5ah0RIySGqKZ+5/
	pNjkOB5jffKzD9Rw4ztsWJF74Ijw+wxxd5XIheBYU5G20tIgNF551NFMgtVJQFeY9+P7b8
	W/tbQH6VRbi5EKuYOLUlM9Z9OE8cgtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719831064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wQS8SqYUp2MnVycGj0ndZZM1N25CO36WSVxtjGhxQvg=;
	b=RDA01fM8QtzzuVMAhLuoy5J0yV2njICB9KxTZ8Lu4gjVFNHQZ6lLvbEE+S6RjqSvmDA/HJ
	e2WoSrobE+lyZFDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F34D13AC4;
	Mon,  1 Jul 2024 10:51:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L7/AHhiKgmY5LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jul 2024 10:51:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 305DBA08AD; Mon,  1 Jul 2024 12:50:56 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trondmy@kernel.org>,
	linux-nfs@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Jeff Layton <jlayton@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v2 3/3] nfs: Block on write congestion
Date: Mon,  1 Jul 2024 12:50:48 +0200
Message-Id: <20240701105056.25535-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617073525.10666-1-jack@suse.cz>
References: <20240617073525.10666-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3971; i=jack@suse.cz; h=from:subject; bh=ji42WWCNenrN+kJSOYSr9QOs3fFhds4dbOa0us3qD2A=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNKauthvzUyc37ilsYK14YR+I2vFuWx5NxYeGy+RLzZB6u9U RIs7GY1ZGBg5GGTFFFlWR17UvjbPqGtrqIYMzCBWJpApDFycAjARwVAOhu2cS7N2OPa5LDx97HeGyS y/E/Hi8+/NX3BBM9/l7mWhdlmGuNI9pWd+7OjoeH0oR3DGI8M+15ZvfWdseiwTK8O8tNhPXLq7LMiW a+LuS1lC4qvCvZ+E7N+5rY+57lLE5+gFN52WPTjT/VJccMrpPbfC9cRv6c8vEzn/K1Bt4/WtTcvc7l 5mCrE6EFFRyNH1zyhKICimIsLNa4vYe8U/Vql8L8zabj8xsLOa4/eRoXDKzm07vY5Jdvy7Y8K5RpuD zan/pd7bWq91ladv7E1elBT73uPCjoikiOtZ3ualUzdH2ux8VJBXk6KgqvEj17Ei4wGD0eHX18Wv/S 6YpqNlZ8Ep1blhfRD/9zMlOdZ1AA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

Commit 6df25e58532b ("nfs: remove reliance on bdi congestion")
introduced NFS-private solution for limiting number of writes
outstanding against a particular server. Unlike previous bdi congestion
this algorithm actually works and limits number of outstanding writeback
pages to nfs_congestion_kb which scales with amount of client's memory
and is capped at 256 MB. As a result some workloads such as random
buffered writes over NFS got slower (from ~170 MB/s to ~126 MB/s). The
fio command to reproduce is:

fio --direct=0 --ioengine=sync --thread --invalidate=1 --group_reporting=1
  --runtime=300 --fallocate=posix --ramp_time=10 --new_group --rw=randwrite
  --size=64256m --numjobs=4 --bs=4k --fsync_on_close=1 --end_fsync=1

This happens because the client sends ~256 MB worth of dirty pages to
the server and any further background writeback request is ignored until
the number of writeback pages gets below the threshold of 192 MB. By the
time this happens and clients decides to trigger another round of
writeback, the server often has no pages to write and the disk is idle.

To fix this problem and make the client react faster to eased congestion
of the server by blocking waiting for congestion to resolve instead of
aborting writeback. This improves the random 4k buffered write
throughput to 184 MB/s.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/write.c            | 15 +++++++++++----
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 3b252dceebf5..8286edd6062d 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -994,6 +994,7 @@ struct nfs_server *nfs_alloc_server(void)
 
 	server->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 
+	init_waitqueue_head(&server->write_congestion_wait);
 	atomic_long_set(&server->writeback, 0);
 
 	ida_init(&server->openowner_id);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index c6255d7edd3c..d5f8f77a2352 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -423,8 +423,10 @@ static void nfs_folio_end_writeback(struct folio *folio)
 
 	folio_end_writeback(folio);
 	if (atomic_long_dec_return(&nfss->writeback) <
-	    NFS_CONGESTION_OFF_THRESH)
+	    NFS_CONGESTION_OFF_THRESH) {
 		nfss->write_congested = 0;
+		wake_up_all(&nfss->write_congestion_wait);
+	}
 }
 
 static void nfs_page_end_writeback(struct nfs_page *req)
@@ -698,12 +700,17 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
 	struct nfs_pageio_descriptor pgio;
 	struct nfs_io_completion *ioc = NULL;
 	unsigned int mntflags = NFS_SERVER(inode)->flags;
+	struct nfs_server *nfss = NFS_SERVER(inode);
 	int priority = 0;
 	int err;
 
-	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    NFS_SERVER(inode)->write_congested)
-		return 0;
+	/* Wait with writeback until write congestion eases */
+	if (wbc->sync_mode == WB_SYNC_NONE && nfss->write_congested) {
+		err = wait_event_killable(nfss->write_congestion_wait,
+					  nfss->write_congested == 0);
+		if (err)
+			return err;
+	}
 
 	nfs_inc_stats(inode, NFSIOS_VFSWRITEPAGES);
 
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 92de074e63b9..38a128796a76 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -140,6 +140,7 @@ struct nfs_server {
 	struct rpc_clnt *	client_acl;	/* ACL RPC client handle */
 	struct nlm_host		*nlm_host;	/* NLM client handle */
 	struct nfs_iostats __percpu *io_stats;	/* I/O statistics */
+	wait_queue_head_t	write_congestion_wait;	/* wait until write congestion eases */
 	atomic_long_t		writeback;	/* number of writeback pages */
 	unsigned int		write_congested;/* flag set when writeback gets too high */
 	unsigned int		flags;		/* various flags */
-- 
2.35.3


