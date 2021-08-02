Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB51D3DDF7A
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Aug 2021 20:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhHBSoW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Aug 2021 14:44:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhHBSoW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Aug 2021 14:44:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7584D60EC0;
        Mon,  2 Aug 2021 18:44:12 +0000 (UTC)
Subject: [PATCH v1 0/5] NFS/RDMA client fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 02 Aug 2021 14:44:11 -0400
Message-ID: <162792979429.3902.11831790821518477892.stgit@manet.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

Not sure I've posted these yet. I've been working on some error
injection features and while testing them, I found a few bugs in
the NFS/RDMA client.

---

Chuck Lever (5):
      xprtrdma: Disconnect after an ib_post_send() immediate error
      xprtrdma: Put rpcrdma_reps before waking the tear-down completion
      xprtrdma: Add xprtrdma_post_recvs_err() tracepoint
      xprtrdma: Add an xprtrdma_post_send_err tracepoint
      xprtrdma: Eliminate rpcrdma_post_sends()


 include/trace/events/rpcrdma.h    | 74 ++++++++++++++++++++++++++++---
 net/sunrpc/xprtrdma/backchannel.c |  2 +-
 net/sunrpc/xprtrdma/frwr_ops.c    | 14 +++++-
 net/sunrpc/xprtrdma/transport.c   |  2 +-
 net/sunrpc/xprtrdma/verbs.c       | 28 +++---------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  2 +-
 6 files changed, 90 insertions(+), 32 deletions(-)

--
Chuck Lever

