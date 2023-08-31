Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721A778F2CB
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347075AbjHaSlY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244547AbjHaSlX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:41:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B609E5D
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 11:41:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E900ACE2029
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 18:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAA8C433C8;
        Thu, 31 Aug 2023 18:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507277;
        bh=Yz+WuNtngb7NMAqVAoUYGVR+Xln/kuntD/QGj+CVO2s=;
        h=From:To:Cc:Subject:Date:From;
        b=mkMmZl1t17ngWRl6G9+YjDmkUh4yFRUCGqYIT4A4XxjEeiJbB4JNWqkVSedM/Uzzq
         omGopo3BIg8rt+/UByHZ6YSsp41OPCEubM5SrWRfp9o9gxYCUuLW7yPNXUzpTnqcAw
         4bPbD0X5THCxZkgkJTEf91ouOo5VMJvBD1XOQVNxzeZl5IMY7Zo9el9hs/RRZAydOs
         M5JFl1+1gz+6Ec+Xm1PiTKVbX1Ewr+UCbv3Jhba9LuxL22MTx5p+h0UrXwWQTezY8L
         I0Wq9Z0S5+MWaidJvT/qmQ6QaWvQAl7thGr33owjb+KAWnOUqICKcNYJhymDuB7ciW
         1BNW452MLsSpA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please pull NFS Client changes for 6.6
Date:   Thu, 31 Aug 2023 14:41:15 -0400
Message-ID: <20230831184115.811493-1-anna@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 53663f4103ff6738e4697004d6f84864d052333d:

  Merge tag 'nfs-for-6.5-2' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2023-08-22 10:50:17 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.6-1

for you to fetch changes up to c4a123d2e8c4dc91d581ee7d05c0cd51a0273fab:

  pNFS: Fix assignment of xprtdata.cred (2023-08-30 14:31:31 -0400)

----------------------------------------------------------------
NFS CLient Updates for Linux 6.6

New Features:
  * Enable the NFS v4.2 READ_PLUS operation by default

Stable Fixes:
  * NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info
  * NFS: Fix a potential data corruption

Bugfixes:
  * Fix various READ_PLUS issues including:
    * smatch warnings
    * xdr size calculations
    * scratch buffer handling
    * 32bit / highmem xdr page handling
  * Fix checkpatch errors in file.c
  * Fix redundant readdir request after an EOF
  * Fix handling of COPY ERR_OFFLOAD_NO_REQ
  * Fix assignment of xprtdata.cred

Cleanups:
  * Remove unused xprtrdma function declarations
  * Clean up an integer overflow check to avoid a warning
  * Clean up #includes in dns_resolve.c
  * Clean up nfs4_get_device_info so we don't pass a NULL pointer to __free_page()
  * Clean up sunrpc TCP socket timeout configuration
  * Guard against READDIR loops when entry names are too long
  * Use EXCHID4_FLAG_USE_PNFS_DS for DS servers

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (6):
      NFSv4.2: Fix READ_PLUS smatch warnings
      NFSv4.2: Fix READ_PLUS size calculations
      NFSv4.2: Rework scratch handling for READ_PLUS (again)
      SUNRPC: kmap() the xdr pages during decode
      NFS: Enable the READ_PLUS operation by default
      pNFS: Fix assignment of xprtdata.cred

Benjamin Coddington (1):
      NFS: Guard against READDIR loop when entry names exceed MAXNAMELEN

Dan Carpenter (2):
      SUNRPC: clean up integer overflow check
      nfs/blocklayout: Use the passed in gfp flags

Fedor Pchelkin (1):
      NFSv4/pnfs: minor fix for cleanup path in nfs4_get_device_info

GUO Zihua (1):
      NFS: Move common includes outside ifdef

Kinglong Mee (1):
      nfs: fix redundant readdir request after get eof

Olga Kornievskaia (2):
      NFSv4.1: use EXCHGID4_FLAG_USE_PNFS_DS for DS server
      NFSv4.2: fix handling of COPY ERR_OFFLOAD_NO_REQ

Trond Myklebust (6):
      NFS: Fix a potential data corruption
      SUNRPC: Set the TCP_SYNCNT to match the socket timeout
      SUNRPC: Refactor and simplify connect timeout
      SUNRPC: Allow specification of TCP client connect timeout at setup
      SUNRPC: Don't override connect timeouts in rpc_clnt_add_xprt()
      NFS/pNFS: Set the connect timeout for the pNFS flexfiles driver

Yue Haibing (1):
      xprtrdma: Remove unused function declaration rpcrdma_bc_post_recv()

huzhi001@208suo.com (1):
      filemap: Fix errors in file.c

 fs/nfs/Kconfig                  |  6 ++---
 fs/nfs/blocklayout/dev.c        |  4 +--
 fs/nfs/client.c                 |  2 ++
 fs/nfs/dir.c                    | 15 ++++++++---
 fs/nfs/direct.c                 | 20 ++++++++++++++-
 fs/nfs/dns_resolve.c            | 14 +++++------
 fs/nfs/file.c                   |  2 +-
 fs/nfs/internal.h               |  3 +++
 fs/nfs/nfs2xdr.c                |  2 +-
 fs/nfs/nfs3client.c             |  3 +++
 fs/nfs/nfs3xdr.c                |  2 +-
 fs/nfs/nfs42.h                  |  1 +
 fs/nfs/nfs42proc.c              |  5 ++--
 fs/nfs/nfs42xdr.c               | 17 ++++++++-----
 fs/nfs/nfs4client.c             |  3 +++
 fs/nfs/nfs4proc.c               | 17 ++++---------
 fs/nfs/pnfs_dev.c               |  2 +-
 fs/nfs/pnfs_nfs.c               |  5 +++-
 fs/nfs/read.c                   | 10 ++++++++
 include/linux/sunrpc/clnt.h     |  2 ++
 include/linux/sunrpc/xdr.h      |  6 ++---
 include/linux/sunrpc/xprt.h     |  2 ++
 net/sunrpc/clnt.c               |  8 ++++++
 net/sunrpc/svc.c                |  2 ++
 net/sunrpc/xdr.c                | 27 +++++++++++++++++++-
 net/sunrpc/xprtrdma/xprt_rdma.h |  1 -
 net/sunrpc/xprtsock.c           | 55 ++++++++++++++++++++++++++++++-----------
 27 files changed, 172 insertions(+), 64 deletions(-)
