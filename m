Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E83E2A2C01
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 14:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgKBNvO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 08:51:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29956 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725977AbgKBNuZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 08:50:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604325024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=RZvZSydwz/5QL+VCmevCndZgN+O/mqIZB0qW8LBfxLs=;
        b=NUNC+PPUiCX8E7qc7WaG93dVbG0yzHSWqgNeNrAZcKlzKDbA384UZqAsGtSfO6rD14WGms
        zII3eCFNDr81MO6JBa1gmc6T4iz6QmqVD3HdMugo/r1jGAmmcanAzHNU03s8SPXoJongSL
        /NLBrXXxsDai3TIa3cvgTnNewdTc19s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-HtZG3wlVP-KaksBlcyCMcw-1; Mon, 02 Nov 2020 08:50:20 -0500
X-MC-Unique: HtZG3wlVP-KaksBlcyCMcw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77A8110A0BA8;
        Mon,  2 Nov 2020 13:50:19 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-113-255.rdu2.redhat.com [10.10.113.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 09C5F5DEBD;
        Mon,  2 Nov 2020 13:50:18 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 11/11] NFS: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()
Date:   Mon,  2 Nov 2020 08:50:11 -0500
Message-Id: <1604325011-29427-12-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

commit 79f687a3de9e ("NFS: Fix a performance regression in readdir")
removed nfs_dir_mapping_need_revalidate() in an attempt to fix a
performance regression, but had the effect that with NFSv3 the
pagecache would never expire while a process was reading a directory.
An earlier patch addressed this problem by allowing the pagecache
to expire but the current process to continue using the last cookie
returned by the server when searching the pagecache, rather than
always starting at 0.  Thus, bring back nfs_dir_mapping_need_revalidate()
so that nfsi->cache_validity & NFS_INO_INVALID_DATA will be seen
and nfs_revalidate_mapping() will be called with NFSv3 as well,
making it behave the same as NFSv4.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/dir.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index cbd74cbdbb9f..aeb086fb3d0a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -872,6 +872,17 @@ int uncached_readdir(nfs_readdir_descriptor_t *desc)
 	return status;
 }
 
+static bool nfs_dir_mapping_need_revalidate(struct inode *dir)
+{
+	struct nfs_inode *nfsi = NFS_I(dir);
+
+	if (nfs_attribute_cache_expired(dir))
+		return true;
+	if (nfsi->cache_validity & NFS_INO_INVALID_DATA)
+		return true;
+	return false;
+}
+
 /* The file offset position represents the dirent entry number.  A
    last cookie cache takes care of the common case of reading the
    whole directory.
@@ -903,7 +914,7 @@ static int nfs_readdir(struct file *file, struct dir_context *ctx)
 	 * to either find the entry with the appropriate number or
 	 * revalidate the cookie.
 	 */
-	if (ctx->pos == 0 || nfs_attribute_cache_expired(inode))
+	if (ctx->pos == 0 || nfs_dir_mapping_need_revalidate(inode))
 		res = nfs_revalidate_mapping(inode, file->f_mapping);
 	if (res < 0)
 		goto out;
-- 
1.8.3.1

