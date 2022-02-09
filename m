Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899E54AFC1C
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Feb 2022 19:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbiBISyY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Feb 2022 13:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241186AbiBISyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Feb 2022 13:54:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C62DC1038D2
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 10:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9110B82385
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCC8C340F1
        for <linux-nfs@vger.kernel.org>; Wed,  9 Feb 2022 18:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644432578;
        bh=l1cJW970K7Bm+hlEhwk5/9VkO6UwIAWTDsCdKUxx6pM=;
        h=From:To:Subject:Date:From;
        b=hyJbV9W4/Fom5je4G11Bxdi6An40AESsIwbgGulIN0OwT62VusWa5gCKzhM+b0++i
         xj+jU6WPTpMrz9bU3QK+x5rpi9r9/TMI2tA6Y0865xycCGOBAQQ3X7nS+taiLD3glV
         5HlR0OPubBoRsZ3XjqmXg3xVujxJcCCB4Vx4KtWYFB8zDswwDKkYXPFllrx13+qGVv
         CT/DBav1dO3iC9CUBG71Rv9dODFmTwhfef8lTGlgeTratfu6BaCrIv9DH+i5KdVml9
         SAYjCszy3ook98IAUesVZxRWk5TAAydMs5k+JLHyfPYuxleM/hh3pxGnIaTCtc2UAd
         ssA+Q3CW5SB2w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 0/2] Adaptive readdir readahead
Date:   Wed,  9 Feb 2022 13:42:49 -0500
Message-Id: <20220209184251.23909-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

The current NFS readdir code will always try to maximise the amount of
readahead it performs on the assumption that we can cache anything that
isn't immediately read by the process.
There are several cases where this assumption breaks down, including
when the 'ls -l' heuristic kicks in to try to force use of readdirplus
as a batch replacement for lookup/getattr.

--
v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
v3: Avoid excessive window shrinking in uncached_readdir case

Trond Myklebust (2):
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: Simplify nfs_readdir_xdr_to_array()

 fs/nfs/dir.c           | 82 ++++++++++++++++++++++++++++++++----------
 include/linux/nfs_fs.h |  1 +
 2 files changed, 65 insertions(+), 18 deletions(-)

-- 
2.34.1

