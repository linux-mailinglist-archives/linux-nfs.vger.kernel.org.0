Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E5372C705
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Jun 2023 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbjFLOKr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Jun 2023 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237076AbjFLOJ5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Jun 2023 10:09:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F87010C4;
        Mon, 12 Jun 2023 07:09:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B032D629A1;
        Mon, 12 Jun 2023 14:09:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1CB7C433D2;
        Mon, 12 Jun 2023 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686578996;
        bh=CW40ED4XwcFWcPaA1yS0qaj3Lz08j3Jn8xbFhhIZxJY=;
        h=Subject:From:To:Cc:Date:From;
        b=WwooHS8MJVSqdMY9iAqm82lQp0iRtFo5jtIdKpHqHgkkB6HcMa4ZRz2MVB0HYoFhL
         xi/NRebyn+/R38FnuKrYWKoQynYnvhuvt6hA6ru7w/YzHVz8TYlRB1wIY+Kp563QDJ
         GVe59zEO/c+1kTrP0ntN8K6VBPvzAkGkXhH9LSZuy6FG6505SN12s3XAzSDYhitebR
         vozq4dRh6vzB/JnahdiiZwTqSfAnXkHqoVZIadVu00GVAwgZVXPBM/fYnRPtsGVLZs
         k40skjWOvjXJ2/khDlGjVys6jn2c6agC3TJY6no6FDpMpww2y275pnG8h6kgnCGyX0
         TQqp4lHQTdZaA==
Subject: [PATCH v2 0/5] svcrdma: Go back to releasing pages-under-I/O
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
        linux-rdma@vger.kernel.org, tom@talpey.com
Date:   Mon, 12 Jun 2023 10:09:54 -0400
Message-ID: <168657879115.5619.5573632864481586166.stgit@manet.1015granger.net>
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

Return to the behavior of releasing reply buffer pages as part of
sending an RPC Reply over RDMA. I measured a performance improvement
(which is documented in 4/4). Matching the page release behavior of
socket transports also means we should be able to share a little
more code between transports as MSG_SPLICE_PAGES rolls out.

Changes since v1:
- Add a related fix
- Clarify some of the patch descriptions

---

Chuck Lever (5):
      SUNRPC: Revert cc93ce9529a6 ("svcrdma: Retain the page backing rq_res.head[0].iov_base")
      SUNRPC: Revert 579900670ac7 ("svcrdma: Remove unused sc_pages field")
      svcrdma: Revert 2a1e4f21d841 ("svcrdma: Normalize Send page handling")
      svcrdma: Prevent page release when nothing was received
      SUNRPC: Optimize page release in svc_rdma_sendto()


 include/linux/sunrpc/svc_rdma.h            |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  8 +---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 12 ++---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 53 ++++++++++++++--------
 4 files changed, 44 insertions(+), 33 deletions(-)

--
Chuck Lever

