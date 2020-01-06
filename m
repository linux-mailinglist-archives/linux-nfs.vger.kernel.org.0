Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28513195E
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jan 2020 21:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgAFU1n (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jan 2020 15:27:43 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39450 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgAFU1n (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jan 2020 15:27:43 -0500
Received: by mail-yb1-f194.google.com with SMTP id b12so286231ybg.6
        for <linux-nfs@vger.kernel.org>; Mon, 06 Jan 2020 12:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w/hIVE15LYVNdry3NEjE4WnBoq/bUjrBpu/8rkj/OzA=;
        b=gdYS+JL1FFSNq+ovAt0B/Wjfl1Flf4TtUntljbQ2KuRR8/p9o0zJ8FiYhTNDgSSCFN
         xoawP9fIMClWH4EDF1F2TPmQXKW9bf/fpmhWQ7DXFjtQEVs+5UPq2DOtqg/6wSYfYlcZ
         rRisf4mrLvKcLsY4iBLKM4cGGKCFyjVPz/kmWBg52qy6kO/wJPARAwbIaPwCa0nvC1u8
         2bfEiGVjdklKyS33YzwLslCVHoN8wmwI7gAcBch+vxZ+lJdTNjKP54Kg2i1j/xBSezkg
         EnVH8T1k8NGFiFN4CEpyda4zvRShtyHPvQSdm2g1F9rKexuNPVYCvZqn+K1+xs0TkgJg
         3xqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w/hIVE15LYVNdry3NEjE4WnBoq/bUjrBpu/8rkj/OzA=;
        b=knZdQ1QjBWYyjqNrU9H8awq94ZYGwgifDistCOTh/bJI3y4jXBodTbAUTVl2eVmkBU
         KX7Mj9tyft4AyFGHrQIl42DMJKWRjbqxXh9nE0xMlD6Ed+L6cOENKkgVedjzV/3UkiNG
         A7jKzhlJ8Nip3Psnb5Wiz3uGbXhPbPfyhjcgoYeQ4Xy1eRgG0Q8VpP/3+dyen2x/pq8k
         Zyb0ruyQowJmsHaPrq3OiIipxsD6h5bbFZZuo+x/eEKlm2f9QpqaxMavgCNV+F6+biL3
         wvw4U7nFgnyZhwD0JBZhTbAbKpMfXnxjkNPH0uXS6yRmPCPiOaCaSRVYr0RuK2QjBsBK
         0PoA==
X-Gm-Message-State: APjAAAVbZ8OqvVEL8kaVUAC1Fge/NEkUapdL8L1H9eY9shJ63aJVLCQ2
        IqiD8EIC4S2DwwkMFqs5IkEoPUnv6g==
X-Google-Smtp-Source: APXvYqzeCF7wCAQ3OPCCNWJP6+SZnqOXuuYXz0zRrkZmK3CwxGMnzLcm6n9iTSngtr1ke+lkVyN9BA==
X-Received: by 2002:a25:d03:: with SMTP id 3mr23848685ybn.368.1578342462151;
        Mon, 06 Jan 2020 12:27:42 -0800 (PST)
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net. [68.40.189.247])
        by smtp.gmail.com with ESMTPSA id l200sm28723579ywl.106.2020.01.06.12.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 12:27:41 -0800 (PST)
From:   Trond Myklebust <trondmy@gmail.com>
X-Google-Original-From: Trond Myklebust <trond.myklebust@hammerspace.com>
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 13/15] NFS: Improve tracing of permission calls
Date:   Mon,  6 Jan 2020 15:25:12 -0500
Message-Id: <20200106202514.785483-14-trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106202514.785483-13-trond.myklebust@hammerspace.com>
References: <20200106202514.785483-1-trond.myklebust@hammerspace.com>
 <20200106202514.785483-2-trond.myklebust@hammerspace.com>
 <20200106202514.785483-3-trond.myklebust@hammerspace.com>
 <20200106202514.785483-4-trond.myklebust@hammerspace.com>
 <20200106202514.785483-5-trond.myklebust@hammerspace.com>
 <20200106202514.785483-6-trond.myklebust@hammerspace.com>
 <20200106202514.785483-7-trond.myklebust@hammerspace.com>
 <20200106202514.785483-8-trond.myklebust@hammerspace.com>
 <20200106202514.785483-9-trond.myklebust@hammerspace.com>
 <20200106202514.785483-10-trond.myklebust@hammerspace.com>
 <20200106202514.785483-11-trond.myklebust@hammerspace.com>
 <20200106202514.785483-12-trond.myklebust@hammerspace.com>
 <20200106202514.785483-13-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On exit from nfs_do_access(), record the mask representing the requested
permissions, as well as the server-supplied set of access rights for
this user.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/dir.c      |  4 ++--
 fs/nfs/nfstrace.h | 61 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e180033e35cf..372c16b3042c 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2476,7 +2476,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 {
 	struct nfs_access_entry cache;
 	bool may_block = (mask & MAY_NOT_BLOCK) == 0;
-	int cache_mask;
+	int cache_mask = -1;
 	int status;
 
 	trace_nfs_access_enter(inode);
@@ -2515,7 +2515,7 @@ static int nfs_do_access(struct inode *inode, const struct cred *cred, int mask)
 	if ((mask & ~cache_mask & (MAY_READ | MAY_WRITE | MAY_EXEC)) != 0)
 		status = -EACCES;
 out:
-	trace_nfs_access_exit(inode, status);
+	trace_nfs_access_exit(inode, mask, cache_mask, status);
 	return status;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 51043f02e86f..b43f1b2501db 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -198,7 +198,66 @@ DEFINE_NFS_INODE_EVENT_DONE(nfs_writeback_inode_exit);
 DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
-DEFINE_NFS_INODE_EVENT_DONE(nfs_access_exit);
+
+TRACE_EVENT(nfs_access_exit,
+		TP_PROTO(
+			const struct inode *inode,
+			unsigned int mask,
+			unsigned int permitted,
+			int error
+		),
+
+		TP_ARGS(inode, mask, permitted, error),
+
+		TP_STRUCT__entry(
+			__field(unsigned long, error)
+			__field(dev_t, dev)
+			__field(u32, fhandle)
+			__field(unsigned char, type)
+			__field(u64, fileid)
+			__field(u64, version)
+			__field(loff_t, size)
+			__field(unsigned long, nfsi_flags)
+			__field(unsigned long, cache_validity)
+			__field(unsigned int, mask)
+			__field(unsigned int, permitted)
+		),
+
+		TP_fast_assign(
+			const struct nfs_inode *nfsi = NFS_I(inode);
+			__entry->error = error < 0 ? -error : 0;
+			__entry->dev = inode->i_sb->s_dev;
+			__entry->fileid = nfsi->fileid;
+			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
+			__entry->type = nfs_umode_to_dtype(inode->i_mode);
+			__entry->version = inode_peek_iversion_raw(inode);
+			__entry->size = i_size_read(inode);
+			__entry->nfsi_flags = nfsi->flags;
+			__entry->cache_validity = nfsi->cache_validity;
+			__entry->mask = mask;
+			__entry->permitted = permitted;
+		),
+
+		TP_printk(
+			"error=%ld (%s) fileid=%02x:%02x:%llu fhandle=0x%08x "
+			"type=%u (%s) version=%llu size=%lld "
+			"cache_validity=0x%lx (%s) nfs_flags=0x%lx (%s) "
+			"mask=0x%x permitted=0x%x",
+			-__entry->error, nfs_show_status(__entry->error),
+			MAJOR(__entry->dev), MINOR(__entry->dev),
+			(unsigned long long)__entry->fileid,
+			__entry->fhandle,
+			__entry->type,
+			nfs_show_file_type(__entry->type),
+			(unsigned long long)__entry->version,
+			(long long)__entry->size,
+			__entry->cache_validity,
+			nfs_show_cache_validity(__entry->cache_validity),
+			__entry->nfsi_flags,
+			nfs_show_nfsi_flags(__entry->nfsi_flags),
+			__entry->mask, __entry->permitted
+		)
+);
 
 TRACE_DEFINE_ENUM(LOOKUP_FOLLOW);
 TRACE_DEFINE_ENUM(LOOKUP_DIRECTORY);
-- 
2.24.1

