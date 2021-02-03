Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C20C30DF90
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Feb 2021 17:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBCQVI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Feb 2021 11:21:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:39458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230106AbhBCQVC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 3 Feb 2021 11:21:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1C5B64F74;
        Wed,  3 Feb 2021 16:20:21 +0000 (UTC)
Subject: [PATCH v2 0/6] Series short description
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 11:20:20 -0500
Message-ID: <161236921379.1030469.17739946617932155431.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following series implements...

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

