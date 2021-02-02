Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6F030BE18
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Feb 2021 13:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhBBMWI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 2 Feb 2021 07:22:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229636AbhBBMWD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 2 Feb 2021 07:22:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612268436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2eOW21ccsnBPuwpkEe+L8bA8LvCC6QrwZ4KS9sqsXdc=;
        b=KpJ8KTiyplzvfkVQTdWgWaPrIGTb7I6lxMXzELLiIZ41eFKnMWMJxujMnOmPY7+MFvHPj5
        gR9WMg8trblik5Yk3aLVOhKZsd51XpYBx4C9KjUuUCyXUPwLzU3XJBDcbPS5D9zuTWOEHE
        gwUixECVLq6nHee1BCSw6tTvCOjcpsw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-pHiJEN_oMjK19H-bh4u9ZA-1; Tue, 02 Feb 2021 07:20:33 -0500
X-MC-Unique: pHiJEN_oMjK19H-bh4u9ZA-1
Received: by mail-ed1-f70.google.com with SMTP id a24so9419723eda.14
        for <linux-nfs@vger.kernel.org>; Tue, 02 Feb 2021 04:20:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2eOW21ccsnBPuwpkEe+L8bA8LvCC6QrwZ4KS9sqsXdc=;
        b=Trje5kTObmJoP2iAB7Rmh3Y+SYwd4I1gdP4TgZJKUeF6VqhQrZyUJLlvocIsU931Jm
         CjZ+h1Ze8ZeqLDxRekf/Vz365nk9LyxklZHuXlVTGyRvuLaXBOAO1uduo356vIcHHlLy
         zEVQZZo0yKK0I3pDBNOU4tYuGjP2BKPxtf2ptfAW8+LTM4phmTAemoQZMtw3cryVjgk+
         yCreN+YX7TI30nZagVPnDguxSzWsWdQI1TCFfHmJu/Rpqj2jWgJ4gMrVWMhODfXRzIkJ
         oFE2ylJuPVXuKmnvo4+sTuwpb3lqSs5ioHuY28Hg31Wh9NFFR1XEO2woaNaEc/urCz2Y
         7fTQ==
X-Gm-Message-State: AOAM532kCBJ8Wx1/BpJfKEtdug54Qju/ImrK1YNueLPWTb0Dph1+5lsT
        axWnDAJdHLZLhDzAGYD60l4c8rxW2NrBRir/Vnc57ObPCfcoVrxAjpoPIECQYBKA5mUi8ODuCGB
        1sTDfuCbAsj7aavxLYgQT7MxrAIpQfFw/RxCm
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr24023973edb.367.1612268431894;
        Tue, 02 Feb 2021 04:20:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQ+aLcnD7oMKLGbiJJbqPf+MG7SMZRKGm7ahBkH+HCYZ8KY+3gbnYfor7MOWE3C+/magyLM3Rko6d8vWlvr2k=
X-Received: by 2002:a05:6402:c92:: with SMTP id cm18mr24023949edb.367.1612268431601;
 Tue, 02 Feb 2021 04:20:31 -0800 (PST)
MIME-Version: 1.0
References: <1611845708-6752-1-git-send-email-dwysocha@redhat.com>
 <CALF+zOkaB8=uedDiSy6YheGjnObGSpUiYmuA13K-TqBgreO1eQ@mail.gmail.com> <CAFX2JfmJULHWjsQM0BkeSGiDspsVJA7MQQOfQT2DVYT9LXHBKg@mail.gmail.com>
In-Reply-To: <CAFX2JfmJULHWjsQM0BkeSGiDspsVJA7MQQOfQT2DVYT9LXHBKg@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 2 Feb 2021 07:19:55 -0500
Message-ID: <CALF+zOknrDpJhAcXcZs2LZhFq0ow4XmMTptYyS3f1GWs0HpH4A@mail.gmail.com>
Subject: Re: [PATCH 00/10] Convert NFS fscache read paths to netfs API
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 1, 2021 at 9:30 AM Anna Schumaker <anna.schumaker@netapp.com> wrote:
>
> Hi David,
>
> On Sun, Jan 31, 2021 at 9:20 PM David Wysochanski <dwysocha@redhat.com> wrote:
> >
> > On Thu, Jan 28, 2021 at 9:59 AM Dave Wysochanski <dwysocha@redhat.com> wrote:
> > >
> > > This minimal set of patches update the NFS client to use the new
> > > readahead method, and convert the NFS fscache to use the new netfs
> > > IO API, and are at:
> > > https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-lib-nfs-20210128
> > > https://github.com/DaveWysochanskiRH/kernel/commit/74357eb291c9c292f3ab3bc9ed1227cb76f52c51
> > >
> > > The patches are based on David Howells fscache-netfs-lib tree at
> > > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-netfs-lib
> > >
> > > The first 6 patches refactor some of the NFS read code to facilitate
> > > re-use, the next 4 patches do the conversion to the new API.  Note
> > > patch 8 converts nfs_readpages to nfs_readahead.
> > >
> > > Changes since my last posting on Jan 27, 2021
> > > - Fix oops with fscache enabled on parallel read unit test
> > > - Add patches to handle invalidate and releasepage
> > > - Use #define FSCACHE_USE_NEW_IO_API to select the new API
> > > - Minor cleanup in nfs_readahead_from_fscache
> > >
> > > Still TODO
> > > 1. Fix known bugs
> > > a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
> > >    with GFP_KERNEL which may sleep (dhowells noted this in a review)
> > > b) nfs_refresh_inode() takes inode->i_lock but may call
> > >    __fscache_invalidate() which may sleep (found with lockdep)
> > > c) WARN with xfstest fscache/netapp/pnfs/nfs41
> >
> > Turns out this is a bit more involved and I would not consider pNFS +
> > fscache stable right now.
> > For now I may have to disable fscache if pNFS is enabled unless I can
> > quickly come up
> > with a reasonable fix for the problem.
>
> So my thought right now is to take the first 6 cleanup / preparation
> patches for the 5.12 merge window and save the cutover for 5.13. This
> would give you an extra release cycle to fix the pNFS stability, and
> it would give more time to find and fix any issues in netfs before
> switching NFS over to it.
>
> Would that work?
> Anna
>

Yes that's fine.


> >
> > The problem is as follows. Once netfs calls us in "issue_op" for a
> > given subrequest, it expects
> > one call back when the subrequest completes.  Now the "clamp_length"
> > function was developed
> > so we tell the netfs caller how big of an IO we can handle.  However,
> > right now it only implements
> > an 'rsize' check, and it does not take into account pNFS
> > characteristics such as segments
> > which may split up the IO into multiple RPCs. Since each of the RPC
> > have their own
> > completion, and so far I've not come up with a way to just call back
> > into netfs when the
> > last one is done, I am not sure what the right approach is.  One
> > obvious approach would be
> > a more sophisticated "clamp_length" function which adds similar logic
> > as to the *pg_test()
> > functions.  But I don't want to duplicate that and so it's not really clear.
> >
> > > 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> > > * Compare with netfs stats and determine if still needed
> > > 3. Cleanup dfprintks and/or convert to tracepoints
> > > 4. Further tests (see "Not tested yet")
> > >
> > > Tests run
> > > 1. Custom NFS+fscache unit tests for basic operation: PASS
> > > * vers=3,4.0,4.1,4.2,sec=sys,server=localhost (same kernel)
> > > 2. cthon04: PASS
> > > * test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys
> > > * No failures, oopses or hangs
> > > 3. iozone tests: PASS
> > > * nofsc,fsc,vers=3,4.0,4.1,4.2,sec=sys,server=rhel7,rhel8
> > > * No failures, oopses, or hangs
> > > 4. xfstests/generic: PASS*
> > > * no hangs or crashes (one WARN); failures unrelated to these patches
> > > * Ran following configurations
> > >   * vers=4.1,fsc,sec=sys,rhel7-server: PASS
> > >   * vers=4.0,fsc,sec=sys,rhel7-server: PASS
> > >   * vers=3,fsc,sec=sys,rhel7-server: PASS
> > >   * vers=4.1,nofsc,sec=sys,netapp-server(pnfs/files): PASS
> > >   * vers=4.1,fsc,sec=sys,netapp-server(pnfs/files): INCOMPLETE
> > >     * WARN_ON fs/netfs/read_helper.c:616
> > >     * ran with kernel.panic_on_oops=1
> > >   * vers=4.2,fsc,sec=sys,rhel7-server: running at generic/438
> > >   * vers=4.2,fsc,sec=sys,rhel8-server: running at generic/127
> > > 5. kernel build: PASS
> > >   * vers=4.2,fsc,sec=sys,rhel8-server: PASS
> > >
> > > Not tested yet:
> > > * error injections (for example, connection disruptions, server errors during IO, etc)
> > > * many process mixed read/write on same file
> > > * performance
> > >
> > > Dave Wysochanski (10):
> > >   NFS: Clean up nfs_readpage() and nfs_readpages()
> > >   NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
> > >     succeeds
> > >   NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
> > >     nfs_readdesc
> > >   NFS: Call readpage_async_filler() from nfs_readpage_async()
> > >   NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
> > >   NFS: Allow internal use of read structs and functions
> > >   NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
> > >   NFS: Convert readpages to readahead and use netfs_readahead for
> > >     fscache
> > >   NFS: Update releasepage to handle new fscache kiocb IO API
> > >   NFS: update various invalidation code paths for new IO API
> > >
> > >  fs/nfs/file.c              |  22 +++--
> > >  fs/nfs/fscache.c           | 230 +++++++++++++++++++------------------------
> > >  fs/nfs/fscache.h           | 105 +++-----------------
> > >  fs/nfs/internal.h          |   8 ++
> > >  fs/nfs/pagelist.c          |   2 +
> > >  fs/nfs/read.c              | 240 ++++++++++++++++++++-------------------------
> > >  fs/nfs/write.c             |  10 +-
> > >  include/linux/nfs_fs.h     |   5 +-
> > >  include/linux/nfs_iostat.h |   2 +-
> > >  include/linux/nfs_page.h   |   1 +
> > >  include/linux/nfs_xdr.h    |   1 +
> > >  11 files changed, 257 insertions(+), 369 deletions(-)
> > >
> > > --
> > > 1.8.3.1
> > >
> >
>

