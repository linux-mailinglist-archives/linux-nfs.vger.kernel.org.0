Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30DEF35A5EC
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Apr 2021 20:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhDISjv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 9 Apr 2021 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDISju (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 9 Apr 2021 14:39:50 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FF3C061762
        for <linux-nfs@vger.kernel.org>; Fri,  9 Apr 2021 11:39:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id w3so10180675ejc.4
        for <linux-nfs@vger.kernel.org>; Fri, 09 Apr 2021 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvijU2l04SP21LaBT0EZ8w/z2QGOnXClpPPM+yDJts8=;
        b=aVp1iJfT+YtjkgKK1B4+f+UkzP6io5gi5AwWKICYzToBJ2axkfvoGYUXp8DO6AiMyd
         Nb9bo8pnZ5nyEXte+WcX8Ib16Tj/rYyQzN6GNWQDeNS+HyL1WZLCVcE4JhxtkwSzB0zm
         6ed5zZiq/JfxrehrGcqxQx93tvr0iFKy4qLHkOX7LWnHLPkSmex7LROe9pUOpdd9ZkSb
         o+H0dTXitRqrc9CPzxNehCJEEM/rGdGr6P9i24tWHKUvgGvdeOX78gyB/r0tNVueBjKw
         VxaBt9kJYsGQdTTObIZ/Zi7nGuWoMtx2xh79gKl3NjUe5qV3Ztqv48SujgvQ2j9JKPsQ
         2NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvijU2l04SP21LaBT0EZ8w/z2QGOnXClpPPM+yDJts8=;
        b=eZMHZgVYkB9ALK3UpJcmQdpbAkx26wuUNTMAYKy3kIe1uDI+pisfqxPmIhf4XRWfPB
         9wzxS9ZjV3538Df8kNs51EW2GYMTmx/oQZRxlcUsTOMnWcLxIPyxf4zPgZKn2cabl2lo
         CUmdWHymGjqtxikrA6mIqRUA4Royl1AMCKPi+nEIwVSoRwA6bLwsc+asxDKu6fHy9ky9
         DjMJfJgyJtZhUQcUoFdvJz3c3oTp7RIPScdlKy+aQIp27BUqmFj2hi4V8Vzz3dHCoCKw
         tYIK7646NIVVssp2xvnnsca0hDTiq8JKBYFWwPi1jN0NIxL6u0E6aLt4vnc6I9eItEyO
         VAUg==
X-Gm-Message-State: AOAM531RA2xWeUSV4LemvrjjQiV8ZiaHmv3KyxB9iuaYD6Ezw1ZE/zjJ
        B8DAs097jTQlyOauRs8jcwMD0zAUOm6S9xf7q6mK0kHA
X-Google-Smtp-Source: ABdhPJxnXT1IpITv+/AlVkFegOaTDaJ501xZu+m07hUNu4a9aozOwex/GPsGBrhn+h7zuCISqWryjn8H2GHsp1ra1mA=
X-Received: by 2002:a17:907:2bc1:: with SMTP id gv1mr16564700ejc.388.1617993576212;
 Fri, 09 Apr 2021 11:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org> <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YGcq7T2wZHJvONHu@pick.fieldses.org>
In-Reply-To: <YGcq7T2wZHJvONHu@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Fri, 9 Apr 2021 14:39:24 -0400
Message-ID: <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the
 last hole
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 2, 2021 at 10:32 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
> > On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >
> > > On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > According to the RFC 7862, "if the server cannot find a
> > > > corresponding sa_what, then the status will still be NFS4_OK,
> > > > but sr_eof would be TRUE". If there is a file that ends with
> > > > a hole and a SEEK request made for sa_what=SEEK_DATA with
> > > > an offset in the middle of the last hole, then the server
> > > > has to return OK and set the eof. Currently the linux server
> > > > returns ERR_NXIO.
> > >
> > > Makes sense, but I think you can use the return value from vfs_llseek
> > > instead of checking the file size again.  E.g.:
> > >
> > >         seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
> > >         if (seek->seek_pos == -ENXIO)
> > >                 seek->seek_eof = true;
> >
> > I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
> > specified seek_offset was beyond the end of the file the server must
> > return ERR_NXIO and not OK.
>
> OK, never mind.
>
> > and (2) for the same reason I need to
> > check if the requested type was looking for data but didn't find it
> > because the offset is in the middle of the hole but still within the
> > file size (thus the need to check if the seek_offset is within the
> > file size). But I'm happy to check specifically if the seek_pos was
> > ENXIO (and not the generic negative error) and then also check if
> > request was for data and request was within file size.
> >
> > Also while I'm fixing this and have your attention, Can you tell if
> > the "else if" condition in the original code makes sense to you. I
> > didn't touch it but I don't think it's correct. "else if
> > (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
> > believe this can ever happen. How can vfs_llseek() ever return a
> > position that is greater than the size of the file (or actually even
> > equal to it)?
>
> I agree, I don't get it either.

Any more thoughts about the forward progress of this patch? Are you
interested in taking it?

>
> --b.
>
> >
> > >         else if (seek->seek_pos < 0)
> > >                 status = nfserrno(seek->seek_pos);
> > >
> > > --b.
> > >
> > > >
> > > > Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfsd/nfs4proc.c | 10 +++++++---
> > > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > > > index e13c4c81fb89..2e7ceb9f1d5d 100644
> > > > --- a/fs/nfsd/nfs4proc.c
> > > > +++ b/fs/nfsd/nfs4proc.c
> > > > @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > > >        *        should ever file->f_pos.
> > > >        */
> > > >       seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> > > > -     if (seek->seek_pos < 0)
> > > > -             status = nfserrno(seek->seek_pos);
> > > > -     else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > > > +     if (seek->seek_pos < 0) {
> > > > +             if (whence == SEEK_DATA &&
> > > > +                 seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> > > > +                     seek->seek_eof = true;
> > > > +             else
> > > > +                     status = nfserrno(seek->seek_pos);
> > > > +     } else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > > >               seek->seek_eof = true;
> > > >
> > > >  out:
> > > > --
> > > > 2.18.2
> > > >
> > >
> >
>
