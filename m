Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2903C6B2D48
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Mar 2023 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjCIS77 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Mar 2023 13:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCIS7p (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Mar 2023 13:59:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86394867EC
        for <linux-nfs@vger.kernel.org>; Thu,  9 Mar 2023 10:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678388339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVBe2hO/2GOtOBxg8IYqIKor5QGj80/RVSIZqHG8NEU=;
        b=gmbhbxv3agzpG9G06eYyL3vVqdoPHOGNIPfusz6Hi+T9zcpmYK607jKdA901MeOolJXj/3
        NiWXTeq0DhLdYCec/BhyrzusWx4CyO4FMUnqIw0MaUbxi4bPL4TvaVbUAetJ3ioaKLMMs3
        128HKlgfrWhG587JScG67oujVJZ4rwk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-MgY9p4b_OP2x4-exMHe5lA-1; Thu, 09 Mar 2023 13:58:56 -0500
X-MC-Unique: MgY9p4b_OP2x4-exMHe5lA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7DCDC299E765;
        Thu,  9 Mar 2023 18:58:53 +0000 (UTC)
Received: from dwysocha.rdu.csb (unknown [10.22.16.140])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 554DA492B04;
        Thu,  9 Mar 2023 18:58:53 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/1] NFS: Fix /proc/PID/io read_bytes for buffered reads
Date:   Thu,  9 Mar 2023 13:58:52 -0500
Message-Id: <20230309185852.1151546-2-dwysocha@redhat.com>
In-Reply-To: <20230309185852.1151546-1-dwysocha@redhat.com>
References: <20230309185852.1151546-1-dwysocha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Prior to commit 8786fde8421c ("Convert NFS from readpages to
readahead"), nfs_readpages() used the old mm interface read_cache_pages()
which called task_io_account_read() for each NFS page read.  After
this commit, nfs_readpages() is converted to nfs_readahead(), which
now uses the new mm interface readahead_page().  The new interface
requires callers to call task_io_account_read() themselves.
In addition, to nfs_readahead() task_io_account_read() should also
be called from nfs_read_folio().

Fixes: 8786fde8421c ("Convert NFS from readpages to readahead")
Link: https://lore.kernel.org/linux-nfs/CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com/
Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/read.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index c380cff4108e..e90988591df4 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -15,6 +15,7 @@
 #include <linux/stat.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/task_io_accounting_ops.h>
 #include <linux/pagemap.h>
 #include <linux/sunrpc/clnt.h>
 #include <linux/nfs_fs.h>
@@ -337,6 +338,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 
 	trace_nfs_aop_readpage(inode, folio);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
+	task_io_account_read(folio_size(folio));
 
 	/*
 	 * Try to flush any pending writes to the file..
@@ -393,6 +395,7 @@ void nfs_readahead(struct readahead_control *ractl)
 
 	trace_nfs_aop_readahead(inode, readahead_pos(ractl), nr_pages);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGES);
+	task_io_account_read(readahead_length(ractl));
 
 	ret = -ESTALE;
 	if (NFS_STALE(inode))
-- 
2.31.1

