Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078E06EE6B9
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Apr 2023 19:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjDYRck (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Apr 2023 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbjDYRcj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Apr 2023 13:32:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1343672A9
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 10:32:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-95316faa3a8so1131595166b.2
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 10:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682443955; x=1685035955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/uerlrdbRbGaHA0wFfSaYXBd9WuSbAnh48rDhj45nY=;
        b=cl7hOobqCaPD1o0u30zZyHvujvDq8yiMOOc3meaYicyRk9zDEet43dnDdBL6xVkkHv
         GSLXCG6ixJVscIoIgd7wD4JT2Dp+COkO+axIHWdVC6YEhs4kBpEErT99+UcI8z94x9PF
         P2GyiloebUScGsJQFFG03QfHDr1dKQy9UGBk/rh5f+csiMC3Hjd1fnBOTAdzgdyds1xt
         wHemt3IUAPm+2L56w8bsdIPl5trRog94UKYEcSipNFIXoCihkDMOJH28EFFIYWWdB5Ye
         8Vn05gNxpGO0YZHQ2m/U9LQmkycEpOiQPknTbS02QmdnGygxEKdEbFuwNg+HGjuC+wvi
         NcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443955; x=1685035955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q/uerlrdbRbGaHA0wFfSaYXBd9WuSbAnh48rDhj45nY=;
        b=Vsziytq476DFxCftoUoyvVoP85xGHAV5MhrhoS0aykOIig+iomF30Xn6HC9ppqkhLa
         tsGmNjK0nTQiPZLeBGXb4A8seh/vnosNBVlI/Appe5xIbJFWSRtdO7CAh1kCQYpI6QVy
         hOCueODr2pvpGL+lXfOjyRlJidKuRg9LFqex0fA461A75CujvsHtr06gjTimB3P3ZxBn
         pA4mqXXeHEn+IpvkqukBZhjMRSLdwU+U/6etsm1VO3RCDuUbgeoAUk2CDY8DOJoNOA41
         i6ExFXfRmAvzTNTHAFUsIPTn+cFW3nkqjozL+qTS8eOLmj+aSWSc7aTzwGLW6LtElhp8
         Zndg==
X-Gm-Message-State: AAQBX9e4BoZaJne8CC1ZEGauuz7TbCqqZxTycyLA5K5Exglz90G2IcWd
        vm1Qq3p1Gj8lEUL37XewC7YFlU4pG5+Vwqz0qLs=
X-Google-Smtp-Source: AKy350bnKK/6x6hGYo28vLfYfVI1nXMvZWl7OKwBOHFbUyvJ5cjIAXL8SCLE9GWJ5qvcxW6jOgSG0huzmmmLXFmVLVU=
X-Received: by 2002:a17:906:368f:b0:953:5ff7:7753 with SMTP id
 a15-20020a170906368f00b009535ff77753mr13521096ejc.11.1682443954704; Tue, 25
 Apr 2023 10:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230220134308.1193219-1-dwysocha@redhat.com> <CALF+zOnr0B2w-0jY4DK6Asgb8m2g9d9hecR0mgw6wausaEEaSA@mail.gmail.com>
In-Reply-To: <CALF+zOnr0B2w-0jY4DK6Asgb8m2g9d9hecR0mgw6wausaEEaSA@mail.gmail.com>
From:   Chris Chilvers <chilversc@gmail.com>
Date:   Tue, 25 Apr 2023 18:32:23 +0100
Message-ID: <CAAmbk-d-kF=-vMD-e2yUnLqsrjtiU0c8oW2ddx0m27CDM2RHXQ@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v11 0/5] Convert NFS with fscache to the
 netfs API
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We've been using NFS with FS-Cache to act as a caching proxy (re-export). W=
hen
under load we've encountered an issue where all the nfsd processes seem to =
get
stuck in I/O wait.

The proxy is running an older version of the nfs-fscache-nfsfs branch taken
from 17th Nov 2022,
https://github.com/DaveWysochanskiRH/kernel/commit/52acbd4584d1b83c844371e4=
8de1a1e39d255a6d.

The proxy mounts the source NFS server using NFS v3 with FS-Cache enabled.
The clients mount the proxy using NFS v4.2 to avoid issues with file handle
sizes.

dmesg suggests that most of the CPU tasks are blocked by nfsd on
folio_wait_bit_common

    INFO: task nfsd:180059 blocked for more than 120 seconds.
          Not tainted 6.1.0-rc5+ #1
    "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
    task:nfsd            state:D stack:0     pid:180059 ppid:2
flags:0x00004000
    Call Trace:
     <TASK>
     __schedule+0x31e/0x14a0
     ? _raw_spin_unlock_irqrestore+0x27/0x50
     schedule+0x6b/0x110
     io_schedule+0x46/0x80
     folio_wait_bit_common+0x124/0x340
     ? xas_find+0x7c/0x1e0
     ? xas_find_marked+0x1f7/0x370
     ? filemap_invalidate_unlock_two+0x50/0x50
     folio_wait_private_2+0x2c/0x50
     nfs_release_folio+0x5e/0xb0 [nfs]
     filemap_release_folio+0x66/0x80
     invalidate_inode_pages2_range+0x240/0x400
     invalidate_inode_pages2+0x17/0x20
     nfs_clear_invalid_mapping+0x1d8/0x2d0 [nfs]
     nfs_revalidate_mapping+0x55/0x70 [nfs]
     nfs_file_read+0x4c/0xc0 [nfs]
     generic_file_splice_read+0x8f/0x160
     do_splice_to+0x7d/0xc0
     splice_direct_to_actor+0xad/0x210
     ? fsid_source+0x60/0x60 [nfsd]
     ? nfsd_file_do_acquire+0xacf/0xbd0 [nfsd]
     nfsd_splice_read+0x7c/0x120 [nfsd]
     nfsd_read+0x147/0x1b0 [nfsd]
     nfsd3_proc_read+0x1b5/0x2d0 [nfsd]
     ? svcxdr_decode_nfs_fh3+0x4e/0x130 [nfsd]
     nfsd_dispatch+0x173/0x2b0 [nfsd]
     svc_process_common+0x3c8/0x620 [sunrpc]
     ? nfsd_svc+0x3e0/0x3e0 [nfsd]
     ? nfsd_shutdown_threads+0xb0/0xb0 [nfsd]
     svc_process+0xb2/0x100 [sunrpc]
     nfsd+0xda/0x190 [nfsd]
     kthread+0xfa/0x130
     ? kthread_complete_and_exit+0x20/0x20
     ret_from_fork+0x1f/0x30
     </TASK>

Checking /proc/PID/stack for all the nfsd processes had the following count=
s:

* 72 - nfsd_file_do_acquire+0x20b/0xbd0
* 36 - folio_wait_bit_common+0x124/0x340
* 10 - fscache_begin_operation.part.0+0x288/0x2b0 [fscache]
*  8 - __fscache_use_cookie+0x2e5/0x320 [fscache]
*  2 - ext4_llseek+0x91/0x110

dmesg also contains a lot of errors about timeouts waiting for the cookie s=
tate
to change:

    FS-Cache: fscache_begin_operation: cookie state change wait timed
out: cookie->state=3D1 state=3D1
    FS-Cache: O-cookie c=3D0026b915 [fl=3D602c na=3D1 nA=3D2 s=3DL]
    FS-Cache: O-cookie V=3D00000001
[Infs,3.0,2,,8335540a,6465ebb4,,,d0,100000,100000,249f0,249f0,249f0,249f0,1=
]
    FS-Cache: O-key=3D[32]
'b4eb6564010000005509a81a02000000ffffffff000000000400fd0301000000'
    FS-Cache: fscache_begin_operation: cookie state change wait timed
out: cookie->state=3D1 state=3D1
    FS-Cache: O-cookie c=3D0024fd88 [fl=3D602c na=3D1 nA=3D2 s=3DL]
    FS-Cache: O-cookie V=3D00000001
[Infs,3.0,2,,8335540a,6465ebb4,,,d0,100000,100000,249f0,249f0,249f0,249f0,1=
]
    FS-Cache: O-key=3D[32]
'b4eb6564010000007df7aa1702000000ffffffff000000000400fd0301000000'
    FS-Cache: fscache_begin_operation: cookie state change wait timed
out: cookie->state=3D1 state=3D1
    FS-Cache: O-cookie c=3D0026d61a [fl=3D4024 na=3D1 nA=3D2 s=3DL]
    FS-Cache: O-cookie V=3D00000001
[Infs,3.0,2,,8335540a,6465ebb4,,,d0,100000,100000,249f0,249f0,249f0,249f0,1=
]
    FS-Cache: O-key=3D[32]
'b4eb656401000000b79947ce01000000ffffffff000000000400fd0301000000'

The clients were shutdown but the proxy instance kept for further diagnosis=
.
The nfsd sockets remained stuck in CLOSE_WAIT, and the nfsd processes remai=
ned
stuck on various tasks for at least 4 days. It seems at some point over the
weekend the issue resolved itself and now all the nfsd threads are idle.

I'm going to try to see if I can reproduce this on the latest versions of t=
he
patches with the lockdep enabled. Though currently we've only seen this iss=
ue
while the system is under a heavy production workload (rendering) after sev=
eral
days.

On Thu, 23 Mar 2023 at 17:50, David Wysochanski <dwysocha@redhat.com> wrote=
:
>
> On Mon, Feb 20, 2023 at 8:43=E2=80=AFAM Dave Wysochanski <dwysocha@redhat=
.com> wrote:
> >
> > Trond, this v11 patchset addresses your latest feedback on patch #2,
> > and I did a little bit of cleanup to patch 3 (see Changes notes below).
> > I'm not sure of further changes to patch #3 without a more in-depth
> > review with specifics, if you feel the current approach is unacceptable=
 [1].
> >
>
> Trond and/or Anna,
>
> Have you had a chance to review this patchset and do you have further
> concerns?
>
> Note that patch #3 will require a small fixup to apply after v6.3-rc1
> due to this commit:
> 8bb7cd842c44 nfs: use bvec_set_page to initialize bvecs
>
> There is also still the small open issue of netfs counting read_bytes
> in its unlock page path, but I view that as a netfs issue.  I'll followup
> with David Howells on that.
>
>
> > Ben and Daire, if you could test this set and provide you feedback
> > and a Tested-By: that would be appreciated.  This set addresses
> > the existing NFS + fscache performance concerns seen by a few
> > users [5], which is due to utilization use of the deprecated
> > single-page function, fscache_fallback_read_page().  However,
> > until "known issue #1" below is also resolved, even with these
> > patches, performance of NFS+fscache will still be a problem
> > in some scenarios.
> >
> > This patchset converts NFS with fscache buffered read IO paths to
> > use the netfs API with a non-invasive approach.  The existing NFS pgio
> > layer does not need extensive changes, and is the best way so far I've
> > found to address Trond's previous concerns about modifying the IO
> > path [2] as well as only enabling netfs when fscache is configured
> > and enabled [3].  I have not attempted performance comparisions to
> > address Chuck Lever's concern [4] because we are not converting the
> > non-fscache enabled NFS IO paths to netfs.
> >
> > The patchset is based on Trond's latest 'testing' branch which includes
> > his folio patchset, and is based on 6.2-rc5.  It has been pushed to
> > github at:
> > https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> > https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b7552ef=
f26eb5da1f2282d35616
> >
> > Changes since v10 [6]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > PATCH6: Dropped
> > PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
> > PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode (Tro=
nd) [7]
> > PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlock()
> >
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > I did a full round of testing on this because it was rebased on top of
> > Trond's testing branch which included his folio series.
> > All of my unit tests pass except the one with the known issue #1 below.
> > Multiple runs of xfstests generic tests (applicable to NFS) were run wi=
th
> > with various servers, both with and without fscache enabled, and
> > compared to baseline (Trond's testing branch).  No new failures were
> > observed with these patches, and in some xfstest instances, this
> > patchset improves the results (some tests that were failing now pass).
> > - hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
> > - NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
> > - RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3
> >
> > Known issues
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Unit test setting rsize < readahead does not properly read from
> > fscache but re-reads data from the NFS server
> > * This will be fixed with another dhowells patch [8]:
> >   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when folio=
 removed from pagecache"
> > * Daire Byrne verified the patch fixes his issue as well
> >
> > 2. "Cache volume key already in use" after xfstest runs involving multi=
ple mounts
> > * Simple reproducer requires just two mounts as follows:
> >  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r:roo=
t_t:s0  nfs-server:/exp1 /mnt1
> >  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r:roo=
t_t:s0  nfs-server:/exp2 /mnt2
> > * This should be fixed with dhowells patch [9]:
> >   "[PATCH v5] vfs, security: Fix automount superblock LSM init problem,=
 preventing NFS sb sharing"
> >
> >
> > References
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b44551d6a=
0d021dc.camel@kernel.org/
> > [2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708=
d67f595.camel@hammerspace.com/
> > [3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92=
eb028fb.camel@hammerspace.com/
> > [4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E980F8B=
310@oracle.com/
> > [5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f7XxR=
j+xS3NVxcJ+b8AAKQg@mail.gmail.com/
> > [6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwysocha=
@redhat.com/
> > [7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5f241=
4c18e1f.camel@kernel.org/
> > [8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells=
@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> > [9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.proc=
yon.org.uk/
> >
> > Dave Wysochanski (5):
> >   NFS: Rename readpage_async_filler to nfs_read_add_folio
> >   NFS: Configure support for netfs when NFS fscache is configured
> >   NFS: Convert buffered read paths to use netfs when fscache is enabled
> >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs AP=
I
> >   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
> >
> >  fs/nfs/Kconfig             |   1 +
> >  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
> >  fs/nfs/fscache.h           | 131 ++++++++++++++------
> >  fs/nfs/inode.c             |   2 +
> >  fs/nfs/internal.h          |   9 ++
> >  fs/nfs/iostat.h            |  17 ---
> >  fs/nfs/nfstrace.h          |  91 --------------
> >  fs/nfs/pagelist.c          |   4 +
> >  fs/nfs/read.c              | 105 ++++++++--------
> >  fs/nfs/super.c             |  11 --
> >  include/linux/nfs_fs.h     |  25 ++--
> >  include/linux/nfs_iostat.h |  12 --
> >  include/linux/nfs_page.h   |   3 +
> >  include/linux/nfs_xdr.h    |   3 +
> >  14 files changed, 317 insertions(+), 339 deletions(-)
> >
> > --
> > 2.31.1
> >
> > --
> > Linux-cachefs mailing list
> > Linux-cachefs@redhat.com
> > https://listman.redhat.com/mailman/listinfo/linux-cachefs
> >
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
