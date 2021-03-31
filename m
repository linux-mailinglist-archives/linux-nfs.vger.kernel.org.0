Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C717D350771
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 21:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbhCaTg1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 15:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235416AbhCaTgA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 31 Mar 2021 15:36:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A91976101E;
        Wed, 31 Mar 2021 19:35:59 +0000 (UTC)
Subject: [PATCH v1 0/8] xprtrdma Receive Queue fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Wed, 31 Mar 2021 15:35:58 -0400
Message-ID: <161721926778.515226.9805598788670386587.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I found a number of crashers and other problems in and around the
xprtrdma logic for managing the Receive Queue during connect and
disconnect events.

---

Chuck Lever (8):
      xprtrdma: Avoid Receive Queue wrapping
      xprtrdma: Do not post Receives after disconnect
      xprtrdma: Put flushed Receives on free list instead of destroying them
      xprtrdma: Improve locking around rpcrdma_rep destruction
      xprtrdma: Improve commentary around rpcrdma_reps_unmap()
      xprtrdma: Improve locking around rpcrdma_rep creation
      xprtrdma: Fix cwnd update ordering
      xprtrdma: Delete rpcrdma_recv_buffer_put()


 net/sunrpc/xprtrdma/backchannel.c |  4 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    |  7 +--
 net/sunrpc/xprtrdma/verbs.c       | 87 +++++++++++++++++++------------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  4 +-
 4 files changed, 64 insertions(+), 38 deletions(-)

--
Chuck Lever

