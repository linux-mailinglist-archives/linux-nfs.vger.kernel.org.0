Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A559E674BAC
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Jan 2023 06:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjATFEf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Jan 2023 00:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjATFEP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Jan 2023 00:04:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AD6D88D3
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 20:51:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0578B8214D
        for <linux-nfs@vger.kernel.org>; Thu, 19 Jan 2023 21:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D8DC433EF;
        Thu, 19 Jan 2023 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674164417;
        bh=+VpgTjJm3tGVenGak4j20oiWDZqAlKAAZIaPFrbf6Qo=;
        h=From:To:Cc:Subject:Date:From;
        b=IqZm4yHeQn5yyyqAXV88oQiBFhJhB7LlqvVT1sekXVVERnynGPRMtY5F9e6vrnRaR
         Vg6Jrt8rNGmkIYSOgGbQinXWv8i9N1NVVjeyhqinO5uJ5IMWdQMkwz7+anu6HqCEpy
         dODpDSmnd2qUirQru83Q+SOjOPhYe2uTJNwlCQjc05BjkbtW9zvapCiFjpgDGSn0BG
         pZDP2VUNc4yzW5ylt/i1rP3YBv3e2MBqK10h4hEAle6zy+vmmyh+ZpQuG6gSLTzx+f
         oWXBeyLjnVPHI2ybrYwHhAg7jKpAnZoVCCSfoE8tE48IyPFUD+898FToPgSTr9GT1+
         tpWwV2QvmTd6g==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/18] Initial conversion of NFS basic I/O to use folios
Date:   Thu, 19 Jan 2023 16:33:33 -0500
Message-Id: <20230119213351.443388-1-trondmy@kernel.org>
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

---
v2:
 - Fix a bisectability issue reported by Anna
 - Remove an unnecessary NULL pointer check in nfs_read_folio()

Trond Myklebust (18):
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
  NFS: Remove unnecessary check in nfs_read_folio()

 fs/nfs/direct.c          |  12 +-
 fs/nfs/file.c            | 124 +++++++------
 fs/nfs/internal.h        |  38 ++--
 fs/nfs/nfstrace.h        |  58 ++++--
 fs/nfs/pagelist.c        | 217 +++++++++++++++++-----
 fs/nfs/pnfs.h            |  10 +-
 fs/nfs/pnfs_nfs.c        |  18 +-
 fs/nfs/read.c            |  94 +++++-----
 fs/nfs/write.c           | 380 ++++++++++++++++++++-------------------
 include/linux/nfs_fs.h   |   7 +-
 include/linux/nfs_page.h |  79 +++++++-
 11 files changed, 646 insertions(+), 391 deletions(-)

-- 
2.39.0

