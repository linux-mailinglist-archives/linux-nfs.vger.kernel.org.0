Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E9D3469EF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbhCWUhO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233375AbhCWUhD (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 16:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 455E161574;
        Tue, 23 Mar 2021 20:37:03 +0000 (UTC)
Subject: [PATCH 1 0/4] Move post-send page release into svc_sendto
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Mar 2021 16:37:02 -0400
Message-ID: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm trying to move work out of the completion handlers, because these
are a convenient but limited resource due to their single-threaded
nature.

As a first step I've moved the code that DMA unmaps each
svc_rdma_send_ctxt and returns it to the free list to the tail of
svc_rdma_sendto().

---

Chuck Lever (4):
      svcrdma: Add a "deferred close" helper
      svcrdma: Normalize Send page handling
      svcrdma: Remove unused sc_pages field
      svcrdma: Retain the page backing rq_res.head[0].iov_base


 include/linux/sunrpc/svc_rdma.h            |  4 +-
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  8 ++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c      | 57 ++++++++--------------
 3 files changed, 29 insertions(+), 40 deletions(-)

--
Chuck Lever

