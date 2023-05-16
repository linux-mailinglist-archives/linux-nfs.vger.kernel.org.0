Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D989270578B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEPTjp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 16 May 2023 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEPTjo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 15:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE6A5D0
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 12:39:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92318632D6
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 19:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C22C4339B;
        Tue, 16 May 2023 19:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684265924;
        bh=cWWo9z23dqLPjO2/AhluWFXVaJ07wULo/SC+11GjfXM=;
        h=Subject:From:To:Cc:Date:From;
        b=Tx5w+kIM8ePwHDUxW2dW4F1Pp2gpgyjo5Od0ErADIDSEH3SGr3qhMB56d0TecWF7v
         uPQoAC7gjflPcL2O2fLiGfDd2XGMX3z5+DdVi8oVI0az2bA3rniYCzWUnwxJWpMeJB
         WHzN8V0H7khBHCPYkLJRnoYn2vvvq4U0TP2cvCK8QAEL/NbNMqYh6YdVNbajcMgY/g
         2cOIr/yH18/muuQHxRBZ6ptNCzM7dCT8lX1QarhVg4cLZUkH2TKeADPbb7VntyJJAw
         YfSF4md6MEe5VsagUhsu/+K3vDN3eLdX8eXoP8ZWjf/0yOMfAq0hsy0EG0YGN3vd4L
         uZGzKfEm5oouw==
Subject: [PATCH RFC 00/12] client-side RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 16 May 2023 15:38:32 -0400
Message-ID: <168426587118.74246.214357450560967997.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that TLS handshake support is available in the kernel, let's
have a look at what is needed to support NFS in-transit confiden-
tiality in the Linux NFS client.

These apply to v6.4-rc2 (actually, net-next to be precise), but
previously they've been tested at multiple NFS bake-a-thon events.

---

Chuck Lever (12):
      NFS: Improvements for fs_context-related tracepoints
      SUNRPC: Plumb an API for setting transport layer security
      SUNRPC: Trace the rpc_create_args
      SUNRPC: Refactor rpc_call_null_helper()
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
 include/linux/sunrpc/auth.h     |   1 +
 include/linux/sunrpc/clnt.h     |   2 +
 include/linux/sunrpc/xprt.h     |  17 ++
 include/linux/sunrpc/xprtsock.h |   3 +
 include/trace/events/sunrpc.h   |  96 ++++++++-
 net/sunrpc/Makefile             |   2 +-
 net/sunrpc/auth.c               |   2 +-
 net/sunrpc/auth_tls.c           | 120 +++++++++++
 net/sunrpc/clnt.c               |  22 +-
 net/sunrpc/xprtsock.c           | 343 +++++++++++++++++++++++++++++++-
 17 files changed, 677 insertions(+), 29 deletions(-)
 create mode 100644 net/sunrpc/auth_tls.c

--
Chuck Lever

