Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23B742AE5
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Jun 2019 17:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408744AbfFLP0H (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Jun 2019 11:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408070AbfFLP0H (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 12 Jun 2019 11:26:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A438820874;
        Wed, 12 Jun 2019 15:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560353166;
        bh=TSjXxGX/iopIFXqQUxKIILrbVvon9SuUKBVCxHltuYE=;
        h=Date:From:To:Cc:Subject:From;
        b=s9H1kLkauLGkRRxEOp97HAjoqWV9Qe9wvfrQQ6RFtlUPE+VUUKmayW59VM+NcJ660
         edLgCm+h1+rAxQarkhjndLV6Ffd8MMEy5xACrHZoKXWwDsZLF7I1WZle1t2K0W4taM
         G0vMxDfvb3MJV6eBr9Ky4shdwccEhWuQNOw1IGec=
Date:   Wed, 12 Jun 2019 17:26:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] nfsd: no need to check return value of debugfs_create
 functions
Message-ID: <20190612152603.GB18440@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: "J. Bruce Fields" <bfields@fieldses.org>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nfsd/fault_inject.c | 12 ++----------
 fs/nfsd/nfsctl.c       |  5 +----
 fs/nfsd/state.h        |  4 ++--
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/fault_inject.c b/fs/nfsd/fault_inject.c
index 84831253203d..76bee0a0d308 100644
--- a/fs/nfsd/fault_inject.c
+++ b/fs/nfsd/fault_inject.c
@@ -127,24 +127,16 @@ static struct nfsd_fault_inject_op inject_ops[] = {
 	},
 };
 
-int nfsd_fault_inject_init(void)
+void nfsd_fault_inject_init(void)
 {
 	unsigned int i;
 	struct nfsd_fault_inject_op *op;
 	umode_t mode = S_IFREG | S_IRUSR | S_IWUSR;
 
 	debug_dir = debugfs_create_dir("nfsd", NULL);
-	if (!debug_dir)
-		goto fail;
 
 	for (i = 0; i < ARRAY_SIZE(inject_ops); i++) {
 		op = &inject_ops[i];
-		if (!debugfs_create_file(op->file, mode, debug_dir, op, &fops_nfsd))
-			goto fail;
+		debugfs_create_file(op->file, mode, debug_dir, op, &fops_nfsd);
 	}
-	return 0;
-
-fail:
-	nfsd_fault_inject_cleanup();
-	return -ENOMEM;
 }
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 62c58cfeb8d8..6a9de59d9633 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1291,9 +1291,7 @@ static int __init init_nfsd(void)
 	retval = nfsd4_init_pnfs();
 	if (retval)
 		goto out_free_slabs;
-	retval = nfsd_fault_inject_init(); /* nfsd fault injection controls */
-	if (retval)
-		goto out_exit_pnfs;
+	nfsd_fault_inject_init(); /* nfsd fault injection controls */
 	nfsd_stat_init();	/* Statistics */
 	retval = nfsd_reply_cache_init();
 	if (retval)
@@ -1315,7 +1313,6 @@ static int __init init_nfsd(void)
 out_free_stat:
 	nfsd_stat_shutdown();
 	nfsd_fault_inject_cleanup();
-out_exit_pnfs:
 	nfsd4_exit_pnfs();
 out_free_slabs:
 	nfsd4_free_slabs();
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 0b74d371ed67..87f310c78e06 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -663,7 +663,7 @@ extern void nfsd4_record_grace_done(struct nfsd_net *nn);
 
 /* nfs fault injection functions */
 #ifdef CONFIG_NFSD_FAULT_INJECTION
-int nfsd_fault_inject_init(void);
+void nfsd_fault_inject_init(void);
 void nfsd_fault_inject_cleanup(void);
 
 u64 nfsd_inject_print_clients(void);
@@ -684,7 +684,7 @@ u64 nfsd_inject_forget_delegations(u64);
 u64 nfsd_inject_recall_client_delegations(struct sockaddr_storage *, size_t);
 u64 nfsd_inject_recall_delegations(u64);
 #else /* CONFIG_NFSD_FAULT_INJECTION */
-static inline int nfsd_fault_inject_init(void) { return 0; }
+static inline void nfsd_fault_inject_init(void) {}
 static inline void nfsd_fault_inject_cleanup(void) {}
 #endif /* CONFIG_NFSD_FAULT_INJECTION */
 
-- 
2.22.0

