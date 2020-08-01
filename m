Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CA42351D8
	for <lists+linux-nfs@lfdr.de>; Sat,  1 Aug 2020 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHALKp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 1 Aug 2020 07:10:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23574 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728505AbgHALKo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 1 Aug 2020 07:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596280243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/EQuDSLLg9Pj4i8gEXHOTqDpgvW/Rl5kodnPfvkj5Q=;
        b=YZZWAWm2vW2DRsPydXNhhdZWeecf0bA0rlU6GEdA7vsbJ24GXh5XmgZ6y0gFCuRGXm/xCr
        NmlE3usi/ZCJSMOBHMqpmXrCqARaBJOkzcpSTAC1zyyeqDD7DWFBvDbYgxv2cwf5q29oHR
        P+9dwXhBtoAL8VqZ/qtrTWm84rH6ZbE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-5Zy5nSwNMxWZ9WnmEU5XQA-1; Sat, 01 Aug 2020 07:10:41 -0400
X-MC-Unique: 5Zy5nSwNMxWZ9WnmEU5XQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9FAA8015F3;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 676CC5F7D8;
        Sat,  1 Aug 2020 11:10:40 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 8F7601A0005; Sat,  1 Aug 2020 07:10:39 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 1/2] nfs: ensure correct writeback errors are returned on close()
Date:   Sat,  1 Aug 2020 07:10:38 -0400
Message-Id: <20200801111039.1407632-2-smayhew@redhat.com>
In-Reply-To: <20200801111039.1407632-1-smayhew@redhat.com>
References: <20200801111039.1407632-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_wb_all() calls filemap_write_and_wait(), which uses
filemap_check_errors() to determine the error to return.
filemap_check_errors() only looks at the mapping->flags and will
therefore only return either -ENOSPC or -EIO.  To ensure that the
correct error is returned on close(), nfs{,4}_file_flush() should call
filemap_check_wb_err() which looks at the errseq value in
mapping->wb_err without consuming it.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with
generic one")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/file.c     | 5 ++++-
 fs/nfs/nfs4file.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f96367a2463e..d72496efa17b 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -140,6 +140,7 @@ static int
 nfs_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
+	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -148,7 +149,9 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	since = filemap_sample_wb_err(file->f_mapping);
+	nfs_wb_all(inode);
+	return filemap_check_wb_err(file->f_mapping, since);
 }
 
 ssize_t
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd3..a33970765467 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -110,6 +110,7 @@ static int
 nfs4_file_flush(struct file *file, fl_owner_t id)
 {
 	struct inode	*inode = file_inode(file);
+	errseq_t since;
 
 	dprintk("NFS: flush(%pD2)\n", file);
 
@@ -125,7 +126,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 		return filemap_fdatawrite(file->f_mapping);
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	since = filemap_sample_wb_err(file->f_mapping);
+	nfs_wb_all(inode);
+	return filemap_check_wb_err(file->f_mapping, since);
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.25.4

