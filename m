Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93904413BE2
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Sep 2021 23:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbhIUVCh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Sep 2021 17:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231592AbhIUVC2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 21 Sep 2021 17:02:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6ABA961159;
        Tue, 21 Sep 2021 21:00:46 +0000 (UTC)
Subject: [PATCH v3 0/2] Provide a buffer for Write chunk padding
From:   Chuck Lever <chuck.lever@oracle.com>
To:     kolga@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 21 Sep 2021 17:00:45 -0400
Message-ID: <163225796153.9206.3736108080135006227.stgit@morisot.1015granger.net>
User-Agent: StGit/1.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This patch series can be pulled from:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=client-miscellany

Changes since v2:
- Change has been tested with a legacy Solaris NFS/RDMA server
- Address Tom Talpey's review comments
- re_implicit_roundup has been removed via a separate patch

---

Chuck Lever (2):
      xprtrdma: Provide a buffer to pad Write chunks of unaligned length
      xprtrdma: Remove rpcrdma_ep::re_implicit_roundup


 include/trace/events/rpcrdma.h  | 13 +++++++++---
 net/sunrpc/xprtrdma/frwr_ops.c  | 35 +++++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/rpc_rdma.c  | 23 +++++++++++++---------
 net/sunrpc/xprtrdma/verbs.c     |  3 +--
 net/sunrpc/xprtrdma/xprt_rdma.h |  6 +++++-
 5 files changed, 65 insertions(+), 15 deletions(-)

--
Chuck Lever

