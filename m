Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059524FAAA1
	for <lists+linux-nfs@lfdr.de>; Sat,  9 Apr 2022 22:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiDIUJo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 9 Apr 2022 16:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiDIUJn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 9 Apr 2022 16:09:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1B61557EE
        for <linux-nfs@vger.kernel.org>; Sat,  9 Apr 2022 13:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEA0360AF0
        for <linux-nfs@vger.kernel.org>; Sat,  9 Apr 2022 20:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B884BC385A6;
        Sat,  9 Apr 2022 20:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649534854;
        bh=8s36uDwAQ6drbCdhPcH2bpOPAXfnPHdl8tI9JW7lbvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWaH8MKzBoPCVStXuVC/zwCgXkC1Ti+5gAFzVqDTF0jhU285MfBNmgxQjZ4tWpzwy
         /YAOz+QyGPK/TYGacxe9rMIU45nkcaxys3EVz7d8c1sFMSuLdt8fKqvDx142Ys+TNS
         yTQiIsZ4ioOJh88JGigHnT6z5yyrqPg7CiX4LMtrGIDMUFuJfaEoO54Zgf4EkjZThj
         rHZJqyUM6HPiZcwUTHKDeKWuKddeJOwB+O8GHMl+tONakCGOQX2fH8mFweuAUVgCu6
         oMR95O1c+lQhQQB/blnTHEs0v7tuO3i1puB3GaXXXmTiqTuHz4wcMGdTwetfJKrpai
         VWFjPy2h5QpAQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     ChenXiaoSong <chenxiaosong2@huawei.com>,
        Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH 2/2] NFS: Don't report write errors twice
Date:   Sat,  9 Apr 2022 16:01:08 -0400
Message-Id: <20220409200108.94208-2-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409200108.94208-1-trondmy@kernel.org>
References: <20220409200108.94208-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Any errors reported by the write() system call need to be cleared from
the file descriptor's error tracking. The current call to nfs_wb_all()
causes the error to be reported, but since it doesn't call
file_check_and_advance_wb_err(), we can end up reporting the same error
a second time when the application calls fsync().

Reported-by: ChenXiaoSong <chenxiaosong2@huawei.com>
Fixes: ce368536dd61 ("nfs: nfs_file_write() should check for writeback errors")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/file.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 81c80548a5c6..54dc6f176f5c 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -677,9 +677,10 @@ ssize_t nfs_file_write(struct kiocb *iocb, struct iov_iter *from)
 	/* Return error values */
 	error = filemap_check_wb_err(file->f_mapping, since);
 	if (nfs_need_check_write(file, inode, error)) {
-		int err = nfs_wb_all(inode);
-		if (err < 0)
-			result = err;
+		nfs_wb_all(inode);
+		error = file_check_and_advance_wb_err(file);
+		if (error < 0)
+			result = error;
 	}
 	nfs_add_stats(inode, NFSIOS_NORMALWRITTENBYTES, written);
 out:
-- 
2.35.1

