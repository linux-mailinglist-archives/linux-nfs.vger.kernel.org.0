Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF92669F87F
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 16:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjBVP6j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 10:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjBVP6i (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 10:58:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D75C10DE
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 07:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677081470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SyZg4bu/QVtYqWqIrWk87isNp8GJlOCUrMmFqleOHYs=;
        b=D0MhiNaipIgt2PmEJNxEeuKDt3d0sJ46GCITmeCtIHpYbsrZetK2yTiKBQ2FCT0t05Dojl
        l1kWOZSt4iELaQjgZp7x6RAafrxGk0a2BsTMTjiYY+xvzzD1IjsWJ+MXDwArctwW+USNw0
        zvd8t7H72hq0WfZqW203iPc2JPHTE3c=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-1_EUPjCzMRav-0l6H-3a7Q-1; Wed, 22 Feb 2023 10:57:49 -0500
X-MC-Unique: 1_EUPjCzMRav-0l6H-3a7Q-1
Received: by mail-pl1-f198.google.com with SMTP id j20-20020a170902759400b0019ace17fa33so4040016pll.7
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 07:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyZg4bu/QVtYqWqIrWk87isNp8GJlOCUrMmFqleOHYs=;
        b=if4P0fpF0Y5/xVAhKwWYnCK/M71KLZ5a5LCRvoYmD8pnh/CAkW5w2VlMy56TTtM+aW
         CJ1cinXC9m+foWZ0U3OFYofqPcrfRDUskZvAt8/cLf/7gpczMLBcvxOg7eG/jr0QwcKy
         n0SK0oB2dswP8k/7PhFM2LZmtc+LuXQzrVGvnyCdn7eq+Zw0IHFR/vOijVN6zoh11NM7
         HFq1sXQ7ri7z/uAwtArjYIb9lp7DHrCfigl9wiwRAFOlif5+DbYsRd1gJktd6c3dYBXV
         Vb8/wffGP86WQbnVrHVs6xtMQ5rHIhat06b2fcK4LcyDzQyUkO/+Pm7vjpkSwCBEC5kH
         Pf9g==
X-Gm-Message-State: AO0yUKVdIWHB+9T2Zsi27jvXPRMggDDacbmtOYl3UtVJo4XZORWJlZhv
        tBCdn5cn7ILoERq610LX1yzZsCXJhN1vIfxk5mTw79FEyJYHCtqI/UeUdTH5Pu85DhltDrHPuN+
        tI6lZZX99mUj2w26L60XbNZSgFoiDBB52sNmK
X-Received: by 2002:a17:902:ceca:b0:19b:c2d:120a with SMTP id d10-20020a170902ceca00b0019b0c2d120amr1576173plg.22.1677081467782;
        Wed, 22 Feb 2023 07:57:47 -0800 (PST)
X-Google-Smtp-Source: AK7set8Kq7z4c2KCBSxKwKgw3SygNqg+zWZ/my45Itx/+l9tYKjiUcItQCp7nGeDlFw7MdoIpK5olkjIKGzDwh2yjW4=
X-Received: by 2002:a17:902:ceca:b0:19b:c2d:120a with SMTP id
 d10-20020a170902ceca00b0019b0c2d120amr1576163plg.22.1677081467398; Wed, 22
 Feb 2023 07:57:47 -0800 (PST)
MIME-Version: 1.0
References: <20230220134308.1193219-1-dwysocha@redhat.com> <CAPt2mGPJxPWfFGtEacBw-AN5nMZfP_pvL6=wEM+QbrPf1brAFg@mail.gmail.com>
In-Reply-To: <CAPt2mGPJxPWfFGtEacBw-AN5nMZfP_pvL6=wEM+QbrPf1brAFg@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 22 Feb 2023 10:57:11 -0500
Message-ID: <CALF+zOmcROD6tzSCixYQN-+hw8bpboTrF-Ff-hEZOMDAPe7BOA@mail.gmail.com>
Subject: Re: [PATCH v11 0/5] Convert NFS with fscache to the netfs API
To:     Daire Byrne <daire@dneg.com>
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>, linux-nfs@vger.kernel.org,
        linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Daire!  Did this also resolve the issue with
/proc/PID/io/read_bytes you reported (link below)
since netfs should increment that count now?

https://lore.kernel.org/linux-nfs/CAPt2mGNEYUk5u8V4abe=5MM5msZqmvzCVrtCP4Qw1n=gCHCnww@mail.gmail.com/



On Wed, Feb 22, 2023 at 7:51 AM Daire Byrne <daire@dneg.com> wrote:
>
> Dave,
>
> Thanks for this! I have been testing it with our production (render
> farm) loads for the last couple of days and have not run into any
> issues so far. It seems to be performing on par with your previous
> version of the patchset (based on v6.0).
>
> I am also running with both the "known issues" dhowells patches [8] &
> [9] mentioned in your email (as I was with your previous version).
>
> Tested-by: Daire Byrne <daire@dneg.com>
>
>
>
> On Mon, 20 Feb 2023 at 13:44, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > Trond, this v11 patchset addresses your latest feedback on patch #2,
> > and I did a little bit of cleanup to patch 3 (see Changes notes below).
> > I'm not sure of further changes to patch #3 without a more in-depth
> > review with specifics, if you feel the current approach is unacceptable [1].
> >
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
> > https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b7552eff26eb5da1f2282d35616
> >
> > Changes since v10 [6]
> > =====================
> > PATCH6: Dropped
> > PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
> > PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode (Trond) [7]
> > PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlock()
> >
> > Testing
> > =======
> > I did a full round of testing on this because it was rebased on top of
> > Trond's testing branch which included his folio series.
> > All of my unit tests pass except the one with the known issue #1 below.
> > Multiple runs of xfstests generic tests (applicable to NFS) were run with
> > with various servers, both with and without fscache enabled, and
> > compared to baseline (Trond's testing branch).  No new failures were
> > observed with these patches, and in some xfstest instances, this
> > patchset improves the results (some tests that were failing now pass).
> > - hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
> > - NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
> > - RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3
> >
> > Known issues
> > ============
> > 1. Unit test setting rsize < readahead does not properly read from
> > fscache but re-reads data from the NFS server
> > * This will be fixed with another dhowells patch [8]:
> >   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when folio removed from pagecache"
> > * Daire Byrne verified the patch fixes his issue as well
> >
> > 2. "Cache volume key already in use" after xfstest runs involving multiple mounts
> > * Simple reproducer requires just two mounts as follows:
> >  mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp1 /mnt1
> >  mount -overs=4.1,fsc,nosharecache -o context=system_u:object_r:root_t:s0  nfs-server:/exp2 /mnt2
> > * This should be fixed with dhowells patch [9]:
> >   "[PATCH v5] vfs, security: Fix automount superblock LSM init problem, preventing NFS sb sharing"
> >
> >
> > References
> > ==========
> > [1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b44551d6a0d021dc.camel@kernel.org/
> > [2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
> > [3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
> > [4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E980F8B310@oracle.com/
> > [5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f7XxRj+xS3NVxcJ+b8AAKQg@mail.gmail.com/
> > [6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwysocha@redhat.com/
> > [7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5f2414c18e1f.camel@kernel.org/
> > [8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@redhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> > [9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyon.org.uk/
> >
> > Dave Wysochanski (5):
> >   NFS: Rename readpage_async_filler to nfs_read_add_folio
> >   NFS: Configure support for netfs when NFS fscache is configured
> >   NFS: Convert buffered read paths to use netfs when fscache is enabled
> >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
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
>

