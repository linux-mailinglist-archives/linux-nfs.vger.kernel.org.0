Return-Path: <linux-nfs+bounces-11973-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32677AC7BEC
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 12:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EDD7AE118
	for <lists+linux-nfs@lfdr.de>; Thu, 29 May 2025 10:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADC31F37C5;
	Thu, 29 May 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M6shfTDy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664B0155335
	for <linux-nfs@vger.kernel.org>; Thu, 29 May 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515561; cv=none; b=Xib0ump4UGKVBYheUpDHAR6CrNiKmGYRp/8vnWT6N6wQ0GeLg6bQNAvzL/SO4V0TXjHaS0o42w5zY9q6X7Vr2gMrC7TG5tINBMER8j5GmQ0MTJYczjL915kSoynMZ6sSzlbBIrUceQvAKTBS5giOjxVGGw1LN9b3IlJQKK6T+tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515561; c=relaxed/simple;
	bh=k6BxRgMD0qMeB7Sapr5VeMt8+UCiTN70DAyTYUv8Fxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffRZzSiggSCEp2CwPWMUhnQFxQW9LZqmPDRHG+ZFvce1XvXgU7Y+fbtCyWiHiDyo1KvXKiglcsKcN6smeKixa63CYKZPcSzmaWye97sM5YyJjgXeJteFDL/gq1pmyJ+AfZi4a0mkPRm7BFsnTb0J/9pxLicRD1h7Uzb60vZv4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M6shfTDy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748515558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C9MjH5PrZ2RLlym57XAfhf6qulhemJKIL5FFs4qallE=;
	b=M6shfTDyYRV3es5uY8at/RawAju2fZ0Lz/nJ4ythfM0liSOqGxDavBZjvkYCPPtkQglKOD
	B8NXXreXXVFwn4tFfmn+Bkc29dNYZcM9AZw84mpKpCKSJmS376d23Kj5Zasadv8DwMp8G2
	vBkRNbue7urp2YLbh5JfpgCWVZDWCVU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-616-jJ6n5zWzNH6A8QUgdLlGoA-1; Thu,
 29 May 2025 06:45:54 -0400
X-MC-Unique: jJ6n5zWzNH6A8QUgdLlGoA-1
X-Mimecast-MFC-AGG-ID: jJ6n5zWzNH6A8QUgdLlGoA_1748515553
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 96240180048E;
	Thu, 29 May 2025 10:45:53 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.58.2])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AEC630002C0;
	Thu, 29 May 2025 10:45:52 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 3/3] NFS: Return the file btime in the statx results when appropriate
Date: Thu, 29 May 2025 06:45:47 -0400
Message-ID: <eae27d6467e08aaa67e0ac6ae7119263a0f83349.1748515333.git.bcodding@redhat.com>
In-Reply-To: <cover.1748515333.git.bcodding@redhat.com>
References: <cover.1748515333.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Trond Myklebust <trond.myklebust@hammerspace.com>

If the server supports the NFSv4.x "create_time" attribute, then return
it as part of the statx results.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/nfs/inode.c     | 15 +++++++++++++--
 fs/nfs/nfs4trace.h |  3 ++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 2e36188a855b..beea003abb8e 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -894,6 +894,7 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 
 static u32 nfs_get_valid_attrmask(struct inode *inode)
 {
+	u64 fattr_valid = NFS_SERVER(inode)->fattr_valid;
 	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
 	u32 reply_mask = STATX_INO | STATX_TYPE;
 
@@ -913,6 +914,9 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_BTIME) &&
+	    (fattr_valid & NFS_ATTR_FATTR_BTIME))
+		reply_mask |= STATX_BTIME;
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		reply_mask |= STATX_CHANGE_COOKIE;
 	return reply_mask;
@@ -923,6 +927,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
+	u64 fattr_valid = server->fattr_valid;
 	unsigned long cache_validity;
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
@@ -933,9 +938,12 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 	request_mask &= STATX_TYPE | STATX_MODE | STATX_NLINK | STATX_UID |
 			STATX_GID | STATX_ATIME | STATX_MTIME | STATX_CTIME |
-			STATX_INO | STATX_SIZE | STATX_BLOCKS |
+			STATX_INO | STATX_SIZE | STATX_BLOCKS | STATX_BTIME |
 			STATX_CHANGE_COOKIE;
 
+	if (!(fattr_valid & NFS_ATTR_FATTR_BTIME))
+		request_mask &= ~STATX_BTIME;
+
 	if ((query_flags & AT_STATX_DONT_SYNC) && !force_sync) {
 		if (readdirplus_enabled)
 			nfs_readdirplus_parent_cache_hit(path->dentry);
@@ -967,7 +975,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS|
+					STATX_SIZE|STATX_BLOCKS|STATX_BTIME|
 					STATX_CHANGE_COOKIE)))
 		goto out_no_revalidate;
 
@@ -991,6 +999,8 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
+	if (request_mask & STATX_BTIME)
+		do_update |= cache_validity & NFS_INO_INVALID_BTIME;
 
 	if (do_update) {
 		if (readdirplus_enabled)
@@ -1012,6 +1022,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
+	stat->btime = NFS_I(inode)->btime;
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index deab4c0e21a0..553e45502588 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -30,7 +30,8 @@
 		{ NFS_ATTR_FATTR_CTIME, "CTIME" }, \
 		{ NFS_ATTR_FATTR_CHANGE, "CHANGE" }, \
 		{ NFS_ATTR_FATTR_OWNER_NAME, "OWNER_NAME" }, \
-		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" })
+		{ NFS_ATTR_FATTR_GROUP_NAME, "GROUP_NAME" }, \
+		{ NFS_ATTR_FATTR_BTIME, "BTIME" })
 
 DECLARE_EVENT_CLASS(nfs4_clientid_event,
 		TP_PROTO(
-- 
2.47.0


