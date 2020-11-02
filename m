Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940982A2CFC
	for <lists+linux-nfs@lfdr.de>; Mon,  2 Nov 2020 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgKBO3c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 2 Nov 2020 09:29:32 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46180 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKBO3c (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 2 Nov 2020 09:29:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2ENnat059441;
        Mon, 2 Nov 2020 14:29:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=c5xcTq2ZxuDkFpiyGmnCSZDUSGO4FbGk/ZrsLTjjtyg=;
 b=llMNDO9WnfF91hYM2WtwB1wkk2Rcz1ao6CIBL0cuengNUwvZVVpfOZAjGFozZjopZe+G
 oTW/Nr83O+ehs2SIaX6W/IfKwefkvo9OHL7wXj2EC6WdzwRNSpwswCz1d/Dv997B1T0q
 Otfu6x+EBbaYjytsmJzouezWBOAgufWzMNA7dbrhKVlfRhpi97dFpOTcfILbfKGTRlXZ
 DEKnxmTdps0pFRpRg6LiK4wJemCwualqowPGh2yo4q8y7atz2Sm4MzDQLDhODuiB+dkX
 CPkebhsVa/hPe/Y9ctepc/dS+IidVGUgASkXfqXXRl8LU+XqfVVOKtQ4VlWqSq94Wrmn bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 34hhb1v6eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 14:29:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A2EOmgM073873;
        Mon, 2 Nov 2020 14:27:23 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 34jf46kmg5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 14:27:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0A2ERIBc028378;
        Mon, 2 Nov 2020 14:27:21 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Nov 2020 06:27:18 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH 00/11] Add NFS readdir tracepoints and improve performance
 of reading directories
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
Date:   Mon, 2 Nov 2020 09:27:17 -0500
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EBBD71E8-998F-4AF7-949D-119064745432@oracle.com>
References: <1604325011-29427-1-git-send-email-dwysocha@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020115
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 2, 2020, at 8:50 AM, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> Note these patches are also on github at:
> https://github.com/DaveWysochanskiRH/kernel/tree/5.9-nfs-readdir
>=20
> This patchset is mostly tracepoints but patch 9 fixes a performance
> problem with NFSv4.x when listing a directory that is being modified.
> After the NFSv4.x patch, for consistency, patch 11 is included which
> makes NFSv3 behave the same as NFSv4, and given the inclusion of
> patch 9 does not re-introduce the regression fixed in previous commit
> 79f687a3de9e.  As described in patch 11, NFSv3 does not currently have
> the NFSv4 problem because it does not drop the pagecache when a
> large directory read is in progress.

Hi Dave-

Replacing our community's deep dependence on wire capture is a good
thing.

My initial concern with the tracepoint patches is that there are
so many new tracepoints. In cases where we might want to enable all
of them on an intensive workload, that generates an enormous amount
of tracepoint traffic, which might overwhelm local file storage or
analysis tools.

Also, much of this infrastructure is useful for developers, but
how much will be used in the field? The point of adding permanent=20
tracepoints should be to capture just enough to enable sustaining
engineers to diagnose problems remotely. Developers can add very
specific tracepoints as they need to, but also they can use tools
like systemtap or eBPF.

Boiled down, I'm wondering if there's a way to prune some of this.
Are the dprintk call sites you're replacing all that useful, for
instance?

And: Will it be easy to backport the fixes at the end? Maybe those
should go earlier in the patch set.


> As background, currently any process that is listing a directory
> must search starting at cookie 0 at each entry to nfs_readdir(),
> regardless of the previous cookie returned by the server, regardless =
of
> NFS version, and regardless of whether the directory is being modified
> or cache expired.  This means, for example, if a large directory =
listing
> requires many getdents64/nfs_readdir calls, the kernel will search
> through the pagecache with an increasing penalty as the size of the
> directory increases and the process attempts to obtain the latter
> entries of the directory.  When the directory is being modified, and
> when acdirmax is exceeded, and nfs_attribute_cache_expired() returns
> true, with NFSv4.x we drop the pagecache for the directory entries,
> so the process cannot make forward progress.
>=20
> I investigated using a similar approach as was done with NFSv3 in
> commit 79f687a3de9e, but for NFSv4, READDIR does not return the =
directory
> attributes and thus _nfs4_proc_readdir does not call =
nfs_refresh_inode()
> unlike nfs3_proc_readdir(). With NFSv3, the calling of =
nfs_refresh_inode()
> is what updates nfsi->read_cache_jiffies causing =
nfs_attribute_cache_expired()
> to always return false, leaving the pagecache in tact despite
> NFS_INO_INVALID_DATA being set.  Thus it's not clear whether the NFSv3
> approach could be done for NFSv4 to achieve the same behavior as with
> NFSv3.  In addition, the current NFSv3 approach leaves in place the
> aforementioned penalty, which for large directories can be =
substantial.
> So rather than this approach, the approach taken with NFSv4 leaves
> in place the dropping of the pagecache when acdirmax expires, and
> relies on the fact that a process can trust the last cookie returned
> by the server and continue at that point in the pagecache without
> forcing the current process to start over from cookie 0 upon the
> next entry to nfs_readdir().  As far as I could tell there is no
> POSIX requirement to start from 0 again when a directory is being
> modified during an in-progress directory read, and so the current
> behavior is only an implementation limitation.
>=20
> The NFSv4 performance problem can be seen by exporting a directory
> with a larger number of files such that the uncached time to list the
> directory exceeds acdirmax.  I have an explicit reproducer script
> I can provide, but a simple reproducer outline is as follows:
>=20
> 1. First export a directory that contains enough files that the=20
> listing exceeds acdirmax.  In my testing, the NFS server and client
> were the same system, there were 500,000 files in the directory,
> and I set acdirmin=3D10,acdirmax=3D20.
>=20
> 2. Mount client1 (writer) and client2 (reader).  Note below I use
> the loopback IP address, and a 'wsize' parameter on the writer mount
> so we get different superblocks:
> mount -o vers=3D4.1 127.0.0.1:/export/bz1889478 $MNT1
> mount -o vers=3D4.1,wsize=3D65536 127.0.0.1:/export/bz1889478 $MNT2
>=20
> 3. Start client1 (writer):
> echo 3 > /proc/sys/vm/drop_caches
> i=3D500000; while true; do touch $MNT2/file$i.bin; i=3D$((i + 1)); =
sleep 1; done > /dev/null 2>&1 &
>=20
> 4. Start client2 (reader):
> while true; do time ls -1f $MNT1 | wc -l; done &
>=20
> The output from my reproducer script is:
> ./t0_bz1889478.sh 4.1 127.0.0.1 500000
> Mon 02 Nov 2020 07:54:22 AM EST: Running with NFS vers=3D4.1 server =
127.0.0.1 and files 500000 directory is idle
> Mon 02 Nov 2020 07:54:22 AM EST: mount -o vers=3D4.1 =
127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:22 AM EST: dropping caches with: echo 3 > =
/proc/sys/vm/drop_caches
> Mon 02 Nov 2020 07:54:24 AM EST: idle directory: skipping client2 =
adding files
> Mon 02 Nov 2020 07:54:24 AM EST: client1 running command: ls -lf =
/mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:24 AM EST: waiting for listing to complete
> Mon 02 Nov 2020 07:54:46 AM EST: client1 pid took 22 seconds to list =
the directory of 500000 files
> Mon 02 Nov 2020 07:54:46 AM EST: client1 READDIR ops total: 4902 =
(before =3D 0 after =3D 4902)
> Mon 02 Nov 2020 07:54:47 AM EST: umounting /mnt/nfs/bz1889478-mnt1 =
/mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:47 AM EST: Running with NFS vers=3D4.1 server =
127.0.0.1 and files 500000 directory being modified
> Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=3D4.1 =
127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:47 AM EST: mount -o vers=3D4.1,wsize=3D65536 =
127.0.0.1:/export/bz1889478 /mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:47 AM EST: dropping caches with: echo 3 > =
/proc/sys/vm/drop_caches
> Mon 02 Nov 2020 07:54:50 AM EST: changing directory: client2 start =
adding 1 file/sec at /mnt/nfs/bz1889478-mnt2
> Mon 02 Nov 2020 07:54:51 AM EST: client1 running command: ls -lf =
/mnt/nfs/bz1889478-mnt1
> Mon 02 Nov 2020 07:54:51 AM EST: waiting for listing to complete
> Mon 02 Nov 2020 07:55:12 AM EST: client1 pid took 21 seconds to list =
the directory of 500000 files
> Mon 02 Nov 2020 07:55:12 AM EST: client1 READDIR ops total: 4902 =
(before =3D 0 after =3D 4902)
> ./t0_bz1889478.sh: line 124:  5973 Killed                  while true; =
do
>    echo $i; touch $NFS_CLIENT_MOUNTPOINT2/file$i.bin; i=3D$((i + 1)); =
sleep 1;
> done > /dev/null 2>&1
> Mon 02 Nov 2020 07:55:20 AM EST: umounting /mnt/nfs/bz1889478-mnt1 =
/mnt/nfs/bz1889478-mnt2
> PASSED TEST ./t0_bz1889478.sh on kernel 5.9.0-nfs-readdir+ with NFS =
vers=3D4.1
>=20
> For diagnostics and verification, of course a tcpdump can be
> used, or even READDIR ops and time can be compared as in the
> reproducer, but also the included tracepoints can be used.  For
> the tracepoints, before step #2 above use the below trace-cmd
> to trace the listing and see whether the problem occurs or not,
> evidenced by either the presence of nfs_invalidate_mapping*
> trace events or multiple nfs_readdir_enter calls with
> "cookie=3D0x00000000":
> trace-cmd start -e nfs:nfs_readdir_enter -e nfs4:nfs4_readdir -e =
nfs:nfs_readdir_exit -e nfs:nfs_invalidate_mapping_*
>=20
>=20
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
>=20
> fs/nfs/dir.c           | 101 +++++++++---------
> fs/nfs/internal.h      |  18 ++++
> fs/nfs/nfs3xdr.c       |   2 +-
> fs/nfs/nfs4proc.c      |   2 +-
> fs/nfs/nfs4trace.h     |  44 +++++++-
> fs/nfs/nfstrace.h      | 277 =
+++++++++++++++++++++++++++++++++++++++++++++++++
> include/linux/nfs_fs.h |   1 +
> 7 files changed, 394 insertions(+), 51 deletions(-)
>=20
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



