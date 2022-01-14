Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC85C48E8A5
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 11:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbiANKyr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 05:54:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232895AbiANKyr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 05:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642157686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kLHXz/GSZUAegTw8y+SE7mm2YpUGrqNT3Mv3k5xiq5U=;
        b=MG8y8oV+FQNMMtb7TzKxqcmRL3lHsws83yzFLDSoteCoREI03ssTGHyA1Pxl3/iKRhD+Np
        9qYmTzDIb07xav82QKDd1KJJiRzoakvOKf8msyj24npMd8yPT1fc83dFlV1vEWQs6Ro+7j
        fBjij00ljoJQ+dudQHMrOKpPJUMpCws=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-300-rVTYGBPQOJyWNTWcWf0qKA-1; Fri, 14 Jan 2022 05:54:45 -0500
X-MC-Unique: rVTYGBPQOJyWNTWcWf0qKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 318B8343CA;
        Fri, 14 Jan 2022 10:54:44 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.39.195.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A1ACE725;
        Fri, 14 Jan 2022 10:54:42 +0000 (UTC)
From:   Gonzalo Siero <gsierohu@redhat.com>
To:     trond.myklebust@hammerspace.com
Cc:     anna.schumaker@netapp.com, linux-nfs@vger.kernel.org,
        Gonzalo Siero <gsierohu@redhat.com>
Subject: [PATCH] NFS: limit block size reported for directories
Date:   Fri, 14 Jan 2022 11:54:39 +0100
Message-Id: <20220114105439.19347-1-gsierohu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

With the inclusion of this commit:

1a34c8c9a49e NFS: Support larger readdir buffers

We have observed that if we run 'ls -l' to get data from server, wait
few secs, and run it again on a directory of 80,000 files, second run
takes 53 secs with this commit vs 11 secs without it.

dtsize is set to rsize, but now is no longer limited to 8 pages.
Since we use it to report block size for directories, buffer being
allocated and passed to getdents could be up to 1Mb.

When running 'ls -l', if we have no data in memory for our directory,
we get the attributes in READDIR operations. If we run it again, and
the attributes have expired, the call to nfs_getattr() looking at first
cached entry will timeout and we will end up calling
nfs_force_use_readdirplus() to invalidate parent directory pagecache
pages. Subsequent nfs_getattr() calls on each entry returned in the
*first*  getdents64 call, ends up getting attributes from server. In
cases where we use large readdir buf, the number of entries returned
will be a lot more than before, and consecuently the number of GETATTR
calls.

Fix this by limiting to 32kb the reported block size for directories.
Note that even if we do more getdents syscalls, it still use large
readdir buffer, taking advantage of it.

Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
---
 fs/nfs/inode.c    | 6 +++++-
 fs/nfs/internal.h | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index fda530d5e764..f21530a5092d 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -917,8 +917,12 @@ int nfs_getattr(struct user_namespace *mnt_userns, const struct path *path,
 
 	generic_fillattr(&init_user_ns, inode, stat);
 	stat->ino = nfs_compat_user_ino64(NFS_FILEID(inode));
-	if (S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode)) {
 		stat->blksize = NFS_SERVER(inode)->dtsize;
+		/* Limit userland buf size for getdents */
+		if (stat->blksize > NFS_MAX_READDIR_BLOCK)
+			stat->blksize = NFS_MAX_READDIR_BLOCK;
+	}
 out:
 	trace_nfs_getattr_exit(inode, err);
 	return err;
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 12f6acb483bb..a75fe07bec29 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -56,6 +56,8 @@ static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
 #define NFS_UNSPEC_RETRANS	(UINT_MAX)
 #define NFS_UNSPEC_TIMEO	(UINT_MAX)
 
+#define NFS_MAX_READDIR_BLOCK	32768
+
 struct nfs_client_initdata {
 	unsigned long init_flags;
 	const char *hostname;			/* Hostname of the server */
-- 
2.21.3

