Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E885C3398D4
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 22:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhCLVE3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 16:04:29 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36709 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234955AbhCLVE1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Mar 2021 16:04:27 -0500
Received: from localhost.localdomain (ip5f5aeac2.dynamic.kabel-deutschland.de [95.90.234.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id ACB4F202254D4;
        Fri, 12 Mar 2021 22:04:20 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-nfs@vger.kernel.org
Subject: [PATCH v4] nfsd: Log client tracking type log message as info instead of warning
Date:   Fri, 12 Mar 2021 22:03:00 +0100
Message-Id: <20210312210259.77310-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312190634.GE24008@fieldses.org>
References: <20210312190634.GE24008@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

`printk()`, by default, uses the log level warning, which leaves the
user reading

    NFSD: Using UMH upcall client tracking operations.

wondering what to do about it (`dmesg --level=warn`).

Several client tracking methods are tried, and expected to fail. That’s
why a message is printed only on success. It might be interesting for
users to know the chosen method, so use info-level instead of
debug-level.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
v4: Remove error message, and use info-level, as several client tracking
methods are tried.

 fs/nfsd/nfs4recover.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 891395c6c7d3..6fedc49726bf 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -626,7 +626,7 @@ nfsd4_legacy_tracking_init(struct net *net)
 	status = nfsd4_load_reboot_recovery_data(net);
 	if (status)
 		goto err;
-	printk("NFSD: Using legacy client tracking operations.\n");
+	pr_info("NFSD: Using legacy client tracking operations.\n");
 	return 0;
 
 err:
@@ -1028,7 +1028,7 @@ nfsd4_init_cld_pipe(struct net *net)
 
 	status = __nfsd4_init_cld_pipe(net);
 	if (!status)
-		printk("NFSD: Using old nfsdcld client tracking operations.\n");
+		pr_info("NFSD: Using old nfsdcld client tracking operations.\n");
 	return status;
 }
 
@@ -1605,7 +1605,7 @@ nfsd4_cld_tracking_init(struct net *net)
 		nfs4_release_reclaim(nn);
 		goto err_remove;
 	} else
-		printk("NFSD: Using nfsdcld client tracking operations.\n");
+		pr_info("NFSD: Using nfsdcld client tracking operations.\n");
 	return 0;
 
 err_remove:
@@ -1864,7 +1864,7 @@ nfsd4_umh_cltrack_init(struct net *net)
 	ret = nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
 	kfree(grace_start);
 	if (!ret)
-		printk("NFSD: Using UMH upcall client tracking operations.\n");
+		pr_info("NFSD: Using UMH upcall client tracking operations.\n");
 	return ret;
 }
 
-- 
2.30.2

