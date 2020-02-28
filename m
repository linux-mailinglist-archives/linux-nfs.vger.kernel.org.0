Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13DCF172D3E
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Feb 2020 01:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729984AbgB1Aa1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Feb 2020 19:30:27 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:39499 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgB1Aa1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Feb 2020 19:30:27 -0500
Received: by mail-pj1-f50.google.com with SMTP id e9so508883pjr.4;
        Thu, 27 Feb 2020 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uDIiFc6YXTy9enlRlRGL86FpscWVeWg0qsaV6z1IdOE=;
        b=L7Rzg807Gn1tFoaGrBPo0/24iC9gvz5QtRxPsdFAQ7A69YYqTneRpr1Hvf6zc6bSWU
         AFfJoTZBXH+QEFy6IRZRfdZ5N3h50ONIYT9tezumqFvyqDvTm+Yxh97d+TcQNd34D+yE
         UrRkc2tKdSj/gKJvOQ1dJNmTiBo7VXn6bKrcLHzVNwPZcIR8oiKUNXsn1C9i3QF0x/J+
         oeRwXTvC7dWlBErGqXU/K9PWhacZr6iiQy9rLAUL5oj4tqDPprtw69N/Mbm62D6bIRDv
         Xc1NmjXr2m6Q75F+8pGYxBIKMX3P7lwLg/9V+T7GJUVjS5aBdPwIPZGCahj4VTXLNvup
         xIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uDIiFc6YXTy9enlRlRGL86FpscWVeWg0qsaV6z1IdOE=;
        b=t80UDpO8KCzYV+NIeIESAvgzNQQos349apdMk6/aPlMVaWL4/2+eOjqQ9NWFkpkArz
         sMfuAtF3QOe47sqpD8A5J4YqefYkENPen5EfibhCDd1RteVgQ7y4D791nAioTFkeDYrA
         4Zz2U1KrnR/2hAtXKKa+dMQ0vnbDG1IUn+wnBjhi11NE6Ijlnv7BcAF9ZDvH8zzcv0hn
         kzv47nGF6obloRlPM4NnDenUNoyR05Krzzon/pYzegz4yy5aLm9P5ZgDNPSYZAb8jlzy
         ChDyyXUwjYDxz6HoZ71DiXxy3Pftqqg50Eo2UqvxSP+L2kg55lK9k86xUYBKGNxClWPh
         mxWw==
X-Gm-Message-State: APjAAAVA+0lICUuRqNRS5G26ndgT31nwwEvly1yoRjENojwEgs36/i3n
        N9fres9GRNw3wpu3qNIqxbszhBV9
X-Google-Smtp-Source: APXvYqxazYLEldxCWMyANNmJ7mYGoVkY9OA2+dW2DBw223T5iAo450P5zVIVxfZVFAodmfIcb+cg9Q==
X-Received: by 2002:a17:902:694b:: with SMTP id k11mr1399384plt.334.1582849826533;
        Thu, 27 Feb 2020 16:30:26 -0800 (PST)
Received: from seurat29.1015granger.net (ip-184-250-247-225.sanjca.spcsdns.net. [184.250.247.225])
        by smtp.gmail.com with ESMTPSA id q187sm8315616pfq.185.2020.02.27.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:30:25 -0800 (PST)
Subject: [PATCH v1 00/16] NFS/RDMA server patches maybe for v5.7
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 27 Feb 2020 19:30:24 -0500
Message-ID: <158284930886.38468.17045380766660946827.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hey Bruce-

Here's the part of the RFC patch series I recently sent out that is
likely to be ready for the v5.7 merge window. These need a little
more soak-time. Please review them and let me know if there's
something terribly objectionable.

Again, the direction of the larger series is eventual support for
the server's RPC/RDMA transport to deal correctly with multiple
Write chunks in an RPC. Today the server transport supports only
one Write chunk per RPC. That's somewhat less than compliant with
RFC 8166, though good enough for any operation the Linux NFS/RDMA
client uses, and most every operation Solaris can send.

The patches below are clean-ups and optimizations that prepare the
way for multi-Write chunk support.

---

Chuck Lever (16):
      nfsd: Fix NFSv4 READ on RDMA when using readv
      NFSD: Clean up nfsd4_encode_readv
      svcrdma: Fix double svc_rdma_send_ctxt_put() in an error path
      SUNRPC: Add xdr_pad_size() helper
      svcrdma: Create a generic tracing class for displaying xdr_buf layout
      svcrdma: Remove svcrdma_cm_event() trace point
      svcrdma: Use struct xdr_stream to decode ingress transport headers
      svcrdma: De-duplicate code that locates Write and Reply chunks
      svcrdma: Update synopsis of svc_rdma_send_reply_chunk()
      svcrdma: Update synopsis of svc_rdma_map_reply_msg()
      svcrdma: Update synopsis of svc_rdma_send_reply_msg()
      svcrdma: Rename svcrdma_encode trace points in send routines
      SUNRPC: Add encoders for list item discriminators
      svcrdma: Refactor chunk list encoders
      svcrdma: Fix double sync of transport header buffer
      svcrdma: Avoid DMA mapping small RPC Replies


 fs/nfsd/nfs4xdr.c                          |   29 +-
 include/linux/sunrpc/rpc_rdma.h            |    3 
 include/linux/sunrpc/svc.h                 |    3 
 include/linux/sunrpc/svc_rdma.h            |   23 +
 include/linux/sunrpc/svc_xprt.h            |    2 
 include/linux/sunrpc/xdr.h                 |   54 +++
 include/trace/events/rpcrdma.h             |   67 ++--
 include/trace/events/sunrpc.h              |   43 ++
 net/sunrpc/auth_gss/auth_gss.c             |    4 
 net/sunrpc/auth_gss/svcauth_gss.c          |    4 
 net/sunrpc/svc.c                           |   16 +
 net/sunrpc/svc_xprt.c                      |    6 
 net/sunrpc/svcsock.c                       |    8 
 net/sunrpc/xprt.c                          |    4 
 net/sunrpc/xprtrdma/rpc_rdma.c             |   39 --
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   16 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c    |  248 +++++++++-----
 net/sunrpc/xprtrdma/svc_rdma_rw.c          |   55 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      |  504 ++++++++++++++++------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c   |    8 
 20 files changed, 693 insertions(+), 443 deletions(-)

--
Chuck Lever
