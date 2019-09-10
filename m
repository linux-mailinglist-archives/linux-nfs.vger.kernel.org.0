Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045AAAEB2E
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Sep 2019 15:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbfIJNLT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Sep 2019 09:11:19 -0400
Received: from fieldses.org ([173.255.197.46]:32792 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfIJNLS (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 10 Sep 2019 09:11:18 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 903522014; Tue, 10 Sep 2019 09:11:18 -0400 (EDT)
Date:   Tue, 10 Sep 2019 09:11:18 -0400
To:     Trond Myklebust <trondmy@gmail.com>
Cc:     "J.Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 0/4] Handling NFSv3 I/O errors in knfsd
Message-ID: <20190910131118.GA26695@fieldses.org>
References: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902170258.92522-1-trond.myklebust@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Looks OK to me; applying for 5.4.

Any ideas for easy ways to test this?  Maybe I should look at
Documentation/fault-injection/fault-injection.txt.

--b.

On Mon, Sep 02, 2019 at 01:02:54PM -0400, Trond Myklebust wrote:
> Recently, a number of changes went into the kernel to try to ensure
> that I/O errors (specifically write errors) are reported to the
> application once and only once. The vehicle for ensuring the errors
> are reported is the struct file, which uses the 'f_wb_err' field to
> track which errors have been reported.
> 
> The problem is that errors are mainly intended to be reported through
> fsync(). If the client is doing synchronous writes, then all is well,
> but if it is doing unstable writes, then the errors may not be
> reported until the client calls COMMIT. If the file cache has
> thrown out the struct file, due to memory pressure, or just because
> the client took a long while between the last WRITE and the COMMIT,
> then the error report may be lost, and the client may just think
> its data is safely stored.
> 
> Note that the problem is compounded by the fact that NFSv3 is stateless,
> so the server never knows that the client may have rebooted, so there
> can be no guarantee that a COMMIT will ever be sent.
> 
> The following patch set attempts to remedy the situation using 2
> strategies:
> 
> 1) If the inode is dirty, then avoid garbage collecting the file
>    from the file cache.
> 2) If the file is closed, and we see that it would have reported
>    an error to COMMIT, then we bump the boot verifier in order to
>    ensure the client retransmits all its writes.
> 
> Note that if multiple clients were writing to the same file, then
> we probably want to bump the boot verifier anyway, since only one
> COMMIT will see the error report (because the cached file is also
> shared).
> 
> So in order to implement the above strategy, we first have to do
> the following: split up the file cache to act per net namespace,
> since the boot verifier is per net namespace. Then add a helper
> to update the boot verifier.
> 
> ---
> v2:
> - Add patch to bump the boot verifier on all write/commit errors
> - Fix initialisation of 'seq' in nfsd_copy_boot_verifier()
> 
> Trond Myklebust (4):
>   nfsd: nfsd_file cache entries should be per net namespace
>   nfsd: Support the server resetting the boot verifier
>   nfsd: Don't garbage collect files that might contain write errors
>   nfsd: Reset the boot verifier on all write I/O errors
> 
>  fs/nfsd/export.c    |  2 +-
>  fs/nfsd/filecache.c | 76 +++++++++++++++++++++++++++++++++++++--------
>  fs/nfsd/filecache.h |  3 +-
>  fs/nfsd/netns.h     |  4 +++
>  fs/nfsd/nfs3xdr.c   | 13 +++++---
>  fs/nfsd/nfs4proc.c  | 14 +++------
>  fs/nfsd/nfsctl.c    |  1 +
>  fs/nfsd/nfssvc.c    | 32 ++++++++++++++++++-
>  fs/nfsd/vfs.c       | 19 +++++++++---
>  9 files changed, 130 insertions(+), 34 deletions(-)
> 
> -- 
> 2.21.0
