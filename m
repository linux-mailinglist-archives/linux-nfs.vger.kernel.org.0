Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6A4661095
	for <lists+linux-nfs@lfdr.de>; Sat,  7 Jan 2023 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjAGRmK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 7 Jan 2023 12:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjAGRmK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 7 Jan 2023 12:42:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421F12DF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 09:42:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BF4160B2D
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A83DC433EF
        for <linux-nfs@vger.kernel.org>; Sat,  7 Jan 2023 17:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673113327;
        bh=FPm1vM9BvrPwnLHPktxilREge4NcfKsqJqIjLJfbLwo=;
        h=From:To:Subject:Date:From;
        b=N8RR2Ig1vEyg3R9O6yG8mkisGayfOurJYgmft30EuLxyZzVwhsxBAaEpRoVGhyhRR
         6FKRQi4k1HnXL6fzXlBMkMdREpR08y61CNs8PKRMCGllebvJ9XFbGylwqItcSftlP4
         wD39jn2n3sG3fC1y1kuFPBbQQq40+PDZ89XUi2NGntvHfSlFOYh/4ELBPKLvcgYhzr
         A2cXCVxJLjpenfFhEc8n0VXXqKKQVdw/8mjqE9UP6uLhMIF+0JxVWWHHyrHshAKxKE
         +5SE0VgoaFBDbPaymo/ux0luROTUd7rDeTrGV3sGo/du0fR1V/ZlAT2p0c2lqaZSUh
         CrVSe9pMiPmmw==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/17] Initial conversion of NFS basic I/O to use folios
Date:   Sat,  7 Jan 2023 12:36:18 -0500
Message-Id: <20230107173635.2025233-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.39.0
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

This set of patches represents an initial effort to convert the page
cache I/O in the NFS client to use native folio functionality. It should
allow the nfs_page structs and their helpers to carry folios (including
folios of order > 0) and to pass their data contents through to the RPC
layer.
Note that because O_DIRECT uses pages, we still need to support the
traditional page based I/O, and so the new struct nfs_page will carry
both types.
I did not touch the fscache code, but I expect that to be able to
continue to work with order 0 folios.

The plan is to merge this functionality with order 0 folios first, in
order to catch any regressions in existing functionality. Then we can
enable order n > 0 once we're happy about the stability (at least for
the non-fscache case).

At this point, the xfstests are all passing without any regressions on
my setup, so I'm throwing the patches over the fence to allow for wider
testing.
Please make sure, in particular to test pNFS if your server supports it.
I didn't have to make any changes to the pNFS code, and I don't expect
any trouble, but it would be good to have validation of that assumption.

Trond Myklebust (17):
  NFS: Fix for xfstests generic/208
  NFS: Add basic functionality for tracking folios in struct nfs_page
  NFS: Support folios in nfs_generic_pgio()
  NFS: Fix nfs_coalesce_size() to work with folios
  NFS: Add a helper to convert a struct nfs_page into an inode
  NFS: Convert the remaining pagelist helper functions to support folios
  NFS: Add a helper nfs_wb_folio()
  NFS: Convert buffered reads to use folios
  NFS: Convert the function nfs_wb_page() to use folios
  NFS: Convert buffered writes to use folios
  NFS: Remove unused function nfs_wb_page()
  NFS: Convert nfs_write_begin/end to use folios
  NFS: Fix up nfs_vm_page_mkwrite() for folios
  NFS: Clean up O_DIRECT request allocation
  NFS: fix up nfs_release_folio() to try to release the page
  NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()
  NFS: Improve tracing of nfs_wb_folio()

 fs/nfs/direct.c          |  12 +-
 fs/nfs/file.c            | 124 +++++++------
 fs/nfs/internal.h        |  38 ++--
 fs/nfs/nfstrace.h        |  58 ++++--
 fs/nfs/pagelist.c        | 217 +++++++++++++++++-----
 fs/nfs/pnfs.h            |  10 +-
 fs/nfs/pnfs_nfs.c        |  18 +-
 fs/nfs/read.c            |  86 +++++----
 fs/nfs/write.c           | 380 ++++++++++++++++++++-------------------
 include/linux/nfs_fs.h   |   7 +-
 include/linux/nfs_page.h |  79 +++++++-
 11 files changed, 645 insertions(+), 384 deletions(-)

-- 
2.39.0

