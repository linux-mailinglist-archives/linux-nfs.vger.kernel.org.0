Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 646451F624
	for <lists+linux-nfs@lfdr.de>; Wed, 15 May 2019 16:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfEOOBN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 May 2019 10:01:13 -0400
Received: from fieldses.org ([173.255.197.46]:60740 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbfEOOBN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 15 May 2019 10:01:13 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 453B71CEA; Wed, 15 May 2019 10:01:12 -0400 (EDT)
Date:   Wed, 15 May 2019 10:01:12 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     steved@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Add a chroot option to nfs.conf
Message-ID: <20190515140112.GA9291@fieldses.org>
References: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514204153.79603-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 14, 2019 at 04:41:48PM -0400, Trond Myklebust wrote:
> The following patchset aims to allow the configuration of a 'chroot
> jail' to rpc.nfsd, and allowing us to export a filesystem /foo (and
> possibly subtrees) as '/'.

This is great, thanks!  Years ago I did an incomplete version that
worked by just string manipulations on paths.  Running part of mountd in
a chrooted thread is a neat way to do it.

If I understand right, the only part that's being run in a chroot is the
writes to /proc/net/sunrpc/*/channel files.  So that means that the path
included in writes to /proc/net/sunrpc/nfsd_fh/channel will be resolved
with respect to the chroot by the kernel code handling the write.

That's not the only place in mountd that uses export paths, though.
What about:

	- next_mnt(), which compares paths from the export file to paths
	  in /etc/mtab.
	- is_mountpoint, which stats export paths.
	- match_fsid, which stats export paths.

Etc.  Doesn't that stuff also need to be done with respect to the
chroot?  Am I missing something?

--b.

> 
> Trond Myklebust (5):
>   mountd: Ensure we don't share cache file descriptors among processes.
>   Add a simple workqueue mechanism
>   Add a helper to write to a file through the chrooted thread
>   Add support for chrooted exports
>   Add support for chroot in exportfs
> 
>  aclocal/libpthread.m4      |  13 +-
>  configure.ac               |   6 +-
>  nfs.conf                   |   1 +
>  support/include/misc.h     |  11 ++
>  support/misc/Makefile.am   |   2 +-
>  support/misc/workqueue.c   | 267 +++++++++++++++++++++++++++++++++++++
>  systemd/nfs.conf.man       |   3 +-
>  utils/exportfs/Makefile.am |   2 +-
>  utils/exportfs/exportfs.c  |  31 ++++-
>  utils/mountd/Makefile.am   |   3 +-
>  utils/mountd/cache.c       |  39 +++++-
>  utils/mountd/mountd.c      |   5 +-
>  utils/nfsd/nfsd.man        |   4 +
>  13 files changed, 369 insertions(+), 18 deletions(-)
>  create mode 100644 support/misc/workqueue.c
> 
> -- 
> 2.21.0
