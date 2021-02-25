Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02030325986
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Feb 2021 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbhBYWTN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Feb 2021 17:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhBYWR7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Feb 2021 17:17:59 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C8CDC061788
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 14:17:04 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id cf12so7958159edb.8
        for <linux-nfs@vger.kernel.org>; Thu, 25 Feb 2021 14:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Dj1l3CLesHckRpCiYdbWEyp1aCRlGYtCamIMKd+9tUg=;
        b=Ro9OpODrWid3i8rah0tF1OIkKUnps4VOYMbIpcljasQrhC4LN9f9PLx8QChMxVYqOM
         g+Wo3YeBwrDcfR1llSld/rBCHLj9MlG0el2i8PUMsluHzHuqdk9zpP2uszy/gVtuG0SE
         6muSwWoieVPkGa6SDn59pz0QyBH42QfK9tTOIPU4dT30vwFpRHXOtIsplGsJJwF1XDCV
         auG039f36tlht+BkupjXj0cRwL0rBnP8AGHzK0qKEphhrm/6LIVMTH2Q/1/6blXIkAZs
         DdCIo8MkTjqzqf0sJD9v6kptGFolOh/nQkWv5Nd28BRNJb7oiy1C227VqFwJeXXP7s4P
         oPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Dj1l3CLesHckRpCiYdbWEyp1aCRlGYtCamIMKd+9tUg=;
        b=E1aNKZa/9mTAaJ4j4NOJIZ8Ox03IQlnKKP2N8B+Oh7Td1K73htyHW+98Q8vs2gx3cO
         TISNEf7esFC+uZmEJ540SpZX1RBZjJrWoSFBDKrinn2dIc55GJeeeUrm5EFHUD7gaL5m
         1TiaYUmO85xrJT4IhWhVYhwit/im89rpdS/NMtT8E9ruMcriQwmvrWgV8jfBM/aJENIa
         CAN+yayr1rUpR4U7O97GzVBH+3oQQcOLKwJec0E7gUEo5zyNjvxFyVA7vFMZ7olxOGz6
         yWEVOTUmKMMyPCyWpIDqs6hEXp5q+RO3gVSdH0QxUqz0Cc6voWK3iEQ6xVaBHyJ3O+0t
         WXIA==
X-Gm-Message-State: AOAM530lDPEc3ibRRaIg7lC3K6iRbRxJ897QtZgVSWfsiTx4F2i4osvW
        CHanJwnFC0v64PXjnSy3/F5bUvGxVQsG6dXUdOqQzgTj0Go=
X-Google-Smtp-Source: ABdhPJy1lQO5EZfLd3yHOb/3CTSd6Yo32ptsO/oy4X254puIPfyQ/Q9HeHe1DuIaOK3sI/Pj+YX0aK/bjJd2wnXpirE=
X-Received: by 2002:aa7:d451:: with SMTP id q17mr93746edr.381.1614291422283;
 Thu, 25 Feb 2021 14:17:02 -0800 (PST)
MIME-Version: 1.0
References: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
In-Reply-To: <CAFX2JfnuPuE7Bd5nAwgwrVQQ84vAMVwpPf0SFZFTwpX0rib+Hg@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 25 Feb 2021 17:16:46 -0500
Message-ID: <CAFX2Jf=SXFy4PbWBGJeFUq5TQbVXpYMNZL8B=kckN_tFX-j01w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull NFS Client Updates for Linux 5.12
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

Sorry to bother you since I know you're busy. I haven't seen this get
pulled yet, and I'm worried it's slipped through the cracks since
we're getting close to the end of the merge window.

Thanks,
Anna

On Fri, Feb 19, 2021 at 5:19 PM Anna Schumaker <schumaker.anna@gmail.com> wrote:
>
> Hi Linus,
>
> The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:
>
>   Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)
>
> are available in the Git repository at:
>
>   git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.12-1
>
> for you to fetch changes up to 7ae017c7322e2b12472033e65a48aa25cde2fb22:
>
>   NFS: Support the '-owrite=' option in /proc/self/mounts and
> mountinfo (2021-02-17 15:36:03 -0500)
>
> ----------------------------------------------------------------
> - New Features:
>   - Support for eager writes, and the write=eager and write=wait mount options
>
> - Other Bugfixes and Cleanups:
>   - Fix typos in some comments
>   - Fix up fall-through warnings for Clang
>   - Cleanups to the NFS readpage codepath
>   - Remove FMR support in rpcrdma_convert_iovs()
>   - Various other cleanups to xprtrdma
>   - Fix xprtrdma pad optimization for servers that don't support RFC 8797
>   - Improvements to rpcrdma tracepoints
>   - Fix up nfs4_bitmask_adjust()
>   - Optimize sparse writes past the end of files
>
> Thanks,
> Anna
> ----------------------------------------------------------------
> Bhaskar Chowdhury (1):
>       net: sunrpc: xprtsock.c: Corrected few spellings ,in comments
>
> Calum Mackay (1):
>       SUNRPC: correct error code comment in xs_tcp_setup_socket()
>
> Chuck Lever (7):
>       xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
>       xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
>       xprtrdma: Refactor invocations of offset_in_page()
>       rpcrdma: Fix comments about reverse-direction operation
>       xprtrdma: Pad optimization, revisited
>       rpcrdma: Capture bytes received in Receive completion tracepoints
>       xprtrdma: Clean up rpcrdma_prepare_readch()
>
> Dave Wysochanski (5):
>       NFS: Clean up nfs_readpage() and nfs_readpages()
>       NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read succeeds
>       NFS: Refactor nfs_readpage() and nfs_readpage_async() to use nfs_readdesc
>       NFS: Call readpage_async_filler() from nfs_readpage_async()
>       NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
>
> Gustavo A. R. Silva (2):
>       SUNRPC: Fix fall-through warnings for Clang
>       nfs: Fix fall-through warnings for Clang
>
> Menglong Dong (1):
>       fs/nfs: remove duplicate include
>
> Trond Myklebust (10):
>       NFSv4: Fixes for nfs4_bitmask_adjust()
>       NFS: Fix documenting comment for nfs_revalidate_file_size()
>       NFS: Optimise sparse writes past the end of file
>       NFS: Always clear an invalid mapping when attempting a buffered write
>       NFS: Don't set NFS_INO_INVALID_XATTR if there is no xattr cache
>       NFS: 'flags' field should be unsigned in struct nfs_server
>       NFS: Add support for eager writes
>       NFS: Add mount options supporting eager writes
>       NFS: Set the stable writes flag when initialising the super block
>       NFS: Support the '-owrite=' option in /proc/self/mounts and mountinfo
>
>  fs/nfs/file.c                              |  27 +++++++++++++++++++++------
>  fs/nfs/fs_context.c                        |  35
> +++++++++++++++++++++++++++++++++++
>  fs/nfs/fscache.c                           |   4 ----
>  fs/nfs/inode.c                             | 111
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
>  fs/nfs/nfs3acl.c                           |   1 +
>  fs/nfs/nfs4client.c                        |   1 +
>  fs/nfs/nfs4proc.c                          |  21 ++++++++++-----------
>  fs/nfs/nfs4state.c                         |   1 +
>  fs/nfs/pnfs.c                              |   2 ++
>  fs/nfs/read.c                              | 206
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------------------------------------------------------------------------------------------------
>  fs/nfs/super.c                             |   7 +++++++
>  fs/nfs/write.c                             |  37
> ++++++++++++++++++++++++-------------
>  include/linux/nfs_fs.h                     |   3 +--
>  include/linux/nfs_fs_sb.h                  |   4 +++-
>  include/trace/events/rpcrdma.h             |  50
> ++++++++++++++++++++++++++++++++++++++++++++++++--
>  net/sunrpc/rpc_pipe.c                      |   1 +
>  net/sunrpc/xprtrdma/backchannel.c          |   4 ++--
>  net/sunrpc/xprtrdma/frwr_ops.c             |  12 +++---------
>  net/sunrpc/xprtrdma/rpc_rdma.c             |  67
> +++++++++++++++++++------------------------------------------------
>  net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   4 ++--
>  net/sunrpc/xprtrdma/xprt_rdma.h            |  15 ++++++++-------
>  net/sunrpc/xprtsock.c                      |  17 ++++++++---------
>  22 files changed, 357 insertions(+), 273 deletions(-)
