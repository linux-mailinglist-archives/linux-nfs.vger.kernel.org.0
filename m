Return-Path: <linux-nfs+bounces-11749-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F463AB899C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B3094E5B09
	for <lists+linux-nfs@lfdr.de>; Thu, 15 May 2025 14:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61C11EDA23;
	Thu, 15 May 2025 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAgP7oWr"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA381F0E2E
	for <linux-nfs@vger.kernel.org>; Thu, 15 May 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747320034; cv=none; b=jra5EmOFjqOCgbl0PuPny8/EVEjir34WEU8geCjQKvmI3acxCGIWfKVwsfbHplag5I3mrvxd7bU8ff8WjR5XE38mpMlx1UQkyDTZ8FX1rj0XjGVaWlAxKDXwSf21EA5qIx1peziNXqfC1ZoxhBUJHEHlMzu4tnfiseDNPSBzbyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747320034; c=relaxed/simple;
	bh=pnNVDfmMVGflt1aJCbSanJni9g7vSUrzuH/g6MTNUzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQq8OnbEunE0sF3JVQ9ZsNCZjKKVLGdMd3PsGxyZKGyEzjELQqDW/UM/2llFk8qdz632InANrx5k33o6tb768tA0fuoCrqiOzpJoE7fWLr0cukqFjccUyT76bI0kGm2psOAaG2wXarjrMErh8PPvX5Y2hJGqUiQtJ/5W4pPpVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAgP7oWr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747320031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIdJe37lGuP5OPF1ZRc+x73Qa7eTLyjB80y3+jpjkH8=;
	b=XAgP7oWrEO+EbzrazQ7Eftk2XsO4wlozjRvbH3BkgqER29HvlEJN/axjBKwoa61p4Co119
	+iymhydVPRhRcGCqsZRiffu9cPDy+kT+2noXj8Uyemkb0AmWhMQs2yJjTXagIXhtDnTYlM
	hFAItc93YweKYgxyeRAoiZ9a6N7K9zA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-m7-PIiOGNvyr-iVGFWciwg-1; Thu,
 15 May 2025 10:40:28 -0400
X-MC-Unique: m7-PIiOGNvyr-iVGFWciwg-1
X-Mimecast-MFC-AGG-ID: m7-PIiOGNvyr-iVGFWciwg_1747320027
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B7981800264;
	Thu, 15 May 2025 14:40:27 +0000 (UTC)
Received: from bcodding.csb.redhat.com (unknown [10.22.90.176])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 68416195608D;
	Thu, 15 May 2025 14:40:24 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	Lance Shelton <lance.shelton@hammerspace.com>
Subject: [PATCH v1 3/3] NFS: Return the file btime in the statx results when appropriate
Date: Thu, 15 May 2025 10:40:18 -0400
Message-ID: <fad0b4dc310de44bd511dc6fc0d96466d6ed44ea.1747318805.git.bcodding@redhat.com>
In-Reply-To: <cover.1747318805.git.bcodding@redhat.com>
References: <cover.1747318805.git.bcodding@redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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
index ffbcecb65bc7..6045d0a2e882 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -892,6 +892,7 @@ static void nfs_readdirplus_parent_cache_hit(struct dentry *dentry)
 
 static u32 nfs_get_valid_attrmask(struct inode *inode)
 {
+	u64 fattr_valid = NFS_SERVER(inode)->fattr_valid;
 	unsigned long cache_validity = READ_ONCE(NFS_I(inode)->cache_validity);
 	u32 reply_mask = STATX_INO | STATX_TYPE;
 
@@ -911,6 +912,9 @@ static u32 nfs_get_valid_attrmask(struct inode *inode)
 		reply_mask |= STATX_UID | STATX_GID;
 	if (!(cache_validity & NFS_INO_INVALID_BLOCKS))
 		reply_mask |= STATX_BLOCKS;
+	if (!(cache_validity & NFS_INO_INVALID_BTIME) &&
+	    (fattr_valid & NFS_ATTR_FATTR_BTIME))
+		reply_mask |= STATX_BTIME;
 	if (!(cache_validity & NFS_INO_INVALID_CHANGE))
 		reply_mask |= STATX_CHANGE_COOKIE;
 	return reply_mask;
@@ -921,6 +925,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 {
 	struct inode *inode = d_inode(path->dentry);
 	struct nfs_server *server = NFS_SERVER(inode);
+	u64 fattr_valid = server->fattr_valid;
 	unsigned long cache_validity;
 	int err = 0;
 	bool force_sync = query_flags & AT_STATX_FORCE_SYNC;
@@ -931,9 +936,12 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 
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
@@ -965,7 +973,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	/* Is the user requesting attributes that might need revalidation? */
 	if (!(request_mask & (STATX_MODE|STATX_NLINK|STATX_ATIME|STATX_CTIME|
 					STATX_MTIME|STATX_UID|STATX_GID|
-					STATX_SIZE|STATX_BLOCKS|
+					STATX_SIZE|STATX_BLOCKS|STATX_BTIME|
 					STATX_CHANGE_COOKIE)))
 		goto out_no_revalidate;
 
@@ -989,6 +997,8 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		do_update |= cache_validity & NFS_INO_INVALID_OTHER;
 	if (request_mask & STATX_BLOCKS)
 		do_update |= cache_validity & NFS_INO_INVALID_BLOCKS;
+	if (request_mask & STATX_BTIME)
+		do_update |= cache_validity & NFS_INO_INVALID_BTIME;
 
 	if (do_update) {
 		if (readdirplus_enabled)
@@ -1010,6 +1020,7 @@ int nfs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		stat->attributes |= STATX_ATTR_CHANGE_MONOTONIC;
 	if (S_ISDIR(inode->i_mode))
 		stat->blksize = NFS_SERVER(inode)->dtsize;
+	stat->btime = NFS_I(inode)->btime;
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 22c973316f0b..ba77bd8cbe6d 100644
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


