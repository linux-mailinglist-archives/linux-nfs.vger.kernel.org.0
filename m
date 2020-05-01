Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05CE1C1A41
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 18:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgEAQBy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 12:01:54 -0400
Received: from fieldses.org ([173.255.197.46]:40318 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728495AbgEAQBy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 May 2020 12:01:54 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D38A43158; Fri,  1 May 2020 12:01:53 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 0/4] allow multiple kthreadd's
Date:   Fri,  1 May 2020 12:01:48 -0400
Message-Id: <1588348912-24781-1-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

These patches allow a caller to create its own kthreadd.

The motivation is file delegations: currently any write operation from a
client breaks all delegations, even delegations held by the same client.

To fix that, we need to know which client is performing a given
operation.

So, we let nfsd put all the nfsd threads into the same thread group (by
spawning them from its own private kthreadd), then patch the delegation
code to treat delegation breaks from the same thread group as not
conflicting, and then leave it to nfsd to sort out conflicts among its
own clients.  Those patches are in:

	git://linux-nfs.org/~bfields/linux.git deleg-fix-self-conflicts

This was an idea from Trond.  Part of his motivation was that it could
work for userspace servers (like Ganesha and Samba) as well.  (We don't
currently let them request delegations, but probably will some day--it
shouldn't be difficult.)

Previously I considered instead adding a new field somewhere in the
struct task.  That might require a new system call to expose to user
space.  Or we might be able to put this in a keyring, if David Howells
thought that would work.

Before that I tried passing the identity of the breaker explicitly, but
that looks like it would require passing the new argument around to huge
swaths of the VFS.

Anyway, does this multiple kthreadd approach look reasonable?

(If so, who should handle the patches?)

--b.

J. Bruce Fields (4):
  kthreads: minor kthreadd refactoring
  kthreads: Simplify tsk_fork_get_node
  kthreads: allow multiple kthreadd's
  kthreads: allow cloning threads with different flags

 include/linux/kthread.h |  21 +++++-
 init/init_task.c        |   3 +
 init/main.c             |   4 +-
 kernel/fork.c           |   4 ++
 kernel/kthread.c        | 140 +++++++++++++++++++++++++++++-----------
 5 files changed, 132 insertions(+), 40 deletions(-)

-- 
2.26.2

