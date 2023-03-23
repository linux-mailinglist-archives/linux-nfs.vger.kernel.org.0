Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51026C6FAF
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Mar 2023 18:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjCWRv2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 Mar 2023 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCWRv1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 23 Mar 2023 13:51:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03A61CAF9
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679593838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJXAfUg8lo5eiFTUV2F0zyb6/OMKPB/p1phXxmrLWt8=;
        b=PP1uCasyAVI4SLVbLnHJX3BH0Cc3Mo/WvgWUPC1UGihElS3/2M/+eRRB9bbanAY+LPRdm4
        VeN/T99JfSLRzkoxyW09zzGsFbyLrp3aOmypkRaIzOYvYSIavoDsp0ZB6AsXCqZ/CKSOQr
        NZ47Ntk0rsZEr66ph8TMs9UgaeUKngQ=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-nDDHcamrNtqboK_0k08fig-1; Thu, 23 Mar 2023 13:50:37 -0400
X-MC-Unique: nDDHcamrNtqboK_0k08fig-1
Received: by mail-vs1-f72.google.com with SMTP id p27-20020a05610223fb00b00425b0a40455so6273901vsc.8
        for <linux-nfs@vger.kernel.org>; Thu, 23 Mar 2023 10:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679593833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJXAfUg8lo5eiFTUV2F0zyb6/OMKPB/p1phXxmrLWt8=;
        b=lpuguhF/8aQ7z2hdG54J+WjO+PqdNJ3wB7zlwBXqr7g8pwsVmL2PqH/QwmV0/G+LWT
         LwgD6sLqu4UYax0WLy8jJZa23UUIKMDqrPFVYvsZ1BmOiiwDShYhXEBjZsbKcKONuo7a
         TDj1kMYOxkR59Oi15xhgdNFlChrm/tC7xy/Pt5zbeygmZEYeY8kfAUZpAzmY+T8VyqiD
         uyRSH7+MTHHOuDR5ZIavKP18VpaKHdPGiQbWZw6pBU4eVGmFgXFrcoJCGGG2Jq/0zp9f
         CnUfzwI/+sfmKIEIvkG0oFrTzFYwxrZD2Esgh1XWVOTgZu2e1LbLgtX8nGDOHjl78Gis
         CQNg==
X-Gm-Message-State: AAQBX9f5L2B3/5HVDkfgWRsfqqNgfyFsrogG47scZdG6OMxtX/bxjdet
        qZoLgT+76HSGjkkj3fzHmRC86MuVhdapyQUm9ZXve3iDJIx3DoX3Kxgs77Sjyk0yv/a7TFOO/Je
        m93w0ZoIiu6k4D9HxIRDxZh8j7kpyNy8/mcIi
X-Received: by 2002:a05:6130:a6:b0:740:714f:aa5d with SMTP id x38-20020a05613000a600b00740714faa5dmr6499600uaf.0.1679593833247;
        Thu, 23 Mar 2023 10:50:33 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZknsEbUDfiavtw+znx9EtFCVU4si0qeGoK+LNbUhZg27p6Me97Ovza8x4J/ffqsSK7vpl4R7RAM9wTw1Un38k=
X-Received: by 2002:a05:6130:a6:b0:740:714f:aa5d with SMTP id
 x38-20020a05613000a600b00740714faa5dmr6499582uaf.0.1679593832912; Thu, 23 Mar
 2023 10:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230220134308.1193219-1-dwysocha@redhat.com>
In-Reply-To: <20230220134308.1193219-1-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 23 Mar 2023 13:49:55 -0400
Message-ID: <CALF+zOnr0B2w-0jY4DK6Asgb8m2g9d9hecR0mgw6wausaEEaSA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v11 0/5] Convert NFS with fscache to the
 netfs API
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>,
        Benjamin Maynard <benmaynard@google.com>,
        Daire Byrne <daire.byrne@gmail.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Feb 20, 2023 at 8:43=E2=80=AFAM Dave Wysochanski <dwysocha@redhat.c=
om> wrote:
>
> Trond, this v11 patchset addresses your latest feedback on patch #2,
> and I did a little bit of cleanup to patch 3 (see Changes notes below).
> I'm not sure of further changes to patch #3 without a more in-depth
> review with specifics, if you feel the current approach is unacceptable [=
1].
>

Trond and/or Anna,

Have you had a chance to review this patchset and do you have further
concerns?

Note that patch #3 will require a small fixup to apply after v6.3-rc1
due to this commit:
8bb7cd842c44 nfs: use bvec_set_page to initialize bvecs

There is also still the small open issue of netfs counting read_bytes
in its unlock page path, but I view that as a netfs issue.  I'll followup
with David Howells on that.


> Ben and Daire, if you could test this set and provide you feedback
> and a Tested-By: that would be appreciated.  This set addresses
> the existing NFS + fscache performance concerns seen by a few
> users [5], which is due to utilization use of the deprecated
> single-page function, fscache_fallback_read_page().  However,
> until "known issue #1" below is also resolved, even with these
> patches, performance of NFS+fscache will still be a problem
> in some scenarios.
>
> This patchset converts NFS with fscache buffered read IO paths to
> use the netfs API with a non-invasive approach.  The existing NFS pgio
> layer does not need extensive changes, and is the best way so far I've
> found to address Trond's previous concerns about modifying the IO
> path [2] as well as only enabling netfs when fscache is configured
> and enabled [3].  I have not attempted performance comparisions to
> address Chuck Lever's concern [4] because we are not converting the
> non-fscache enabled NFS IO paths to netfs.
>
> The patchset is based on Trond's latest 'testing' branch which includes
> his folio patchset, and is based on 6.2-rc5.  It has been pushed to
> github at:
> https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> https://github.com/DaveWysochanskiRH/kernel/commit/6424e4f139652b7552eff2=
6eb5da1f2282d35616
>
> Changes since v10 [6]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> PATCH6: Dropped
> PATCH1: Rename nfs_pageio_add_page to nfs_read_add_folio
> PATCH2: Use anonymous union to add struct netfs_inode to nfs_inode (Trond=
) [7]
> PATCH3: Change nfs_netfs_readpage_release() to nfs_netfs_folio_unlock()
>
> Testing
> =3D=3D=3D=3D=3D=3D=3D
> I did a full round of testing on this because it was rebased on top of
> Trond's testing branch which included his folio series.
> All of my unit tests pass except the one with the known issue #1 below.
> Multiple runs of xfstests generic tests (applicable to NFS) were run with
> with various servers, both with and without fscache enabled, and
> compared to baseline (Trond's testing branch).  No new failures were
> observed with these patches, and in some xfstest instances, this
> patchset improves the results (some tests that were failing now pass).
> - hammerspace(pNFS flexfiles): NFS4.1, NFS4.2
> - NetApp(pNFS filelayout): NFS4.1, NFS4.0, NFS3
> - RHEL9: NFS4.2, NFS4.1, NFS4.0, NFS3
>
> Known issues
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Unit test setting rsize < readahead does not properly read from
> fscache but re-reads data from the NFS server
> * This will be fixed with another dhowells patch [8]:
>   "[PATCH v6 2/2] mm, netfs, fscache: Stop read optimisation when folio r=
emoved from pagecache"
> * Daire Byrne verified the patch fixes his issue as well
>
> 2. "Cache volume key already in use" after xfstest runs involving multipl=
e mounts
> * Simple reproducer requires just two mounts as follows:
>  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r:root_=
t:s0  nfs-server:/exp1 /mnt1
>  mount -overs=3D4.1,fsc,nosharecache -o context=3Dsystem_u:object_r:root_=
t:s0  nfs-server:/exp2 /mnt2
> * This should be fixed with dhowells patch [9]:
>   "[PATCH v5] vfs, security: Fix automount superblock LSM init problem, p=
reventing NFS sb sharing"
>
>
> References
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [1] https://lore.kernel.org/linux-nfs/0676ecb2bb708e6fc29dbbe6b44551d6a0d=
021dc.camel@kernel.org/
> [2] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d6=
7f595.camel@hammerspace.com/
> [3] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb=
028fb.camel@hammerspace.com/
> [4] https://lore.kernel.org/linux-nfs/0A640C47-5F51-47E8-864D-E0E980F8B31=
0@oracle.com/
> [5] https://lore.kernel.org/linux-nfs/CA+QRt4tPqH87NVkoETLjxieGjZ_f7XxRj+=
xS3NVxcJ+b8AAKQg@mail.gmail.com/
> [6] https://lore.kernel.org/linux-nfs/20221103161637.1725471-1-dwysocha@r=
edhat.com/
> [7] https://lore.kernel.org/linux-nfs/4d60636f62df4f5c200666ed2d1a5f2414c=
18e1f.camel@kernel.org/
> [8] https://lore.kernel.org/linux-nfs/20230216150701.3654894-1-dhowells@r=
edhat.com/T/#mf3807fa68fb6d495b87dde0d76b5237833a0cc81
> [9] https://lore.kernel.org/linux-kernel/217595.1662033775@warthog.procyo=
n.org.uk/
>
> Dave Wysochanski (5):
>   NFS: Rename readpage_async_filler to nfs_read_add_folio
>   NFS: Configure support for netfs when NFS fscache is configured
>   NFS: Convert buffered read paths to use netfs when fscache is enabled
>   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
>   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
>
>  fs/nfs/Kconfig             |   1 +
>  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
>  fs/nfs/fscache.h           | 131 ++++++++++++++------
>  fs/nfs/inode.c             |   2 +
>  fs/nfs/internal.h          |   9 ++
>  fs/nfs/iostat.h            |  17 ---
>  fs/nfs/nfstrace.h          |  91 --------------
>  fs/nfs/pagelist.c          |   4 +
>  fs/nfs/read.c              | 105 ++++++++--------
>  fs/nfs/super.c             |  11 --
>  include/linux/nfs_fs.h     |  25 ++--
>  include/linux/nfs_iostat.h |  12 --
>  include/linux/nfs_page.h   |   3 +
>  include/linux/nfs_xdr.h    |   3 +
>  14 files changed, 317 insertions(+), 339 deletions(-)
>
> --
> 2.31.1
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

