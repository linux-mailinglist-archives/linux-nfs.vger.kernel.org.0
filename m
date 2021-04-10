Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47C35AFF0
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbhDJS5U (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234969AbhDJS5S (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:57:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0ECC6113A;
        Sat, 10 Apr 2021 18:57:03 +0000 (UTC)
Subject: [PATCH v1 0/5] Continue making FRWR the only memreg scheme
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:57:02 -0400
Message-ID: <161808077437.21544.8496120800134971916.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

This series continues the work of making FRWR the only supported
memory registration mode. These are clean-up patches that remove
struct rpcrdma_frwr, hoisting all of its fields into struct
rpcrdma_mr. No behavior change is expected.

---

Chuck Lever (5):
      xprtrdma: Move fr_cid to struct rpcrdma_mr
      xprtrdma: Move cqe to struct rpcrdma_mr
      xprtrdma: Move fr_linv_done field to struct rpcrdma_mr
      xprtrdma: Move the Work Request union to struct rpcrdma_mr
      xprtrdma: Move fr_mr field to struct rpcrdma_mr


 include/trace/events/rpcrdma.h  | 12 +++---
 net/sunrpc/xprtrdma/frwr_ops.c  | 76 +++++++++++++--------------------
 net/sunrpc/xprtrdma/xprt_rdma.h | 19 ++++-----
 3 files changed, 44 insertions(+), 63 deletions(-)

--
Chuck Lever

