Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757566E9B1F
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjDTR4V (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjDTR4V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 13:56:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827C32690
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 10:56:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CBDC6151A
        for <linux-nfs@vger.kernel.org>; Thu, 20 Apr 2023 17:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5076AC433EF;
        Thu, 20 Apr 2023 17:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682013379;
        bh=Wja/VYvxJzyDI34sWit11mdsm9XzBkD6G2oeYwe0gts=;
        h=Subject:From:To:Cc:Date:From;
        b=Lq2kG1zvbQiyeYd7NLkfuetQCM4cHWn8P6qggdLNXcJBTwpMsr4yvqUhRsPNIiW5H
         q1yeU6c2c4YAxGXT4Xyam3+/ZdgD2P6RWYjQW8Wh/NUqvXrZ0GMbrj991LD5mhHsHl
         B7acdmFbEcyUuFxNFrH7/gWnpn/FGkLgQsq6cMLgk1u9+HdUAkfoQmmIOWjyhmxAlQ
         g/3OTb6unCsoeUM+v5r3odrSSclZbwcwbzvAptTSPGgUVMY64B64LlakYWhMLsFbKK
         Z+2Iu4v6ZKIxTLKDl3yneUMWro5+976ims1YZfKftxfWGuOY6T335ByRjZetHCIVhQ
         SdD3lobrIQB9g==
Subject: [PATCH v1 0/2] NFSD support for RPC-with-TLS
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     kernel-tls-handshake@lists.linux.dev
Date:   Thu, 20 Apr 2023 13:56:18 -0400
Message-ID: <168201329016.6370.17351667274885826598.stgit@91.116.238.104.host.secureserver.net>
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

Jakub has pulled the netlink handshake mechanism into net-next. I
plan to rebase nfsd-next on net-next so I can include the following
two patches as the first in-kernel consumer of TLS handshakes.

---

Chuck Lever (2):
      SUNRPC: Support TLS handshake in the server-side TCP socket code
      NFSD: Handle new xprtsec= export option


 fs/nfsd/export.c                 |  51 +++++++++++++++-
 fs/nfsd/export.h                 |   1 +
 include/linux/sunrpc/svc_xprt.h  |   5 +-
 include/linux/sunrpc/svcsock.h   |   2 +
 include/trace/events/sunrpc.h    |  16 ++++-
 include/uapi/linux/nfsd/export.h |  13 ++++
 net/sunrpc/svc_xprt.c            |   5 +-
 net/sunrpc/svcauth_unix.c        |  11 +++-
 net/sunrpc/svcsock.c             | 101 ++++++++++++++++++++++++++++++-
 9 files changed, 194 insertions(+), 11 deletions(-)

--
Chuck Lever

