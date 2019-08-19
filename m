Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 256D9950DB
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Aug 2019 00:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbfHSWfz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Aug 2019 18:35:55 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:35978 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbfHSWfy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Aug 2019 18:35:54 -0400
Received: by mail-oi1-f170.google.com with SMTP id n1so195336oic.3;
        Mon, 19 Aug 2019 15:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4KZ3AuJ500jGK3DD+VDBHr0V9amt1vp4TKGzTpZ1HcM=;
        b=dUailAstIfD74WWQ290i5/8XVB2cBQLQOjwoawPqSVUjpvDBqtaKk0cvlHfz3/pnfS
         5POUyYVRa/Rs0+55E0VBpAHYPc457C+/KpNvN9isHb2M9KLr4xMYo1ovThSa9CMtA0yd
         A3emgqo+LhKxfRm1cBhvoWSQ1VHiU3QpQqfqnvyLkFypMiLrHu64YBPpMAHnyjk1wra7
         unB0Nqg712NBG3xkGYWi09APTYZlhWAiVAZUm9cF+rUXYpxZyhbC5QQIEu6S8n1QDXix
         /WWrXejEdrcS3S0B5WmQd9oqIzPxH0+q5k2nNvan9dlXTiRAo0/r3wbOQ7dGL8i8Rpff
         ma0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4KZ3AuJ500jGK3DD+VDBHr0V9amt1vp4TKGzTpZ1HcM=;
        b=KGQrJ0wQpadnf/J+FJ8vQOSHD58Vyw9urK5c7182/rhjwlvGKoIxNam4fkhFd2Dq9W
         Ld0C/nEWugsOYIcO3w19tYRaVSSP1llh30GaFi7g0HH+P1jH7TtPqouxuWFX4q6AEPij
         AQzP3Tck3czAJTfV1kfMSmvWRFWkqnzDEtQP8UP7ZBr7CVwzAig1x7lHoFNmlmnbV5WP
         J99RAOuCHbV2QxDWfAOW4+MLa9JKNrUX7iCO4UUkhVpXv3BH0zKlV5P3BHRGvTDkLpoA
         e+t+iwx+IYZ9j1D2HDE5G33Ztc+nOOzMl5zjWm77DPCl6a5CMqFST/aKQrf6nUQEenGH
         c36Q==
X-Gm-Message-State: APjAAAXj/OkYpUbhqrXdU8G+YEnBp/y/jg/11SeSk8UsOS0n8+Ut2Vy4
        TkxZUBy5+82I8yh1spEIE310jtjh
X-Google-Smtp-Source: APXvYqxHBHDwUHL/0nctxsRNYqjpYhgQg8FhuasMqwZcNtI5XmKQqOkoYv3wOWi3HGmOw/ISaGQbXg==
X-Received: by 2002:aca:c6d8:: with SMTP id w207mr14215913oif.94.1566254153803;
        Mon, 19 Aug 2019 15:35:53 -0700 (PDT)
Received: from seurat29.1015granger.net ([12.235.16.3])
        by smtp.gmail.com with ESMTPSA id f21sm6045571otq.7.2019.08.19.15.35.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 15:35:53 -0700 (PDT)
Subject: [PATCH v2 00/21] NFS/RDMA client-side for-5.4
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Aug 2019 18:35:32 -0400
Message-ID: <156625401091.8161.14744201497689200191.stgit@seurat29.1015granger.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

These feel like they are ready for you to merge.

Changes since v1:
- Rebased on v5.3-rc5
- Improved "Boost maximum transport header size"
- Minor clarifications

---

Chuck Lever (21):
      SUNRPC: Remove rpc_wake_up_queued_task_on_wq()
      SUNRPC: Inline xdr_commit_encode
      xprtrdma: Refresh the documenting comment in frwr_ops.c
      xprtrdma: Update obsolete comment
      xprtrdma: Fix calculation of ri_max_segs again
      xprtrdma: Boost maximum transport header size
      xprtrdma: Boost client's max slot table size to match Linux server
      xprtrdma: Rename CQE field in Receive trace points
      xprtrdma: Rename rpcrdma_buffer::rb_all
      xprtrdma: Toggle XPRT_CONGESTED in xprtrdma's slot methods
      xprtrdma: Simplify rpcrdma_mr_pop
      xprtrdma: Combine rpcrdma_mr_put and rpcrdma_mr_unmap_and_put
      xprtrdma: Move rpcrdma_mr_get out of frwr_map
      xprtrdma: Ensure creating an MR does not trigger FS writeback
      xprtrdma: Cache free MRs in each rpcrdma_req
      xprtrdma: Remove rpcrdma_buffer::rb_mrlock
      xprtrdma: Use an llist to manage free rpcrdma_reps
      xprtrdma: Clean up xprt_rdma_set_connect_timeout()
      xprtrdma: Fix bc_max_slots return value
      xprtrdma: Inline XDR chunk encoder functions
      xprtrdma: Optimize rpcrdma_post_recvs()


 include/linux/sunrpc/sched.h      |    3 
 include/linux/sunrpc/xprtrdma.h   |    4 -
 include/trace/events/rpcrdma.h    |   88 ++++++++++++--
 net/sunrpc/sched.c                |   27 +---
 net/sunrpc/xdr.c                  |    2 
 net/sunrpc/xprtrdma/backchannel.c |    4 -
 net/sunrpc/xprtrdma/frwr_ops.c    |  131 +++++++--------------
 net/sunrpc/xprtrdma/rpc_rdma.c    |   63 +++++++---
 net/sunrpc/xprtrdma/transport.c   |   12 +-
 net/sunrpc/xprtrdma/verbs.c       |  235 ++++++++++++++++---------------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |   58 ++++-----
 11 files changed, 305 insertions(+), 322 deletions(-)

--
Chuck Lever
