Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B436970DF2E
	for <lists+linux-nfs@lfdr.de>; Tue, 23 May 2023 16:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjEWO3y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 May 2023 10:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237348AbjEWO3w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 May 2023 10:29:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDC18E
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 07:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FC1663316
        for <linux-nfs@vger.kernel.org>; Tue, 23 May 2023 14:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12B61C4339B;
        Tue, 23 May 2023 14:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684852188;
        bh=N4SsnA4e19rM33w/4/4zZ9dZesbMbq87aX/rORjv2QY=;
        h=Subject:From:To:Cc:Date:From;
        b=HwZONNB/SmZb/OhsaJ9t+jTfe9Khm/wF0CaUoaDEJcTY9YlP1PZ6f2C6aUbyUieO0
         vURovwM4PYi4GnPyv4zqS2yW0WuiUyYifRIMIJIqdhk49LAWN5U7hHDSCY2o6KZnOg
         QdrTaFjmch5wy7P/S27x02qxenOcRjlgLoFXtmrhzM9qUlUPCQwIfXDWP5Ba3W5Byh
         GNfy2XiWUfTDu5OMXUFo2RPSKHj4Q56oxLA57hJ8UKATTSkeI8HfSuT3ufB1pRB2Lm
         8XpeX2M/KeSxufzb9vQ9WNjXFvJPY+eiM9pRrA1eNPZmT51fXLzv+4Z6lF/UV8IJNW
         ePBt/OOSOfRUw==
Subject: [PATCH v2 00/11] client-side RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 23 May 2023 10:29:36 -0400
Message-ID: <168485183242.6613.7025123558596119858.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let's have a look at what is needed to support NFS in-transit
confidentiality in the Linux NFS client. These apply to net-next
but previously they've been tested at multiple NFS bake-a-thon
events.

This series is also available in the topic-rpc-with-tls-upcall
branch at

  https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Changes since RFC:
- Add an rpc_authops method to send TLS probes

---

Chuck Lever (11):
      NFS: Improvements for fs_context-related tracepoints
      SUNRPC: Plumb an API for setting transport layer security
      SUNRPC: Trace the rpc_create_args
      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
      SUNRPC: Ignore data_ready callbacks during TLS handshakes
      SUNRPC: Capture CMSG metadata on client-side receive
      SUNRPC: Add a connect worker function for TLS
      SUNRPC: Add RPC-with-TLS support to xprtsock.c
      SUNRPC: Add RPC-with-TLS tracepoints
      NFS: Have struct nfs_client carry a TLS policy field
      NFS: Add an "xprtsec=" NFS mount option


 fs/nfs/client.c                 |   7 +
 fs/nfs/fs_context.c             |  55 +++++
 fs/nfs/internal.h               |   2 +
 fs/nfs/nfs3client.c             |   1 +
 fs/nfs/nfs4client.c             |  18 +-
 fs/nfs/super.c                  |  12 ++
 include/linux/nfs_fs_sb.h       |   3 +-
 include/linux/sunrpc/auth.h     |   2 +
 include/linux/sunrpc/clnt.h     |   2 +
 include/linux/sunrpc/xprt.h     |  17 ++
 include/linux/sunrpc/xprtsock.h |   3 +
 include/trace/events/sunrpc.h   |  96 ++++++++-
 net/sunrpc/Makefile             |   2 +-
 net/sunrpc/auth.c               |   2 +-
 net/sunrpc/auth_tls.c           | 175 ++++++++++++++++
 net/sunrpc/clnt.c               |   9 +-
 net/sunrpc/xprtsock.c           | 343 +++++++++++++++++++++++++++++++-
 17 files changed, 727 insertions(+), 22 deletions(-)
 create mode 100644 net/sunrpc/auth_tls.c

--
Chuck Lever

