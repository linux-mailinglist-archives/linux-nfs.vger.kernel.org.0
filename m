Return-Path: <linux-nfs+bounces-12433-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2CF9AD8856
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9619A3B2D35
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jun 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D12D5C6E;
	Fri, 13 Jun 2025 09:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLhjGxl1";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="mLhjGxl1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32062D8DD9
	for <linux-nfs@vger.kernel.org>; Fri, 13 Jun 2025 09:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749807933; cv=none; b=oBp9FaiON68MD8GAOELcWrayXpRJuIRmNbkXTkTUGzRrzkIzkwpA+pgz6CQvaVy4chF2wCY/2deDnsdHolP83R1GXs1MNKXrQ5oihXQFpuoDFGWTI72YEktrJmZviMmwL7tP4B9coVYQAVXYz2GBCYXzd3k2YYyN1Tiuzqa8RCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749807933; c=relaxed/simple;
	bh=tiHC4hXhhGqXwrTYPGlnD+6kE+5HjwnwPHJWuAhW/sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fPK2ORb1SreEj19gQQBQnfaODTE1M5P+XpXuVZz69yN2tmvVEETw5XLrJpQVK2ggRjFDlqXKTDYyGezi4TBt9ruktH/39OYEBkcuuCQr4KUKCRtGmRTXWIAjGULrL7nnoYD44sJB0LjXAiztG3Grw5/NRp7TJqt2Qp2wF96vIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLhjGxl1; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=mLhjGxl1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from kunlun.arch.suse.cz (unknown [10.100.128.76])
	by smtp-out1.suse.de (Postfix) with ESMTP id 47C1721903;
	Fri, 13 Jun 2025 09:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9VC+qbe+6tH+Kdye+fXQwUyC/AVihvNLEACk8mi2fM=;
	b=mLhjGxl14GKjO0cHbHPCjL32qdjh67RHxnnebomM5CwVwAXK0U1oMWbRsCgP1RTtzEL5fO
	jI9EcwT/DjK7VOAfbw72gMP1iC4BaKsAWmldu7QtXNFmv1zeeN0dJKZcgEAgNxOEAVH/8s
	iwjMBfGE7/ldrc3vAnabsfaPYFzTK4c=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1749807921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u9VC+qbe+6tH+Kdye+fXQwUyC/AVihvNLEACk8mi2fM=;
	b=mLhjGxl14GKjO0cHbHPCjL32qdjh67RHxnnebomM5CwVwAXK0U1oMWbRsCgP1RTtzEL5fO
	jI9EcwT/DjK7VOAfbw72gMP1iC4BaKsAWmldu7QtXNFmv1zeeN0dJKZcgEAgNxOEAVH/8s
	iwjMBfGE7/ldrc3vAnabsfaPYFzTK4c=
From: Anthony Iliopoulos <ailiop@suse.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] NFS: remove unused time_delta field from struct nfs_server
Date: Fri, 13 Jun 2025 11:44:38 +0200
Message-ID: <20250613094439.82338-3-ailiop@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613094439.82338-1-ailiop@suse.com>
References: <20250613094439.82338-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

The last code that was using this was removed via commit ca0daa277aca
("NFS: Cache aggressively when file is open for writing") which was
merged in v4.8-rc1, so it can be removed completely.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 fs/nfs/client.c           | 1 -
 include/linux/nfs_fs_sb.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/fs/nfs/client.c b/fs/nfs/client.c
index 23dafc590476..47258dc3af70 100644
--- a/fs/nfs/client.c
+++ b/fs/nfs/client.c
@@ -830,7 +830,6 @@ static void nfs_server_set_fsinfo(struct nfs_server *server,
 
 	server->maxfilesize = fsinfo->maxfilesize;
 
-	server->time_delta = fsinfo->time_delta;
 	server->change_attr_type = fsinfo->change_attr_type;
 
 	server->clone_blksize = fsinfo->clone_blksize;
diff --git a/include/linux/nfs_fs_sb.h b/include/linux/nfs_fs_sb.h
index 1aa89b41afd8..05c1aa5fc4e4 100644
--- a/include/linux/nfs_fs_sb.h
+++ b/include/linux/nfs_fs_sb.h
@@ -202,7 +202,6 @@ struct nfs_server {
 	struct nfs_fsid		fsid;
 	int			s_sysfs_id;	/* sysfs dentry index */
 	__u64			maxfilesize;	/* maximum file size */
-	struct timespec64	time_delta;	/* smallest time granularity */
 	unsigned long		mount_time;	/* when this fs was mounted */
 	struct super_block	*super;		/* VFS super block */
 	dev_t			s_dev;		/* superblock dev numbers */
-- 
2.49.0


