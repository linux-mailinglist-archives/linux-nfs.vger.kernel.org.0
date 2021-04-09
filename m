Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3385359479
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 07:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbhDIFYA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 01:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhDIFXt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 01:23:49 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEBCC061762
        for <linux-nfs@vger.kernel.org>; Thu,  8 Apr 2021 22:23:35 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id v23so1448433uaq.13
        for <linux-nfs@vger.kernel.org>; Thu, 08 Apr 2021 22:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gTs7X0Kha8yyPPjoketYAk4TM4kCJYNv+QtbVLV11qw=;
        b=JBxB536edN2icemaU8QdaNm6AYnLTCaemM3Ithzlz1Np8v6pO1wJVYu2ejP+rZfSsz
         3qTVcd9dZRn1Feo6qXBUuDjeMAnnW2T0zl5u/1BBTcFJ+rKqnzY7gZyIabasGO0cSGPX
         8205mExpo36r3SKCYZ/4AByGCO1VBW7dAvtH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gTs7X0Kha8yyPPjoketYAk4TM4kCJYNv+QtbVLV11qw=;
        b=ggiHA7wkb9cVbH+916hPntIBYnlLo2ss0x4+PUwOY2e2c0WqOKRT0cEytKWv9kB2QK
         4alz8ZrnimqQ4ecpJqOy7hvmUri83nyDfX+JcDVG7Iez3hzuLIPW/rDErFwMU53ROQIv
         J6KCBwyAlJ8o+X8sC7djU+QjI0H0ygBL1xQ6DWw7TXo6WLFkx9sPUPzfwElo9iwmpLVG
         8ThBj+FTSOs0XvHYxI3AGPEJs00aCzhJ8NgX6w8PBRziMl/Y7TVKfu0BXiXuvMkXSnKG
         U3Q16Y8lrHlk9j955At1Yf4OrvK6z3ohlJwd1a5Hkwwv2YQVL9+PHy5lk1qufOCF24al
         8O5A==
X-Gm-Message-State: AOAM530gB3FltPcuK5NMXtBPCwmo7/uVNsKUxYZk/FOTK0tYR/T3Ejgy
        7SVkn6eez8rl8bcJjDAhHTyCHtR7t9uNDaiy4UpTmQ==
X-Google-Smtp-Source: ABdhPJyiEqe2/5BdCT+RzysMIjR0yOEhjnFfYuWD4d3HBGwzC0gqP0VjxLNWerB7XM2SkAAm/TzcFU4LTi8Xfv/RYMA=
X-Received: by 2002:ab0:7593:: with SMTP id q19mr9451736uap.74.1617945814814;
 Thu, 08 Apr 2021 22:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210221195833.23828-1-lhenriques@suse.de> <20210222102456.6692-1-lhenriques@suse.de>
 <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
 <YDYpHccgM7agpdTQ@suse.de> <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
In-Reply-To: <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 9 Apr 2021 13:23:23 +0800
Message-ID: <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Feb 24, 2021 at 6:44 PM Nicolas Boichat <drinkcat@chromium.org> wro=
te:
>
> On Wed, Feb 24, 2021 at 6:22 PM Luis Henriques <lhenriques@suse.de> wrote=
:
> >
> > On Tue, Feb 23, 2021 at 08:00:54PM -0500, Olga Kornievskaia wrote:
> > > On Mon, Feb 22, 2021 at 5:25 AM Luis Henriques <lhenriques@suse.de> w=
rote:
> > > >
> > > > A regression has been reported by Nicolas Boichat, found while usin=
g the
> > > > copy_file_range syscall to copy a tracefs file.  Before commit
> > > > 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") =
the
> > > > kernel would return -EXDEV to userspace when trying to copy a file =
across
> > > > different filesystems.  After this commit, the syscall doesn't fail=
 anymore
> > > > and instead returns zero (zero bytes copied), as this file's conten=
t is
> > > > generated on-the-fly and thus reports a size of zero.
> > > >
> > > > This patch restores some cross-filesystem copy restrictions that ex=
isted
> > > > prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy a=
cross
> > > > devices").  Filesystems are still allowed to fall-back to the VFS
> > > > generic_copy_file_range() implementation, but that has now to be do=
ne
> > > > explicitly.
> > > >
> > > > nfsd is also modified to fall-back into generic_copy_file_range() i=
n case
> > > > vfs_copy_file_range() fails with -EOPNOTSUPP or -EXDEV.
> > > >
> > > > Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across dev=
ices")
> > > > Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-=
1-drinkcat@chromium.org/
> > > > Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0x=
x+BnvW=3DZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
> > > > Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7=
cdc3ff707bc1efa17f5366057d60603c45f@changeid/
> > > > Reported-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > >
> > > I tested v8 and I believe it works for NFS.
> >
> > Thanks a lot for the testing.  And to everyone else for reviews,
> > feedback,... and patience.
>
> Thanks so much to you!!!
>
> Works here, you can add my
> Tested-by: Nicolas Boichat <drinkcat@chromium.org>

What happened to this patch? It does not seem to have been picked up
yet? Any reason why?

> >
> > I'll now go look into the manpage and see what needs to be changed.
> >
> > Cheers,
> > --
> > Lu=C3=ADs
