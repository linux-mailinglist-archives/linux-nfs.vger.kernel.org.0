Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AF22A2C0E
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgKBNvb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27156 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgKBNuW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=XrU0bFlBCj1V1T9Ebc6GurMHRM5nMTXgiahapsaXOSg=;
        b=feQkT0KpFTX5edz5UOY3H+FXaQj2lwfkIiMYbL91R29RQGS43dsMKQy8t6MY99lMG2qiTN
        6t2UEG1HxDqXUUMFLlJTTVij0+Io0MYsijuHMcwc7TTi77iR3hU5atvKGKVUmnu5qbyyN0
        2mr3JUh/IMNa13lf4Yi26vhX8BxnWOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-tvnBCHvmOu2yLV3w93J5_Q-1; Mon, 02 Nov 2020 08:50:19 -0500
X-MC-Unique: tvnBCHvmOu2yLV3w93J5_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE7918030BB;
        Mon,  2 Nov 2020 13:50:17 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EDA95DA6B;
        Mon,  2 Nov 2020 13:50:17 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 08/11] NFS: Replace LOOKUPCACHE dfprintk statements with tracepoints
Date:   Mon,  2 Nov 2020 08:50:08 -0500
Message-Id: <1604325011-29427-9-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Remove all the LOOKUPCACHE dfprintk statements in favor of
tracepoints based on existing tracing templates
DEFINE_NFS_LOOKUP_EVENT and DEFINE_NFS_LOOKUP_EVENT_DONE.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 27 ++++++++++++---------------
 fs/nfs/nfstrace.h |  8 ++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d8c3c3fdea75..52e06c8fc7cd 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1226,8 +1226,7 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 {
 	switch (error) {
 	case 1:
-		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is valid\n",
-			__func__, dentry);
+		trace_nfs_lookup_revalidate_done_valid(dir, dentry, 0);
 		return 1;
 	case 0:
 		nfs_mark_for_revalidate(dir);
@@ -1243,12 +1242,10 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 			if (IS_ROOT(dentry))
 				return 1;
 		}
-		dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) is invalid\n",
-				__func__, dentry);
+		trace_nfs_lookup_revalidate_done_invalid(dir, dentry, 0);
 		return 0;
 	}
-	dfprintk(LOOKUPCACHE, "NFS: %s(%pd2) lookup returned error %d\n",
-				__func__, dentry, error);
+	trace_nfs_lookup_revalidate_done_exit(dir, dentry, 0, error);
 	return error;
 }
 
@@ -1344,12 +1341,14 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 	nfs_inc_stats(dir, NFSIOS_DENTRYREVALIDATE);
 	inode = d_inode(dentry);
 
-	if (!inode)
+	if (!inode) {
+		trace_nfs_lookup_revalidate_negative_inode(dir, dentry,
+							   flags);
 		return nfs_lookup_revalidate_negative(dir, dentry, flags);
+	}
 
 	if (is_bad_inode(inode)) {
-		dfprintk(LOOKUPCACHE, "%s: %pd2 has dud inode\n",
-				__func__, dentry);
+		trace_nfs_lookup_revalidate_bad_inode(dir, dentry, flags);
 		goto out_bad;
 	}
 
@@ -1436,20 +1435,18 @@ static int nfs_weak_revalidate(struct dentry *dentry, unsigned int flags)
 	 * eventually need to do something more here.
 	 */
 	if (!inode) {
-		dfprintk(LOOKUPCACHE, "%s: %pd2 has negative inode\n",
-				__func__, dentry);
+		trace_nfs_weak_revalidate_negative_inode(inode, dentry,
+							 flags);
 		return 1;
 	}
 
 	if (is_bad_inode(inode)) {
-		dfprintk(LOOKUPCACHE, "%s: %pd2 has dud inode\n",
-				__func__, dentry);
+		trace_nfs_weak_revalidate_bad_inode(inode, dentry, flags);
 		return 0;
 	}
 
 	error = nfs_lookup_verify_inode(inode, flags);
-	dfprintk(LOOKUPCACHE, "NFS: %s: inode %lu is %s\n",
-			__func__, inode->i_ino, error ? "invalid" : "valid");
+	trace_nfs_weak_revalidate_exit(inode, dentry, flags, error);
 	return !error;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index e28551f70eab..06b301da85a2 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -386,6 +386,14 @@
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_exit);
 DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_enter);
 DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_exit);
+DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_negative_inode);
+DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_bad_inode);
+DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_done_valid);
+DEFINE_NFS_LOOKUP_EVENT(nfs_lookup_revalidate_done_invalid);
+DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_lookup_revalidate_done_exit);
+DEFINE_NFS_LOOKUP_EVENT(nfs_weak_revalidate_negative_inode);
+DEFINE_NFS_LOOKUP_EVENT(nfs_weak_revalidate_bad_inode);
+DEFINE_NFS_LOOKUP_EVENT_DONE(nfs_weak_revalidate_exit);
 
 TRACE_DEFINE_ENUM(O_WRONLY);
 TRACE_DEFINE_ENUM(O_RDWR);
-- 
1.8.3.1

