Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2638028020
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfEWOqM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59886 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730792AbfEWOqM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 034CD64A72;
        Thu, 23 May 2019 14:46:12 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B329B7BE75;
        Thu, 23 May 2019 14:46:11 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id C4DB7109C3CB; Thu, 23 May 2019 10:45:48 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 0/5] NLM fl_pid fixup
Date:   Thu, 23 May 2019 10:45:43 -0400
Message-Id: <cover.1558622651.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 23 May 2019 14:46:12 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This series aims to correct the fl_pid value for locks held by the NLM
server, or lockd.  It applies onto the revert of the previous attempt to fix
this problem sent ealier this week: '[PATCH] Revert "lockd: Show pid of
lockd for remote locks"'.

The problem with the earlier attempt was that we discarded the svid, and so
we couldn't distinguish remote lockowners on each host.  It is necessary to
turn the svid and host into a distinct owner.

We can take a page from the NLM client and make an allocation to track the
svid and host together, which is what we do here.  The mechanisms to do so
aren't quite similar enough to generalize, but I did share the nlm_lockowner
structure.  There is one field unsed on the server: nlm_lockowner.owner.

It turns out that the LTP's testcases/network/nfsv4/locks/locktests.c was
useful for testing this, as it coordinates locking tests amongst NFS
clients.

Changes on:
	v2 - Fixed typos in commit log messages, and whitespace.

Benjamin Coddington (5):
  lockd: prepare nlm_lockowner for use by the server
  lockd: Convert NLM service fl_owner to nlm_lockowner
  lockd: Remove lm_compare_owner and lm_owner_key
  lockd: Show pid of lockd for remote locks
  locks: Cleanup lm_compare_owner and lm_owner_key

 Documentation/filesystems/Locking |  14 ----
 fs/lockd/clntproc.c               |  21 +++---
 fs/lockd/svc4proc.c               |  14 +++-
 fs/lockd/svclock.c                | 118 +++++++++++++++++++++++++-----
 fs/lockd/svcproc.c                |  14 +++-
 fs/lockd/svcsubs.c                |   2 +-
 fs/lockd/xdr.c                    |   3 -
 fs/lockd/xdr4.c                   |   3 -
 fs/locks.c                        |   5 --
 include/linux/fs.h                |   2 -
 include/linux/lockd/lockd.h       |   2 +
 11 files changed, 138 insertions(+), 60 deletions(-)

-- 
2.20.1

