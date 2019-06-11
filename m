Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2453D03D
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jun 2019 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389150AbfFKPIB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jun 2019 11:08:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:56226 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389076AbfFKPIB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jun 2019 11:08:01 -0400
Received: by mail-it1-f194.google.com with SMTP id i21so5468812ita.5;
        Tue, 11 Jun 2019 08:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=EBtXGmxYfB+895YTii3tpVZbtYsdyY2qNHgV8Ly2C0o=;
        b=YSqAPgq0aCRt3N5q9OtESh9ByGVQBOjwmT3nIaBtLt/IZCfO0KCKgJAhhy6BEgVlBs
         uqpQwN5PbEgyl/MkQ8KZQ9HUA9IMkP5AFz5ELFjyNxgjdsUl5eLGbRSbjvJnARz+Ego5
         uUsu6GsePwJCfWsG5VL2gr24vVYkqR+9bVIbpLuJINz3P/ImkZ92aHHDLZMqGp4QB6DU
         p/6AAvFN17gBqhdSLZ/utj+QI1sN8C7/1Lp01HXU/RirsMgIMq7j40IoamkzQBxSlkp9
         8RSNp4Dikp+G2mrlgfh/16FeNynkZy24WkKTZ/HIOUTlC9JXSlMgxrOJrofJXbcfZGPk
         cTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=EBtXGmxYfB+895YTii3tpVZbtYsdyY2qNHgV8Ly2C0o=;
        b=fmWE+UIeJ3g1LoiBgmnXhg45qsFi1y3cHdCd0xx+YWuMtYMVUqD2AxkKULPvCHehBd
         c9RGxOcfHCIWnlxBvctzCNYra6RXpz03cv25MddRWFa46QABdUc6RVvOHT49J146nId4
         89BBX5EjBtOkF8VoN0dHx528Ex+mceT39Duv5JmMSx2pHoCDZZK4T/S6IOg2wcdeBRmy
         w49U7QCBLk2mFojz902c4U6hwaQb2r4grmWvELv6HPx/29TY5IvJRB1/GdrIQxJbGVCa
         U8ip60aD7FrQ7XvwmKSg42ST+66QN/AjZMie7Ts1nrXYmk8lfNL7FHyYdpgnJF3L8gfR
         ljWA==
X-Gm-Message-State: APjAAAWhg3mvT+D/3/4IkqnHVVRP1HleHB9P1Vef+GWUFO0vkziuEUFL
        AqMZMbY+8HOWsd5nNlA0CUDz0Kkv
X-Google-Smtp-Source: APXvYqxm1sGEe7NY2cV5eIX07R67HbyTk9slMRgVRhV5ir4h2Kz6nnUzdFoO+VTlrKIllomr0Jy09A==
X-Received: by 2002:a24:b649:: with SMTP id d9mr18825962itj.61.1560265679934;
        Tue, 11 Jun 2019 08:07:59 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id k9sm618456ion.28.2019.06.11.08.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 08:07:59 -0700 (PDT)
Received: from manet.1015granger.net (manet.1015granger.net [192.168.1.51])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id x5BF7wQa021725;
        Tue, 11 Jun 2019 15:07:58 GMT
Subject: [PATCH v2 00/19] for-5.3 patches for review
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Tue, 11 Jun 2019 11:07:58 -0400
Message-ID: <20190611150445.2877.8656.stgit@manet.1015granger.net>
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
 fs/nfs/nfs4trace.h              |  165 +++++++++++++-------
 fs/nfs/nfs4xdr.c                |    2 
 fs/nfs/nfstrace.h               |  181 ++++++++++++++++------
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
 16 files changed, 776 insertions(+), 470 deletions(-)

--
Chuck Lever
