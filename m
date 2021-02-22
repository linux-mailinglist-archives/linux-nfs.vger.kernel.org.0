Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E7B321B58
	for <lists+linux-nfs@lfdr.de>; Mon, 22 Feb 2021 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231605AbhBVPZ0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 10:25:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231200AbhBVPXo (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 10:23:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0307364E57;
        Mon, 22 Feb 2021 15:23:01 +0000 (UTC)
Subject: [PATCH v2 0/4] Reduce page allocator traffic caused by NFSD
From:   Chuck Lever <chuck.lever@oracle.com>
To:     mgorman@techsingularity.net
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org, kuba@kernel.org
Date:   Mon, 22 Feb 2021 10:23:00 -0500
Message-ID: <161400722731.195066.9584156841718557193.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Mel-

I've been testing these four, which include a working version of
your bulk allocator patch. In "Refresh rq_pages" I've replaced
the cond_resched() call with schedule_timeout(), as you requested.

As always, review comments and test results are welcome.

---

Chuck Lever (3):
      SUNRPC: Set rq_page_end differently
      SUNRPC: Refresh rq_pages using a bulk page allocator
      SUNRPC: Cache pages that were replaced during a read splice

Mel Gorman (1):
      mm: alloc_pages_bulk()


 fs/nfsd/vfs.c                   |   4 +-
 include/linux/gfp.h             |  24 +++++++
 include/linux/sunrpc/svc.h      |   1 +
 include/linux/sunrpc/svc_xprt.h |  28 ++++++++
 mm/page_alloc.c                 | 110 +++++++++++++++++++++++++++++++-
 net/sunrpc/svc.c                |   7 ++
 net/sunrpc/svc_xprt.c           |  55 ++++++++++++----
 7 files changed, 214 insertions(+), 15 deletions(-)

--
Chuck Lever

