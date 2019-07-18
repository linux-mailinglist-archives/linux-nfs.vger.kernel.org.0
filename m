Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C36026C9EA
	for <lists+linux-nfs@lfdr.de>; Thu, 18 Jul 2019 09:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfGRH1B (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 18 Jul 2019 03:27:01 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:42669 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbfGRH1B (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 18 Jul 2019 03:27:01 -0400
Received: by mail-io1-f66.google.com with SMTP id e20so19564218iob.9
        for <linux-nfs@vger.kernel.org>; Thu, 18 Jul 2019 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=elastifile-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XZDPbf3fUxpUtWCiEtYq2MYMTFj1U09yzNVn1a4M8AY=;
        b=AuvAlURdpb6rmlrgdnZu+B5G58nHZioUeTn5YLidjdv/oXnBr+L3gEpbhOwig93N1G
         fORxO36GVjDHJ4IO4opVUTeXsWtyhvzHhEHG0vnceEgOx0IGRLc5nONsXcqu3Q/6l/ni
         zN++5sci8Pkv5v6/LFxn8FzpTeOGVlyLFxOgLR1Y3GQdYH3zh1+knCBAHJUC/He+YZ7m
         p5mfAewqDzXGtfeasBFH/dwjBpF2ujF0J1QgsYF18X4nicIkbWSRJRBYKQP8hrDUV4e8
         4B7Nw7GWHZ0liuQrHwEggSxpZHRrUaskl1Qc/gMxJ8w5Mx/2OufgmB/IIzyUSYox51kc
         im/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XZDPbf3fUxpUtWCiEtYq2MYMTFj1U09yzNVn1a4M8AY=;
        b=kSDPifbiWyGmED3kyDCxWTPcuy3mPyycdNTEobIZ1FQHd78oIgXczZ2omSDpSqp0Zk
         xC4jj6vRrZI4ci0YhNrRF8+rE0XIIqayf6+A80GDNEa2GhwnaOoL4VJippGWXckAAuh1
         HfJSCGsDvm4PcuhoYb8zC/rerobflH3jf0ZwY4zieG8lxLohlIJEaNjMO3Y9Qw7m8wXK
         RyUaXSx5Uqd+dOi4hQ0nIwNo2uDWLjT5vIzU0mFFhGDZitqHJ939dBMD/bQicQme2F4n
         5qmS47SeeJg8o+UsEhl9R3rNrP0tDVt46AjVmt+FE4KZjLppKMc7dIjOGCX8Qywz7tqR
         EapA==
X-Gm-Message-State: APjAAAWeWkM4MeyVqGIuSSS/onSxE74tfJbStIIxmjrScLll+A7KCKYw
        DJAAGbaXIFFHeK0Grz1HXDVsk4LCDh5nH4ieNR6cYQ==
X-Google-Smtp-Source: APXvYqwxq2JP14gus/wDfIHdQjxDnfW5ckc7l3+yOS3HxRJMaEWWYXwj9Xz5dKb+xryf5/Ob526h+zsIOxOApi1Pd88=
X-Received: by 2002:a5e:9b05:: with SMTP id j5mr14583489iok.75.1563434820679;
 Thu, 18 Jul 2019 00:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <CALDUuiDyf5mfNVLeTKHNkU+bTbsKLOoHw_rZm1khcaiep-cEDQ@mail.gmail.com>
 <CALDUuiDG8mKRtH+Zhoc7kQjoKN-SpTn-xaKm=oh+sXHDQ47sug@mail.gmail.com> <6A3988F2-45CB-4C2D-84D6-0D5826E77493@redhat.com>
In-Reply-To: <6A3988F2-45CB-4C2D-84D6-0D5826E77493@redhat.com>
From:   Noam Lewis <noam.lewis@elastifile.com>
Date:   Thu, 18 Jul 2019 10:26:24 +0300
Message-ID: <CALDUuiDey9rRVgsia8zH76uw10i7hQ0ttiME-HvkKyna3RYx6g@mail.gmail.com>
Subject: Re: large directory iteration (getdents) over NFS mount resets due to stat
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The patch seems to work nicely. getdents() doesn't get stuck /
iteration does not restart when accessing a non-cached file.

Thanks!

Can we agree this is the more correct behavior?
What's the next step?

On Wed, Jul 17, 2019 at 3:08 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> Maybe because we always drop the directory's page cache whenever we
> decide
> to switch to READDIRPLUS, even if we're already doing it..  I've not
> tested
> or checked very thoroughly if this is ok, but I think maybe want
> something
> like this:
>
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index 57b6a45576ad..acfe47668238 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -438,8 +438,8 @@ void nfs_force_use_readdirplus(struct inode *dir)
>          struct nfs_inode *nfsi = NFS_I(dir);
>
>          if (nfs_server_capable(dir, NFS_CAP_READDIRPLUS) &&
> -           !list_empty(&nfsi->open_files)) {
> -               set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags);
> +           !list_empty(&nfsi->open_files) &&
> +               !test_and_set_bit(NFS_INO_ADVISE_RDPLUS, &nfsi->flags))
> {
>                  invalidate_mapping_pages(dir->i_mapping, 0, -1);
>          }
>   }
>
> Want to give that a spin?
>
> Ben
>
> On 17 Jul 2019, at 2:44, Noam Lewis wrote:
>
> > I'm starting to think this is a bug. I can't see a good reason why
> > accessing (stat) a directory entry should cause the READDIRPLUS cookie
> > to be reset.
> >
> > It seems that the trigger for iteration reset is accessing a directory
> > entry that doesn't have a valid entry in the cache. If it does has a
> > valid cache entry it doesn't trigger the cookie reset. Note, it
> > doesn't matter if the entry (or traversed dir) has actually changed:
> > the reset occurs even if both did not change on the server side.
> >
> > Setting actimeo to a large enough value allows the dir iteration to
> > complete without any resets, but this is just a workaround that isn't
> > acceptable if the file system is being modified or if there isn't
> > enough memory. It's also heuristic and can lead to unexpected hiccups
> > if something in the environment changes.
> >
> > So my questions still stand: is this expected behavior? What's the
> > reason?
> >
> > P.S. I'm using NFSv3
> >
> > On Mon, Jul 15, 2019, 08:56 Noam Lewis <noam.lewis@elastifile.com>
> > wrote:
> >>
> >> I've encountered a problem while iterating large directories via an
> >> NFS mount.
> >>
> >> Scenario:
> >>
> >> 1. Linux NFS client iterates a directory with many (millions) of
> >> files, e.g. via getdents() until all entries are done. In my case,
> >> READDIRPLUS is being used under the hood. Trivial reproduction is to
> >> run: ls -la
> >> 2. At the same time, run the stat tool on a file inside that
> >> directory.
> >>
> >> The directory on the server is not being modified anywhere (on this
> >> client or any other client).
> >>
> >> Result: the next or ongoing getdents will get stuck for a long time
> >> (tens of seconds to minutes). It appears to be re-iterating some of
> >> the work it already did, by going back to a previous NFS READDIRPLUS
> >> cookie.
> >>
> >>
> >> Things I've tried as workarounds:
> >> - Mounting with nordirplus - the iteration doesn't seem to reset or
> >> at
> >> least getdents doesn't get stuck, but now I have tons of LOOKUPs, as
> >> expected.
> >> - Setting actimeo=(large number) doesn't affect the behavior
> >>
> >> Questions:
> >> 1. Why does the stat command cause this?
> >> 2. How can I avoid the reset, i.e. ensure forward progress of the dir
> >> iteration?
