Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47EC83E82F2
	for <lists+linux-nfs@lfdr.de>; Tue, 10 Aug 2021 20:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhHJSZm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 10 Aug 2021 14:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbhHJSZB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 10 Aug 2021 14:25:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF2AC06C568
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 11:19:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id k9so14248062edr.10
        for <linux-nfs@vger.kernel.org>; Tue, 10 Aug 2021 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UdlWaxo4IuikHDnj+68bnfoOJGDDkAqrwTOUu9luTG0=;
        b=BAazC4kR8iUbtlZVYC3D4KJlskrUzbVxbMuRmp+GAURCgKIlDAqZXM51IlwDEm9hup
         eAJ9S8aJGg1pAWQBghyFBbp11Db3gMMsRV/8CwMtI6wCcdulSkhOgOHMCiiILzMeqHpW
         ZWZ5wBnWSkqZhFgsMJbmDPWLZlSzeWMokSkXDV6iOyKmSKjjwk40rnMyGIeJ1IUm9YiX
         yjoaj4Ov/aVBOE4DXGDi8VcKUMCeUgAMQEJxv43g+zNgaUgdBLB9iusb/HmBRyBGbVgf
         hWCEYoD4FjEblSuEw3g4Eg0DUFhj+fhVSmu8sr7qLQusmbb8k4cZWVyrOk3BbIJzL65t
         tyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UdlWaxo4IuikHDnj+68bnfoOJGDDkAqrwTOUu9luTG0=;
        b=B3E2BnwuVoqji+DrR1roiEnyiZEHYhMD04B4KsucXzmOMZi3z9Q5UiyxuYX/ZF2CY/
         /0zOpKk/MrEnnsqgjfQlpvCVjydzwRqUHBLCb5zljttySLCG3A/F41gyrq7e8FbmPA0y
         8EsuUvTO4nYIX8LruY+3UHUpXdeRU0BB0QVWzTdoUbGYuXaodF9c2eHBEuRfTgWziJTu
         nzshJTFDCSYS160rBSOnSY4/T2RXtljPBWu8Qm6NF7laJo8bV2aj6NNxw4I4dxkuIseo
         3cLoigp8c/lA8u7LRzoZYzYEKDl7JFWpxhkE7siQmGtXU/aMfP7TLSRw2tEdxqq2Cpkl
         ZzMw==
X-Gm-Message-State: AOAM533xaQiTQg7TwoXV1Xs59bbeP+KhmqWeR/P45tZfGNXtsiLX/j8Y
        hH5z0KsSHeLMivVVLT1xbrnwugO2CGZRbh7069c=
X-Google-Smtp-Source: ABdhPJwlB9xR8kmTt4ckCWx1hpcPUGNxymEUa1DoiUWL22yNp/x+k7cxKuaohLU3KWDq4M/2J0aM5az7jB7t/o+qj2w=
X-Received: by 2002:a05:6402:1206:: with SMTP id c6mr6520486edw.264.1628619562677;
 Tue, 10 Aug 2021 11:19:22 -0700 (PDT)
MIME-Version: 1.0
References: <162637843471.728653.5920517086867549998.stgit@manet.1015granger.net>
 <02B12E59-E014-4CF6-9A5B-58E5F426F964@oracle.com> <CAFX2JfkSG5Qe4_svtunwRhMvwdN=bNP0VtuSFtU6siDihjWpZA@mail.gmail.com>
 <BA8CF63B-5328-42C3-AE69-92766C0EF556@oracle.com>
In-Reply-To: <BA8CF63B-5328-42C3-AE69-92766C0EF556@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Tue, 10 Aug 2021 14:19:06 -0400
Message-ID: <CAFX2JfkMXTsvKsgGb0iJ9noAmTCZk63Nix5utfXsR=EqK5DV6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] XDR overhaul of NFS callback service
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Aug 10, 2021 at 2:16 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Aug 10, 2021, at 2:01 PM, Anna Schumaker <schumaker.anna@gmail.com> wrote:
> >
> > Hi Chuck,
> >
> > On Fri, Jul 30, 2021 at 3:53 PM Chuck Lever III <chuck.lever@oracle.com> wrote:
> >>
> >> Hi Trond-
> >>
> >>> On Jul 15, 2021, at 3:52 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
> >>>
> >>> Trond, please let me know if you want to take these or if I may
> >>> handle them through the NFSD tree for v5.15. Thanks.
> >>
> >> I've included these in the NFSD for-next topic branch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=for-next
> >>
> >> They can be removed if you would like to take them through
> >> your tree instead.
> >
> > These look to be mostly client-side changes, so it would make sense to
> > take them through the NFS tree. Would that cause problems now that
> > they've been in your for-next branch for a while?
>
> I've dropped them.

And I've added them. Thanks!

Anna

>
>
> > Anna
> >
> >>
> >> If I am to take these, Bruce and I would like an Acked-by:
> >> from you.
> >>
> >>
> >>> The purpose of this series is to prepare for the optimization of
> >>> svc_process_common() to handle NFSD workloads more efficiently. In
> >>> other words, NFSD should be the lubricated common case, and callback
> >>> is the use case that takes exceptional paths.
> >>>
> >>> Changes since RFC:
> >>> - Removed RQ_DROPME test from nfs_callback_dispatch()
> >>> - Restored .pc_encode call-outs to prevent dropped replies
> >>> - Fixed whitespace damage
> >>>
> >>> ---
> >>>
> >>> Chuck Lever (7):
> >>>     SUNRPC: Add svc_rqst::rq_auth_stat
> >>>     SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
> >>>     SUNRPC: Eliminate the RQ_AUTHERR flag
> >>>     NFS: Add a private local dispatcher for NFSv4 callback operations
> >>>     NFS: Remove unused callback void decoder
> >>>     NFS: Extract the xdr_init_encode/decode() calls from decode_compound
> >>>     NFS: Clean up the synopsis of callback process_op()
> >>>
> >>>
> >>> fs/lockd/svc.c                    |  2 +
> >>> fs/nfs/callback.c                 |  4 ++
> >>> fs/nfs/callback_xdr.c             | 61 ++++++++++++++++---------------
> >>> include/linux/sunrpc/svc.h        |  3 +-
> >>> include/linux/sunrpc/svcauth.h    |  4 +-
> >>> include/trace/events/sunrpc.h     |  9 ++---
> >>> net/sunrpc/auth_gss/svcauth_gss.c | 47 +++++++++++++-----------
> >>> net/sunrpc/svc.c                  | 39 ++++++--------------
> >>> net/sunrpc/svcauth.c              |  8 ++--
> >>> net/sunrpc/svcauth_unix.c         | 18 +++++----
> >>> 10 files changed, 96 insertions(+), 99 deletions(-)
> >>>
> >>> --
> >>> Chuck Lever
> >>>
> >>
> >> --
> >> Chuck Lever
>
> --
> Chuck Lever
>
>
>
