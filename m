Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE5F3F8E71
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Aug 2021 21:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbhHZTGg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Aug 2021 15:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhHZTGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Aug 2021 15:06:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E221BC061757
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:05:46 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id me10so8462070ejb.11
        for <linux-nfs@vger.kernel.org>; Thu, 26 Aug 2021 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UqKbgtXNT9mPX5OQ/yRv5Rr6ZTQMQQVwysMsOInuc9U=;
        b=uRbjCXz8nur8WLYso40yzDJFOuCMtArYBsgnq084VTMyffLfyKJ0eZqYdzLxGbtjU4
         Zcke43f1Rir0aqvBwqJVNUewDOeXcm/6SOltuxGyreUOyYVw8VKHIv48GPcfIq/gnX3F
         VlSSfm0cf16OEvhbW5+BNhYj+a458xmZyg2m4ygXn+WF7PKvzV4LgxEPWDZ/lLYrWzBY
         SV4zyL+NcEAY08cT63FRZuxg+6RQWZZaGVmZkkapHB/ZxvfisPeBcRjnBgCMdmqXBFWC
         rG/sNdOINTuOCpRo09/SmFB/zq5jCNIPUKI2eU/wq+j1eCDTkDrXSZlurwEb4VRI5hGb
         Xv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UqKbgtXNT9mPX5OQ/yRv5Rr6ZTQMQQVwysMsOInuc9U=;
        b=UHgmRxZFZJGX8BP3N8UdA/lXSMf37rOZjwb8XBzkl/dDnrcmxbk8l7hDyetF+xXlUr
         niILo8GlxVGTkvpudeczQTO4t6ALnwwOPsibNWR69Ligvhj7qLPt0Bj5GU9InD8dkxIV
         t11gnx0YDaRLIc5nMtVDy2Vl4bDxDR8f5gI9m8GGuCJWOs4ij9CV/Glp+nz9I88KpvYF
         zOl5c1YwJJXOfZBj1HokB3nfAFfhLtHWiWAQ2CWvvXmpSJ9RDr/UwJNguZiu21a26KmR
         UbrGSUj8gs7mkc0CjYYG1d72UYClBkdmhpctB2MJBoz73I06WYzfK8SVAVaNdgmV16gw
         +5kQ==
X-Gm-Message-State: AOAM5329lFOS0CoyX483OlAsm88dZJaqtgcB3hvphflVB05C8MK6RETb
        cef6ofwN+l3AhdzbR3Gje6hOVIGMVvqRsueCA9M=
X-Google-Smtp-Source: ABdhPJz+oCwkFMk7FuXpZNeadPraQeGyRVwDbPROFRxABnBPOYDzdrpvX2yc55sOX+X6DCvtt85D1/2ChPOEwghI8Y4=
X-Received: by 2002:a17:906:13c4:: with SMTP id g4mr5712090ejc.152.1630004745256;
 Thu, 26 Aug 2021 12:05:45 -0700 (PDT)
MIME-Version: 1.0
References: <1629493326-28336-1-git-send-email-bfields@redhat.com>
In-Reply-To: <1629493326-28336-1-git-send-email-bfields@redhat.com>
From:   Anna Schumaker <schumakeranna@gmail.com>
Date:   Thu, 26 Aug 2021 15:05:28 -0400
Message-ID: <CAFX2JfmB36zQ8dWXCwGmCBWxShXsCyPhR86XT+CRL8ZCZPS0nQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] reexport lock fixes v3
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>, daire@dneg.com,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Aug 20, 2021 at 5:02 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> From: "J. Bruce Fields" <bfields@redhat.com>
>
> The following fix up some problems that can cause crashes or silently
> broken lock guarantees in the reexport case.
>
> Note:
>         - patches 1-5 are server side
>         - patches 6-7 are client side
>         - patch 8 affects both
>
> Simplest might be for Trond or Anna to ACK 6-8, if they look OK, and

They look okay to me. You can add:
        Acked-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
to all three.

Anna

> then submit them all through the server.  But those three sets of
> patches are all independent if you'd rather split them up.
>
> Not fixed:
>         - Attempts to reclaim locks after a reboot of the reexport
>           server will fail.  This at least seems like an improvement
>           over the current situation, which is that they'll succeed even
>           in cases where they shouldn't.  Complete support for reboot
>           recovery is a bigger job.
>
>         - NFSv4.1+ lock nofications don't work.  So, clients have to
>           poll as they do with NFSv4.0, which is suboptimal, but correct
>           (and an improvement over the current situation, which is a
>           kernel oops).
>
> So what we have at this point is a suboptimal lock implementation that
> doesn't support lock recovery.
>
> Another alternative might be to turn off file locking entirely in the
> re-export case.  I'd rather take the incremental improvement and fix the
> oopses.
>
> Change since v2:
>         - keep nlmsvc_file_inode a static inline to address build
>           failure identified by the kernel test robot
> Changes since v1:
>         - Use ENOGRACE instead of returning NFS-specific error from vfs lock
>           method.
>         - Take write opens for write locks in the NLM case (as we always
>           have in the NFSv4 case).
>         - Don't block NLM threads waiting for blocking locks.
>
> With those changes I'm passing connecthon tests for NFSv3-4.2 reexports
> of an NFSv4.0 filesystem.
>
> --b.
>
> J. Bruce Fields (8):
>   lockd: lockd server-side shouldn't set fl_ops
>   nlm: minor nlm_lookup_file argument change
>   nlm: minor refactoring
>   lockd: update nlm_lookup_file reexport comment
>   Keep read and write fds with each nlm_file
>   nfs: don't atempt blocking locks on nfs reexports
>   lockd: don't attempt blocking locks on nfs reexports
>   nfs: don't allow reexport reclaims
>
>  fs/lockd/svc4proc.c         |   6 +-
>  fs/lockd/svclock.c          |  80 ++++++++++++++----------
>  fs/lockd/svcproc.c          |   6 +-
>  fs/lockd/svcsubs.c          | 117 +++++++++++++++++++++++++-----------
>  fs/nfs/export.c             |   2 +-
>  fs/nfs/file.c               |   3 +
>  fs/nfsd/lockd.c             |   8 ++-
>  fs/nfsd/nfs4state.c         |  11 +++-
>  fs/nfsd/nfsproc.c           |   1 +
>  include/linux/errno.h       |   1 +
>  include/linux/exportfs.h    |   2 +
>  include/linux/fs.h          |   1 +
>  include/linux/lockd/bind.h  |   3 +-
>  include/linux/lockd/lockd.h |  11 +++-
>  14 files changed, 170 insertions(+), 82 deletions(-)
>
> --
> 2.31.1
>
