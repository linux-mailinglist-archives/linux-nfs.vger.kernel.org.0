Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839C8425FE8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Oct 2021 00:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbhJGWcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Oct 2021 18:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233370AbhJGWcs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Oct 2021 18:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633645853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mz2hPiZW43Ml1iJmYyn9808jlklT92BinqlidQSptIE=;
        b=aQm/GT4DuZfbWtIjPmGYlo9E2rZNdbG6x/flMHmrsCo8J5kZ3XPx6MdrqLK/2jDB/9OjH6
        dowdqKqkImbndrfNdMXDj1XEwtM5aBKG+OmKtrZn38lBOpPcr0IkcirKBBWnR53gkvR1sZ
        MBO/EeRAFnEZVSZtM4Pqll8jEVIFL7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-Ts52FDTXNLykI84-ijJ7vA-1; Thu, 07 Oct 2021 18:30:47 -0400
X-MC-Unique: Ts52FDTXNLykI84-ijJ7vA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1583E1923762;
        Thu,  7 Oct 2021 22:30:46 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.8.139])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 76C205D9C6;
        Thu,  7 Oct 2021 22:30:45 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com, linux-nfs@vger.kernel.org
Subject: [PATCH v2  3/7] NFS: Convert NFS fscache enable/disable dfprintks to tracepoints
Date:   Thu,  7 Oct 2021 18:30:19 -0400
Message-Id: <1633645823-31235-4-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
References: <1633645823-31235-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the enable / disable NFS fscache dfprintks to tracepoints.
Utilize the existing NFS inode trace event class, which allows us
to keep the same output format to other NFS inode tracepoints.
Start the names of the tracepoints with "nfs_fscache" for easy
identification.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/fscache.c  | 5 +++--
 fs/nfs/nfstrace.h | 2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 6764938eca2d..5f9be4a1b5f8 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -19,6 +19,7 @@
 #include "internal.h"
 #include "iostat.h"
 #include "fscache.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_FSCACHE
 
@@ -314,11 +315,11 @@ void nfs_fscache_open_file(struct inode *inode, struct file *filp)
 	nfs_fscache_update_auxdata(&auxdata, inode);
 
 	if (inode_is_open_for_write(inode)) {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p disabling cache\n", nfsi);
+		trace_nfs_fscache_disable_inode(inode);
 		clear_bit(NFS_INO_FSCACHE, &nfsi->flags);
 		fscache_disable_cookie(cookie, &auxdata, true);
 	} else {
-		dfprintk(FSCACHE, "NFS: nfsi 0x%p enabling cache\n", nfsi);
+		trace_nfs_fscache_enable_inode(inode);
 		fscache_enable_cookie(cookie, &auxdata, i_size_read(inode),
 				      nfs_fscache_can_enable, inode);
 		if (fscache_cookie_enabled(cookie))
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 8a224871be74..b79f5fe2e39d 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -209,6 +209,8 @@
 DEFINE_NFS_INODE_EVENT(nfs_fsync_enter);
 DEFINE_NFS_INODE_EVENT_DONE(nfs_fsync_exit);
 DEFINE_NFS_INODE_EVENT(nfs_access_enter);
+DEFINE_NFS_INODE_EVENT(nfs_fscache_enable_inode);
+DEFINE_NFS_INODE_EVENT(nfs_fscache_disable_inode);
 
 TRACE_EVENT(nfs_access_exit,
 		TP_PROTO(
-- 
1.8.3.1

