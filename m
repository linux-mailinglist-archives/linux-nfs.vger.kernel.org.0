Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54083422ACE
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Oct 2021 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbhJEOTp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Oct 2021 10:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235294AbhJEOTp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 5 Oct 2021 10:19:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56B4C60F4B;
        Tue,  5 Oct 2021 14:17:54 +0000 (UTC)
Subject: [PATCH v3 0/2] Fix write pad
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com, trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 05 Oct 2021 10:17:53 -0400
Message-ID: <163344340514.1933.10783386394620857061.stgit@morisot.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Anna-

Can you include this series in your next pull request to Trond?

Trond, 

This series addresses your concern about xprtrdma using the 
rq_rcv_buf.tail vector in some cases to receive an XDR pad. It has
been tested with a legacy Solaris server, in addition to the usual
tests I run.

We haven't yet confirmed whether this addresses the GPU-Direct
issue, but since that is an out-of-tree user that depends on 
unsupported kernel facilities, I regard that confirmation as only
"nice to have", not mandatory. We are confident this change will
address that situation, based on our understanding of the issue.

Changes since v2:
- Address more review comments from Tom Talpey

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

