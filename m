Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E593A351D4E
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhDAS1x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 14:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbhDASPl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 14:15:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6B7C08EA6C
        for <linux-nfs@vger.kernel.org>; Thu,  1 Apr 2021 06:28:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bx7so1936706edb.12
        for <linux-nfs@vger.kernel.org>; Thu, 01 Apr 2021 06:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFeQXUmBBzjvxm5Akvjllspdul7zhPU0c1iyWjZeU5g=;
        b=Jf1geZ+ZPCXqzPQGRKrMSClGVn0la/LzhmQVtJ2P3PwSfIEwMjSu/aFvz/QX6Uj7cj
         tCk7jAACgjZm/JUCqZ7Y5il3knx28z2Rat2MmGAWBgd/Ws/DY+rHq/vB+7ChIWVdIuw2
         ij3JcD+MmBggwGGy410PjEqmGzwmeLHutwU8fP4/a5fBKVLW8kg62fHRiAp2QVxfk3mL
         zuu0eH16qFN6izxEGy6HnQK8PaPVf/e94mvV86u6RA9yU/jGrRkwTLRvLRuhBbRFBa7Z
         I1jVDtZoVvpTQ0ZlPUM/+Evt9ZCrfggsp101zAiZT00ppZl67QEdaWUG/bj15MNSJ2Xk
         ZhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFeQXUmBBzjvxm5Akvjllspdul7zhPU0c1iyWjZeU5g=;
        b=OZMwoeLgrOppMgPnPCorZa2YCt2ewmQhBzjyC2fbOkCeRQqyozmhJuH/cWJiflJXh9
         C9SNQbXc4cj2Q/U8SuhJ8KjbkuXAfVGValI/PpflLSRPs09fqDSq9GuVpbX9xiIeqX23
         MUItA+htz+HweBt9V+rz0keQpYy7t8A/HbNMxVz4wXX9FjkEtaENBWtdVk9jXiupX7ot
         wGHATOw9z4qmoYZxYRHJrEuSW9mf/swHs6gXXhFOhqjzFEQ+aXWgzn4c90v75RB7O/Y5
         hq5rmA6RJFqPIwcYCcNWnR0K3tYoqYe5PyTD1VHtI+eCIp2zr52UY3WAEEHWF5b/vWX6
         KFFg==
X-Gm-Message-State: AOAM5311x9jYbMQxu9rwtkSZTbsgf3M5NH6SVitiBJgXZwky7ZlAsDYV
        02qLRAm3mQ9wRPMj9itma7iBkpnxLUx3EwOHN9C+I+m85wg=
X-Google-Smtp-Source: ABdhPJwz6pZnkZ5X9WSAmLCGokdrjj4tC4ZDqr8e2YOLGfTzNhAnyhHxC+NAWyx9S7rIYz2K6IY/JlTFSnxerFRQYS4=
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr9761823edu.67.1617283687669;
 Thu, 01 Apr 2021 06:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com> <YGUm7/HE3HqVJik2@pick.fieldses.org>
In-Reply-To: <YGUm7/HE3HqVJik2@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Thu, 1 Apr 2021 09:27:56 -0400
Message-ID: <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the
 last hole
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> > From: Olga Kornievskaia <kolga@netapp.com>
> >
> > According to the RFC 7862, "if the server cannot find a
> > corresponding sa_what, then the status will still be NFS4_OK,
> > but sr_eof would be TRUE". If there is a file that ends with
> > a hole and a SEEK request made for sa_what=SEEK_DATA with
> > an offset in the middle of the last hole, then the server
> > has to return OK and set the eof. Currently the linux server
> > returns ERR_NXIO.
>
> Makes sense, but I think you can use the return value from vfs_llseek
> instead of checking the file size again.  E.g.:
>
>         seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
>         if (seek->seek_pos == -ENXIO)
>                 seek->seek_eof = true;

I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
specified seek_offset was beyond the end of the file the server must
return ERR_NXIO and not OK. and (2) for the same reason I need to
check if the requested type was looking for data but didn't find it
because the offset is in the middle of the hole but still within the
file size (thus the need to check if the seek_offset is within the
file size). But I'm happy to check specifically if the seek_pos was
ENXIO (and not the generic negative error) and then also check if
request was for data and request was within file size.

Also while I'm fixing this and have your attention, Can you tell if
the "else if" condition in the original code makes sense to you. I
didn't touch it but I don't think it's correct. "else if
(seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
believe this can ever happen. How can vfs_llseek() ever return a
position that is greater than the size of the file (or actually even
equal to it)?

>         else if (seek->seek_pos < 0)
>                 status = nfserrno(seek->seek_pos);
>
> --b.
>
> >
> > Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > ---
> >  fs/nfsd/nfs4proc.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > index e13c4c81fb89..2e7ceb9f1d5d 100644
> > --- a/fs/nfsd/nfs4proc.c
> > +++ b/fs/nfsd/nfs4proc.c
> > @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> >        *        should ever file->f_pos.
> >        */
> >       seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> > -     if (seek->seek_pos < 0)
> > -             status = nfserrno(seek->seek_pos);
> > -     else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > +     if (seek->seek_pos < 0) {
> > +             if (whence == SEEK_DATA &&
> > +                 seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> > +                     seek->seek_eof = true;
> > +             else
> > +                     status = nfserrno(seek->seek_pos);
> > +     } else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> >               seek->seek_eof = true;
> >
> >  out:
> > --
> > 2.18.2
> >
>
