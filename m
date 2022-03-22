Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D364E363D
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Mar 2022 02:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiCVB4E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Mar 2022 21:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbiCVB4C (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Mar 2022 21:56:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923291CFD7
        for <linux-nfs@vger.kernel.org>; Mon, 21 Mar 2022 18:54:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49B9CB818E6
        for <linux-nfs@vger.kernel.org>; Tue, 22 Mar 2022 01:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99165C340E8;
        Tue, 22 Mar 2022 01:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647914072;
        bh=uMjNaDhQikir6YSCGCjDm3nJKvfqJTQRvB1VWIwdQC4=;
        h=From:To:Cc:Subject:Date:From;
        b=NOrFVNYcgOkVeTAsOOFTnuYG3VayWcA2oC7tTFz24/StmmIMSs7cPK9n8y9/+3R/3
         yfLyDmEC1IwDLZ9RxF/wjT8cJhxixwVEKIUp5+5mBImkEB3UJ8KfE5JVBq9Q9cTL7l
         CctINC7yS67TeLXJiNgeURqkvDIaHsD1wHdWU+Xo+jqNJKDeH1JfP+jUgVnE6LVsSV
         kkNborFWYx9bovfVlTSPzCt57ianAHykxM9xKf5OcvVLbBW54yAVmj2qobxGMEXYBD
         5JFQld8pBetuXQcTm0rCdS9M+oNWDvHNzpqPN+YsFTMTC7uvv6jHkhRm2eraQT7sub
         nwbwMeWGawccA==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: [PATCH v2 0/9] Crossing our fingers is not a strategy
Date:   Mon, 21 Mar 2022 21:47:37 -0400
Message-Id: <20220322014746.1052984-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

We'd like to avoid GFP_NOWAIT whenever possible, because it has no fall-
back reclaim strategy for dealing with a failure of the initial
allocation.
At the same time, memory pools appear to be suboptimal as an allocation
strategy when used with anything other than GFP_NOWAIT, since they cause
threads to hang upon failure.

This patch series therefore aims to demote the mempools to being a
strategy of last resort, with the primary allocation strategy being to
use the underlying slabs.
While we're at it, we want to ensure that rpciod, xprtiod and nfsiod all
use the same allocation strategy, so that the latter two don't thwart
our ability to complete writeback RPC calls by getting blocked in the mm
layer.

Trond Myklebust (9):
  NFS: Fix memory allocation in rpc_malloc()
  NFS: Fix memory allocation in rpc_alloc_task()
  SUNRPC: Fix unx_lookup_cred() allocation
  SUNRPC: Make the rpciod and xprtiod slab allocation modes consistent
  NFS: nfsiod should not block forever in mempool_alloc()
  NFS: Avoid writeback threads getting stuck in mempool_alloc()
  NFSv4/pnfs: Ensure pNFS allocation modes are consistent with nfsiod
  pNFS/flexfiles: Ensure pNFS allocation modes are consistent with
    nfsiod
  pNFS/files: Ensure pNFS allocation modes are consistent with nfsiod

 fs/nfs/filelayout/filelayout.c         |  2 +-
 fs/nfs/flexfilelayout/flexfilelayout.c | 50 +++++++++++---------------
 fs/nfs/internal.h                      |  7 ++++
 fs/nfs/nfs42proc.c                     |  2 +-
 fs/nfs/pagelist.c                      | 10 +++---
 fs/nfs/pnfs.c                          | 39 +++++++++-----------
 fs/nfs/pnfs_nfs.c                      |  8 +++--
 fs/nfs/write.c                         | 34 +++++++++---------
 include/linux/nfs_fs.h                 |  2 +-
 include/linux/sunrpc/sched.h           |  1 +
 net/sunrpc/auth_unix.c                 | 18 +++++-----
 net/sunrpc/backchannel_rqst.c          |  8 ++---
 net/sunrpc/rpcb_clnt.c                 |  4 +--
 net/sunrpc/sched.c                     | 31 ++++++++++------
 net/sunrpc/socklib.c                   |  3 +-
 net/sunrpc/xprt.c                      |  5 +--
 net/sunrpc/xprtsock.c                  | 11 +++---
 17 files changed, 123 insertions(+), 112 deletions(-)

-- 
2.35.1

