Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F4C780CF2
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 15:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377273AbjHRNtk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 09:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377445AbjHRNtT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 09:49:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBCB44AD
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 06:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 778E3668D0
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:48:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E72C433C7;
        Fri, 18 Aug 2023 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692366497;
        bh=E0kVVodCbefyJp5FzPYsAMTrouQBUn4DwuH07ZLpV9c=;
        h=From:To:Cc:Subject:Date:From;
        b=h3RFuKX89hLcbh2U6Gk2sGW4bN3HCVcF7nIyhCltmlSoRttVKaiIloTv1jNJt6g/B
         eiFq5jKr0FzGw19gcSisKdMoaFfCdcydqLWdchDOHwzPm8Tt3JSSjlEPrq5mw+ifHv
         o05g1rVzY52LxUZ+tRMPSUYpC5+iTz0v8n+83LE/CYTjB/tqmFfsyK+xIBhmfehDun
         7oNio0A+7tjsJKkzdrZnh+EaDmZDDUsqn+qLSll/XXrFHH1G5/Jk0npaUEFb/Fbsmv
         dWGdUoa4cvrDHKpGWR+BIxVIYD31b6KQA3PYn9wGeZvYgzcGzM0KpQ/z2fFc2JTvNB
         CZm+ri4j5VsIw==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] Improve failover times for pNFS mirroring
Date:   Fri, 18 Aug 2023 09:41:46 -0400
Message-ID: <20230818134150.23485-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When a data server goes down, it can currently take 3 minutes for the
RPC connection attempt to give up, and return control to the NFS layer.
If the file is mirrored, we usually want to fail the attempt to the
downed data server much earlier, and retry using one of the other
mirrors.
This patchset sets the connect timeout to be closer to the I/O timeout
value for the case of pNFS to NFSv3 data servers.

Trond Myklebust (4):
  SUNRPC: Set the TCP_SYNCNT to match the socket timeout
  SUNRPC: Refactor and simplify connect timeout
  SUNRPC: Allow specification of TCP client connect timeout at setup
  NFS/pNFS: Set the connect timeout for the pNFS flexfiles driver

 fs/nfs/client.c             |  2 ++
 fs/nfs/internal.h           |  2 ++
 fs/nfs/nfs3client.c         |  3 ++
 fs/nfs/pnfs_nfs.c           |  3 ++
 include/linux/sunrpc/clnt.h |  2 ++
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/clnt.c           |  2 ++
 net/sunrpc/xprtsock.c       | 58 +++++++++++++++++++++++++++----------
 8 files changed, 59 insertions(+), 15 deletions(-)

-- 
2.41.0

