Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88622A32A9
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgKBSRU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 13:17:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726076AbgKBSRU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:20 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A7120731
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604341040;
        bh=fsr9Yq0aHB/8I0Sy6bV3PWBbhDZuWG8/RtIDy++KQaM=;
        h=From:To:Subject:Date:From;
        b=wmJUPEBBt5NtauJxXmowaGnyylN8WqnUUAoLBg4VqEnyrOITnuIPCPaLk+IjNZ8HA
         EpKWSfHblwAJ0msfmgf0NB4f961UK2nEG/BOaeR3+N/x6bBUET1fgUgp33thoVw3Cf
         MAx4VF4eKhwiFUyAIO4EsZJtHzRyHmIupW3ILCyQ=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/12] Readdir enhancements
Date:   Mon,  2 Nov 2020 13:06:46 -0500
Message-Id: <20201102180658.6218-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series performs a number of cleanups on the readdir
code.
It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
the caching code to ensure that we cache the entire contents of that
1MB call (instead of discarding the data that doesn't fit into a single
page).

Trond Myklebust (12):
  NFS: Ensure contents of struct nfs_open_dir_context are consistent
  NFS: Clean up readdir struct nfs_cache_array
  NFS: Clean up nfs_readdir_page_filler()
  NFS: Clean up directory array handling
  NFS: Don't discard readdir results
  NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
  NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
  NFS: Simplify struct nfs_cache_array_entry
  NFS: Support larger readdir buffers
  NFS: More readdir cleanups
  NFS: nfs_do_filldir() does not return a value
  NFS: Reduce readdir stack usage

 fs/nfs/client.c        |   4 +-
 fs/nfs/dir.c           | 555 ++++++++++++++++++++++++-----------------
 fs/nfs/internal.h      |   6 -
 include/linux/nfs_fs.h |   1 -
 4 files changed, 325 insertions(+), 241 deletions(-)

-- 
2.28.0

