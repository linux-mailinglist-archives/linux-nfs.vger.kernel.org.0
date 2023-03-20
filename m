Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23A76C14A1
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjCTOYZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbjCTOYY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:24:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04C1BDB
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:24:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 184DC6153E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4DAC43322;
        Mon, 20 Mar 2023 14:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322262;
        bh=Sf9A/Ut0JWRYeCmgyfORdwb3j6efMx3XxNqEryxhheo=;
        h=Subject:From:To:Cc:Date:From;
        b=fitRJp9bQawH96Uh62DqI4WuqWwH7A75qbEpcl/IdWgpl4vPjHX61inz9UWatbe33
         aV9bb8V6PKTJaaUCFJMwGBr1L3scAjPccHsASo1F29SIG2qwAEKlRO6T4u+p4VgpH8
         obzNFNw52+XV+eiiwWfFFiVn+3V02x6ZqkdEfO0n9miLE7diJg38W/I7W9Gib8hsfb
         95sE9nTg6LLAWo2zKNKcDgv4yyic0WEY9h0fBB15frD5Jo3Y7AWJOnscilrL/+6Kd9
         yXOXCsUVvAhHby+dm26J2PY4WdPjvZa1VyarLK8/M6/zVgNopniKIqxR/tkcX/0ao6
         H+MbkRXD9ANLQ==
Subject: [PATCH RFC 0/5] NFSD support for RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Mon, 20 Mar 2023 10:24:21 -0400
Message-ID: <167932094748.3131.11264549266195745851.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This is server-side support for RPC-with-TLS, to accompany similar
support in the Linux NFS client. This implementation can support
both the opportunistic use of transport layer security (it will be
used if the client cares to) and the required use of transport
layer security (the server requires the client to use it to access
a particular export).

The kernel patches, along with the the handshake upcall, are carried
in the topic-rpc-with-tls-upcall branch available from:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

The user space componenet of the upcall can be found in the
netlink-v7 branch from:

https://github.com/oracle/ktls-utils

This work includes a man page, tlshd(8), that explains how to set
up certificates for the server to use. Currently, NFS support for
RPC-with-TLS does not implement support for pre-shared keys.

Without any other user space componentry, this implementation will
be able to handle clients that request the use of RPC-with-TLS. To
support security policies that restrict access to exports based on
the client's use of TLS, modifications to exportfs and mountd are
needed. These can be found here:

git://git.linux-nfs.org/projects/cel/nfs-utils.git

They include an update to exports(5) explaining how to use the new
"xprtsec=" export option. I will post these for review under
separate cover.

---

Chuck Lever (5):
      SUNRPC: Revert 987c7b1d094d
      SUNRPC: Recognize control messages in server-side TCP socket code
      SUNRPC: Ensure server-side sockets have a sock->file
      SUNRPC: Support TLS handshake in the server-side TCP socket code
      NFSD: Handle new xprtsec= export option


 fs/nfsd/export.c                |  53 +++++++++-
 fs/nfsd/export.h                |  11 ++
 include/linux/sunrpc/svc_xprt.h |   5 +-
 include/linux/sunrpc/svcsock.h  |   2 +
 include/trace/events/sunrpc.h   |  42 +++++++-
 net/sunrpc/svc_xprt.c           |   5 +-
 net/sunrpc/svcauth_unix.c       |  11 +-
 net/sunrpc/svcsock.c            | 177 +++++++++++++++++++++++++++++---
 8 files changed, 284 insertions(+), 22 deletions(-)

--
Chuck Lever

