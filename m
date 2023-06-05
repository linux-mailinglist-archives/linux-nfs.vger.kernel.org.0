Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0BA722703
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Jun 2023 15:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231840AbjFENLj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Jun 2023 09:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjFENL3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Jun 2023 09:11:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B976E6;
        Mon,  5 Jun 2023 06:11:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA8B61380;
        Mon,  5 Jun 2023 13:11:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6DEC433D2;
        Mon,  5 Jun 2023 13:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685970679;
        bh=SI9HoG9+koDF4RD/XUOQrZv2tgN83UZUnipQ5clChLU=;
        h=Subject:From:To:Cc:Date:From;
        b=T9UTWdM9av/xFNw6HRoR21B1gIebR4oEWWrOo4SmJbifxQ3v1k3uXevjtO9soNN9Q
         nwlf3Bl+sh8Njuz0SEgW4j8wP0AEBZa9D8F6u4ySS3vmbLk/DhI6OsDOOfZbiENlA2
         Y+mnQWsY5nQ3ofewGXKbp2Lf6EYywdqgThlOXP/ckBNrjRIFq5GvdX4VsEZXqOdofX
         NqyKWOH8JMiYcvNaWDEdDrCmnDif4wkZr5lR4AUqX4uEMopgieAmon51gdaah3HvDM
         c2fK9WxlkVC29x3VHEjWI4Yl2zrEifoNlO4vX2KpT/3D9ar/DMVhCf4GXzHNsCHEXV
         D4djSZsI1/Cqg==
Subject: [PATCH v1 0/4] NUMA memory optimizations for NFS/RDMA server
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        tom@talpey.com
Date:   Mon, 05 Jun 2023 09:11:17 -0400
Message-ID: <168597050247.7694.8719658227499409307.stgit@manet.1015granger.net>
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

Ensure that memory for various purposes is allocated on the node
closest to the underlying device. Using the device::numa_node field
guarantees the allocation is performed from the correct node.

---

Chuck Lever (4):
      svcrdma: Allocate new transports on device's NUMA node
      svcrdma: Clean up allocation of svc_rdma_recv_ctxt
      svcrdma: Clean up allocation of svc_rdma_send_ctxt
      svcrdma: Clean up allocation of svc_rdma_rw_ctxt


 include/linux/sunrpc/svc_rdma.h          |  1 -
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 18 +++++++-----------
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 10 ++++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    |  9 ++++-----
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 18 +++++++++---------
 5 files changed, 26 insertions(+), 30 deletions(-)

--
Chuck Lever

