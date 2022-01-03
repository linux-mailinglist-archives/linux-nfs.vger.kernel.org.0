Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA1E483812
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 21:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiACUvE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 15:51:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiACUvE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 15:51:04 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E837C061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 12:51:03 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 50ACB7099; Mon,  3 Jan 2022 15:51:03 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 50ACB7099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641243063;
        bh=7vJhF6SVGoKXarItZaxycL/mQiRLX4XEJWOZZhW2mx0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=Wzh0xtR9wXXAACJtDlV4sEIbqMJpn0BzzzK+aL+Hf1+k1685K0ij9Q2nVK2AT6BhS
         jP6iAYf6BmbTl2fw23wJcmr44qvHUMW5YSuRRNwIboOjDAIUTqVZh9Km5SdfcAcRhC
         h7nVWqcTL+jygxXVObCtej56XN4zV15AUwHb3UZM=
Date:   Mon, 3 Jan 2022 15:51:03 -0500
To:     trondmy@kernel.org
Cc:     Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
Message-ID: <20220103205103.GI21514@fieldses.org>
References: <20211217204854.439578-1-trondmy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211217204854.439578-1-trondmy@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 17, 2021 at 03:48:46PM -0500, trondmy@kernel.org wrote:
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> 
> NFSv4 has support for a number of extra attributes that are of interest
> to Samba when it is used to re-export a filesystem to Windows clients.
> Aside from the btime, which is of interest in statx(), Windows clients
> have an interest in determining the status of the 'hidden', and 'system'
> flags.
> Backup programs want to read the 'archive' flags and the 'time backup'
> attribute.
> Finally, the 'offline' flag can tell whether or not a file needs to be
> staged by an HSM system before it can be read or written to.
> 
> The patch series also adds an ioctl() to allow userspace retrieval and
> setting of these attributes where appropriate. It also adds an ioctl()
> to allow retrieval of the raw NFSv4 ACCESS information, to allow more
> fine grained determination of the user's access rights to a file or
> directory. All of this information is of use for Samba.

Same question, what filesystem and server are you testing against?

--b.

> 
> Anne Marie Merritt (3):
>   nfs: Add timecreate to nfs inode
>   nfs: Add 'archive', 'hidden' and 'system' fields to nfs inode
>   nfs: Add 'time backup' to nfs inode
> 
> Richard Sharpe (1):
>   NFS: Support statx_get and statx_set ioctls
> 
> Trond Myklebust (4):
>   NFS: Expand the type of nfs_fattr->valid
>   NFS: Return the file btime in the statx results when appropriate
>   NFSv4: Support the offline bit
>   NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask
> 
>  fs/nfs/dir.c              |  71 ++---
>  fs/nfs/getroot.c          |   3 +-
>  fs/nfs/inode.c            | 147 +++++++++-
>  fs/nfs/internal.h         |  10 +
>  fs/nfs/nfs3proc.c         |   1 +
>  fs/nfs/nfs4_fs.h          |  31 +++
>  fs/nfs/nfs4file.c         | 550 ++++++++++++++++++++++++++++++++++++++
>  fs/nfs/nfs4proc.c         | 175 +++++++++++-
>  fs/nfs/nfs4trace.h        |   8 +-
>  fs/nfs/nfs4xdr.c          | 240 +++++++++++++++--
>  fs/nfs/nfstrace.c         |   5 +
>  fs/nfs/nfstrace.h         |   9 +-
>  fs/nfs/proc.c             |   1 +
>  include/linux/nfs4.h      |   1 +
>  include/linux/nfs_fs.h    |  15 ++
>  include/linux/nfs_fs_sb.h |   2 +-
>  include/linux/nfs_xdr.h   |  80 ++++--
>  include/uapi/linux/nfs.h  | 101 +++++++
>  18 files changed, 1356 insertions(+), 94 deletions(-)
> 
> -- 
> 2.33.1
