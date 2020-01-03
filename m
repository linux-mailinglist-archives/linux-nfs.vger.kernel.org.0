Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8A12FADE
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Jan 2020 17:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgACQ4Y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 3 Jan 2020 11:56:24 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44244 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgACQ4Y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 3 Jan 2020 11:56:24 -0500
Received: by mail-yb1-f195.google.com with SMTP id f136so15716268ybg.11;
        Fri, 03 Jan 2020 08:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5vzo5OY7+DMv0SkDiOo0FJLSqA4kZjxbOb3656Sqpu8=;
        b=sl9l/vy2QMWZluEGfRoi/RIFQlXxjADkm3PPYv+96FsbISFEPryhcHXdw2I/uy2+OY
         xHEAMsJkztBe58qy2Hx0fs59acCE5VqYYUKd5HfvUXNdfsBdsBGBJ6VJc0HAUv2XgS3B
         cZtNtOLepotRcMyGPtvKGnOwYVcHH26yScngo2ono2QJFPn88Zp+6RSTdMargrGBk6CU
         JsnQnjDEeesSHNOgI6mqg4KLqsgbx5ft4nQAAFSBXf9Lz9+BLfXJm9VI6u+36EsnWPPK
         jq+G8Xq7V1sZ5f3iU6y0PfMHsWaB01Db+Lbkjw7kuRbtVUX8TamSZGUgIXWPKlEUqdtI
         nzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5vzo5OY7+DMv0SkDiOo0FJLSqA4kZjxbOb3656Sqpu8=;
        b=TquiGC8OUxh+x0oMHH0Ez6KgwTEOR5K27q+z5KWtv00M4eCHjmjMOqwZbVoviSHMuf
         TsSbohmYiQxYf+epWU8AGPw8gy5zZKBdRMEvB8wfumjXDRCYdm8k2zMLor9wfM+9fjl6
         hsa7QIPhRdhNT9hyagdHrpHkhBwQPm51tZ6KQtGilIRvKp4/Da5In0QMrPfg2fAAtWhN
         pEIRcXMUt1Cb0XgSDLsk9IDO2cn/iBCdEc9lPown01LUCM9X8MI0PPJgTIdW4589lfpA
         D+QDl+4zyJV10FdOLLXijfajI1IT1GdkmXdWCu0Jpxqfx5g4o3jrZIiIXWS7Z+TjPRYc
         AohQ==
X-Gm-Message-State: APjAAAXDHMyaG6Y7xlC/ZDP2tADFyMuhKdMDRSw3mi2BXO0s4umOnzmW
        686F201j6MvoVjuN62hLaYqyNciW
X-Google-Smtp-Source: APXvYqyBowtCvHx1UZGh+x012JXLRQvbaAu9MUmmP0qqq7CalIYadAFMRRDHJ0VTQRaEWqg83PNZCg==
X-Received: by 2002:a25:53c4:: with SMTP id h187mr28062736ybb.402.1578070583365;
        Fri, 03 Jan 2020 08:56:23 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d137sm22035319ywd.86.2020.01.03.08.56.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jan 2020 08:56:22 -0800 (PST)
Received: from morisot.1015granger.net (morisot.1015granger.net [192.168.1.67])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 003GuLOE016379;
        Fri, 3 Jan 2020 16:56:21 GMT
Subject: [PATCH v1 0/9] NFS/RDMA client patches for v5.6
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 03 Jan 2020 11:56:21 -0500
Message-ID: <157807044515.4606.732915438702066797.stgit@morisot.1015granger.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

These patches clean up the RPC/RDMA client code in preparation for
rewriting the transport set-up code. These are the only NFS/RDMA-
related patches I plan to submit for v5.6.

---

Chuck Lever (9):
      xprtrdma: Eliminate ri_max_send_sges
      xprtrdma: Make sendctx queue lifetime the same as connection lifetime
      xprtrdma: Refactor initialization of ep->rep_max_requests
      xprtrdma: Eliminate per-transport "max pages"
      xprtrdma: Refactor frwr_is_supported
      xprtrdma: Allocate and map transport header buffers at connect time
      xprtrdma: Destroy rpcrdma_rep when Receive is flushed
      xprtrdma: Destroy reps from previous connection instance
      xprtrdma: DMA map rr_rdma_buf as each rpcrdma_rep is created


 include/trace/events/rpcrdma.h    |   12 +-
 net/sunrpc/xprtrdma/backchannel.c |    4 +
 net/sunrpc/xprtrdma/frwr_ops.c    |  104 ++++++++----------
 net/sunrpc/xprtrdma/rpc_rdma.c    |   20 +--
 net/sunrpc/xprtrdma/transport.c   |   17 +--
 net/sunrpc/xprtrdma/verbs.c       |  213 +++++++++++++++++++++----------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |   14 +-
 7 files changed, 201 insertions(+), 183 deletions(-)

--
Chuck Lever

