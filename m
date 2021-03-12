Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C841833944F
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLRKC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 12:10:02 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:44681 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230388AbhCLRJ7 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 12 Mar 2021 12:09:59 -0500
Received: from localhost.localdomain (ip5f5aeac2.dynamic.kabel-deutschland.de [95.90.234.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id F27EF206479D9;
        Fri, 12 Mar 2021 18:09:57 +0100 (CET)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     "J . Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, linux-nfs@vger.kernel.org
Subject: [PATCH v3] nfsd: Log error on UMH upcall init failure and debug message on success
Date:   Fri, 12 Mar 2021 18:09:44 +0100
Message-Id: <20210312170943.57461-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210312170604.56169-1-pmenzel@molgen.mpg.de>
References: <20210312170604.56169-1-pmenzel@molgen.mpg.de>
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
v2: Log error and demote success message to debug-level (forgot `-a` in `git commit --amend`)
v3: Actually sent correct diff

 fs/nfsd/nfs4recover.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index 891395c6c7d3..fff89c739033 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -1863,8 +1863,11 @@ nfsd4_umh_cltrack_init(struct net *net)
 
 	ret = nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
 	kfree(grace_start);
-	if (!ret)
-		printk("NFSD: Using UMH upcall client tracking operations.\n");
+	if (ret)
+		pr_debug("NFSD: Using UMH upcall client tracking operations.\n");
+	else
+		pr_err("NFSD: Failed to init UMH upcall client tracking operations.");
+
 	return ret;
 }
 
-- 
2.30.2

