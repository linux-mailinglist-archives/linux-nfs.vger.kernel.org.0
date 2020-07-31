Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED923234A6D
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jul 2020 19:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgGaRqT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 31 Jul 2020 13:46:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57908 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387429AbgGaRqT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 31 Jul 2020 13:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596217578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qFPO+Z15nztX6EIfKvMpKcaydKBsQ7RALeC0PvYnrFg=;
        b=bDxq42QBiT0nkQXN7Yo2loNlBEvnVVALVFTijsHtyXDMW+79m91oawySvfzXnlgxEjE/QO
        YNFqqaWvRW3hTwRAxLzJaeQlJc3SwWuhxVzShG13oUsvYono71igDBjOcmd8Tj5r3EFsL/
        uxhhNVxAjRBH8hYN+g9X13qt7OKlKKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-VdaqVV9jNKyEAvrC9yiT6Q-1; Fri, 31 Jul 2020 13:46:16 -0400
X-MC-Unique: VdaqVV9jNKyEAvrC9yiT6Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C92618839CD;
        Fri, 31 Jul 2020 17:46:15 +0000 (UTC)
Received: from aion.usersys.redhat.com (ovpn-115-198.rdu2.redhat.com [10.10.115.198])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 612425BAC3;
        Fri, 31 Jul 2020 17:46:15 +0000 (UTC)
Received: by aion.usersys.redhat.com (Postfix, from userid 1000)
        id 7857C1A0005; Fri, 31 Jul 2020 13:46:14 -0400 (EDT)
From:   Scott Mayhew <smayhew@redhat.com>
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs: ensure correct writeback errors are returned on close()
Date:   Fri, 31 Jul 2020 13:46:13 -0400
Message-Id: <20200731174614.1299346-2-smayhew@redhat.com>
In-Reply-To: <20200731174614.1299346-1-smayhew@redhat.com>
References: <20200731174614.1299346-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

nfs_wb_all() calls filemap_write_and_wait(), which uses
filemap_check_errors() to determine the error to return.
filemap_check_errors() only looks at the mapping->flags and will
therefore only return either -ENOSPC or -EIO.  To ensure that the
correct error is returned on close(), nfs{,4}_file_flush() should call
file_check_and_advance_wb_err() which looks at the errseq value in
mapping->wb_err.

Fixes: 6fbda89b257f ("NFS: Replace custom error reporting mechanism with
generic one")
Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 fs/nfs/file.c     | 3 ++-
 fs/nfs/nfs4file.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index f96367a2463e..eeef6580052f 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -148,7 +148,8 @@ nfs_file_flush(struct file *file, fl_owner_t id)
 		return 0;
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	nfs_wb_all(inode);
+	return file_check_and_advance_wb_err(file);
 }
 
 ssize_t
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 8e5d6223ddd3..77bf9c12734c 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -125,7 +125,8 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 		return filemap_fdatawrite(file->f_mapping);
 
 	/* Flush writes to the server and return any errors */
-	return nfs_wb_all(inode);
+	nfs_wb_all(inode);
+	return file_check_and_advance_wb_err(file);
 }
 
 #ifdef CONFIG_NFS_V4_2
-- 
2.25.4

