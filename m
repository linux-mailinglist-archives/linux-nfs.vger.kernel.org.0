Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05F62A2C13
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKBNvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38642 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgKBNuT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=IflCTAsCltnUeNlhT1ftLYsSS43K+h1sSKXdsRM3zSA=;
        b=IOUogRT4bmLyIYCqBtFrTznLhcNttAm3Rx8T17FLr0w5kldhlikW0n9KVuJu46T5oqVKFz
        2j8hJrrugUP4KeVd/C1B2cEOthf2G3QMDo68Dba0OAHzWbPtbcKwtaUxYqg19t5YfdpxkZ
        zM1x5ySyjuYAQELKKzTLtmDvmUfyA8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-pYHksQS-Nj6ZCIx-up-inQ-1; Mon, 02 Nov 2020 08:50:16 -0500
X-MC-Unique: pYHksQS-Nj6ZCIx-up-inQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C23557097;
        Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 128BC5D9DD;
        Mon,  2 Nov 2020 13:50:15 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 03/11] NFS: Move nfs_readdir_descriptor_t into internal header
Date:   Mon,  2 Nov 2020 08:50:03 -0500
Message-Id: <1604325011-29427-4-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

In preparation for readdir tracing involving nfs_readdir_descriptor_t
move the definition into the "internal.h" header file, and ensure
internal.h is included before nfstrace.h to avoid build problems.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c      | 18 ------------------
 fs/nfs/internal.h | 18 ++++++++++++++++++
 fs/nfs/nfs3xdr.c  |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 116493e66922..145393188f6a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -144,24 +144,6 @@ struct nfs_cache_array {
 	struct nfs_cache_array_entry array[];
 };
 
-typedef struct {
-	struct file	*file;
-	struct page	*page;
-	struct dir_context *ctx;
-	unsigned long	page_index;
-	u64		*dir_cookie;
-	u64		last_cookie;
-	loff_t		current_index;
-	loff_t		prev_index;
-
-	unsigned long	dir_verifier;
-	unsigned long	timestamp;
-	unsigned long	gencount;
-	unsigned int	cache_entry_index;
-	bool plus;
-	bool eof;
-} nfs_readdir_descriptor_t;
-
 static
 void nfs_readdir_init_array(struct page *page)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 6673a77884d9..68ade987370d 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -62,6 +62,24 @@ static inline bool nfs_lookup_is_soft_revalidate(const struct dentry *dentry)
  */
 #define NFS_MAX_READDIR_PAGES 8
 
+typedef struct {
+	struct file	*file;
+	struct page	*page;
+	struct dir_context *ctx;
+	unsigned long	page_index;
+	u64		*dir_cookie;
+	u64		last_cookie;
+	loff_t		current_index;
+	loff_t		prev_index;
+
+	unsigned long	dir_verifier;
+	unsigned long	timestamp;
+	unsigned long	gencount;
+	unsigned int	cache_entry_index;
+	bool plus;
+	bool eof;
+} nfs_readdir_descriptor_t;
+
 struct nfs_client_initdata {
 	unsigned long init_flags;
 	const char *hostname;			/* Hostname of the server */
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 69971f6c840d..972759325de0 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -21,8 +21,8 @@
 #include <linux/nfs3.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfsacl.h>
-#include "nfstrace.h"
 #include "internal.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
-- 
1.8.3.1

