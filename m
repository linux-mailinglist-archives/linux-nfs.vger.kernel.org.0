Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A984C5FC7
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Feb 2022 00:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiB0XTN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Feb 2022 18:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiB0XTM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Feb 2022 18:19:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EEC22501
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 15:18:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58F74611AF
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB74C340E9
        for <linux-nfs@vger.kernel.org>; Sun, 27 Feb 2022 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646003913;
        bh=OjPQB8rh7JPrreofA5AKdQ4GHwFU5RVd/rBQnGG3CfA=;
        h=From:To:Subject:Date:From;
        b=NqYm+Cfmt22nx0sZsglav+dExV8yLtmhXX2rG5R9fw5jVGekyN7Pyul9Ate0qpev9
         GmhHoRJHgUPpi1ifn/OoE9/a276YqLkablz/DbxP1YwAbRHsQAkugJ2P/eWWp8oxQa
         4Z9KXBBMFQIBEIlpXK2iRasjs50Q7nnHA8l8Zn/nuPOnxLf9y+VuQfibRcn+lU5lrt
         n8O9h9BWHiIGRu2r5qvcVGx3RTfyZRsSMmQZfGNiYKwFCqEJGRkMSPaNcbyq39nYA6
         aRJz2fDcfwjfPCyvher9O/nzTwvHMm8oxGo9PCIclK+6ccHIj9+zYQIEuyW8sIpNPt
         7hcP++F2I58tQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v9 00/27] Readdir improvements
Date:   Sun, 27 Feb 2022 18:12:00 -0500
Message-Id: <20220227231227.9038-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This series also implement Ben's page cache filter to ensure that we can
improve the ability to share cached data between processes that are
reading the same directory at the same time, and to avoid live-locks
when the directory is simultaneously changing.

--
v2: Remove reset of dtsize when NFS_INO_FORCE_READDIR is set
v3: Avoid excessive window shrinking in uncached_readdir case
v4: Track 'ls -l' cache hit/miss statistics
    Improved algorithm for falling back to uncached readdir
    Skip readdirplus when files are being written to
v5: bugfixes
    Skip readdirplus when the acdirmax/acregmax values are low
    Request a full XDR buffer when doing READDIRPLUS
v6: Add tracing
    Don't have lookup request readdirplus when it won't help
v7: Implement Ben's page cache filter
    Reduce the use of uncached readdir
    Change indexing of the page cache to improve seekdir() performance.
v8: Reduce the page cache overhead by shrinking the cookie hashvalue size
    Incorporate other feedback from Anna, Ben and Neil
    Fix nfs2/3_decode_dirent return values
    Fix the change attribute value set in nfs_readdir_page_get_next()
v9: Address bugs that were hit when testing with large directories
    Misc cleanups

Trond Myklebust (27):
  NFS: Return valid errors from nfs2/3_decode_dirent()
  NFS: constify nfs_server_capable() and nfs_have_writebacks()
  NFS: Trace lookup revalidation failure
  NFS: Initialise the readdir verifier as best we can in nfs_opendir()
  NFS: Use kzalloc() to avoid initialising the nfs_open_dir_context
  NFS: Calculate page offsets algorithmically
  NFS: Store the change attribute in the directory page cache
  NFS: Don't re-read the entire page cache to find the next cookie
  NFS: Don't advance the page pointer unless the page is full
  NFS: Adjust the amount of readahead performed by NFS readdir
  NFS: If the cookie verifier changes, we must invalidate the page cache
  NFS: Simplify nfs_readdir_xdr_to_array()
  NFS: Reduce use of uncached readdir
  NFS: Improve heuristic for readdirplus
  NFS: Don't ask for readdirplus unless it can help nfs_getattr()
  NFSv4: Ask for a full XDR buffer of readdir goodness
  NFS: Readdirplus can't help lookup for case insensitive filesystems
  NFS: Don't request readdirplus when revalidation was forced
  NFS: Add basic readdir tracing
  NFS: Trace effects of readdirplus on the dcache
  NFS: Trace effects of the readdirplus heuristic
  NFS: Clean up page array initialisation/free
  NFS: Convert readdir page cache to use a cookie based index
  NFS: Fix up forced readdirplus
  NFS: Remove unnecessary cache invalidations for directories
  NFS: Optimise away the previous cookie field
  NFS: Cache all entries in the readdirplus reply

 fs/nfs/Kconfig          |   4 +
 fs/nfs/dir.c            | 602 ++++++++++++++++++++++++----------------
 fs/nfs/inode.c          |  46 ++-
 fs/nfs/internal.h       |   4 +-
 fs/nfs/nfs2xdr.c        |   3 +-
 fs/nfs/nfs3xdr.c        |  29 +-
 fs/nfs/nfs4proc.c       |   2 -
 fs/nfs/nfs4xdr.c        |   7 +-
 fs/nfs/nfstrace.h       | 123 +++++++-
 include/linux/nfs_fs.h  |  19 +-
 include/linux/nfs_xdr.h |   3 +-
 11 files changed, 532 insertions(+), 310 deletions(-)

-- 
2.35.1

