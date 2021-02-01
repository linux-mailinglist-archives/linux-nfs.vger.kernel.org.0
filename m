Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EDA30A9CC
	for <lists+linux-nfs@lfdr.de>; Mon,  1 Feb 2021 15:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhBAOcH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 1 Feb 2021 09:32:07 -0500
Received: from mail-ej1-f47.google.com ([209.85.218.47]:45605 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhBAObb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 1 Feb 2021 09:31:31 -0500
Received: by mail-ej1-f47.google.com with SMTP id b9so5076436ejy.12
        for <linux-nfs@vger.kernel.org>; Mon, 01 Feb 2021 06:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOd9lYd0yHEdXXTRBQjqh76Xv3yhpTN0HXyTgktT1ME=;
        b=JOFC3Y5KRj8s/q44lleqRanwLxq0us7CNqfniQe32AqKdVvD4Zsi9/dJPocbPMuhTX
         20pbJd/nUonf2dphLJ6qFdMASXmuwoWlv8Oo6lS0vXWA7snM7ZARi/vEWxXIL/3ntOcw
         6fx1fV3CiXaEwa7jN44n/Vk0RiudBWD16aIuWg2ZD23ZuSTzbnSQnXm9cnJJLJ+J8wIz
         6uxqnVUo6uxr4B0AAdOyGP6ttab2cIWndIpKHG5B3gC9I5z1WBPkhDrVX/dy5ichShYq
         3Wxr6AFOCRBn7NPN8a+6lYw2Lbj5Rj6QdGhI+JqZ9nW90WJrxjmkYvYm6h50B8U9pPLD
         bwaw==
X-Gm-Message-State: AOAM532cgLWW8RJjHweeYN+dK3PgZrWFuvST9C6yJjprosuXf2oWciM3
        E5Rp39ENab0wKyjj/Vb5PMKT7f3tXMGHj59wuyY=
X-Google-Smtp-Source: ABdhPJx4Yky8fYTOPsXAkfxiNvZ/sj5OW0s4DW5nwQanmHw6ubyjL5mGQAtxST7WKEAi/f5Xhv4l+pUTd+hXc4+e2g8=
X-Received: by 2002:a17:906:4451:: with SMTP id i17mr17134257ejp.436.1612189848292;
 Mon, 01 Feb 2021 06:30:48 -0800 (PST)
MIME-Version: 1.0
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com> <CALF+zOkaB8=uedDiSy6YheGjnObGSpUiYmuA13K-TqBgreO1eQ@mail.gmail.com>
In-Reply-To: <CALF+zOkaB8=uedDiSy6YheGjnObGSpUiYmuA13K-TqBgreO1eQ@mail.gmail.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Mon, 1 Feb 2021 09:30:32 -0500
Message-ID: <CAFX2JfmJULHWjsQM0BkeSGiDspsVJA7MQQOfQT2DVYT9LXHBKg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Convert NFS fscache read paths to netfs API
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi David,

On Sun, Jan 31, 2021 at 9:20 PM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Thu, Jan 28, 2021 at 9:59 AM Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > This minimal set of patches update the NFS client to use the new
> > readahead method, and convert the NFS fscache to use the new netfs
> > IO API, and are at:
> > https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-lib-nfs-20210128
> > https://github.com/DaveWysochanskiRH/kernel/commit/74357eb291c9c292f3ab3bc9ed1227cb76f52c51
> >
> > The patches are based on David Howells fscache-netfs-lib tree at
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib
> >
> > The first 6 patches refactor some of the NFS read code to facilitate
> > re-use, the next 4 patches do the conversion to the new API.  Note
> > patch 8 converts nfs_readpages to nfs_readahead.
> >
> > Changes since my last posting on Jan 27, 2021
> > - Fix oops with fscache enabled on parallel read unit test
> > - Add patches to handle invalidate and releasepage
> > - Use #define FSCACHE_USE_NEW_IO_API to select the new API
> > - Minor cleanup in nfs_readahead_from_fscache
> >
> > Still TODO
> > 1. Fix known bugs
> > a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
> >    with GFP_KERNEL which may sleep (dhowells noted this in a review)
> > b) nfs_refresh_inode() takes inode->i_lock but may call
> >    __fscache_invalidate() which may sleep (found with lockdep)
> > c) WARN with xfstest fscache/netapp/pnfs/nfs41
>
> Turns out this is a bit more involved and I would not consider pNFS +
> fscache stable right now.
> For now I may have to disable fscache if pNFS is enabled unless I can
> quickly come up
> with a reasonable fix for the problem.

So my thought right now is to take the first 6 cleanup / preparation
patches for the 5.12 merge window and save the cutover for 5.13. This
would give you an extra release cycle to fix the pNFS stability, and
it would give more time to find and fix any issues in netfs before
switching NFS over to it.

Would that work?
Anna

>
> The problem is as follows. Once netfs calls us in "issue_op" for a
> given subrequest, it expects
> one call back when the subrequest completes.  Now the "clamp_length"
> function was developed
> so we tell the netfs caller how big of an IO we can handle.  However,
> right now it only implements
> an 'rsize' check, and it does not take into account pNFS
> characteristics such as segments
> which may split up the IO into multiple RPCs. Since each of the RPC
> have their own
> completion, and so far I've not come up with a way to just call back
> into netfs when the
> last one is done, I am not sure what the right approach is.  One
> obvious approach would be
> a more sophisticated "clamp_length" function which adds similar logic
> as to the *pg_test()
> functions.  But I don't want to duplicate that and so it's not really clear.
>
> > 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> > * Compare with netfs stats and determine if still needed
> > 3. Cleanup dfprintks and/or convert to tracepoints
> > 4. Further tests (see "Not tested yet")
> >
> > Tests run
> > 1. Custom NFS+fscache unit tests for basic operation: PASS
> > * vers=3,4.0,4.1,4.2,sec=sys,server=localhost (same kernel)
> > 2. cthon04: PASS
> > * test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys
> > * No failures, oopses or hangs
> > 3. iozone tests: PASS
> > * nofsc,fsc,vers=3,4.0,4.1,4.2,sec=sys,server=rhel7,rhel8
> > * No failures, oopses, or hangs
> > 4. xfstests/generic: PASS*
> > * no hangs or crashes (one WARN); failures unrelated to these patches
> > * Ran following configurations
> >   * vers=4.1,fsc,sec=sys,rhel7-server: PASS
> >   * vers=4.0,fsc,sec=sys,rhel7-server: PASS
> >   * vers=3,fsc,sec=sys,rhel7-server: PASS
> >   * vers=4.1,nofsc,sec=sys,netapp-server(pnfs/files): PASS
> >   * vers=4.1,fsc,sec=sys,netapp-server(pnfs/files): INCOMPLETE
> >     * WARN_ON fs/netfs/read_helper.c:616
> >     * ran with kernel.panic_on_oops=1
> >   * vers=4.2,fsc,sec=sys,rhel7-server: running at generic/438
> >   * vers=4.2,fsc,sec=sys,rhel8-server: running at generic/127
> > 5. kernel build: PASS
> >   * vers=4.2,fsc,sec=sys,rhel8-server: PASS
> >
> > Not tested yet:
> > * error injections (for example, connection disruptions, server errors during IO, etc)
> > * many process mixed read/write on same file
> > * performance
> >
> > Dave Wysochanski (10):
> >   NFS: Clean up nfs_readpage() and nfs_readpages()
> >   NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
> >     succeeds
> >   NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
> >     nfs_readdesc
> >   NFS: Call readpage_async_filler() from nfs_readpage_async()
> >   NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
> >   NFS: Allow internal use of read structs and functions
> >   NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
> >   NFS: Convert readpages to readahead and use netfs_readahead for
> >     fscache
> >   NFS: Update releasepage to handle new fscache kiocb IO API
> >   NFS: update various invalidation code paths for new IO API
> >
> >  fs/nfs/file.c              |  22 +++--
> >  fs/nfs/fscache.c           | 230 +++++++++++++++++++------------------------
> >  fs/nfs/fscache.h           | 105 +++-----------------
> >  fs/nfs/internal.h          |   8 ++
> >  fs/nfs/pagelist.c          |   2 +
> >  fs/nfs/read.c              | 240 ++++++++++++++++++++-------------------------
> >  fs/nfs/write.c             |  10 +-
> >  include/linux/nfs_fs.h     |   5 +-
> >  include/linux/nfs_iostat.h |   2 +-
> >  include/linux/nfs_page.h   |   1 +
> >  include/linux/nfs_xdr.h    |   1 +
> >  11 files changed, 257 insertions(+), 369 deletions(-)
> >
> > --
> > 1.8.3.1
> >
>
