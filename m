Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9B2CE6B
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 20:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfE1SUw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 14:20:52 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:33857 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfE1SUw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 14:20:52 -0400
Received: by mail-it1-f175.google.com with SMTP id g23so3325329iti.1;
        Tue, 28 May 2019 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=N0c2rFnSmWzudniOXAgq6FAlJXTSYfwB+Tp97fGmO8Q=;
        b=WwHlIWsf3S1iXVYmqEqvK+xcDQY/1xmbADXyb/DrYqUZcW3HXWQUGCGTtGWQ/jQn1T
         4ctAMGO4KQ7C/Fp9tMGh1NdoUVE1KBoqrBEouuqm+TFWTJyM9A78EGhy/dzXH8XztLur
         kXygXOA9kog+4lcfvtA3a0TQxAy9+ATL54fdcSlJsGFNPlDFoaxy7nW8I7KoMUdaW8R2
         KuPSNMix/MbBfXgNpZ0wckNRkhMgJybjE2kFIkRQe2PCyWw7DbLRYuyS0tdIDZsBQtZR
         /tFw02fm0DF7Fd2hUsK1Q/i3cHlfrwm2yAFLDhKw/OVqAy6wyq99Xf2QyDReo3HQo4nB
         Gh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=N0c2rFnSmWzudniOXAgq6FAlJXTSYfwB+Tp97fGmO8Q=;
        b=o1C+7AG9Cm+Cq/5TWV5T88FxhBidyJk+bFPlCXbNo3cCiGiMLixErJBtr8GHyXt7rQ
         VVvo4Tg7dpoj1xZwrRgC4Q9nsy9cnai9dXqXIIgKSd3w9DCM3E7kfMVHIS/H69rZOwh8
         fqJIgmv3R3m57LJMZ4v0DfwTz73S8v1X0UvK/ZHQ3+Cqu5pwM35zZeS8BlnOgF8kFZhL
         vzcBO3+Vw+Y57y6kGY76JfIwU/D42OkrBjT9dsQSZoSsEr5nhEh3V7OyXCN23TWLHdbV
         r/ON5hPtor7toItpP/3CezAtIRg8OJO0QZkq4Qx0LtgzKtR/QdxY0xq1c3XMiq3XriFl
         Vr2A==
X-Gm-Message-State: APjAAAWxIJBTk67sRNu6UMt/BRnSN/2ka1i3GPJ86aTSTW6kQ8Z8rp7C
        4O0khEWLJN3aSKfAAGe7NBa9xflx
X-Google-Smtp-Source: APXvYqzYWPLUse5oluk/7h5DncU8sPSSuOVqaapmqqKGuK93Bux6QS78oWartr6a4lm35XB9ZPAzVw==
X-Received: by 2002:a02:9986:: with SMTP id a6mr15351888jal.51.1559067651496;
        Tue, 28 May 2019 11:20:51 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f1sm4727331iop.53.2019.05.28.11.20.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:20:51 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x4SIKoKd014513;
        Tue, 28 May 2019 18:20:50 GMT
Subject: [PATCH RFC 00/12] for-5.3 NFS/RDMA patches for review
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 28 May 2019 14:20:50 -0400
Message-ID: <20190528181018.19012.61210.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a series of fixes and architectural changes that should
improve robustness and result in better scalability of NFS/RDMA.
I'm sure one or two of these could be broken down a little more,
comments welcome.

The fundamental observation is that the RPC work queues are BOUND,
thus rescheduling work in the Receive completion handler to one of
these work queues just forces it to run later on the same CPU. So
try to do more work right in the Receive completion handler to
reduce context switch overhead.

A secondary concern is that the average amount of wall-clock time
it takes to handle a single Receive completion caps the IOPS rate
(both per-xprt and per-NIC). In this patch series I've taken a few
steps to reduce that latency, and I'm looking into a few others.

This series can be fetched from:

  git://git.linux-nfs.org/projects/cel/cel-2.6.git

in topic branch "nfs-for-5.3".

---

Chuck Lever (12):
      xprtrdma: Fix use-after-free in rpcrdma_post_recvs
      xprtrdma: Replace use of xdr_stream_pos in rpcrdma_marshal_req
      xprtrdma: Fix occasional transport deadlock
      xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag
      xprtrdma: Remove fr_state
      xprtrdma: Add mechanism to place MRs back on the free list
      xprtrdma: Reduce context switching due to Local Invalidation
      xprtrdma: Wake RPCs directly in rpcrdma_wc_send path
      xprtrdma: Simplify rpcrdma_rep_create
      xprtrdma: Streamline rpcrdma_post_recvs
      xprtrdma: Refactor chunk encoding
      xprtrdma: Remove rpcrdma_req::rl_buffer


 include/trace/events/rpcrdma.h  |   47 ++++--
 net/sunrpc/xprtrdma/frwr_ops.c  |  330 ++++++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |  146 +++++++----------
 net/sunrpc/xprtrdma/transport.c |   16 +-
 net/sunrpc/xprtrdma/verbs.c     |  115 ++++++--------
 net/sunrpc/xprtrdma/xprt_rdma.h |   43 +----
 6 files changed, 384 insertions(+), 313 deletions(-)

--
Chuck Lever
