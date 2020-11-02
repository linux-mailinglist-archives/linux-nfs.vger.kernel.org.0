Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95B2A2EDC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 16:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgKBP6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 10:58:39 -0500
Received: from smtp-o-1.desy.de ([131.169.56.154]:49229 "EHLO smtp-o-1.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726638AbgKBP6i (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 2 Nov 2020 10:58:38 -0500
Received: from smtp-buf-1.desy.de (smtp-buf-1.desy.de [IPv6:2001:638:700:1038::1:a4])
        by smtp-o-1.desy.de (Postfix) with ESMTP id 1B1F6E0869
        for <linux-nfs@vger.kernel.org>; Mon,  2 Nov 2020 16:58:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-1.desy.de 1B1F6E0869
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1604332714; bh=4kBTKMt3yOzjKi8zV+pWOH647Nkgyl+pC+Uk+CUzIso=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=aFHN568bX1cJOk8d+die0ydvyToJ1Kk+o1xB0zlEUOkvbeptHUoFq5pUvaynKdNiU
         gX5rLwjZVUTX7wtfYflWKTUld5nnwuPFbHH4DSiGljIbcCoM4F1XQFl8s0hdg8lZ+a
         neie+KoiEzPnplVbS9gBGq+nIzM9CjuKVb9eBXNw=
Received: from smtp-m-1.desy.de (smtp-m-1.desy.de [131.169.56.129])
        by smtp-buf-1.desy.de (Postfix) with ESMTP id 144681208A0;
        Mon,  2 Nov 2020 16:58:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id D938FC0177;
        Mon,  2 Nov 2020 16:58:33 +0100 (CET)
Date:   Mon, 2 Nov 2020 16:58:33 +0100 (CET)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     trondmy <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Message-ID: <42420978.5311919.1604332713797.JavaMail.zimbra@desy.de>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
Subject: Re: [PATCH 00/11] Add NFS readdir tracepoints and improve
 performance of reading directories
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF82 (Linux)/8.8.15_GA_3953)
Thread-Topic: Add NFS readdir tracepoints and improve performance of reading directories
Thread-Index: lxBTd5GPQGEvmfYtV6PzvZ8dSBW/AA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi Dave,

thanks for addressing this issue!

The readdir on large directory that's permanently changes is a pain in a b...
We have solved it by creating a snapshot of a directory on the server and
identifying this snapshot by cookie verifier. This is probably it not posix
compliant, but works for us.

I am happy to run some tests.

Tigran.


----- Original Message -----
> From: "David Wysochanski" <dwysocha@redhat.com>
> To: "trondmy" <trondmy@hammerspace.com>, "Anna Schumaker" <anna.schumaker@netapp.com>
> Cc: "linux-nfs" <linux-nfs@vger.kernel.org>
> Sent: Monday, 2 November, 2020 14:50:00
> Subject: [PATCH 00/11] Add NFS readdir tracepoints and improve performance of reading directories

> Note these patches are also on github at:
> https://github.com/DaveWysochanskiRH/kernel/tree/5.9-nfs-readdir
> 
> This patchset is mostly tracepoints but patch 9 fixes a performance
> problem with NFSv4.x when listing a directory that is being modified.
> After the NFSv4.x patch, for consistency, patch 11 is included which
> makes NFSv3 behave the same as NFSv4, and given the inclusion of
> patch 9 does not re-introduce the regression fixed in previous commit
> 79f687a3de9e.  As described in patch 11, NFSv3 does not currently have
> the NFSv4 problem because it does not drop the pagecache when a
> large directory read is in progress.
> 
> As background, currently any process that is listing a directory
> must search starting at cookie 0 at each entry to nfs_readdir(),
> regardless of the previous cookie returned by the server, regardless of
> NFS version, and regardless of whether the directory is being modified
> or cache expired.  This means, for example, if a large directory listing
> requires many getdents64/nfs_readdir calls, the kernel will search
> through the pagecache with an increasing penalty as the size of the
> directory increases and the process attempts to obtain the latter
> entries of the directory.  When the directory is being modified, and
> when acdirmax is exceeded, and nfs_attribute_cache_expired() returns
> true, with NFSv4.x we drop the pagecache for the directory entries,
> so the process cannot make forward progress.
> 
> I investigated using a similar approach as was done with NFSv3 in
> commit 79f687a3de9e, but for NFSv4, READDIR does not return the directory
> attributes and thus _nfs4_proc_readdir does not call nfs_refresh_inode()
> unlike nfs3_proc_readdir(). With NFSv3, the calling of nfs_refresh_inode()
> is what updates nfsi->read_cache_jiffies causing nfs_attribute_cache_expired()
> to always return false, leaving the pagecache in tact despite
> NFS_INO_INVALID_DATA being set.  Thus it's not clear whether the NFSv3
> approach could be done for NFSv4 to achieve the same behavior as with
> NFSv3.  In addition, the current NFSv3 approach leaves in place the
> aforementioned penalty, which for large directories can be substantial.
> So rather than this approach, the approach taken with NFSv4 leaves
> in place the dropping of the pagecache when acdirmax expires, and
> relies on the fact that a process can trust the last cookie returned
> by the server and continue at that point in the pagecache without
> forcing the current process to start over from cookie 0 upon the
> next entry to nfs_readdir().  As far as I could tell there is no
> POSIX requirement to start from 0 again when a directory is being
> modified during an in-progress directory read, and so the current
> behavior is only an implementation limitation.
> 
> The NFSv4 performance problem can be seen by exporting a directory
> with a larger number of files such that the uncached time to list the
> directory exceeds acdirmax.  I have an explicit reproducer script
> I can provide, but a simple reproducer outline is as follows:
> 
> 1. First export a directory that contains enough files that the
> listing exceeds acdirmax.  In my testing, the NFS server and client
> were the same system, there were 500,000 files in the directory,
> and I set acdirmin=10,acdirmax=20.
> 
> 2. Mount client1 (writer) and client2 (reader).  Note below I use
> the loopback IP address, and a 'wsize' parameter on the writer mount
> so we get different superblocks:
> mount -o vers=4.1 127.0.0.1:/export/bz1889478 $MNT1
> mount -o vers=4.1,wsize=65536 127.0.0.1:/export/bz1889478 $MNT2
> 
> 3. Start client1 (writer):
> echo 3 > /proc/sys/vm/drop_caches
> i=500000; while true; do touch $MNT2/file$i.bin; i=$((i + 1)); sleep 1; done >
> /dev/null 2>&1 &
> 
> 4. Start client2 (reader):
> while true; do time ls -1f $MNT1 | wc -l; done &
> 
> The output from my reproducer script is:
> ./t0_bz1889478.sh 4.1 127.0.0.1 500000
> Mon 02 Nov 2020 07:54:22 AM EST: Running with NFS vers=4.1 server 127.0.0.1 and
> files 500000 directory is idle
> Mon 02 Nov 2020 07:54:22 AM EST: mount -o vers=4.1 127.0.0.1:/export/bz1889478
> /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:22 AM EST: dropping caches with: echo 3 >
> /proc/sys/vm/drop_caches
> Mon 02 Nov 2020 07:54:24 AM EST: idle directory: skipping client2 adding files
> Mon 02 Nov 2020 07:54:24 AM EST: client1 running command: ls -lf
> /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:24 AM EST: waiting for listing to complete
> Mon 02 Nov 2020 07:54:46 AM EST: client1 pid took 22 seconds to list the
> directory of 500000 files
> Mon 02 Nov 2020 07:54:46 AM EST: client1 READDIR ops total: 4902 (before = 0
> after = 4902)
> Mon 02 Nov 2020 07:54:47 AM EST: umounting /mnt/nfs/bz1889478-mnt1
> /mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:47 AM EST: Running with NFS vers=4.1 server 127.0.0.1 and
> files 500000 directory being modified
> Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=4.1 127.0.0.1:/export/bz1889478
> /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=4.1,wsize=65536
> 127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:47 AM EST: dropping caches with: echo 3 >
> /proc/sys/vm/drop_caches
> Mon 02 Nov 2020 07:54:50 AM EST: changing directory: client2 start adding 1
> file/sec at /mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:51 AM EST: client1 running command: ls -lf
> /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:51 AM EST: waiting for listing to complete
> Mon 02 Nov 2020 07:55:12 AM EST: client1 pid took 21 seconds to list the
> directory of 500000 files
> Mon 02 Nov 2020 07:55:12 AM EST: client1 READDIR ops total: 4902 (before = 0
> after = 4902)
> ./t0_bz1889478.sh: line 124:  5973 Killed                  while true; do
>    echo $i; touch $NFS_CLIENT_MOUNTPOINT2/file$i.bin; i=$((i + 1)); sleep 1;
> done > /dev/null 2>&1
> Mon 02 Nov 2020 07:55:20 AM EST: umounting /mnt/nfs/bz1889478-mnt1
> /mnt/nfs/bz1889478-mnt2
> PASSED TEST ./t0_bz1889478.sh on kernel 5.9.0-nfs-readdir+ with NFS vers=4.1
> 
> For diagnostics and verification, of course a tcpdump can be
> used, or even READDIR ops and time can be compared as in the
> reproducer, but also the included tracepoints can be used.  For
> the tracepoints, before step #2 above use the below trace-cmd
> to trace the listing and see whether the problem occurs or not,
> evidenced by either the presence of nfs_invalidate_mapping*
> trace events or multiple nfs_readdir_enter calls with
> "cookie=0x00000000":
> trace-cmd start -e nfs:nfs_readdir_enter -e nfs4:nfs4_readdir -e
> nfs:nfs_readdir_exit -e nfs:nfs_invalidate_mapping_*
> 
> 
> Dave Wysochanski (11):
>  NFSv4: Improve nfs4_readdir tracepoint by adding additional fields
>  NFS: Replace dfprintk statements with trace events in nfs_readdir
>  NFS: Move nfs_readdir_descriptor_t into internal header
>  NFS: Add tracepoints for functions involving nfs_readdir_descriptor_t
>  NFS: Add tracepoints for opendir, closedir, fsync_dir and llseek_dir
>  NFS: Add tracepoints for nfs_readdir_xdr_filler enter and exit
>  NFS: Add tracepoint to entry and exit of nfs_do_filldir
>  NFS: Replace LOOKUPCACHE dfprintk statements with tracepoints
>  NFS: Improve performance of listing directories being modified
>  NFS: Add page_index to nfs_readdir enter and exit tracepoints
>  NFS: Bring back nfs_dir_mapping_need_revalidate() in nfs_readdir()
> 
> fs/nfs/dir.c           | 101 +++++++++---------
> fs/nfs/internal.h      |  18 ++++
> fs/nfs/nfs3xdr.c       |   2 +-
> fs/nfs/nfs4proc.c      |   2 +-
> fs/nfs/nfs4trace.h     |  44 +++++++-
> fs/nfs/nfstrace.h      | 277 +++++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/nfs_fs.h |   1 +
> 7 files changed, 394 insertions(+), 51 deletions(-)
> 
> --
> 1.8.3.1
