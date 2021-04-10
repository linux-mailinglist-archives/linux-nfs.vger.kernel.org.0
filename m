Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7404A35AFAF
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhDJSwE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:52:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDJSwE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:52:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 225AE61104;
        Sat, 10 Apr 2021 18:51:49 +0000 (UTC)
Subject: [PATCH v1 0/4] minor xprtrdma tracepoint fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:51:47 -0400
Message-ID: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

---

Chuck Lever (4):
      xprtrdma: Add tracepoints showing FastReg WRs and remote invalidation
      xprtrdma: Add an rpcrdma_mr_completion_class
      xprtrdma: Don't display r_xprt memory addresses in tracepoints
      xprtrdma: Remove the RPC/RDMA QP event handler


 include/trace/events/rpcrdma.h | 131 ++++++++++++++++-----------------
 net/sunrpc/xprtrdma/verbs.c    |  18 -----
 2 files changed, 63 insertions(+), 86 deletions(-)

--
Chuck Lever

