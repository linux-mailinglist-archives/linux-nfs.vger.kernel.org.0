Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F3E7E9D6E
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjKMNnE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjKMNnD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:43:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB7918B;
        Mon, 13 Nov 2023 05:43:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035EDC433C9;
        Mon, 13 Nov 2023 13:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699882980;
        bh=lG5EYDtZnt2X+DiALFLYeV+KP/ShKxTW+QClyREU06I=;
        h=Subject:From:To:Cc:Date:From;
        b=iSI9PNnhmrIS9Z/dWBs6uHf5gS0+2vh6xrCU3DXAiWfCrjpfFCUMgDqjctf3hx2ls
         EOC/mdEW3yfTQOel7WuoCdf2yaSQiQo1W7LEJTRV4YvdX+VNoZH6DVhGGR+Ojwpo4q
         WFYCt5sg912NlIJtnQgg7nT4SyrXYwOU1CjFrzNKG612oKLr1lAp8RL4ga8es2ZIHB
         jkM74mvRGxt8n1wJMlUzMg4hsPg6ioutJKvmrhmX/BpZRvc2t41bdb1pRyFoThDxfV
         /cmvwFOdGQZanf62PRS6dSd2l2b+EMeH6hcfAaZtXqO6TlvUkkkW2zcqehsJB+9HKV
         U7HpoxL2g90KA==
Subject: [PATCH v1 0/7] Switch NFS server CQs to use soft IRQ
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     tom@talpey.com
Date:   Mon, 13 Nov 2023 08:42:59 -0500
Message-ID: <169988267843.6417.17927133323277523958.stgit@bazille.1015granger.net>
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

I've found that using the ib_comp_wq for completion queues can add
microseconds of latency in the average case and extend tail
latencies significantly. Now that we've shaved a bunch of work out
of the server's completion handlers, it should be safe to go back to
using soft IRQ rather than ib_comp_wq, in order to gain better RTT
latencies.

---

Chuck Lever (7):
      svcrdma: Eliminate allocation of recv_ctxt objects in backchannel
      svcrdma: Clean up use of rdma->sc_pd->device in Receive paths
      svcrdma: Pre-allocate svc_rdma_recv_ctxt objects
      svcrdma: Switch Receive CQ to soft IRQ
      svcrdma: Clean up use of rdma->sc_pd->device
      svcrdma: Move the svcxprt_rdma::sc_pd field
      svcrdma: Move Send CQ to SOFTIRQ context


 include/linux/sunrpc/svc_rdma.h            |  6 +--
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 11 ++--
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    | 53 +++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 59 ++++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |  6 +--
 6 files changed, 75 insertions(+), 64 deletions(-)

--
Chuck Lever

