Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3144E2F65BC
	for <lists+linux-nfs@lfdr.de>; Thu, 14 Jan 2021 17:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbhANQXJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Jan 2021 11:23:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726241AbhANQXJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 14 Jan 2021 11:23:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01D8C23B44;
        Thu, 14 Jan 2021 16:22:28 +0000 (UTC)
Subject: [PATCH v1 0/5] Convert svcrdma stats to per-CPU counters
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Thu, 14 Jan 2021 11:22:28 -0500
Message-ID: <161064114388.6061.6808790429789225779.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These follow on Amir's patches that did the same for the generic
NFSD stats. See:

https://lore.kernel.org/linux-nfs/20210106075236.4184-2-amir73il@gmail.com/T/

---

Chuck Lever (5):
      svcrdma: Refactor svc_rdma_init() and svc_rdma_clean_up()
      svcrdma: Convert rdma_stat_recv to a per-CPU counter
      svcrdma: Convert rdma_stat_sq_starve to a per-CPU counter
      svcrdma: Restore read and write stats
      svcrdma: Deprecate stat variables that are no longer used


 include/linux/sunrpc/svc_rdma.h         |  14 +-
 net/sunrpc/xprtrdma/svc_rdma.c          | 164 ++++++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |   3 +-
 net/sunrpc/xprtrdma/svc_rdma_rw.c       |   3 +
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   |   2 +-
 5 files changed, 108 insertions(+), 78 deletions(-)

--
Chuck Lever

