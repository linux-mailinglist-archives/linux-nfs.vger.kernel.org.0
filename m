Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100F572C71B
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbjFLONa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235611AbjFLON3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02B1F0
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 07:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 757A961D80
        for <linux-nfs@vger.kernel.org>; Mon, 12 Jun 2023 14:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB7EC433EF;
        Mon, 12 Jun 2023 14:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686579207;
        bh=9eecKELwBaYftnl/t+fUPs0zTSNUZrdQht8+fQwEjWY=;
        h=Subject:From:To:Cc:Date:From;
        b=HnnlKDSm4tRvjXFon8DCcATn/5Fyxa98hVYLJRteVTiSkuFxMe1b4IMnmGw9UQqgd
         9Hd2HxhrlncUO4/4pL3GNgsBMW6gyWzQVfw3SxmtV4JIWzUItHmMBwZaDrw58va7NS
         tu9/FVYg2xwm0oaRoTT5OpGu/EfsDkdmpWMjoSiCjVBsVc3sjEIM3O/svsv0zQSD+I
         faCvBsdtPGWQWQqd4PRsb/ymYsPYP6xMP61M5HxnF3N5z4CRpPWy1XXVkZKLlr+U1q
         fBwq/Wlm2I3beBfmysss2GPCge9DIlOFTSb3vfG9QWmAVJVcFkPdWME7FLVm7qykbh
         +BSnIvM9kSpHQ==
Subject: [PATCH v1 0/7] Several minor NFSD clean-ups
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 12 Jun 2023 10:13:26 -0400
Message-ID: <168657912781.5674.12501431304770900992.stgit@manet.1015granger.net>
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

These are not strongly related to each other, but there was a whole
collection such that I didn't feel like posting each individually.

---

Chuck Lever (7):
      SUNRPC: Move initialization of rq_stime
      NFSD: Add an nfsd4_encode_nfstime4() helper
      svcrdma: Convert "might sleep" comment into a code annotation
      svcrdma: trace cc_release calls
      svcrdma: Remove an unused argument from __svc_rdma_put_rw_ctxt()
      SUNRPC: Fix comments for transport class registration
      SUNRPC: Remove transport class dprintk call sites


 fs/nfsd/nfs4xdr.c                     | 46 +++++++++++++++------------
 include/trace/events/rpcrdma.h        |  8 +++++
 net/sunrpc/svc_xprt.c                 | 18 ++++++++---
 net/sunrpc/xprtrdma/svc_rdma_rw.c     | 14 ++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |  2 ++
 5 files changed, 58 insertions(+), 30 deletions(-)

--
Chuck Lever

