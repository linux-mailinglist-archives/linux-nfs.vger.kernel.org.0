Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35EB619B612
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2020 20:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgDAS7B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Apr 2020 14:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgDAS7B (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 1 Apr 2020 14:59:01 -0400
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50F55206F5
        for <linux-nfs@vger.kernel.org>; Wed,  1 Apr 2020 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585767540;
        bh=vsFiJHfdBRdrIc7kGRq8VKrAZ9mDWIS0U45Xq6ODPwY=;
        h=From:To:Subject:Date:From;
        b=QtgWm6Vbw0OYoZpQYHyj/zmZFugN/EuXi8damizaZNsgskZytkoiZyUX3prpWhdu1
         osQpO856kLJn9yZkgoxoTklCcWfEMC6zU6pVrTqTyq52zQKAHC6ezJH8m7qfp2iJcT
         AB8qjWJnjgIXxfPooN2ktYaYqBeeohe4GPD43kkY=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/10] NFS: Fix a number of memory leaks and use-after-free
Date:   Wed,  1 Apr 2020 14:56:42 -0400
Message-Id: <20200401185652.1904777-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

When running xfstests with wsize=1024, a number of use-after-free issues
and memory leaks can currently be hit. One of the more obvious
leaks is seen when the generic/013 test fails due to the presence of
sillyrenamed files that never go away.

After testing with kasan enabled, and adding some debugging code to
detect leaked nfs_page and nfs_direct_req structures, I found a number
of issues that appear to be fixed by the following patchset.

Trond Myklebust (10):
  NFS: Fix a page leak in nfs_destroy_unlinked_subrequests()
  NFS: Fix races nfs_page_group_destroy() vs
    nfs_destroy_unlinked_subrequests()
  NFS: Fix use-after-free issues in nfs_pageio_add_request()
  NFS: Fix a request reference leak in nfs_direct_write_clear_reqs()
  NFS: Fix memory leaks in nfs_pageio_stop_mirroring()
  NFS: Remove the redundant function nfs_pgio_has_mirroring()
  NFS: Clean up nfs_lock_and_join_requests()
  NFS: Reverse the submission order of requests in
    __nfs_pageio_add_request()
  NFS: Refactor nfs_lock_and_join_requests()
  NFS: Try to join page groups before an O_DIRECT retransmission

 fs/nfs/direct.c          |  21 +++
 fs/nfs/internal.h        |   6 -
 fs/nfs/pagelist.c        | 350 +++++++++++++++++++++++++--------------
 fs/nfs/write.c           | 258 ++++++++++++++---------------
 include/linux/nfs_page.h |   5 +
 5 files changed, 379 insertions(+), 261 deletions(-)

-- 
2.25.1

