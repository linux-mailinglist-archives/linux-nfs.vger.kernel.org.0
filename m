Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C426781BA8
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Aug 2023 02:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjHTAWR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 19 Aug 2023 20:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjHTAVj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 19 Aug 2023 20:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CEBE10BC
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 14:39:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C7D61523
        for <linux-nfs@vger.kernel.org>; Sat, 19 Aug 2023 21:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D56C433C7;
        Sat, 19 Aug 2023 21:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692481152;
        bh=Fuw9fDL1uSQacwGQef40IwdHBgarFsnXK8S0mj29vYE=;
        h=From:To:Cc:Subject:Date:From;
        b=Ri1Pk7O4pQ6JM7ry1U1NFPHgKkgtm3TwxZpCc3jtnsJbrVGnwZdwUNOCKv99qP2an
         RV+XDwrzP/NOp/8U6QJHpCY7dRAXciSb/1h3AyhGMbg1iAGJrPWOLCkvNoMOdJ45V9
         ZyoQD4mMz1O8PHn8tspwIMCMZJBAg5U5/wp2jL/2r/IQ+vC5IKfYtvMvbpdLH3m/Lh
         ZuYnOS7OqHH4NWYS4KzNJjUDowNvZvGEMF+nQHftthjlD3K0+WqDXVrBDTxTI2Luqw
         Ignjxz/MuXEZVOd7uI5Vhh5v1AjICOOwyTgk0ziYwIYemG8TOCsTLRKQ3ogjSD/9pE
         uc2EbCOqJg+WA==
From:   trondmy@kernel.org
To:     Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/5] Improve failover times for pNFS mirroring
Date:   Sat, 19 Aug 2023 17:32:20 -0400
Message-ID: <20230819213225.731214-1-trondmy@kernel.org>
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

v2:
 - Don't override connect timeouts in rpc_clnt_add_xprt
 - Don't override specified connect timeouts at setup

Trond Myklebust (5):
  SUNRPC: Set the TCP_SYNCNT to match the socket timeout
  SUNRPC: Refactor and simplify connect timeout
  SUNRPC: Allow specification of TCP client connect timeout at setup
  SUNRPC: Don't override connect timeouts in rpc_clnt_add_xprt()
  NFS/pNFS: Set the connect timeout for the pNFS flexfiles driver

 fs/nfs/client.c             |  2 ++
 fs/nfs/internal.h           |  2 ++
 fs/nfs/nfs3client.c         |  3 ++
 fs/nfs/pnfs_nfs.c           |  3 ++
 include/linux/sunrpc/clnt.h |  2 ++
 include/linux/sunrpc/xprt.h |  2 ++
 net/sunrpc/clnt.c           |  7 +++++
 net/sunrpc/xprtsock.c       | 55 +++++++++++++++++++++++++++----------
 8 files changed, 61 insertions(+), 15 deletions(-)

-- 
2.41.0

