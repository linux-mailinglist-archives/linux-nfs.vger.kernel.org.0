Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D952A2DA7
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:08:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKBPIf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgKBPIf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 10:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604329712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y2TUaDnFAj8F5URTBk74okXakXC2yVae6yoAYP4wN80=;
        b=W0mNwwJkTqgXYjyw8o2J+XRaBv/t8stnnR4+StvahM/QOoH0UfeRm4gA4+xIZstQ2W2Ya/
        hqbJX8AkzuyZLeUbsad4EpvRor81iviaqfRHywsNdj9ZBlkSA6aXCfafw77QjItZLOiNEy
        Gucg+7HIz4B/1CohhvKjSBBgfDUEa0o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-NM0erUiUM5OFvvJDXmkN8Q-1; Mon, 02 Nov 2020 10:08:28 -0500
X-MC-Unique: NM0erUiUM5OFvvJDXmkN8Q-1
Received: by mail-ej1-f70.google.com with SMTP id t1so4343242ejb.21
        for <linux-nfs@vger.kernel.org>; Mon, 02 Nov 2020 07:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2TUaDnFAj8F5URTBk74okXakXC2yVae6yoAYP4wN80=;
        b=WFB08N8ht7M4vkJRqPgJZiybmnXItbfx/mF//BvyvHQN8UizMtiMIX6Y9NECdQizfi
         dTJrEZKquFKtXv02qUysnXHuj9n6hOWFYnB+QjLPlk87QXF+rEhGU5Y9jENul5OvrGiV
         0pa71QB6tz8NPSc1tbYOGRe7PebLuMcxWDoIE8Ib731cNJMuerqTWN1TxyARV8X2wnCH
         BMsax6FrlA/aylTM+BCRsfi/CNNvEqidx1iHIOdwaAeyTfOdiolTNMoPiGNQiRpojkwT
         Mx1GCx5KkWsMTVEDe9US601f326taJVzcfyzh7jgbY8qJyTLPIAeJOIxTTPMqnTsvCZV
         sRPQ==
X-Gm-Message-State: AOAM5318nOKULU/1ngZYIRf6egDOAYCS99uXxRohMqkofRha0BTxEGA+
        lDqS7yqicRYPLhDu8qMOHmXSsBsNlf7bEeWBzJYurD0/V+VmSdafXdKcXBReijESieMY2qsXW0U
        g0omvRx5YOmL1ZpykW9y8IjrEZs3Fj1p1LnO8
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr9243118edt.211.1604329707055;
        Mon, 02 Nov 2020 07:08:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJydggo/a4aSrMhVq9G7xJls4nQO9hDOpj1G09wR4+JLD29+4i95RMGPIYqoyxJkvMM4pp88AmUOv84E2V+eCwU=
X-Received: by 2002:aa7:cb02:: with SMTP id s2mr9243095edt.211.1604329706716;
 Mon, 02 Nov 2020 07:08:26 -0800 (PST)
MIME-Version: 1.0
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com> <EBBD71E8-998F-4AF7-949D-119064745432@oracle.com>
In-Reply-To: <EBBD71E8-998F-4AF7-949D-119064745432@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 2 Nov 2020 10:07:50 -0500
Message-ID: <CALF+zOk4mNBA7ARWqUGZKnupOOLWj2xizTi98hwQtraZ5dLmqw@mail.gmail.com>
Subject: Re: [PATCH 00/11] Add NFS readdir tracepoints and improve performance
 of reading directories
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Nov 2, 2020 at 9:29 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
>
>
> > On Nov 2, 2020, at 8:50 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > Note these patches are also on github at:
> > https://github.com/DaveWysochanskiRH/kernel/tree/5.9-nfs-readdir
> >
> > This patchset is mostly tracepoints but patch 9 fixes a performance
> > problem with NFSv4.x when listing a directory that is being modified.
> > After the NFSv4.x patch, for consistency, patch 11 is included which
> > makes NFSv3 behave the same as NFSv4, and given the inclusion of
> > patch 9 does not re-introduce the regression fixed in previous commit
> > 79f687a3de9e.  As described in patch 11, NFSv3 does not currently have
> > the NFSv4 problem because it does not drop the pagecache when a
> > large directory read is in progress.
>
> Hi Dave-
>
> Replacing our community's deep dependence on wire capture is a good
> thing.
>
Chuck, I agree and thanks for your early response here.

> My initial concern with the tracepoint patches is that there are
> so many new tracepoints. In cases where we might want to enable all
> of them on an intensive workload, that generates an enormous amount
> of tracepoint traffic, which might overwhelm local file storage or
> analysis tools.
>
> Also, much of this infrastructure is useful for developers, but
> how much will be used in the field? The point of adding permanent
> tracepoints should be to capture just enough to enable sustaining
> engineers to diagnose problems remotely. Developers can add very
> specific tracepoints as they need to, but also they can use tools
> like systemtap or eBPF.
>
> Boiled down, I'm wondering if there's a way to prune some of this.
> Are the dprintk call sites you're replacing all that useful, for
> instance?
>
Yes this is a good point.  I struggled with this too, I actually had even
more tracepoints than was included here, and even looked
at the size of nfs.ko before and after (it is about 22k difference).
# size /lib/modules/$(uname -r)/kernel/fs/nfs/nfs.ko
   text    data     bss     dec     hex filename
 250820   67272     408  318500   4dc24
/lib/modules/5.9.0-nfs-readdir+/kernel/fs/nfs/nfs.ko
# size /lib/modules/5.9.0/kernel/fs/nfs/nfs.ko
   text    data     bss     dec     hex filename
 240232   55496     408  296136   484c8 /lib/modules/5.9.0/kernel/fs/nfs/nfs.ko

I can surely take another look at this and see what are the most
important, but off the top of my head, I'm thinking nfs_readdir() entry
and exit, as well as tracing the actual READDIR ops, probably something
searching the NFS readdir cache.  Are there tracepoints that look
unnecessary to you, or are you mainly asking me for more justification
for each one?

> And: Will it be easy to backport the fixes at the end? Maybe those
> should go earlier in the patch set.
>
Yes it could be done that way.  I also thought of separating the tracing
patches into one set, then the fixes another, but decided on one post
maybe due to the intro patch which ties everything together.

FWIW, there is only one tiny conflicts on 5.9 with the two fixes and
it's with patch 9:
863c92f4328a... NFS: Improve performance of listing directories being modified
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@@ -949,7 -941,9 +952,13 @@@ static int nfs_readdir(struct file *fil
  out:
        if (res > 0)
                res = 0;
++<<<<<<< HEAD
 +      dfprintk(FILE, "NFS: readdir(%pD2) returns %d\n", file, res);
++=======
+       dir_ctx->page_index = desc->page_index;
+       trace_nfs_readdir_exit(inode, ctx->pos, dir_ctx->dir_cookie,
+                              NFS_SERVER(inode)->dtsize, my_desc.plus, res);
++>>>>>>> 863c92f4328a... NFS: Improve performance of listing
directories being modified
        return res;
  }


>
> > As background, currently any process that is listing a directory
> > must search starting at cookie 0 at each entry to nfs_readdir(),
> > regardless of the previous cookie returned by the server, regardless of
> > NFS version, and regardless of whether the directory is being modified
> > or cache expired.  This means, for example, if a large directory listing
> > requires many getdents64/nfs_readdir calls, the kernel will search
> > through the pagecache with an increasing penalty as the size of the
> > directory increases and the process attempts to obtain the latter
> > entries of the directory.  When the directory is being modified, and
> > when acdirmax is exceeded, and nfs_attribute_cache_expired() returns
> > true, with NFSv4.x we drop the pagecache for the directory entries,
> > so the process cannot make forward progress.
> >
> > I investigated using a similar approach as was done with NFSv3 in
> > commit 79f687a3de9e, but for NFSv4, READDIR does not return the directory
> > attributes and thus _nfs4_proc_readdir does not call nfs_refresh_inode()
> > unlike nfs3_proc_readdir(). With NFSv3, the calling of nfs_refresh_inode()
> > is what updates nfsi->read_cache_jiffies causing nfs_attribute_cache_expired()
> > to always return false, leaving the pagecache in tact despite
> > NFS_INO_INVALID_DATA being set.  Thus it's not clear whether the NFSv3
> > approach could be done for NFSv4 to achieve the same behavior as with
> > NFSv3.  In addition, the current NFSv3 approach leaves in place the
> > aforementioned penalty, which for large directories can be substantial.
> > So rather than this approach, the approach taken with NFSv4 leaves
> > in place the dropping of the pagecache when acdirmax expires, and
> > relies on the fact that a process can trust the last cookie returned
> > by the server and continue at that point in the pagecache without
> > forcing the current process to start over from cookie 0 upon the
> > next entry to nfs_readdir().  As far as I could tell there is no
> > POSIX requirement to start from 0 again when a directory is being
> > modified during an in-progress directory read, and so the current
> > behavior is only an implementation limitation.
> >
> > The NFSv4 performance problem can be seen by exporting a directory
> > with a larger number of files such that the uncached time to list the
> > directory exceeds acdirmax.  I have an explicit reproducer script
> > I can provide, but a simple reproducer outline is as follows:
> >
> > 1. First export a directory that contains enough files that the
> > listing exceeds acdirmax.  In my testing, the NFS server and client
> > were the same system, there were 500,000 files in the directory,
> > and I set acdirmin=10,acdirmax=20.
> >
> > 2. Mount client1 (writer) and client2 (reader).  Note below I use
> > the loopback IP address, and a 'wsize' parameter on the writer mount
> > so we get different superblocks:
> > mount -o vers=4.1 127.0.0.1:/export/bz1889478 $MNT1
> > mount -o vers=4.1,wsize=65536 127.0.0.1:/export/bz1889478 $MNT2
> >
> > 3. Start client1 (writer):
> > echo 3 > /proc/sys/vm/drop_caches
> > i=500000; while true; do touch $MNT2/file$i.bin; i=$((i + 1)); sleep 1; done > /dev/null 2>&1 &
> >
> > 4. Start client2 (reader):
> > while true; do time ls -1f $MNT1 | wc -l; done &
> >
> > The output from my reproducer script is:
> > ./t0_bz1889478.sh 4.1 127.0.0.1 500000
> > Mon 02 Nov 2020 07:54:22 AM EST: Running with NFS vers=4.1 server 127.0.0.1 and files 500000 directory is idle
> > Mon 02 Nov 2020 07:54:22 AM EST: mount -o vers=4.1 127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt1
> > Mon 02 Nov 2020 07:54:22 AM EST: dropping caches with: echo 3 > /proc/sys/vm/drop_caches
> > Mon 02 Nov 2020 07:54:24 AM EST: idle directory: skipping client2 adding files
> > Mon 02 Nov 2020 07:54:24 AM EST: client1 running command: ls -lf /mnt/nfs/bz1889478-mnt1
> > Mon 02 Nov 2020 07:54:24 AM EST: waiting for listing to complete
> > Mon 02 Nov 2020 07:54:46 AM EST: client1 pid took 22 seconds to list the directory of 500000 files
> > Mon 02 Nov 2020 07:54:46 AM EST: client1 READDIR ops total: 4902 (before = 0 after = 4902)
> > Mon 02 Nov 2020 07:54:47 AM EST: umounting /mnt/nfs/bz1889478-mnt1 /mnt/nfs/bz1889478-mnt2
> > Mon 02 Nov 2020 07:54:47 AM EST: Running with NFS vers=4.1 server 127.0.0.1 and files 500000 directory being modified
> > Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=4.1 127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt1
> > Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=4.1,wsize=65536 127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt2
> > Mon 02 Nov 2020 07:54:47 AM EST: dropping caches with: echo 3 > /proc/sys/vm/drop_caches
> > Mon 02 Nov 2020 07:54:50 AM EST: changing directory: client2 start adding 1 file/sec at /mnt/nfs/bz1889478-mnt2
> > Mon 02 Nov 2020 07:54:51 AM EST: client1 running command: ls -lf /mnt/nfs/bz1889478-mnt1
> > Mon 02 Nov 2020 07:54:51 AM EST: waiting for listing to complete
> > Mon 02 Nov 2020 07:55:12 AM EST: client1 pid took 21 seconds to list the directory of 500000 files
> > Mon 02 Nov 2020 07:55:12 AM EST: client1 READDIR ops total: 4902 (before = 0 after = 4902)
> > ./t0_bz1889478.sh: line 124:  5973 Killed                  while true; do
> >    echo $i; touch $NFS_CLIENT_MOUNTPOINT2/file$i.bin; i=$((i + 1)); sleep 1;
> > done > /dev/null 2>&1
> > Mon 02 Nov 2020 07:55:20 AM EST: umounting /mnt/nfs/bz1889478-mnt1 /mnt/nfs/bz1889478-mnt2
> > PASSED TEST ./t0_bz1889478.sh on kernel 5.9.0-nfs-readdir+ with NFS vers=4.1
> >
> > For diagnostics and verification, of course a tcpdump can be
> > used, or even READDIR ops and time can be compared as in the
> > reproducer, but also the included tracepoints can be used.  For
> > the tracepoints, before step #2 above use the below trace-cmd
> > to trace the listing and see whether the problem occurs or not,
> > evidenced by either the presence of nfs_invalidate_mapping*
> > trace events or multiple nfs_readdir_enter calls with
> > "cookie=0x00000000":
> > trace-cmd start -e nfs:nfs_readdir_enter -e nfs4:nfs4_readdir -e nfs:nfs_readdir_exit -e nfs:nfs_invalidate_mapping_*
> >
> >
> > Dave Wysochanski (11):
> >  NFSv4: Improve nfs4_readdir tracepoint by adding additional fields
> >  NFS: Replace dfprintk statements with trace events in nfs_readdir
> >  NFS: Move nfs_readdir_descriptor_t into internal header
> >  NFS: Add tracepoints for functions involving nfs_readdir_descriptor_t
> >  NFS: Add tracepoints for opendir, closedir, fsync_dir and llseek_dir
> >  NFS: Add tracepoints for nfs_readdir_xdr_filler enter and exit
> >  NFS: Add tracepoint to entry and exit of nfs_do_filldir
> >  NFS: Replace LOOKUPCACHE dfprintk statements with tracepoints
> >  NFS: Improve performance of listing directories being modified
> >  NFS: Add page_index to nfs_readdir enter and exit tracepoints
> >  NFS: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()
> >
> > fs/nfs/dir.c           | 101 +++++++++---------
> > fs/nfs/internal.h      |  18 ++++
> > fs/nfs/nfs3xdr.c       |   2 +-
> > fs/nfs/nfs4proc.c      |   2 +-
> > fs/nfs/nfs4trace.h     |  44 +++++++-
> > fs/nfs/nfstrace.h      | 277 +++++++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/nfs_fs.h |   1 +
> > 7 files changed, 394 insertions(+), 51 deletions(-)
> >
> > --
> > 1.8.3.1
> >
>
> --
> Chuck Lever
>
>
>

