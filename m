Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBBF1B9F1
	for <lists+linux-nfs@lfdr.de>; Mon, 13 May 2019 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfEMP1G (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 May 2019 11:27:06 -0400
Received: from fieldses.org ([173.255.197.46]:58464 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727437AbfEMP1G (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 13 May 2019 11:27:06 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 6C19C1D39; Mon, 13 May 2019 11:27:05 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/2] nfsd shoudn't call mnt_want_write twice
Date:   Mon, 13 May 2019 11:27:01 -0400
Message-Id: <1557761223-14483-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

A fuzzer recently triggered lockdep warnings about potential sb_writers
deadlocks caused by fh_want_write, showing that we haven't been careful
to pair each fh_want_write() with an fh_drop_write().

This isn't normally a problem since fh_put() will call fh_drop_write()
for us.  And that's OK for NFSv3.  But an NFSv4 protocol fuzzer can do
weird things like call unlink twice in a compound.

So we can either make it safe to call fh_want_write() twice, or we can
fix all the callers to call fh_drop_write().

For now I think we have to do the former just to get the bug fixed.

Long term I don't know whether it's best to stay with that or to fix up
the callers.  I fixed nfsd_unlink just because it's easy, but maybe
that's pointless, it's others (like setattr) that are the complicated
ones.

J. Bruce Fields (2):
  nfsd: allow fh_want_write to be called twice
  nfsd: fh_drop_write in nfsd_unlink

 fs/nfsd/vfs.c | 8 +++++---
 fs/nfsd/vfs.h | 5 ++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
2.21.0

