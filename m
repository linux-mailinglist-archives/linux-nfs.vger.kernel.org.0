Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE43D5C09
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Jul 2021 16:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbhGZOGY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Jul 2021 10:06:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhGZOGY (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Jul 2021 10:06:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C20460EB2;
        Mon, 26 Jul 2021 14:46:53 +0000 (UTC)
Subject: [PATCH v1 0/3] Optimize NFSD Send completion processing
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Jul 2021 10:46:52 -0400
Message-ID: <162731055652.13580.8774661104190191089.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following series improves the efficiency of NFSD's Send
completion processing by removing costly operations from the svcrdma
Send completion handlers. Each of these patches reduces the CPU
utilized per RPC by Send completion by an average of 2-3%.

The goal is to improve the rate of RPCs that can be retired for a
single-transport workload, thus increasing the server's scalability.

These patches are also available for testing:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=for-next

---

Chuck Lever (3):
      svcrdma: Fewer calls to wake_up() in Send completion handler
      svcrdma: Relieve contention on sc_send_lock.
      svcrdma: Convert rdma->sc_rw_ctxts to llist


 include/linux/sunrpc/svc_rdma.h          |  7 +--
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 56 ++++++++++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c    | 41 +++++++++--------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  4 +-
 4 files changed, 66 insertions(+), 42 deletions(-)

--
Chuck Lever

