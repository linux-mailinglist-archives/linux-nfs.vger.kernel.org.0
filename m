Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9014BB8D
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 16:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfFSOc3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 10:32:29 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:47061 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSOc3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 10:32:29 -0400
Received: by mail-io1-f66.google.com with SMTP id i10so38487938iol.13;
        Wed, 19 Jun 2019 07:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1ocFhRT15TVKyx9UOCxRa+zAnCt1RI4SJ07RigYpSUE=;
        b=OqdeuybSLyynVo6uGP8/B/6s6zwgAR+kA0kl7rl5+xLEroZygaTL6kQ0FoT/JekWF8
         mcthohqsRATA3yi2ZGyZTtH084XsVUixlO7L1URLJyvc6be5r8auFy5h6XgoNAhss5vT
         PXrqYlMc1hs84jLnyyqbA9wxuCTdbg7NTs5rHsNh+ZeyV5c27P7kIrbtMog5Frkb3G0s
         t5OPg/v+eLhXs/wdA6Rf9S8JdD6numxzqXWj48T4ceKKUZphie2moWaSZKRCMxnbZLI+
         Jy5QZJdnmJmLi2MjdMKQ/LeTKFaIilSzPmV70N2grlIJr/nv/EAl01UXI2y1nrFt3mTT
         6Mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1ocFhRT15TVKyx9UOCxRa+zAnCt1RI4SJ07RigYpSUE=;
        b=hUnw6Hbz5barJeAKeijh+JrX1EWHL20IUTgCpn/EvWm1SIfgAt2Ry1VBeF7DqzkhIn
         CTR4HJZrQjs9UvEJy3lSUfGUwPc1MU9aqhHmjuVCfzLTqLffuxpPj9qgunvtS+5dXJXC
         6Pxhm6ps8g60piuaPNAkI89xFymEntxLUsQ9IxbJWXoyByc8KrzwlSmFcLih6Q1buEul
         vymGbPg1eu8hvzth2LUKVZE8cuYC65J2bGqaONA2bs1vTQzyGZjTyjAOi6/TM6ncfG78
         4Z4/sKRLApxG7AlyX4rpI1aXQgjs/405QTdyHGidQ+ccz0LlX5HWyZD2lBogTfLbm2yq
         4mXA==
X-Gm-Message-State: APjAAAVeOkeAO1vWX5vqBQqE+euTAItB8cVEVEQCWOgWBNAczGyY+8bF
        tDSfgoBm5YHLYgUKlaodNSA=
X-Google-Smtp-Source: APXvYqwjA5HeTXgZ5s2BEfVffMyLfnonwRIsHFabIk3MquiCgd05+pfiTgGrOociDyAWfnFT31jROw==
X-Received: by 2002:a05:6638:281:: with SMTP id c1mr9702676jaq.43.1560954748690;
        Wed, 19 Jun 2019 07:32:28 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v25sm14476159ioh.25.2019.06.19.07.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:32:28 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5JEWRL8004491;
        Wed, 19 Jun 2019 14:32:27 GMT
Subject: [PATCH v4 00/19] for-5.3 patches
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 19 Jun 2019 10:32:26 -0400
Message-ID: <20190619143031.3826.46412.stgit@manet.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

I think these are ready to merge.

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


Changes since v3:
* Fixed use-after-free bug introduced in two patches

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
