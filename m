Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F606B326A
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Mar 2023 00:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCIXw0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Mar 2023 18:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjCIXwZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Mar 2023 18:52:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053AD1102A2
        for <linux-nfs@vger.kernel.org>; Thu,  9 Mar 2023 15:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678405899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A/Ex1IasW+Aw0khqFPJTnUAHDAW0XCrhREw6hTyC/ms=;
        b=aAnbPUIY4mTeV8nscGJ5n/07LZT8nURBTtT+8G0S+7VSc7EInVxRlxRqjvUqYgnemLwYJ7
        23xZHeX6JHf2KWE2SkW/p845LPje6bmZslbq2rTjH0VqmC47Ql8bV9P8igCWDvKgPkhWUA
        zuB1K4c+wz4FuwenBOWj6CVJ5mNltv4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-qr_HqDEPPFS1xcpKCAw6ng-1; Thu, 09 Mar 2023 18:51:38 -0500
X-MC-Unique: qr_HqDEPPFS1xcpKCAw6ng-1
Received: by mail-pj1-f71.google.com with SMTP id m9-20020a17090a7f8900b0023769205928so3380763pjl.6
        for <linux-nfs@vger.kernel.org>; Thu, 09 Mar 2023 15:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678405895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/Ex1IasW+Aw0khqFPJTnUAHDAW0XCrhREw6hTyC/ms=;
        b=tOjn6HvJaQitNOPXPfxf4vQ6OfzdO87Q02mMQGbYvFoZoDDz9ek5AjfXZ1lM0dpkGc
         GL8DTdH/bkcgkw5KoBRDI/cw9AKHsG0D9LLYoyp+TVdVThczbhXEweI2AB5hHr0yK1jb
         z89hoOkCyoEV+lLvUmTqPvyGb1H6d9jPPLxcWlOLM40uNmP2bjLGIcvdE2Tu7h7G00aD
         9nYV9dBGdQ0UD78QjNTZOfb5k1c6ustwkrchzGVDzgx65bCffqlCPc4/50o93KBhnm4p
         A5b8du6/PFjqrQs2RMxOuPSkAKRsqxCPYDBLIj7/3YkShl+lSNxtlZwmpF+bpQlbQg6u
         Tp7g==
X-Gm-Message-State: AO0yUKW7dGxHQU2mIjkHRzduEsMk7A2tymap2iaJ9PiC7UjUAvpDC1Fk
        2e5a6zHEcvE6mqA9j/hL9MxBB/V6KCAE6e14K9Gfz4GOC0M+Y7NK3FwQ0vuNFnx29BsHiJVaPT8
        l+al7/GVEN+JO0srRFpvAcdlw8oAAtzME4C+P
X-Received: by 2002:a17:90b:1881:b0:236:9f22:664a with SMTP id mn1-20020a17090b188100b002369f22664amr179645pjb.0.1678405895593;
        Thu, 09 Mar 2023 15:51:35 -0800 (PST)
X-Google-Smtp-Source: AK7set9oTEKhSpPlhPscfdE7TBpN0IkIUmPmo0TROCWvDRYwIAiw3rG+sJBk/Fh6ZvMmgw++l7qky9EpY85IUiCFBls=
X-Received: by 2002:a17:90b:1881:b0:236:9f22:664a with SMTP id
 mn1-20020a17090b188100b002369f22664amr179638pjb.0.1678405895206; Thu, 09 Mar
 2023 15:51:35 -0800 (PST)
MIME-Version: 1.0
References: <20230220134308.1193219-1-dwysocha@redhat.com> <CAPt2mGPJxPWfFGtEacBw-AN5nMZfP_pvL6=wEM+QbrPf1brAFg@mail.gmail.com>
 <CALF+zOmcROD6tzSCixYQN-+hw8bpboTrF-Ff-hEZOMDAPe7BOA@mail.gmail.com> <CAPt2mGMCzGdqgrF6e7hNAzJiz55wP3PkPCJvaZkNtcVW9Ydnvg@mail.gmail.com>
In-Reply-To: <CAPt2mGMCzGdqgrF6e7hNAzJiz55wP3PkPCJvaZkNtcVW9Ydnvg@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 9 Mar 2023 18:50:58 -0500
Message-ID: <CALF+zO=ZH3vt17653OC=x-ED4HbCKrdJ5QYxC6GmiQa=NW_VWA@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Convert NFS with fscache to the netfs API
To:     Daire Byrne <daire@dneg.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I posted a patch which should fix the problem.  It applied cleanly
to 6.3-rc1 as well as this series.

I think netfs should not be counting in the unlock path
because the PID won't be correct.  Fixing netfs should
be a separate patch though, orthogonal to this v11 series.

On Thu, Feb 23, 2023 at 10:47=E2=80=AFAM Daire Byrne <daire@dneg.com> wrote=
:
>
> Oh, I didn't realise that was included.
>
> I did a quick test doing a dd off a NFS mount but I did not see the
> read_bytes increment - rchar yes, read_bytes no (as before). This was
> an NFSv3 mount.
>
> Daire
>
> On Wed, 22 Feb 2023 at 15:57, David Wysochanski <dwysocha@redhat.com> wro=
te:
> >
> > Thanks Daire!  Did this also resolve the issue with
> > /proc/PID/io/read_bytes you reported (link below)
> > since netfs should increment that count now?
> >
> > https://lore.kernel.org/linux-nfs/CAPt2mGNEYUk5u8V4abe=3D5MM5msZqmvzCVr=
tCP4Qw1n=3DgCHCnww@mail.gmail.com/
> >
> >
> >
> > On Wed, Feb 22, 2023 at 7:51 AM Daire Byrne <daire@dneg.com> wrote:
> > >
> > > Dave,
> > >
> > > Thanks for this! I have been testing it with our production (render
> > > farm) loads for the last couple of days and have not run into any
> > > issues so far. It seems to be performing on par with your previous
> > > version of the patchset (based on v6.0).
> > >
> > > I am also running with both the "known issues" dhowells patches [8] &
> > > [9] mentioned in your email (as I was with your previous version).
> > >
> > > Tested-by: Daire Byrne <daire@dneg.com>
> > >
> > >
> > >
> > > On Mon, 20 Feb 2023 at 13:44, Dave Wysochanski <dwysocha@redhat.com> =
wrote:
> > > >
> > > > Trond, this v11 patchset addresses your latest feedback on patch #2=
,
> > > > and I did a little bit of cleanup to patch 3 (see Changes notes bel=
ow).
> > > > I'm not sure of further changes to patch #3 without a more in-depth
> > > > review with specifics, if you feel the current approach is unaccept=
able [1].
> > > >
> > > > Ben and Daire, if you could test this set and provide you feedback
> > > > and a Tested-By: that would be appreciated.  This set addresses
> > > > the existing NFS + fscache performance concerns seen by a few
> > > > users [5], which is due to utilization use of the deprecated
> > > > single-page function, fscache_fallback_read_page().  However,
> > > > until "known issue #1" below is also resolved, even with these
> > > > patches, performance of NFS+fscache will still be a problem
> > > > in some scenarios.
> > > >
> > > > This patchset converts NFS with fscache buffered read IO paths to
> > > > use the netfs API with a non-invasive approach.  The existing NFS p=
gio
> > > > layer does not need extensive changes, and is the best way so far I=
've
> > > > found to address Trond's previous concerns about modifying the IO
> > > > path [2] as well as only enabling netfs when fscache is configured
> > > > and enabled [3].  I have not attempted performance comparisions to
> > > > address Chuck Lever's concern [4] because we are not converting the
> > > > non-fscache enabled NFS IO paths to netfs.
> > > >
> > > > The patchset is based on Trond's latest 'testing' branch which incl=
udes
> > > > his folio patchset, and is based on 6.2-rc5.  It has been pushed to
> > > > github at:
> > > > https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-net=
fs
> > > > https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b75=
52eff26eb5da1f2282d35616
> > > >
> > > > Changes since v10 [6]
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > PATCH6: Dropped
> > > > PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
> > > > PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode =
(Trond) [7]
> > > > PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlo=
ck()
> > > >
> > > > Testing
> > > > =3D=3D=3D=3D=3D=3D=3D
> > > > I did a full round of testing on this because it was rebased on top=
 of
> > > > Trond's testing branch which included his folio series.
> > > > All of my unit tests pass except the one with the known issue #1 be=
low.
> > > > Multiple runs of xfstests generic tests (applicable to NFS) were ru=
n with
> > > > with various servers, both with and without fscache enabled, and
> > > > compared to baseline (Trond's testing branch).  No new failures wer=
e
> > > > observed with these patches, and in some xfstest instances, this
> > > > patchset improves the results (some tests that were failing now pas=
s).
> > > > - hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
> > > > - NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
> > > > - RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3
> > > >
> > > > Known issues
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > 1. Unit test setting rsize < readahead does not properly read from
> > > > fscache but re-reads data from the NFS server
> > > > * This will be fixed with another dhowells patch [8]:
> > > >   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when f=
olio removed from pagecache"
> > > > * Daire Byrne verified the patch fixes his issue as well
> > > >
> > > > 2. "Cache volume key already in use" after xfstest runs involving m=
ultiple mounts
> > > > * Simple reproducer requires just two mounts as follows:
> > > >  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r=
:root_t:s0  nfs-server:/exp1 /mnt1
> > > >  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r=
:root_t:s0  nfs-server:/exp2 /mnt2
> > > > * This should be fixed with dhowells patch [9]:
> > > >   "[PATCH v5] vfs, security: Fix automount superblock LSM init prob=
lem, preventing NFS sb sharing"
> > > >
> > > >
> > > > References
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > [1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b4455=
1d6a0d021dc.camel@kernel.org/
> > > > [2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222=
e708d67f595.camel@hammerspace.com/
> > > > [3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd=
6b92eb028fb.camel@hammerspace.com/
> > > > [4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E98=
0F8B310@oracle.com/
> > > > [5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f=
7XxRj+xS3NVxcJ+b8AAKQg@mail.gmail.com/
> > > > [6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwys=
ocha@redhat.com/
> > > > [7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5=
f2414c18e1f.camel@kernel.org/
> > > > [8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhow=
ells@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> > > > [9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.=
procyon.org.uk/
> > > >
> > > > Dave Wysochanski (5):
> > > >   NFS: Rename readpage_async_filler to nfs_read_add_folio
> > > >   NFS: Configure support for netfs when NFS fscache is configured
> > > >   NFS: Convert buffered read paths to use netfs when fscache is ena=
bled
> > > >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netf=
s API
> > > >   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
> > > >
> > > >  fs/nfs/Kconfig             |   1 +
> > > >  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++-----------=
----
> > > >  fs/nfs/fscache.h           | 131 ++++++++++++++------
> > > >  fs/nfs/inode.c             |   2 +
> > > >  fs/nfs/internal.h          |   9 ++
> > > >  fs/nfs/iostat.h            |  17 ---
> > > >  fs/nfs/nfstrace.h          |  91 --------------
> > > >  fs/nfs/pagelist.c          |   4 +
> > > >  fs/nfs/read.c              | 105 ++++++++--------
> > > >  fs/nfs/super.c             |  11 --
> > > >  include/linux/nfs_fs.h     |  25 ++--
> > > >  include/linux/nfs_iostat.h |  12 --
> > > >  include/linux/nfs_page.h   |   3 +
> > > >  include/linux/nfs_xdr.h    |   3 +
> > > >  14 files changed, 317 insertions(+), 339 deletions(-)
> > > >
> > > > --
> > > > 2.31.1
> > > >
> > >
> >
>

