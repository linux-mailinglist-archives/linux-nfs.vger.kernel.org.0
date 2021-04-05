Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0507235453F
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 18:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242379AbhDEQez (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 12:34:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:40690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239097AbhDEQez (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Apr 2021 12:34:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0559061398;
        Mon,  5 Apr 2021 16:34:47 +0000 (UTC)
Subject: [PATCH v1 0/6] More xprtrdma fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 05 Apr 2021 12:34:47 -0400
Message-ID: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I found a number of crashers and other problems in the logic that
manages MR-related completions during disconnection events.

---

Chuck Lever (6):
      xprtrdma: rpcrdma_mr_pop() already does list_del_init()
      xprtrdma: Rename frwr_release_mr()
      xprtrdma: Clarify use of barrier in frwr_wc_localinv_done()
      xprtrdma: Do not recycle MR after FastReg/LocalInv flushes
      xprtrdma: Do not wake RPC consumer on a failed LocalInv
      xprtrdma: Avoid Send Queue wrapping


 include/trace/events/rpcrdma.h  |   1 -
 net/sunrpc/xprtrdma/frwr_ops.c  | 111 ++++++++++++++------------------
 net/sunrpc/xprtrdma/rpc_rdma.c  |  32 ++++++++-
 net/sunrpc/xprtrdma/verbs.c     |  20 +-----
 net/sunrpc/xprtrdma/xprt_rdma.h |   3 +-
 5 files changed, 82 insertions(+), 85 deletions(-)

--
Chuck Lever

