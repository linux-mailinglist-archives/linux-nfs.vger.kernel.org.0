Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2457E352D78
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbhDBPaP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPaO (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19F2160FF0;
        Fri,  2 Apr 2021 15:30:13 +0000 (UTC)
Subject: [PATCH v2 0/8] xprtrdma Receive Queue fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:12 -0400
Message-ID: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
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

Changes since v1:
- Reworked 2/8 based on review comments
- Clarified code comments and patch descriptions
- Added Reviewed-by tags where appropriate

---

Chuck Lever (8):
      xprtrdma: Avoid Receive Queue wrapping
      xprtrdma: Do not refresh Receive Queue while it is draining
      xprtrdma: Put flushed Receives on free list instead of destroying them
      xprtrdma: Improve locking around rpcrdma_rep destruction
      xprtrdma: Improve commentary around rpcrdma_reps_unmap()
      xprtrdma: Improve locking around rpcrdma_rep creation
      xprtrdma: Fix cwnd update ordering
      xprtrdma: Delete rpcrdma_recv_buffer_put()


 net/sunrpc/xprtrdma/backchannel.c |  4 +-
 net/sunrpc/xprtrdma/rpc_rdma.c    |  7 ++-
 net/sunrpc/xprtrdma/verbs.c       | 93 ++++++++++++++++++++-----------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  5 +-
 4 files changed, 71 insertions(+), 38 deletions(-)

--
Chuck Lever

