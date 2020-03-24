Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E043191DAB
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 00:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCXXtj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Mar 2020 19:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCXXtj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 24 Mar 2020 19:49:39 -0400
Received: from localhost.localdomain (c-68-40-189-247.hsd1.mi.comcast.net [68.40.189.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 893F920719
        for <linux-nfs@vger.kernel.org>; Tue, 24 Mar 2020 23:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585093777;
        bh=ktZKbgMD2CA22QiFwNaUDNUOSXgoTHb3bZLLYwUQFSw=;
        h=From:To:Subject:Date:From;
        b=uI3rMCYqnGeiO93G4ht/Qv/qK8+bm4D4trU0kJ1J1yAA6JqdmkBYLR7J6SD39A0Xo
         O2mKvKSxarOhzmCC2L94P1qDv6pazLNxZKZw5ohLU9Oit1A38MCLMRx8AdVreweRkl
         asWURq1RIcQpS5KKrtO6tSUy5uOV6NKWC8NRPJEw=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/22] Fix NFS commit to DS
Date:   Tue, 24 Mar 2020 19:47:06 -0400
Message-Id: <20200324234728.8997-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The commit to DS code is currently broken in the face of layout
segments that do not cover the full file case. In particular, if
the layout is a flexfile mirrored layout, we see that if two layout
segments have differing numbers of mirrors, or just have different
ordering of mirrors, then the current code can lead to data
corruption and even kernel Oopses on the client.

The root cause of these problems is the fact that we have one
array of commit lists per struct pnfs_ds_commit_info, and
that once that array is set up, it cannot change. This despite
the fact that layout segments can be recalled and changed on
the fly.
This patch set attempts to fix that problem by changing the
array of commit lists into a list of lists. It does so in
a way that ensures 1-1 correspondence between a layout
segment and a set of commits for the case of buffered writes,
and a similar setup for a collection of O_DIRECT writes.

Since most of this work is acting on code that is currently
common to both the files layout and the flexfiles layout, I've
fixed up both layout types in the same way.

Trond Myklebust (22):
  pNFS/flexfiles: Simplify allocation of the mirror array
  NFS/pNFS: Refactor pnfs_generic_commit_pagelist()
  pNFS: Add a helper to allocate the array of buckets
  NFSv4/pnfs: Support a list of commit arrays in struct
    pnfs_ds_commit_info
  NFSv4/pNFS: Scan the full list of commit arrays when committing
  pNFS: Support per-layout segment commits in
    pnfs_generic_recover_commit_reqs()
  pNFS: Support per-layout segment commits in
    pnfs_generic_commit_pagelist()
  NFS/pNFS: Allow O_DIRECT to release the DS commitinfo
  NFS: commit errors should be fatal
  NFS: Fix O_DIRECT commit verifier handling
  NFS/pNFS: Support commit arrays in
    nfs_clear_pnfs_ds_commit_verifiers()
  pNFS: Add infrastructure for cleaning up per-layout commit structures
  pNFS: Enable per-layout segment commit structures
  NFS/pNFS: Add a helper pnfs_generic_search_commit_reqs()
  NFS: Remove bucket array from struct pnfs_ds_commit_info
  NFS/pNFS: Clean up pNFS commit operations
  NFS/pNFS: Simplify bucket layout segment reference counting
  NFS/pNFS: Fix pnfs_layout_mark_request_commit() invalid layout segment
    handling
  pNFS/flexfile: Don't merge layout segments if the mirrors don't match
  pNFS/flexfiles: Check the layout segment range before doing I/O
  pNFS/flexfiles: remove requirement for whole file layouts
  pNFS/flexfiles: Specify the layout segment range in LAYOUTGET

 fs/nfs/direct.c                        | 174 +++------
 fs/nfs/filelayout/filelayout.c         | 163 +++-----
 fs/nfs/flexfilelayout/flexfilelayout.c | 203 ++++------
 fs/nfs/flexfilelayout/flexfilelayout.h |   2 +-
 fs/nfs/internal.h                      |  26 +-
 fs/nfs/pnfs.c                          |   4 +-
 fs/nfs/pnfs.h                          | 127 ++++--
 fs/nfs/pnfs_nfs.c                      | 514 ++++++++++++++++++-------
 fs/nfs/write.c                         |  16 +-
 include/linux/nfs_xdr.h                |  32 +-
 10 files changed, 699 insertions(+), 562 deletions(-)

-- 
2.25.1

