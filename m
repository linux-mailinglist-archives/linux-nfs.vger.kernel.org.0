Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C04875C
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Jun 2019 17:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbfFQPef (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Jun 2019 11:34:35 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37141 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbfFQPef (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Jun 2019 11:34:35 -0400
Received: by mail-io1-f67.google.com with SMTP id e5so22188683iok.4;
        Mon, 17 Jun 2019 08:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=/0BNvwtWNjnV2oFse4K1P6m2nPh45v3q/rowDs3iqGU=;
        b=ik40szpy1zWwecT719gvcy4c0EOZ692olFS4kjY99Hycqpk6lR+exbXuv4j9JNNMth
         PxYG0oPhZrqe/btT1RhT3vXaYPIaUD//xTS5fB4yoS/rpKcArNTWqsnWeFPXyI38RlfO
         VlD/c0+07KAG7mcKPh2PnP7z3IiBwqVpdUJdqt/kHaq1lMUd0ywmntfRqIin4v7d8321
         U9ZuCmVSXDI3+3kkDha6ZLJLcvvakiyHVTTL5JQut477ZWQNG/jwLUUV1St6QTt+y+ne
         0wpnAtkc0zuL2SR89iRyO77Q//IeT2MTov+z9kqgFbeiEfsHdzJj5fGOT67WTDtwSae8
         9bvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/0BNvwtWNjnV2oFse4K1P6m2nPh45v3q/rowDs3iqGU=;
        b=mZWO12JUWg0acd9vB+5lFqYn3I/lFtqmBuGWzUea1aXtkccYkQI7SWJiQE8hi6ZNf6
         YsulwDuK/3/V1wc3SVuBWnS/KNztHAv60ThVOFxkgjVS4DTr2lGCAjaGK4G6PnsSSp37
         chMnGC4+V/ZAK0kj9ULuosnU1/A+cmzNLQ54cUbIc0s3g5/goHHIq2N4uPT1MaYvetWW
         WosM9YwPtbg4tb82HaGM8s2a5yEfOvSYIFvAYBjike9jENn0UTczUaqd1kYlzCVUbqTi
         fuwJj1s/l5qmGHLraKN6OLcZnf5AJiD5ZeVHJqbGPCFOOsuwQi++0yW+IvAMsB9zCJqP
         pMbA==
X-Gm-Message-State: APjAAAWGqH6y3PNHDcZ0IFbO5PRCXGEoTLxmat8I/FVL25fLzo7KW9xp
        cgvTePpGe+TFcgIN/lzbUYYTb7T3
X-Google-Smtp-Source: APXvYqx4Y+naNSOTLf1NtCl6Z/qFu8eSZdFMhPu1dj1OmgixzZkOFtMXQHo1DVMOo73+gj3CO0Q1gQ==
X-Received: by 2002:a02:84e6:: with SMTP id f93mr51208347jai.73.1560785491669;
        Mon, 17 Jun 2019 08:31:31 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 20sm12332984iog.62.2019.06.17.08.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 08:31:30 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5HFVTrp031184;
        Mon, 17 Jun 2019 15:31:29 GMT
Subject: [PATCH v3 00/19] for-5.3 patches
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 17 Jun 2019 11:31:29 -0400
Message-ID: <20190617152657.12090.11389.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

I think these are ready for merge.

This is a series of fixes and architectural changes that should
improve robustness and result in better scalability of NFS/RDMA.

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


Changes since v2:
* Rebased on v5.2-rc5
* Changed trace points to display errors as negative values
* Used BIT() when defining trace point flag values
* Updated NFS lookup flags as well

Changes since RFC:
* Rebased on v5.2-rc4
* Clarified some patch descriptions and comments
* Addressed Anna's compiler warning in frwr_unmap_[a]sync
* Cross-ported recent xs_connect changes to xprt_rdma_connect
* Fixed several trace-event bugs

---

Chuck Lever (19):
      xprtrdma: Fix a BUG when tracing is enabled with NFSv4.1 on RDMA
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
      xprtrdma: Modernize ops->connect
      NFS4: Add a trace event to record invalid CB sequence IDs
      NFS: Fix show_nfs_errors macros again
      NFS: Display symbolic status code names in trace log
      NFS: Update symbolic flags displayed by trace events
      NFS: Record task, client ID, and XID in xdr_status trace points


 fs/nfs/callback_proc.c          |   28 ++-
 fs/nfs/nfs2xdr.c                |    2 
 fs/nfs/nfs3xdr.c                |    2 
 fs/nfs/nfs4trace.h              |  207 +++++++++++++++----------
 fs/nfs/nfs4xdr.c                |    2 
 fs/nfs/nfstrace.h               |  233 +++++++++++++++++++++-------
 include/linux/sunrpc/xprt.h     |    3 
 include/trace/events/rpcrdma.h  |   90 ++++++++---
 net/sunrpc/sched.c              |    1 
 net/sunrpc/xprt.c               |   32 ++++
 net/sunrpc/xprtrdma/frwr_ops.c  |  327 ++++++++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |  148 ++++++++----------
 net/sunrpc/xprtrdma/transport.c |   83 ++++++++--
 net/sunrpc/xprtrdma/verbs.c     |  115 ++++++--------
 net/sunrpc/xprtrdma/xprt_rdma.h |   44 +----
 net/sunrpc/xprtsock.c           |   23 ---
 16 files changed, 837 insertions(+), 503 deletions(-)

--
Chuck Lever
