Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7481E6A0D49
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Feb 2023 16:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbjBWPrq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Feb 2023 10:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233862AbjBWPrp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Feb 2023 10:47:45 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD90C5507A
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 07:47:43 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536cb25982eso176996897b3.13
        for <linux-nfs@vger.kernel.org>; Thu, 23 Feb 2023 07:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2W33cFuBQeCH1l5ObL0b570YsX8Lq+IhJXvGR83/f+o=;
        b=wEZz2tXDu1lvmKAnMuvWSS+n2+ULMxrj3K4aW7Rgt10e/+tEIrXIfLFI5hhfSyMHVn
         CWH+Ax66/3SMzfWVFCKnedi1Jjf143MRSW/PV8r59rhUzXM6QQyIe/5bEXQfbEDphmY+
         SZ+WMvSSyThOie0mScfFqZX+BqGlC6viB/LdQrXL36fD7PfJBlK2Vu7tAlT/fVg/v6CQ
         w2o2uapdr0tZpA4hS3WBHd7CJRyBy27m9S7FFFsiEPVvopV0T3S2G52e0Gf7BvzQM9bi
         nEpTawFwp6ew0JJtP2aQrpJFxiwjwslijMa1OgS2qaVBwFKbCh1iQTjy4fm4laA5mArw
         YISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2W33cFuBQeCH1l5ObL0b570YsX8Lq+IhJXvGR83/f+o=;
        b=UCR2cnHHzpGcThojzdvt+BiNKfJ+1GKA2JVpJipRF50vvwBvABviNoZ93IHi3SQi0k
         aPenHdT2+5XRCi+khOqGp5IJMirNArQNrk2WCALcgWvxuPuIzuZAI/g2q5b1WZZC1+4m
         ZZdr04lIJ5/Y3kXrttpUMktC7OnVWtJ1QUc6Cd5WAb3+gqx80IUvtYURaNFqSGLu0CVJ
         SeypMqApFHMm2gtzYYrLzoKUoADBAHvVHEMmLskiTbYLiKTB3ykkdTwlYvD4llYE8BGF
         V1FEUxPTemxgbij+oQSS4sB5h4nopGVnojtxKXf3uuhhjv6NFXJvjTEyjL/QT30LbDfY
         kEUw==
X-Gm-Message-State: AO0yUKWftsAxGOausHhW8Jr8rymdzSdvNFFYysOUriBM30Yf9tByQekM
        oJgK20Htz7jYKmZHtrNkEIs+P0nbRkOnMlnYtt7ROQ==
X-Google-Smtp-Source: AK7set8XyvAhpwEBmxqhET3MEy3Y/Dw/aZxNxIgLqdxaAVEOEzmeD+ccPwJtODWRHU62O4iDcHOeae4bw/h6eg0zIxs=
X-Received: by 2002:a81:ad0f:0:b0:52e:cea7:f6e0 with SMTP id
 l15-20020a81ad0f000000b0052ecea7f6e0mr2490532ywh.7.1677167262932; Thu, 23 Feb
 2023 07:47:42 -0800 (PST)
MIME-Version: 1.0
References: <20230220134308.1193219-1-dwysocha@redhat.com> <CAPt2mGPJxPWfFGtEacBw-AN5nMZfP_pvL6=wEM+QbrPf1brAFg@mail.gmail.com>
 <CALF+zOmcROD6tzSCixYQN-+hw8bpboTrF-Ff-hEZOMDAPe7BOA@mail.gmail.com>
In-Reply-To: <CALF+zOmcROD6tzSCixYQN-+hw8bpboTrF-Ff-hEZOMDAPe7BOA@mail.gmail.com>
From:   Daire Byrne <daire@dneg.com>
Date:   Thu, 23 Feb 2023 15:47:07 +0000
Message-ID: <CAPt2mGMCzGdqgrF6e7hNAzJiz55wP3PkPCJvaZkNtcVW9Ydnvg@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Convert NFS with fscache to the netfs API
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Oh, I didn't realise that was included.

I did a quick test doing a dd off a NFS mount but I did not see the
read_bytes increment - rchar yes, read_bytes no (as before). This was
an NFSv3 mount.

Daire

On Wed, 22 Feb 2023 at 15:57, David Wysochanski <dwysocha@redhat.com> wrote:
>
> Thanks Daire!  Did this also resolve the issue with
> /proc/PID/io/read_bytes you reported (link below)
> since netfs should increment that count now?
>
> https://lore.kernel.org/linux-nfs/CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com/
>
>
>
> On Wed, Feb 22, 2023 at 7:51 AM Daire Byrne <daire@dneg.com> wrote:
> >
> > Dave,
> >
> > Thanks for this! I have been testing it with our production (render
> > farm) loads for the last couple of days and have not run into any
> > issues so far. It seems to be performing on par with your previous
> > version of the patchset (based on v6.0).
> >
> > I am also running with both the "known issues" dhowells patches [8] &
> > [9] mentioned in your email (as I was with your previous version).
> >
> > Tested-by: Daire Byrne <daire@dneg.com>
> >
> >
> >
> > On Mon, 20 Feb 2023 at 13:44, Dave Wysochanski <dwysocha@redhat.com> wrote:
> > >
> > > Trond, this v11 patchset addresses your latest feedback on patch #2,
> > > and I did a little bit of cleanup to patch 3 (see Changes notes below).
> > > I'm not sure of further changes to patch #3 without a more in-depth
> > > review with specifics, if you feel the current approach is unacceptable [1].
> > >
> > > Ben and Daire, if you could test this set and provide you feedback
> > > and a Tested-By: that would be appreciated.  This set addresses
> > > the existing NFS + fscache performance concerns seen by a few
> > > users [5], which is due to utilization use of the deprecated
> > > single-page function, fscache_fallback_read_page().  However,
> > > until "known issue #1" below is also resolved, even with these
> > > patches, performance of NFS+fscache will still be a problem
> > > in some scenarios.
> > >
> > > This patchset converts NFS with fscache buffered read IO paths to
> > > use the netfs API with a non-invasive approach.  The existing NFS pgio
> > > layer does not need extensive changes, and is the best way so far I've
> > > found to address Trond's previous concerns about modifying the IO
> > > path [2] as well as only enabling netfs when fscache is configured
> > > and enabled [3].  I have not attempted performance comparisions to
> > > address Chuck Lever's concern [4] because we are not converting the
> > > non-fscache enabled NFS IO paths to netfs.
> > >
> > > The patchset is based on Trond's latest 'testing' branch which includes
> > > his folio patchset, and is based on 6.2-rc5.  It has been pushed to
> > > github at:
> > > https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> > > https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b7552eff26eb5da1f2282d35616
> > >
> > > Changes since v10 [6]
> > > =====================
> > > PATCH6: Dropped
> > > PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
> > > PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode (Trond) [7]
> > > PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlock()
> > >
> > > Testing
> > > =======
> > > I did a full round of testing on this because it was rebased on top of
> > > Trond's testing branch which included his folio series.
> > > All of my unit tests pass except the one with the known issue #1 below.
> > > Multiple runs of xfstests generic tests (applicable to NFS) were run with
> > > with various servers, both with and without fscache enabled, and
> > > compared to baseline (Trond's testing branch).  No new failures were
> > > observed with these patches, and in some xfstest instances, this
> > > patchset improves the results (some tests that were failing now pass).
> > > - hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
> > > - NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
> > > - RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3
> > >
> > > Known issues
> > > ============
> > > 1. Unit test setting rsize < readahead does not properly read from
> > > fscache but re-reads data from the NFS server
> > > * This will be fixed with another dhowells patch [8]:
> > >   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache"
> > > * Daire Byrne verified the patch fixes his issue as well
> > >
> > > 2. "Cache volume key already in use" after xfstest runs involving multiple mounts
> > > * Simple reproducer requires just two mounts as follows:
> > >  mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp1 /mnt1
> > >  mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp2 /mnt2
> > > * This should be fixed with dhowells patch [9]:
> > >   "[PATCH v5] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing"
> > >
> > >
> > > References
> > > ==========
> > > [1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org/
> > > [2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
> > > [3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
> > > [4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com/
> > > [5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f7XxRj+xS3NVxcJ+b8AAKQg@mail.gmail.com/
> > > [6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwysocha@redhat.com/
> > > [7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5f2414c18e1f.camel@kernel.org/
> > > [8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> > > [9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyon.org.uk/
> > >
> > > Dave Wysochanski (5):
> > >   NFS: Rename readpage_async_filler to nfs_read_add_folio
> > >   NFS: Configure support for netfs when NFS fscache is configured
> > >   NFS: Convert buffered read paths to use netfs when fscache is enabled
> > >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
> > >   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
> > >
> > >  fs/nfs/Kconfig             |   1 +
> > >  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
> > >  fs/nfs/fscache.h           | 131 ++++++++++++++------
> > >  fs/nfs/inode.c             |   2 +
> > >  fs/nfs/internal.h          |   9 ++
> > >  fs/nfs/iostat.h            |  17 ---
> > >  fs/nfs/nfstrace.h          |  91 --------------
> > >  fs/nfs/pagelist.c          |   4 +
> > >  fs/nfs/read.c              | 105 ++++++++--------
> > >  fs/nfs/super.c             |  11 --
> > >  include/linux/nfs_fs.h     |  25 ++--
> > >  include/linux/nfs_iostat.h |  12 --
> > >  include/linux/nfs_page.h   |   3 +
> > >  include/linux/nfs_xdr.h    |   3 +
> > >  14 files changed, 317 insertions(+), 339 deletions(-)
> > >
> > > --
> > > 2.31.1
> > >
> >
>
