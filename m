Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFC2AE408
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Nov 2020 00:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732013AbgKJX3V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Nov 2020 18:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726737AbgKJX3T (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Nov 2020 18:29:19 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22ED20781
        for <linux-nfs@vger.kernel.org>; Tue, 10 Nov 2020 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605050958;
        bh=hStNH2bnjnwhkxmPkjxdG2aH8abWmgNQm7Z6jtpiHZM=;
        h=From:To:Subject:Date:From;
        b=xKKIN/+GWNv7T0YEtEn5a4QBJRd5DMZXvW/oM8xDQGXQsG+kmfSSoIu69CYUjF+3u
         rtmvAJEKaNDe5w59x3mKHsYfGcxRAXa3jf8tH1A9QOEWBJnH5dSr5DFgUIb3mSl4nB
         I7bRjNIjUEdweuPhoKN24JaYrxmS6q+BNK7xoY2Q=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v3 00/11] Add RDMA support to the pNFS file+flexfiles data channels
Date:   Tue, 10 Nov 2020 18:18:55 -0500
Message-Id: <20201110231906.863446-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Add support for connecting to the pNFS files/flexfiles data servers
through RDMA, assuming that the GETDEVICEINFO call advertises that
support.

v2: Fix layoutstats encoding for pNFS/flexfiles.
v3: Move most of the netid handling into the SUNRPC and RDMA modules.
    Fix up the mount code to benefit more from automated loading of
    SUNRPC transport modules.

Trond Myklebust (11):
  SUNRPC: xprt_load_transport() needs to support the netid "rdma6"
  SUNRPC: Close a race with transport setup and module put
  SUNRPC: Add a helper to return the transport identifier given a netid
  NFS: Switch mount code to use xprt_find_transport_ident()
  SUNRPC: Remove unused function xprt_load_transport()
  NFSv4/pNFS: Use connections to a DS that are all of the same protocol
    family
  pNFS: Add helpers for allocation/free of struct nfs4_pnfs_ds_addr
  NFSv4/pNFS: Store the transport type in struct nfs4_pnfs_ds_addr
  pNFS/flexfiles: Fix up layoutstats reporting for non-TCP transports
  SUNRPC: Fix up open coded kmemdup_nul()
  pNFS: Clean up open coded xdr string decoding

 fs/nfs/flexfilelayout/flexfilelayout.c |   9 +-
 fs/nfs/fs_context.c                    |  21 +++--
 fs/nfs/pnfs.h                          |   2 +
 fs/nfs/pnfs_nfs.c                      | 103 ++++++++++------------
 include/linux/sunrpc/xprt.h            |   3 +-
 net/sunrpc/xdr.c                       |   4 +-
 net/sunrpc/xprt.c                      | 117 ++++++++++++++++++-------
 net/sunrpc/xprtrdma/module.c           |   1 +
 net/sunrpc/xprtrdma/transport.c        |   1 +
 net/sunrpc/xprtsock.c                  |   4 +
 10 files changed, 159 insertions(+), 106 deletions(-)

-- 
2.28.0

