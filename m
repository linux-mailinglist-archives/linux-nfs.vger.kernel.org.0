Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4261553E6EE
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jun 2022 19:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240026AbiFFOud (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jun 2022 10:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbiFFOub (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jun 2022 10:50:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6585703F9
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 07:50:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B0A614AF
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jun 2022 14:50:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57D3C34115;
        Mon,  6 Jun 2022 14:50:29 +0000 (UTC)
Subject: [PATCH v2 00/15] RPC-with-TLS client side
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     trondmy@hammerspace.com
Date:   Mon, 06 Jun 2022 10:50:28 -0400
Message-ID: <165452664596.1496.16204212908726904739.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the initial v5.19 merge window has closed, it's time for
another round of review for RPC-with-TLS support in the Linux NFS
client. This is just the RPC-specific portions. The full series is
available in the "topic-rpc-with-tls-upcall" branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

I've taken two or three steps towards implementing the architecture
Trond requested during the last review. There is now a two-stage
connection establishment process so that the upper level can use
XPRT_CONNECTED to determine when a TLS session is ready to use.
There are probably additional changes and simplifications that can
be made. Please review and provide feedback.

I wanted to make more progress on client-side authentication (ie,
passing an x.509 cert from the client to the server) but NFSD bugs
have taken all my time for the past few weeks.


Changes since v1:
- Rebased on v5.18
- Re-ordered so generic fixes come first
- Addressed some of Trond's review comments

---

Chuck Lever (15):
      SUNRPC: Fail faster on bad verifier
      SUNRPC: Widen rpc_task::tk_flags
      SUNRPC: Replace dprintk() call site in xs_data_ready
      NFS: Replace fs_context-related dprintk() call sites with tracepoints
      SUNRPC: Plumb an API for setting transport layer security
      SUNRPC: Trace the rpc_create_args
      SUNRPC: Refactor rpc_call_null_helper()
      SUNRPC: Add RPC client support for the RPC_AUTH_TLS auth flavor
      SUNRPC: Ignore data_ready callbacks during TLS handshakes
      SUNRPC: Capture cmsg metadata on client-side receive
      SUNRPC: Add a connect worker function for TLS
      SUNRPC: Add RPC-with-TLS support to xprtsock.c
      SUNRPC: Add RPC-with-TLS tracepoints
      NFS: Have struct nfs_client carry a TLS policy field
      NFS: Add an "xprtsec=" NFS mount option


 fs/nfs/client.c                 |  14 ++
 fs/nfs/fs_context.c             |  65 +++++--
 fs/nfs/internal.h               |   2 +
 fs/nfs/nfs3client.c             |   1 +
 fs/nfs/nfs4client.c             |  16 +-
 fs/nfs/nfstrace.h               |  77 ++++++++
 fs/nfs/super.c                  |   7 +
 include/linux/nfs_fs_sb.h       |   5 +-
 include/linux/sunrpc/auth.h     |   1 +
 include/linux/sunrpc/clnt.h     |  15 +-
 include/linux/sunrpc/sched.h    |  32 ++--
 include/linux/sunrpc/xprt.h     |   2 +
 include/linux/sunrpc/xprtsock.h |   4 +
 include/net/tls.h               |   2 +
 include/trace/events/sunrpc.h   | 157 ++++++++++++++--
 net/sunrpc/Makefile             |   2 +-
 net/sunrpc/auth.c               |   2 +-
 net/sunrpc/auth_tls.c           | 120 +++++++++++++
 net/sunrpc/clnt.c               |  34 ++--
 net/sunrpc/debugfs.c            |   2 +-
 net/sunrpc/xprtsock.c           | 310 +++++++++++++++++++++++++++++++-
 21 files changed, 805 insertions(+), 65 deletions(-)
 create mode 100644 net/sunrpc/auth_tls.c

--
Chuck Lever

