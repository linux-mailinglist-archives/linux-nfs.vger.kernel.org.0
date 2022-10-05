Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3245F5AC9
	for <lists+linux-nfs@lfdr.de>; Wed,  5 Oct 2022 22:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJEUEa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 5 Oct 2022 16:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiJEUE3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 5 Oct 2022 16:04:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C848A2D1C3
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 13:04:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74FB1B81F2D
        for <linux-nfs@vger.kernel.org>; Wed,  5 Oct 2022 20:04:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D63C433D6;
        Wed,  5 Oct 2022 20:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665000265;
        bh=KX7BO/0MQep+t3eyK4s4doS/1R/Mp3i6L3wRr8f3eUA=;
        h=From:To:Cc:Subject:Date:From;
        b=ViwkW6J8T8+K+OVF1EbkEQAVyiu9Yei+XrVas5fm+9jdt8qX51NzF1roJw51I1D7R
         gXO8aRtBsnquwPi/kOG+oNHhjFOQqpNUy0hTZzTCalppdU1h+pfWoI6QXClBKh1vej
         rEBu8gOq4tZIQzNGTZg6YtCVq2EIG83JBd8GeEItumTC7anYPfUN6c+tYaBOOaQZ5o
         uHBm2LhmpPwPQQlIrwS3PzrGRQqU1cBJ9xrL7mUxp3VsR/sK/9svsm7BldUepl2TEy
         UsvOjlUVLxEFDf7M5EVPeP3zTfm1VwzNBbSxEuLj7kY+XumJZxvQ+NlEqxCF6xx4K6
         LNqCx8Cet8oFQ==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 0/4] pNFS/flexfiles: Cancel I/O if the layout is revoked
Date:   Wed,  5 Oct 2022 15:57:34 -0400
Message-Id: <20221005195738.4552-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.37.3
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

The pNFS/flexfiles driver is capable of having a lot of outstanding I/O
in the RPC layer when it flushes out the writeback data. If the server
decides to recall or revoke the layout when this happens, then it takes
a while for that I/O to complete.
To speed things up, add an API to allow the flexfiles driver to cancel
that I/O and hence return the layout earlier.

Trond Myklebust (4):
  SUNRPC: Fix races with rpc_killall_tasks()
  SUNRPC: Add a helper to allow pNFS drivers to selectively cancel RPC
    calls
  SUNRPC: Add API to force the client to disconnect
  NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked

 fs/nfs/flexfilelayout/flexfilelayout.c | 84 +++++++++++++++++++++++++-
 fs/nfs/pnfs.c                          |  9 ++-
 fs/nfs/pnfs.h                          |  9 +++
 include/linux/sunrpc/clnt.h            |  1 +
 include/linux/sunrpc/sched.h           |  6 ++
 net/sunrpc/clnt.c                      | 57 +++++++++++++++--
 net/sunrpc/sched.c                     | 51 +++++++++++-----
 net/sunrpc/xprtsock.c                  |  3 +-
 8 files changed, 194 insertions(+), 26 deletions(-)

-- 
2.37.3

