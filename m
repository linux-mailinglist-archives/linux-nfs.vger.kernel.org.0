Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117FAC0EC5
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Sep 2019 01:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbfI0Xz4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Sep 2019 19:55:56 -0400
Received: from fieldses.org ([173.255.197.46]:35976 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbfI0Xzz (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 27 Sep 2019 19:55:55 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 61F0B1BE7; Fri, 27 Sep 2019 19:55:54 -0400 (EDT)
Date:   Fri, 27 Sep 2019 19:55:54 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] nfsd changes for 5.4
Message-ID: <20190927235554.GA11051@fieldses.org>
References: <20190927200838.GA2618@fieldses.org>
 <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_bMxjz_T9Oa62Uyp8tKnKomtHKV9HTnuvMxrdwuTPOg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 27, 2019 at 03:44:02PM -0700, Linus Torvalds wrote:
> But then the actual code is just one single small commit:
> 
> > Dave Wysochanski (1):
> >       SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist

And that's also all that was in the diffstat in my pull message, but I
somehow didn't notice.  I must be tired....

> which doesn't actually match any of the things your description says
> should be there.
> 
> So I undid my pull - either the description is completely wrong, or
> you tagged the wrong commit.

Yes, the latter.  I've redone the tag; the pull request should have
been for:

  git://linux-nfs.org/~bfields/linux.git tags/nfsd-5.4

----------------------------------------------------------------
Highlights:

	- add a new knfsd file cache, so that we don't have to open and
	  close on each (NFSv2/v3) READ or WRITE.  This can speed up
	  read and write in some cases.  It also replaces our readahead
	  cache.
	- Prevent silent data loss on write errors, by treating write
	  errors like server reboots for the purposes of write caching,
	  thus forcing clients to resend their writes.
	- Tweak the code that allocates sessions to be more forgiving,
	  so that NFSv4.1 mounts are less likely to hang when a server
	  already has a lot of clients.
	- Eliminate an arbitrary limit on NFSv4 ACL sizes; they should
	  now be limited only by the backend filesystem and the
	  maximum RPC size.
	- Allow the server to enforce use of the correct kerberos
	  credentials when a client reclaims state after a reboot.

And some miscellaneous smaller bugfixes and cleanup.

----------------------------------------------------------------
Chuck Lever (2):
      svcrdma: Remove svc_rdma_wq
      svcrdma: Use llist for managing cache of recv_ctxts

Colin Ian King (1):
      sunrpc: clean up indentation issue

Dave Wysochanski (1):
      SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist

J. Bruce Fields (4):
      Merge nfsd bugfixes
      nfsd: Remove unnecessary NULL checks
      Deprecate nfsd fault injection
      nfsd: eliminate an unnecessary acl size limit

Jeff Layton (12):
      sunrpc: add a new cache_detail operation for when a cache is flushed
      locks: create a new notifier chain for lease attempts
      nfsd: add a new struct file caching facility to nfsd
      nfsd: hook up nfsd_write to the new nfsd_file cache
      nfsd: hook up nfsd_read to the nfsd_file cache
      nfsd: hook nfsd_commit up to the nfsd_file cache
      nfsd: convert nfs4_file->fi_fds array to use nfsd_files
      nfsd: convert fi_deleg_file and ls_file fields to nfsd_file
      nfsd: hook up nfs4_preprocess_stateid_op to the nfsd_file cache
      nfsd: have nfsd_test_lock use the nfsd_file cache
      nfsd: rip out the raparms cache
      nfsd: close cached files prior to a REMOVE or RENAME that would replace target

NeilBrown (2):
      nfsd: handle drc over-allocation gracefully.
      nfsd: degraded slot-count more gracefully as allocation nears exhaustion.

Scott Mayhew (2):
      nfsd: add a "GetVersion" upcall for nfsdcld
      nfsd: add support for upcall version 2

Trond Myklebust (9):
      notify: export symbols for use by the knfsd file cache
      vfs: Export flush_delayed_fput for use by knfsd.
      nfsd: Fix up some unused variable warnings
      nfsd: Fix the documentation for svcxdr_tmpalloc()
      nfsd: nfsd_file cache entries should be per net namespace
      nfsd: Support the server resetting the boot verifier
      nfsd: Don't garbage collect files that might contain write errors
      nfsd: Reset the boot verifier on all write I/O errors
      nfsd: fix nfs read eof detection

YueHaibing (2):
      nfsd: remove duplicated include from filecache.c
      nfsd: Make nfsd_reset_boot_verifier_locked static

 fs/file_table.c                          |   1 +
 fs/locks.c                               |  62 ++
 fs/nfsd/Kconfig                          |   3 +-
 fs/nfsd/Makefile                         |   3 +-
 fs/nfsd/acl.h                            |   8 -
 fs/nfsd/blocklayout.c                    |   3 +-
 fs/nfsd/export.c                         |  13 +
 fs/nfsd/filecache.c                      | 934 +++++++++++++++++++++++++++++++
 fs/nfsd/filecache.h                      |  61 ++
 fs/nfsd/netns.h                          |   4 +
 fs/nfsd/nfs3proc.c                       |   9 +-
 fs/nfsd/nfs3xdr.c                        |  13 +-
 fs/nfsd/nfs4callback.c                   |  35 +-
 fs/nfsd/nfs4layouts.c                    |  12 +-
 fs/nfsd/nfs4proc.c                       |  97 ++--
 fs/nfsd/nfs4recover.c                    | 388 ++++++++++---
 fs/nfsd/nfs4state.c                      | 239 ++++----
 fs/nfsd/nfs4xdr.c                        |  56 +-
 fs/nfsd/nfsctl.c                         |   1 +
 fs/nfsd/nfsproc.c                        |   4 +-
 fs/nfsd/nfssvc.c                         |  48 +-
 fs/nfsd/state.h                          |  13 +-
 fs/nfsd/trace.h                          | 140 +++++
 fs/nfsd/vfs.c                            | 351 +++++-------
 fs/nfsd/vfs.h                            |  37 +-
 fs/nfsd/xdr3.h                           |   2 +-
 fs/nfsd/xdr4.h                           |  19 +-
 fs/notify/fsnotify.h                     |   2 -
 fs/notify/group.c                        |   2 +
 fs/notify/mark.c                         |   6 +
 include/linux/fs.h                       |   5 +
 include/linux/fsnotify_backend.h         |   2 +
 include/linux/sunrpc/cache.h             |   7 +-
 include/linux/sunrpc/svc_rdma.h          |   6 +-
 include/uapi/linux/nfsd/cld.h            |  41 +-
 net/sunrpc/cache.c                       |  15 +-
 net/sunrpc/svc.c                         |   4 +-
 net/sunrpc/xprtrdma/svc_rdma.c           |   7 -
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  24 +-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   6 +-
 40 files changed, 2083 insertions(+), 600 deletions(-)
 create mode 100644 fs/nfsd/filecache.c
 create mode 100644 fs/nfsd/filecache.h
