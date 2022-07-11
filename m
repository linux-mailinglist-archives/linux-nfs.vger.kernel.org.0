Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A508B5709F3
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Jul 2022 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGKSau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Jul 2022 14:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKSat (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Jul 2022 14:30:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5C47AC22
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 11:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D545EB81126
        for <linux-nfs@vger.kernel.org>; Mon, 11 Jul 2022 18:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C6BC341CA;
        Mon, 11 Jul 2022 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657564217;
        bh=GA/G/YGzJV89w2p/2Z+fcyEnpNh175KiLw4OuIexOv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNpGcP8uWxcn1r955Pc146pwMaEov1dygCU6VX5yMzYIOwkd2WOzkDdbaStUftUJD
         Eyy0bZ2ZLvu3Hmqrlij02j7tXmM4JIUkIg4vu869nx+dIi9zL4DZRVZMvHfAfMZ43Z
         kswTm+CGbNAiaIuiaAYn2/nzTKWp8Xc8cbh1HFlzgWdN+fBTNAirVkJz/BdTU9Trz8
         sDduU4hGMkVtzIoMuC7dCvEzQZyYVKAyRA/YofAtT+QYVDihFw6G6CCoqsYwgqiMQo
         VU73Fl758+8ybbaGzTOs4jEc2LLBDnQ6IAt0taM//0SdqxqaVHQ4eyhibR0VZZVXqH
         oTD8cUfY29YoA==
From:   Jeff Layton <jlayton@kernel.org>
To:     chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com,
        anna@kernel.org, "J . Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH 1/2] lockd: set fl_owner when unlocking files
Date:   Mon, 11 Jul 2022 14:30:13 -0400
Message-Id: <20220711183014.15161-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711183014.15161-1-jlayton@kernel.org>
References: <20220711183014.15161-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Unlocking a POSIX inode with vfs_lock_file only works if the owner
matches. Ensure we set it in the request.

Cc: J. Bruce Fields <bfields@fieldses.org>
Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svcsubs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index 0a22a2faf552..b2f277727469 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -176,7 +176,7 @@ nlm_delete_file(struct nlm_file *file)
 	}
 }
 
-static int nlm_unlock_files(struct nlm_file *file)
+static int nlm_unlock_files(struct nlm_file *file, fl_owner_t owner)
 {
 	struct file_lock lock;
 
@@ -184,6 +184,7 @@ static int nlm_unlock_files(struct nlm_file *file)
 	lock.fl_type  = F_UNLCK;
 	lock.fl_start = 0;
 	lock.fl_end   = OFFSET_MAX;
+	lock.fl_owner = owner;
 	if (file->f_file[O_RDONLY] &&
 	    vfs_lock_file(file->f_file[O_RDONLY], F_SETLK, &lock, NULL))
 		goto out_err;
@@ -225,7 +226,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 		if (match(lockhost, host)) {
 
 			spin_unlock(&flctx->flc_lock);
-			if (nlm_unlock_files(file))
+			if (nlm_unlock_files(file, fl->fl_owner))
 				return 1;
 			goto again;
 		}
-- 
2.36.1

