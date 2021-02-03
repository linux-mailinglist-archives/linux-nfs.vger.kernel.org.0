Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED0B30DF9C
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhBCQYb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:40080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhBCQYa (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 11:24:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1048964F7C;
        Wed,  3 Feb 2021 16:23:48 +0000 (UTC)
Subject: [PATCH v2 0/6] RPC/RDMA client fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:23:48 -0500
Message-ID: <161236925476.1030487.10407536259816633879.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Fresh version of the single patch I posted yesterday, now expanded
with additional fixes.


Changes since v1:
- Respond to review comments
- Split "Remove FMR support" into three patches for clarity
- Fix implicit chunk roundup
- Improve Receive completion tracepoints

---

Chuck Lever (6):
      xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
      xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
      xprtrdma: Refactor invocations of offset_in_page()
      rpcrdma: Fix comments about reverse-direction operation
      xprtrdma: Pad optimization, revisited
      rpcrdma: Capture bytes received in Receive completion tracepoints


 include/trace/events/rpcrdma.h             | 50 +++++++++++++++++++++-
 net/sunrpc/xprtrdma/backchannel.c          |  4 +-
 net/sunrpc/xprtrdma/frwr_ops.c             | 12 ++----
 net/sunrpc/xprtrdma/rpc_rdma.c             | 17 +++-----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
 net/sunrpc/xprtrdma/xprt_rdma.h            | 15 ++++---
 6 files changed, 68 insertions(+), 34 deletions(-)

--
Chuck Lever

