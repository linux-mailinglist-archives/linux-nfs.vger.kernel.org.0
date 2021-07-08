Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014113C15EA
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jul 2021 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhGHP3A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 8 Jul 2021 11:29:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231804AbhGHP27 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 8 Jul 2021 11:28:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A0036142B;
        Thu,  8 Jul 2021 15:26:17 +0000 (UTC)
Subject: [PATCH v3 0/3] Bulk-release pages during NFSD read splice
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-mm@kvack.org
Cc:     neilb@suse.de
Date:   Thu, 08 Jul 2021 11:26:16 -0400
Message-ID: <162575623717.2532.8517369487503961860.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm using "v3" simply because the v2 series of NFSD page allocator
work included the same bulk-release concept in a different form.
v2 has now been merged (thanks, Mel!). However, the bulk-release
part of that series was postponed.

Consider v3 to be an RFC refresh.

As with the page allocation side, I'm trying to reduce the average
number of times NFSD invokes the page allocation and release APIs
because they can be expensive, and because it is a resource that is
shared amongst all nfsd threads and thus access to it is partially
serialized. This small series tackles a code path that is frequently
invoked when NFSD handles READ operations on local filesystems that
support splice (i.e., most of the popular ones).

The previous version of this proposal placed the unused pages on
a local list and then re-used the pages directly in svc_alloc_arg()
before invoking alloc_pages_bulk_array() to fill in any remaining
missing rq_pages entries.

This meant there would be the possibility of some workloads that
caused accrual of pages without bounds, so the finished version of
that logic would have to be complex and possibly involve a shrinker.

In this version, I'm simply handing the pages back to the page
allocator, so all that complexity vanishes. What makes it more
efficient is that instead of calling put_page() for each page,
the code collects the unused pages in a per-nfsd thread array, and
returns them to the allocator using a bulk free API (release_pages)
when the array is full.

In this version of the series, each nfsd thread never accrues more
than 16 pages. We can easily make that larger or smaller, but 16
already reduces the rate of put_pages() calls to a minute fraction
of what it was, and does not consume much additional space in struct
svc_rqst.

Comments welcome!

---

Chuck Lever (3):
      NFSD: Clean up splice actor
      SUNRPC: Add svc_rqst_replace_page() API
      NFSD: Batch release pages during splice read


 fs/nfsd/vfs.c              | 20 +++++---------------
 include/linux/sunrpc/svc.h |  5 +++++
 net/sunrpc/svc.c           | 29 +++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 15 deletions(-)

--
Chuck Lever

