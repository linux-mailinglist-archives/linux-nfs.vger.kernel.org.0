Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6650E339447
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 18:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCLRGR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 12:06:17 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59813 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231597AbhCLRGO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Mar 2021 12:06:14 -0500
Received: from localhost.localdomain (ip5f5aeac2.dynamic.kabel-deutschland.de [95.90.234.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 36B57206479D9;
        Fri, 12 Mar 2021 18:06:13 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-nfs@vger.kernel.org
Subject: [PATCH v2] nfsd: Log error on UMH upcall init failure and debug message on success
Date:   Fri, 12 Mar 2021 18:06:04 +0100
Message-Id: <20210312170604.56169-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312153257.GC24008@fieldses.org>
References: <20210312153257.GC24008@fieldses.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

By default, using `printk()`, Linux logs messages with level warning,
which leaves the user reading

    NFSD: Using UMH upcall client tracking operations.

wondering what to do about it. Reading `nfsd4_umh_cltrack_init()`, the
message is actually logged on success, so nothing needs to be done, and
it was decided to use the debug level.

Additionally, Linux now logs an error on init failure.

    NFSD: Failed to init UMH upcall client tracking operations.

Cc: linux-nfs@vger.kernel.org
Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 fs/nfsd/nfs4recover.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 891395c6c7d3..db66c45a6b97 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
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

