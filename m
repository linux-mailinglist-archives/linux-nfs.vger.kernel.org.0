Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF6562621D
	for <lists+linux-nfs@lfdr.de>; Fri, 11 Nov 2022 20:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbiKKTgr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 11 Nov 2022 14:36:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbiKKTgq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 11 Nov 2022 14:36:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532EF67F4E
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 11:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0AF3B8279D
        for <linux-nfs@vger.kernel.org>; Fri, 11 Nov 2022 19:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD88C433D7;
        Fri, 11 Nov 2022 19:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668195402;
        bh=GUr/pvjzS+Gbv0NQ95I+TzMbAVc9/2m30a4t6CDpvKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PLx+V7GDpZkso7/H1/0LJsMesu61FSHVpfOxPsTKqvlesPInHVRBwcm6UkmZp1D5F
         zywOOwR83dpr+2x8xZOddn2PH7WDttFk6Ot6qDkhzFXJRiK/6+5higwv9jvPsS4msW
         tXMbq9znhGThJhkcyU7gIdN7FaNdfxXHq0jCXvFYOzCPCxKjBVoCWiH9Xd+QksAd3j
         AuOCdBY49x1GgCf5uPlNxuB1+KWv/dL+sqyxjojlTs/DdLCzz1QE7sE6Em3TgLOeGP
         rrdhpifuThHcbxJaOpoVoKOa4FHp8G05kEUQkIOlzwHdOSvsL1uAzFBGbIyr+v0CDC
         6G7OFDQ/ny2iA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     trond.myklebust@hammerspace.com, linux-nfs@vger.kernel.org
Subject: [PATCH 2/4] lockd: ensure we use the correct file description when unlocking
Date:   Fri, 11 Nov 2022 14:36:37 -0500
Message-Id: <20221111193639.346992-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221111193639.346992-1-jlayton@kernel.org>
References: <20221111193639.346992-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Shared locks are set on O_RDONLY descriptors and exclusive locks are set
on O_WRONLY ones. nlmsvc_unlock however calls vfs_lock_file twice, once
for each descriptor, but it doesn't reset fl_file. Ensure that it does.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svclock.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 9c1aa75441e1..9eae99e08e69 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -659,11 +659,13 @@ nlmsvc_unlock(struct net *net, struct nlm_file *file, struct nlm_lock *lock)
 	nlmsvc_cancel_blocked(net, file, lock);
 
 	lock->fl.fl_type = F_UNLCK;
-	if (file->f_file[O_RDONLY])
-		error = vfs_lock_file(file->f_file[O_RDONLY], F_SETLK,
+	lock->fl.fl_file = file->f_file[O_RDONLY];
+	if (lock->fl.fl_file)
+		error = vfs_lock_file(lock->fl.fl_file, F_SETLK,
 					&lock->fl, NULL);
-	if (file->f_file[O_WRONLY])
-		error = vfs_lock_file(file->f_file[O_WRONLY], F_SETLK,
+	lock->fl.fl_file = file->f_file[O_WRONLY];
+	if (lock->fl.fl_file)
+		error |= vfs_lock_file(lock->fl.fl_file, F_SETLK,
 					&lock->fl, NULL);
 
 	return (error < 0)? nlm_lck_denied_nolocks : nlm_granted;
-- 
2.38.1

