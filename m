Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED1C486A22
	for <lists+linux-nfs@lfdr.de>; Thu,  6 Jan 2022 19:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbiAFSrj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 6 Jan 2022 13:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiAFSrj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 6 Jan 2022 13:47:39 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D282FC061245
        for <linux-nfs@vger.kernel.org>; Thu,  6 Jan 2022 10:47:38 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id q25so4371949edb.2
        for <linux-nfs@vger.kernel.org>; Thu, 06 Jan 2022 10:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MC9nUbuZNOi46TQBEH+CNW9ViAn+XFOUS/iJVSYhBg=;
        b=Su8At/j31FnXxBfvYde6nH+lJTOqsCJpP7rmEwRFZVPSf9g2DFeKkUeSG8FyXOObU/
         JHq2v2wa8uBT/or9AjQhh6rJw5H59l2U86JyuFHlPeGdV2HLDthxvr818oc1hsczgtbe
         A71IDQnjlazSU5j4iQBm1nDhoWn4tIRU7rC76GDV/SMMYR8eTEBcZAEO4CaNp+QV4iDl
         0vEZW0NQURGWjfGPlzqPzHjfPA0PQqVmSs8ostVsL5DQ/qfs2dXRFsTV1smgTKo59Wu/
         f7LOoAi2R5IsWi71NIydISRO2PkN3FD4vARnWlqvwyC88lrmOd70TlJbqRLQp4WPATwL
         pCTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MC9nUbuZNOi46TQBEH+CNW9ViAn+XFOUS/iJVSYhBg=;
        b=OiBUX1awiHzaq/lPJH5RDTUbz1+lCdKBLSJPFW6lVV4eUfLocwwr4yTNiIecRybukk
         5xNS9kwnHSaK3gBQiQ6YEv5UyKjkrpbnOFIItbgF+C1EN9UwLXPH/mQdZxdnnfZKC7j1
         Z3GLn/D95bG9AT9+vse4P5sBgqkmwCXS/UI/W8kdRmXmjifTWX0pkajr+mlEYTc2qoJH
         WGB65dTaTYvsEL7sSOSjb2X5TofMUZwydDJGychElPDAxXxKpzL4AUq3oxYogW67u73W
         Lcop7z7UavY//xGdhE+an9u5NwCUYN/3Hut0kdeNL/yJVyAUV9XgsUEHtxCgOMfF3hqy
         Bt8Q==
X-Gm-Message-State: AOAM532Efjz6tJoklTGtyyCq6caC7QoJkfzUdgMP/qG72MAaFsXbxULG
        Xq9xOSw2VpfXTXlwd86sHfIkA+cg29+mZp8iwKQ=
X-Google-Smtp-Source: ABdhPJzi3iq09YH14qwIeHEk3PbzMzC2ww/Y+Yo1FxyHNHueZ4Jldj80jdJjIVZB/ZzbMFBcaJQt2rW5ghFtrOXEDFI=
X-Received: by 2002:a05:6402:27cb:: with SMTP id c11mr8048373ede.86.1641494857405;
 Thu, 06 Jan 2022 10:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20211217204854.439578-1-trondmy@kernel.org> <20220103205103.GI21514@fieldses.org>
In-Reply-To: <20220103205103.GI21514@fieldses.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 6 Jan 2022 13:47:26 -0500
Message-ID: <CAN-5tyHFCcOyNmV9=mhCEUjqLoo49MgcsX8B9V58AWWL8iAdSQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Support btime and other NFSv4 specific attributes
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     trondmy@kernel.org, Anna Schumaker <anna.schumaker@netapp.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jan 3, 2022 at 4:34 PM J. Bruce Fields <bfields@fieldses.org> wrote:
>
> On Fri, Dec 17, 2021 at 03:48:46PM -0500, trondmy@kernel.org wrote:
> > From: Trond Myklebust <trond.myklebust@hammerspace.com>
> >
> > NFSv4 has support for a number of extra attributes that are of interest
> > to Samba when it is used to re-export a filesystem to Windows clients.
> > Aside from the btime, which is of interest in statx(), Windows clients
> > have an interest in determining the status of the 'hidden', and 'system'
> > flags.
> > Backup programs want to read the 'archive' flags and the 'time backup'
> > attribute.
> > Finally, the 'offline' flag can tell whether or not a file needs to be
> > staged by an HSM system before it can be read or written to.
> >
> > The patch series also adds an ioctl() to allow userspace retrieval and
> > setting of these attributes where appropriate. It also adds an ioctl()
> > to allow retrieval of the raw NFSv4 ACCESS information, to allow more
> > fine grained determination of the user's access rights to a file or
> > directory. All of this information is of use for Samba.
>
> Same question, what filesystem and server are you testing against?

I have tested the patch set against the Netapp filer. generic/528
tests the btime attribute. I'm not sure if xfstests has any other
tests for archive, offline, hidden attributes.

>
> --b.
>
> >
> > Anne Marie Merritt (3):
> >   nfs: Add timecreate to nfs inode
> >   nfs: Add 'archive', 'hidden' and 'system' fields to nfs inode
> >   nfs: Add 'time backup' to nfs inode
> >
> > Richard Sharpe (1):
> >   NFS: Support statx_get and statx_set ioctls
> >
> > Trond Myklebust (4):
> >   NFS: Expand the type of nfs_fattr->valid
> >   NFS: Return the file btime in the statx results when appropriate
> >   NFSv4: Support the offline bit
> >   NFSv4: Add an ioctl to allow retrieval of the NFS raw ACCESS mask
> >
> >  fs/nfs/dir.c              |  71 ++---
> >  fs/nfs/getroot.c          |   3 +-
> >  fs/nfs/inode.c            | 147 +++++++++-
> >  fs/nfs/internal.h         |  10 +
> >  fs/nfs/nfs3proc.c         |   1 +
> >  fs/nfs/nfs4_fs.h          |  31 +++
> >  fs/nfs/nfs4file.c         | 550 ++++++++++++++++++++++++++++++++++++++
> >  fs/nfs/nfs4proc.c         | 175 +++++++++++-
> >  fs/nfs/nfs4trace.h        |   8 +-
> >  fs/nfs/nfs4xdr.c          | 240 +++++++++++++++--
> >  fs/nfs/nfstrace.c         |   5 +
> >  fs/nfs/nfstrace.h         |   9 +-
> >  fs/nfs/proc.c             |   1 +
> >  include/linux/nfs4.h      |   1 +
> >  include/linux/nfs_fs.h    |  15 ++
> >  include/linux/nfs_fs_sb.h |   2 +-
> >  include/linux/nfs_xdr.h   |  80 ++++--
> >  include/uapi/linux/nfs.h  | 101 +++++++
> >  18 files changed, 1356 insertions(+), 94 deletions(-)
> >
> > --
> > 2.33.1
