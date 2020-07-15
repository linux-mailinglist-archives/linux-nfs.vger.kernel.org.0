Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB6E221094
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jul 2020 17:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgGOPL6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jul 2020 11:11:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59648 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726830AbgGOPL4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jul 2020 11:11:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594825914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=4wotiqVbHYaAe4IwLLT5l9YK7WJ5NQWqMVC45h4uXjE=;
        b=YA5bm4zORKZJh9NhV6X0p2LNTQRbu5dL7AFCiIoRRdYzWgIBxqX8lEmoAoz1dVsR/gMdgd
        4RayAdOx9zY6jW4+K4JFyxDUMKqkLvgxqZ4a941mBeSlV8ZXXam48xEuIowvg6L0tfzM2k
        r02wqh+vetVhtqdWapGAp0Q8L+7UW8M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-d_ahxAN9PgihAYfKK6nE1g-1; Wed, 15 Jul 2020 11:11:52 -0400
X-MC-Unique: d_ahxAN9PgihAYfKK6nE1g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BEF6804333;
        Wed, 15 Jul 2020 15:10:56 +0000 (UTC)
Received: from dwysocha.rdu.csb (ovpn-118-79.rdu2.redhat.com [10.10.118.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A411560BF4;
        Wed, 15 Jul 2020 15:10:55 +0000 (UTC)
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH v1 08/13] NFS: Allow nfs_async_read_completion_ops to be used by other NFS code
Date:   Wed, 15 Jul 2020 11:10:44 -0400
Message-Id: <1594825849-24991-9-git-send-email-dwysocha@redhat.com>
In-Reply-To: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
References: <1594825849-24991-1-git-send-email-dwysocha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The standard read nfs_pgio_completion_ops will be needed when
fscache read path is converted to the new API, so export just to
other NFS code.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
---
 fs/nfs/internal.h | 1 +
 fs/nfs/read.c     | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index df4ffe9afb6a..5590f0883f94 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -443,6 +443,7 @@ extern char *nfs_path(char **p, struct dentry *dentry,
 
 struct nfs_pgio_completion_ops;
 /* read.c */
+extern const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 extern void nfs_pageio_init_read(struct nfs_pageio_descriptor *pgio,
 			struct inode *inode, bool force_mds,
 			const struct nfs_pgio_completion_ops *compl_ops);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index de57bb692a4b..2f2c32346212 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -30,7 +30,7 @@
 
 #define NFSDBG_FACILITY		NFSDBG_PAGECACHE
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops;
 static const struct nfs_rw_ops nfs_rw_read_ops;
 
 static struct kmem_cache *nfs_rdata_cachep;
@@ -215,7 +215,7 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 	}
 }
 
-static const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
+const struct nfs_pgio_completion_ops nfs_async_read_completion_ops = {
 	.error_cleanup = nfs_async_read_error,
 	.completion = nfs_read_completion,
 };
-- 
1.8.3.1

