Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAC46C14D0
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Mar 2023 15:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjCTOfk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Mar 2023 10:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbjCTOfe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Mar 2023 10:35:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D7F244B7
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 07:35:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54FFAB80E79
        for <linux-nfs@vger.kernel.org>; Mon, 20 Mar 2023 14:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE44C433EF;
        Mon, 20 Mar 2023 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679322927;
        bh=ZhuxR85y8YTbcDUoD2uUAbCYYCbhdce0ug/TQlz/VqI=;
        h=Subject:From:To:Cc:Date:From;
        b=NBv4ZB+f2wbli0nGdyr1vZvBdhPQeebU7gT9/kqwprsuruGtTX9FClK99LPQG7E5R
         diH99rVl0nnQMmtwlkV8wulKORyrIPhA9Pr2RkdObGMeeQ+4c9pFYYKTHSOws1M4K0
         lGRJhtmO7oFDUnWQitKYyjtCIV62sFvvDfaaBVEVMcsdmOgj5gVhIhuCUuCMDOUwzg
         5vfhp+dIsXy98pX+PJgQHbd+EHgUkBpNNsVCkt+0RoAxT3viZjVn2s7LrVJzum+Sxa
         Uq1l0QEwI4oMfsi1mcWn3RYPwJ1eI2sAXOeE0j7s5A22zUz4jTcl1Rq6KzsNN3frKW
         i/2TlPefebHkA==
Subject: [PATCH v1 0/4] nfs-utils changes for RPC-with-TLS server
From:   Chuck Lever <cel@kernel.org>
To:     SteveD@redhat.com
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 20 Mar 2023 10:35:25 -0400
Message-ID: <167932279970.3437.7130911928591001093.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve-

This is server-side support for RPC-with-TLS, to accompany similar
support in the Linux NFS client. This implementation can support
both the opportunistic use of transport layer security (it will be
used if the client cares to) and the required use of transport
layer security (the server requires the client to use it to access
a particular export).

Without any other user space componentry, this implementation will
be able to handle clients that request the use of RPC-with-TLS. To
support security policies that restrict access to exports based on
the client's use of TLS, modifications to exportfs and mountd are
needed. These can be found here:

git://git.linux-nfs.org/projects/cel/nfs-utils.git

They include an update to exports(5) explaining how to use the new
"xprtsec=" export option.

The kernel patches, along with the the handshake upcall, are carried
in the topic-rpc-with-tls-upcall branch available from:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

This was posted under separate cover.

---

Chuck Lever (4):
      libexports: Fix whitespace damage in support/nfs/exports.c
      exports: Add an xprtsec= export option
      exportfs: Push xprtsec settings to the kernel
      exports.man: Add description of xprtsec= to exports(5)


 support/export/cache.c       |  15 ++++++
 support/include/nfs/export.h |   6 +++
 support/include/nfslib.h     |  14 +++++
 support/nfs/exports.c        | 100 ++++++++++++++++++++++++++++++++---
 utils/exportfs/exportfs.c    |   1 +
 utils/exportfs/exports.man   |  45 +++++++++++++++-
 6 files changed, 172 insertions(+), 9 deletions(-)

--
Chuck Lever

