Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCC94D7715
	for <lists+linux-nfs@lfdr.de>; Sun, 13 Mar 2022 18:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiCMRNN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 13 Mar 2022 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiCMRNM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 13 Mar 2022 13:13:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0C4139CDA
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 10:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFAC60FCF
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD6AC340E8
        for <linux-nfs@vger.kernel.org>; Sun, 13 Mar 2022 17:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647191523;
        bh=AGwjQrwXRkfOBt5a699Fv2rALhnAFx9y9PJXtkpBX78=;
        h=From:To:Subject:Date:From;
        b=CvUKlGFgK8+f9tZU/MZq/MiEjO5UWU/ZvC0b6ex7L8b4GSb+gQcFCBcmweaT8F7lf
         b0Ir3iJsqbeM3Y4gxD1dIPgQw9MSJCgPn5AvYw9VQPEMNmEdPYUJMqGbbF475+icYg
         2i1ufVHwKlYcWt1ySxV+ShoWZV/AuXMaicnhp07eO5g7MXdLcfQU8kt+A+o0bRwHXn
         ucKKiW7XFMyVqk4NIjqUWTY+goDZgAxH2EMZF8EQWjEZvvLrmX/10kaCs62AkoaHTG
         hAyEZW7Rd3w6NCMWZU9kq2/bhR9i2drvkwYeEae0fGnAM6FTYB7hRoJNiLqJEnkHf2
         k/UDiSay/cxVg==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v10 00/26] Readdir improvements
Date:   Sun, 13 Mar 2022 13:05:31 -0400
Message-Id: <20220313170557.5940-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v10: Reinstate cache invalidations for directories, since Olga showed
    that the NFSv3 ctime resolution can be insufficient to record
    rapid changes to a directory.

Trond Myklebust (26):
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
  NFS: Optimise away the previous cookie field
  NFS: Cache all entries in the readdirplus reply

 fs/nfs/Kconfig          |   4 +
 fs/nfs/dir.c            | 595 ++++++++++++++++++++++++----------------
 fs/nfs/inode.c          |  45 +--
 fs/nfs/internal.h       |   4 +-
 fs/nfs/nfs2xdr.c        |   3 +-
 fs/nfs/nfs3xdr.c        |  29 +-
 fs/nfs/nfs4xdr.c        |   7 +-
 fs/nfs/nfstrace.h       | 123 ++++++++-
 include/linux/nfs_fs.h  |  17 +-
 include/linux/nfs_xdr.h |   3 +-
 10 files changed, 535 insertions(+), 295 deletions(-)

-- 
2.35.1

