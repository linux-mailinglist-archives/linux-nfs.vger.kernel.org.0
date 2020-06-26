Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626E420BBEC
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jun 2020 23:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725816AbgFZVxU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 26 Jun 2020 17:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgFZVxU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 26 Jun 2020 17:53:20 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD903C03E979
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 14:53:19 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e15so8033431edr.2
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jun 2020 14:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rE6nJ9tCbrrTach2OEj3HqnZ0eucPB2cwV9aKyzV0ME=;
        b=vHob1hT48NijPeja8QTyIYyNUAChXlOkS1+FzIE482NJnVSs96f7H1YL8ixU8Qo3rM
         csfSpAeLhk6nOt6rI1s9zLxZNseigufdYSIYeqCf4BU0/eIyt/OF8OchOwWc3EtSGIRr
         12HZhKzEXsSso0Ngp7a8hi0TOT6xCF+dPwH1iXwsx7yPjDrjN/z6/aShAKnO8NnA8246
         1w2DZk/uc7RhnsITDnC5Kkov0sqlvuwTfX/P94RR/Hz5Q9VSRoLQD3orwv/W8mMr4iVU
         KBbpRG35i2fclNWnDg8G3Vy2XxaBINDYaKkqEy0mwXo7bPSi5LIYl6jyHMWWOhk77/BJ
         MkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rE6nJ9tCbrrTach2OEj3HqnZ0eucPB2cwV9aKyzV0ME=;
        b=VYblcYrtCGqfvdSi0nDxTIfDLEW7QNo0eHsrbXE5XlcKRgv14UAVbiL3KbixBBdYel
         NxiNMtTcuqJn/U5hmY+0H+ASrKog2rrSkjd7Xe76ud3OteuPG38YFiWKTOeBUMI6Q2jZ
         H3L52fPCH36UWoiLNTRb07MgG/ioGj3v8YqBD2quadLauuS95wy3ylq98BKIYJwhPmYV
         IgTr5tLK9RBONIv8dp5LQOWIFPyu6qt+uu3Lx8vAtMTL0/V3KJ/xGGddXckNFBYLwtfT
         Y39N9Qx6QL3xFjmjwZ4kPwB3g2iJisFqD8nCgJPv5fpHItrUDuR+FZjwlp3B7mYGox7E
         qFCg==
X-Gm-Message-State: AOAM533h4Aa+0Vfflo4pPDYWW+u2tQy1G2443Ef/ewCSaYLRb9o1DmKn
        PCKwYlT41S9xCtKW9jLNJ2pBp/V+rjwukNGXWOCeVFjU
X-Google-Smtp-Source: ABdhPJxdkKyczDiUccDam6rnrjV1P0MRy2RjqlvzVQN7j6vcrUq3i0gjZUBwnugqI/pAYaq4NAXSdHzUJJDS1q1VqZg=
X-Received: by 2002:a50:ab5c:: with SMTP id t28mr5551684edc.209.1593208398462;
 Fri, 26 Jun 2020 14:53:18 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Fri, 26 Jun 2020 17:53:02 -0400
Message-ID: <CAFX2JfkFH1gQQNyLJ88_oe0Zu+_S=XDODoo1nG9PZX=bEKVFFg@mail.gmail.com>
Subject: [GIT PULL] Please pull NFS client fixes for 5.8-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.8-2

for you to fetch changes up to 89a3c9f5b9f0bcaa9aea3e8b2a616fcaea9aad78:

  SUNRPC: Properly set the @subbuf parameter of xdr_buf_subsegment()
(2020-06-26 08:45:23 -0400)

----------------------------------------------------------------
Stable Fixes:
- xprtrdma: Fix handling of RDMA_ERROR replies
- sunrpc: Fix rollback in rpc_gssd_dummy_populate()
- pNFS/flexfiles: Fix list corruption if the mirror count changes
- NFSv4: Fix CLOSE not waiting for direct IO completion
- SUNRPC: Properly set the @subbuf parameter of xdr_buf_subsegment()

Other Fixes:
- xprtrdma: Fix a use-after-free with r_xprt->rx_ep
- Fix other xprtrdma races during disconnect
- NFS: Fix memory leak of export_path

Thanks,
Anna
----------------------------------------------------------------
Chuck Lever (6):
      xprtrdma: Prevent dereferencing r_xprt->rx_ep after it is freed
      xprtrdma: Use re_connect_status safely in rpcrdma_xprt_connect()
      xprtrdma: Clean up synopsis of rpcrdma_flush_disconnect()
      xprtrdma: Clean up disconnect
      xprtrdma: Fix handling of RDMA_ERROR replies
      SUNRPC: Properly set the @subbuf parameter of xdr_buf_subsegment()

Olga Kornievskaia (1):
      NFSv4 fix CLOSE not waiting for direct IO compeletion

Tom Rix (1):
      nfs: Fix memory leak of export_path

Trond Myklebust (1):
      pNFS/flexfiles: Fix list corruption if the mirror count changes

Vasily Averin (1):
      sunrpc: fixed rollback in rpc_gssd_dummy_populate()

 fs/nfs/direct.c                        | 13 +++++++++----
 fs/nfs/file.c                          |  1 +
 fs/nfs/flexfilelayout/flexfilelayout.c | 11 +++++++----
 fs/nfs/nfs4namespace.c                 |  1 +
 net/sunrpc/rpc_pipe.c                  |  1 +
 net/sunrpc/xdr.c                       |  4 ++++
 net/sunrpc/xprtrdma/frwr_ops.c         |  8 ++++----
 net/sunrpc/xprtrdma/rpc_rdma.c         |  9 +++------
 net/sunrpc/xprtrdma/transport.c        |  2 +-
 net/sunrpc/xprtrdma/verbs.c            | 71
++++++++++++++++++++++++++++++++++++++++++-----------------------------
 net/sunrpc/xprtrdma/xprt_rdma.h        |  3 ++-
 11 files changed, 75 insertions(+), 49 deletions(-)
