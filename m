Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D473183A63
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Mar 2020 21:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgCLUKJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Mar 2020 16:10:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38821 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLUKJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 12 Mar 2020 16:10:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id h5so9107600edn.5
        for <linux-nfs@vger.kernel.org>; Thu, 12 Mar 2020 13:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VoEV9KU4GDwxNzE6DaMukdb0OGqUdZoDKsktfpqE534=;
        b=P4SGh1yBjpoIyaFig/VWclVnLLn6ZkwowllSCgV7rk9FAJZAK5z1ajBsLJNHy7iSWk
         Xu35oa5q59S0roTbdq45HMm8IhZ6iQ4Tqw9bFb7Z+EWVAOgqD13Z+QAiK/bBfpdbGZoh
         y5/D9VXvcSeM17hJ5vFzkjwY9+ffcxv6jfskpHVZ1KC//T4pvstueBdliuH39gECL0e3
         IuD+jCJWgsInT3j3ukS8xvjiDCpqjJkzR4YG1b3mC9itkOH09XCDBgWl5sy/WUkMiR9J
         0Ibvv6bKfO3RyQT5yTcla8Aq8Tg6y+3+85Qj8Gp3v7UGcFD2MHe6yDE8lrSycujUnMs5
         MNYw==
X-Gm-Message-State: ANhLgQ2DiPRI/GXyVOI0QKVTagVJA1cvf/aJJgrVsWXyvAoJHrfnSXGw
        nMIUb89NoKp7kp1OWQJISAzrLe1eFij6g43htrE=
X-Google-Smtp-Source: ADFU+vvNstilYnHidtaKbpuusziWj7FNpHPd1dnYiMB41lAn2sP/CmLWQWZMnPL1GMWxstpqVm3Nu+AoPRpcDRq3ew8=
X-Received: by 2002:a05:6402:161a:: with SMTP id f26mr9300772edv.264.1584043807883;
 Thu, 12 Mar 2020 13:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200311195613.26108-1-fllinden@amazon.com>
In-Reply-To: <20200311195613.26108-1-fllinden@amazon.com>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 12 Mar 2020 16:09:51 -0400
Message-ID: <CAFX2Jf=g2Pv62cnciB4VG6HTndJSrtfeSR_oVu9PmiBez8_Upw@mail.gmail.com>
Subject: Re: [PATCH 00/13] client side user xattr (RFC8276) support
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     trond.myklebust@hammerspace.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Frank,

On Wed, Mar 11, 2020 at 3:57 PM Frank van der Linden
<fllinden@amazon.com> wrote:
>
> This patchset implements the client side for NFS user extended attributes,
> as defined in RFC8726.
>
> This was originally posted as an RFC in:
>
> https://patchwork.kernel.org/cover/11143565/
>
> Patch 1 is shared with the server side patch, posted
> separately.
>
> Most comments in there still apply, except that:
>
> 1. Client side caching is now included in this patch set.
> 2. As per the discussion, user extended attributes are enabled if
>    the client and server support them (e.g. they support 4.2 and
>    advertise the user extended attribute FATTR). There are no longer
>    options to switch them off on either the client or the server.
> 3. The code is no longer conditioned on a config option.
> 4. The number of patches has been reduced somewhat by merging
>    smaller, related ones.
>
> The client side caching is implemented through a per-inode hash table,
> which is allocated on demand. See fs/nfs/nfs42xattr.c for details.
>
> This has been tested as follows:
>
> * Linux client and server:
>         * Test all corner cases (XATTR_SIZE_*)
>         * Test all failure cases (no xattr, setxattr with different or
>           invalid flags, etc).
>         * Verify the content of xattrs across several operations.
>         * Use KASAN and KMEMLEAK for a longer mix of testruns to verify
>           that there were no leaks (after unmounting the filesystem).
>         * Stress tested caching, trying to run the client out of memory.

I'm curious if you've tried xfstests with your patches? There are a
handful of tests using xattrs that might be good to check with, too:

anna@gouda % grep xattr -l tests/generic/[0-9][0-9][0-9]
tests/generic/037
tests/generic/062
tests/generic/066
tests/generic/093
tests/generic/117
tests/generic/337
tests/generic/377
tests/generic/403
tests/generic/425
tests/generic/454
tests/generic/489
tests/generic/523
tests/generic/529
tests/generic/556

Thanks,
Anna


>
> * Tested against the FreeBSD-current implementation as well, which works
>   (after I fixed 2 bugs in that implementation, which I'm sending out to
>   them too).
>
> * Not tested: RDMA (I couldn't get a setup going).
>
> Frank van der Linden (13):
>   nfs,nfsd:  NFSv4.2 extended attribute protocol definitions
>   nfs: add client side only definitions for user xattrs
>   NFSv4.2: query the server for extended attribute support
>   NFSv4.2: define limits and sizes for user xattr handling
>   NFSv4.2: add client side XDR handling for extended attributes
>   nfs: define nfs_access_get_cached function
>   NFSv4.2: query the extended attribute access bits
>   nfs: modify update_changeattr to deal with regular files
>   nfs: define and use the NFS_INO_INVALID_XATTR flag
>   nfs: make the buf_to_pages_noslab function available to the nfs code
>   NFSv4.2: add the extended attribute proc functions.
>   NFSv4.2: hook in the user extended attribute handlers
>   NFSv4.2: add client side xattr caching.
>
>  fs/nfs/Makefile             |    1 +
>  fs/nfs/client.c             |   19 +-
>  fs/nfs/dir.c                |   24 +-
>  fs/nfs/inode.c              |   16 +-
>  fs/nfs/internal.h           |   28 ++
>  fs/nfs/nfs42.h              |   24 +
>  fs/nfs/nfs42proc.c          |  248 ++++++++++
>  fs/nfs/nfs42xattr.c         | 1083 +++++++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfs42xdr.c           |  442 ++++++++++++++++++
>  fs/nfs/nfs4_fs.h            |    5 +
>  fs/nfs/nfs4client.c         |   31 ++
>  fs/nfs/nfs4proc.c           |  248 ++++++++--
>  fs/nfs/nfs4super.c          |   10 +
>  fs/nfs/nfs4xdr.c            |   29 ++
>  fs/nfs/nfstrace.h           |    3 +-
>  include/linux/nfs4.h        |   25 +
>  include/linux/nfs_fs.h      |   12 +
>  include/linux/nfs_fs_sb.h   |    6 +
>  include/linux/nfs_xdr.h     |   60 ++-
>  include/uapi/linux/nfs4.h   |    3 +
>  include/uapi/linux/nfs_fs.h |    1 +
>  21 files changed, 2276 insertions(+), 42 deletions(-)
>  create mode 100644 fs/nfs/nfs42xattr.c
>
> --
> 2.16.6
>
