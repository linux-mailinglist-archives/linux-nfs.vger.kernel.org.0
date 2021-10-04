Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BBD421126
	for <lists+linux-nfs@lfdr.de>; Mon,  4 Oct 2021 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhJDORw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 4 Oct 2021 10:17:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233350AbhJDORv (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 4 Oct 2021 10:17:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7F0661216;
        Mon,  4 Oct 2021 14:16:02 +0000 (UTC)
Subject: [PATCH 0/5] Resend: tracepoint patches for NFSD
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 04 Oct 2021 10:16:02 -0400
Message-ID: <163335690747.3921.13072315880207206379.stgit@klimt.1015granger.net>
User-Agent: StGit/1.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Bruce-

I posted these on 9/22 and have heard no objections. Can you include
them in your v5.16 for-next branch?

---

Chuck Lever (5):
      svcrdma: Split the svcrdma_wc_receive() tracepoint
      svcrdma: Split the svcrdma_wc_send() tracepoint
      svcrdma: Split svcrmda_wc_{read,write} tracepoints
      SUNRPC: Add trace event when alloc_pages_bulk() makes no progress
      SUNRPC: Capture value of xdr_buf::page_base


 include/trace/events/rpcrdma.h          | 185 +++++++++++++++++++++++-
 include/trace/events/sunrpc.h           |  38 ++++-
 net/sunrpc/svc_xprt.c                   |   1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   9 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |  30 +++-
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |  14 +-
 6 files changed, 258 insertions(+), 19 deletions(-)

--
Chuck Lever

