Return-Path: <linux-nfs+bounces-3745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0859066C2
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 10:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99791F2306C
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jun 2024 08:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EE0142654;
	Thu, 13 Jun 2024 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qqr5+08j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4JvH915";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hzc9anyF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="md9O0Ijp"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127B713E03B
	for <linux-nfs@vger.kernel.org>; Thu, 13 Jun 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267322; cv=none; b=BGL3aRTi1mLG5fJpDo/i36rRWmy3wXrWgDNkNVmqW5qS2UH60d7OVlSfsMQLLKLGDw9HheeKxk8D3iZvQwZE9Rwzt1fBK6IDngLdE5RJQNKR94JRyA45VdU6EOaoP8enjkDOuVF9PdcxA/3CqZ3ydtqY3DS92wTNFlyDIfuuTdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267322; c=relaxed/simple;
	bh=HSnYnQ8CSQe3BnAYyevrYC7xyJa9NpzptogQ7j3U9YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snnl6dvrcU7FOTyFuNN4lK63a0ZV1qD3OTlLSaL1bcRlCeszcDmxnCQMI9GWozaR12c7NePHNnMzPAYD7spLqTqa1Dtm7I5+CYOboK+4HVM1kQwEjPDu453UqzDQQZry412FtdZ8+poVg+D1QRVeXdH8NtNeC/eqdVEhHvOKpNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qqr5+08j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4JvH915; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hzc9anyF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=md9O0Ijp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EEA8B5D007;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5nwBAYFD0cdcZNWh3+SGlT6ixsCG461/5j6ErYY3ec=;
	b=qqr5+08j2TTDnScEecEUIiVqJqp8ZfmLhYcwJxVN6w4keXsrzUJTskSkYW71eDseV+0PGp
	r6KjuDzsR6jGeemTrCBRNJurDcWs5q8LkFYWNPVWOzuNB02ZfwNQmJgoQG/z8Iic5ieC3z
	ud6qA7d87YMd/TRlXSdxn/xk0HQBP6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5nwBAYFD0cdcZNWh3+SGlT6ixsCG461/5j6ErYY3ec=;
	b=H4JvH915aEKcHFVaFmIXa8PJOIMYHkTOV+m5bP2/4agfQj8ivgZFEwCy+2omLYLxId08+1
	+ng3nc3Oi/1tJGAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Hzc9anyF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=md9O0Ijp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718267316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5nwBAYFD0cdcZNWh3+SGlT6ixsCG461/5j6ErYY3ec=;
	b=Hzc9anyFKtlPziOFQIl02VOak66WvqNd4uKpiyDmqm6/N1RVu0nMQeCsSp1WNUIv7aJK/Q
	nEDWQ2PVsq729PmYOxkN4pbqe9WYsPcV/ZdNlZNJK8UpPOOTdwZRQiMd9i3AE3oqNQNnjh
	mvu/niD/Yh2/sVBCh4q9PIBvr6KGaiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718267316;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T5nwBAYFD0cdcZNWh3+SGlT6ixsCG461/5j6ErYY3ec=;
	b=md9O0IjprB8jr+OhsOko7sAb5vadkWi1KPiq2VHYrLJ4TR38mWkHsEfAlLgY647ICo8zxu
	P9Fhi+4ZJ4/4yVAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E17CC13AB2;
	Thu, 13 Jun 2024 08:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yzQIN7StamY+XAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 13 Jun 2024 08:28:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 87DE6A088D; Thu, 13 Jun 2024 10:28:21 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: linux-nfs@vger.kernel.org,
	Neil Brown <neilb@suse.de>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] nfs: Block on write congestion
Date: Thu, 13 Jun 2024 10:28:19 +0200
Message-Id: <20240613082821.849-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240612153022.25454-1-jack@suse.cz>
References: <20240612153022.25454-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3821; i=jack@suse.cz; h=from:subject; bh=HSnYnQ8CSQe3BnAYyevrYC7xyJa9NpzptogQ7j3U9YU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmaq2ioOgGKmwXNoTZjbhRTF19r8jjM+ymUSRvMFHh BTyIRpyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZmqtogAKCRCcnaoHP2RA2XcMCA C9FaCjzVKrJvgI1zsMy9znQvzcW4YPmSyiwlGieTyftzTcaoi1amj2ZaW1taogisEoAEQnrIIVvW/w ApyvvhoiFbzVo0CPDre2SQAefG4cmzSz3hlOhn02yiYyHBuRjrf7WXDCF52K76BSorQLHoFoQaFB01 Zbwt3VuYJvRA+wol0nxG8hQKqu4FB8EFW6c/zfmJnKmU/qXl5KmOBVWmPEss4lp++wS67pwNaQp7CA 18FSqcjo2tP+MAjE2/cimod4etIYhRagy77gtXKmIS2rQZPEYlYpoocSkHg0NyWuWO8dGHyIqbUTFe rE2QpvVWnsAfrQYaDjWjjifsH/XTSs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EEA8B5D007
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/nfs/client.c           |  1 +
 fs/nfs/write.c            | 12 ++++++++----
 include/linux/nfs_fs_sb.h |  1 +
 3 files changed, 10 insertions(+), 4 deletions(-)

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
index c6255d7edd3c..21a5f1e90859 100644
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
@@ -698,12 +700,14 @@ int nfs_writepages(struct address_space *mapping, struct writeback_control *wbc)
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
+	if (wbc->sync_mode == WB_SYNC_NONE && nfss->write_congested)
+		wait_event(nfss->write_congestion_wait,
+			   nfss->write_congested == 0);
 
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


