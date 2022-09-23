Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF0D5E7B4A
	for <lists+linux-nfs@lfdr.de>; Fri, 23 Sep 2022 15:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbiIWNGG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 23 Sep 2022 09:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiIWNGF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 23 Sep 2022 09:06:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFA128A3F
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 06:06:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFB2D610A5
        for <linux-nfs@vger.kernel.org>; Fri, 23 Sep 2022 13:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7F9C433C1;
        Fri, 23 Sep 2022 13:06:00 +0000 (UTC)
Subject: [PATCH v1 0/6] xprtrdma deadlock avoidance
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Fri, 23 Sep 2022 09:05:58 -0400
Message-ID: <166393821144.1029362.9036806277307694311.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These patches attempt to reduce the possibility of a deadlock when
direct reclaim drives resource allocation in xprtrdma. Looking for
comments and review.

---

Chuck Lever (6):
      svcrdma: Clean up RPCRDMA_DEF_GFP
      xprtrdma: Clean up synopsis of rpcrdma_req_create()
      xprtrdma: Clean up synopsis of rpcrdma_regbuf_alloc()
      xprtrdma: MR-related memory allocation should be allowed to fail
      xprtrdma: Memory allocation should be allowed to fail during connect
      xprtrdma: Prevent memory allocations from driving a reclaim


 net/sunrpc/xprtrdma/backchannel.c          |  2 +-
 net/sunrpc/xprtrdma/frwr_ops.c             | 17 ++++-----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +--
 net/sunrpc/xprtrdma/verbs.c                | 42 +++++++++++-----------
 net/sunrpc/xprtrdma/xprt_rdma.h            | 10 ++++--
 5 files changed, 38 insertions(+), 37 deletions(-)

--
Chuck Lever

