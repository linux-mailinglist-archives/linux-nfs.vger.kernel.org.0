Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C4D71630D
	for <lists+linux-nfs@lfdr.de>; Tue, 30 May 2023 16:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjE3OF0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 30 May 2023 10:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbjE3OFY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 30 May 2023 10:05:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D6E110
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 07:05:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 045E8626D0
        for <linux-nfs@vger.kernel.org>; Tue, 30 May 2023 14:05:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9FAC433D2;
        Tue, 30 May 2023 14:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685455521;
        bh=teoKXskHIuWiFWjWwLW8rnqCDUwghrH0NfbdivrjD0E=;
        h=Subject:From:To:Cc:Date:From;
        b=U1jcjROGAa2/O2KAEVfj2y4e2Oxi0CbNUHlFlgKutJnFSm/OYCli1mo/B2BsvkL11
         crtbSA0NZMZJL+EY9AUKZW/dxNbPXvhKNJkkYIUdHTMS3BkyAGTH32ixDFFkmxfHBu
         /FnY0ftmAt+pWpyIE6ebMOOJuiECHW5v4PeXzebC7yyBEJihL4rxNtFmfgeh0sssbc
         ZNwLaFqqxF83h1xkv6LoXHH9bxksiyOPo/cmaZSPGQI0w4r30KtF+WZnPDP6ejCi0S
         4qLb1nffO81hjsDb7E8D6ilKgySXQuuHnQTSnmBPhpf/4CQ2nyK0Qb+iGskwOU24M/
         Q2OqvEY9g/oAw==
Subject: [PATCH v3 00/11] client-side RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, jlayton@redhat.com,
        linux-nfs@vger.kernel.org, kernel-tls-handshake@lists.linux.dev
Date:   Tue, 30 May 2023 10:05:09 -0400
Message-ID: <168545533442.1917.10040716812361925735.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Let's have a look at what is needed to support NFS in-transit
confidentiality in the Linux NFS client. These apply to 6.4-rc4
but previously they've been tested at multiple NFS bake-a-thon
events.

This series is also available in the topic-rpc-with-tls-upcall
branch at

 https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

Changes since v2:
- Rebased on v6.4-rc4

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

