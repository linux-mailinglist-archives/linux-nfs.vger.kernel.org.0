Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36C035E2EB
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239012AbhDMPcY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 11:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhDMPcY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 13 Apr 2021 11:32:24 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790CC061574
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 08:32:04 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id s15so19908459edd.4
        for <linux-nfs@vger.kernel.org>; Tue, 13 Apr 2021 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qt0EHmGUdqumrZlf7Rqyhl2WHyDlHrI4e3YRO3AOzDU=;
        b=GFpYLiJITCk5BqgInuDFUk75CFixaGjV7HfqzKIM+hOzwZ/wRIbG3dil6jVBklph+R
         1jvO8fTnTJN90+D3j2NZizapSA88AEm13VI5g+jdxdztj1H939nyzPZlYtrQ7bwOFwBg
         468MWeFFAzP8BIDK2mKQXM3tKqImSJVsyAxXd1T6sC+jlJcHQmVLRXKPceQP6kXGdvYy
         JPeQxFHxH1FdWg9+pR69P+NYdRQQug0jnXklt1xHo6ZLgjFEK+ah6N83hGYKhUisKF3W
         RrNaSIqlNtcHPnyMe6J7tyz5SPgS/guf4yE+RJ1PnJ3zWiUYmTeD+uWqkXYVDc5UFPoy
         Tcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qt0EHmGUdqumrZlf7Rqyhl2WHyDlHrI4e3YRO3AOzDU=;
        b=rRqKEReKWKmR/Z8CvsQuiYCgNXwTVmXX9iVQNGEZ5DQ1w+fSk+IWjMrztLPLWdsaNt
         PrIAycKsIzFULDZTdsKdvKwrrALX1qIYtMnlexhpxdLpGckzEw4N7/OJrOfnfjp/zZHv
         lSHJk+GtHAHBN+1+5+eLNJvmdH2dV7pbT4ktTuh7rvmEYHQbXjab8YIgIArofHZgp9x4
         3x369TDMKoRTxZRclQvk6YXxQvXDDO6PPFRu7BgBZxk/nc8LuTeGIrs5XhgSwOYtvfBJ
         APUOTzbfleMMy19Hm0WXP8OkhUvLAnRYB1xPM8Pu3fpi98s42NMMWEjk4OqINvjau+rj
         nYxw==
X-Gm-Message-State: AOAM533UBZ7uKtCeNg3E2T/U0reRPXQJCjNX4X/rovmgAzLZ1CFFMdQy
        1v0wSEL1fSQTonTrKzpdFm8K2L/GcMpcw1qeIF/f/pCB
X-Google-Smtp-Source: ABdhPJzRst2xGM4YRgn+uS9jlW7jDer/WN6CdO0BCke1auPcB18GUMNNGa/bx1VZ896GfbhExDzlsfXG2ICo1SfkEME=
X-Received: by 2002:aa7:cdcf:: with SMTP id h15mr35420977edw.28.1618327922956;
 Tue, 13 Apr 2021 08:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210331192819.25637-1-olga.kornievskaia@gmail.com>
 <YGUm7/HE3HqVJik2@pick.fieldses.org> <CAN-5tyETvKvUq_X7+2E0o=9GjJ628DC=QJW5xKA2-X7UHc_DOw@mail.gmail.com>
 <YGcq7T2wZHJvONHu@pick.fieldses.org> <CAN-5tyHBr-H3UjAMHqAQTUPSe_w-wwd4Pqb=WuvkCFfvxnOo_Q@mail.gmail.com>
 <2ACF7423-7162-4880-B8B7-4580208925E5@oracle.com> <YHWyRNTZ6QyAgcIW@pick.fieldses.org>
In-Reply-To: <YHWyRNTZ6QyAgcIW@pick.fieldses.org>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 13 Apr 2021 11:31:51 -0400
Message-ID: <CAN-5tyEp5=QEMRsObv9dy7Yi7jd+cqtEv4S5TRkSnb=ix5rf1Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSD fix handling of NFSv4.2 SEEK for data within the
 last hole
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 13, 2021 at 11:01 AM J. Bruce Fields <bfields@redhat.com> wrote:
>
> On Sun, Apr 11, 2021 at 04:43:22PM +0000, Chuck Lever III wrote:
> >
> >
> > > On Apr 9, 2021, at 2:39 PM, Olga Kornievskaia <olga.kornievskaia@gmail.com> wrote:
> > >
> > > On Fri, Apr 2, 2021 at 10:32 AM J. Bruce Fields <bfields@redhat.com> wrote:
> > >>
> > >> On Thu, Apr 01, 2021 at 09:27:56AM -0400, Olga Kornievskaia wrote:
> > >>> On Wed, Mar 31, 2021 at 9:50 PM J. Bruce Fields <bfields@redhat.com> wrote:
> > >>>>
> > >>>> On Wed, Mar 31, 2021 at 03:28:19PM -0400, Olga Kornievskaia wrote:
> > >>>>> From: Olga Kornievskaia <kolga@netapp.com>
> > >>>>>
> > >>>>> According to the RFC 7862, "if the server cannot find a
> > >>>>> corresponding sa_what, then the status will still be NFS4_OK,
> > >>>>> but sr_eof would be TRUE". If there is a file that ends with
> > >>>>> a hole and a SEEK request made for sa_what=SEEK_DATA with
> > >>>>> an offset in the middle of the last hole, then the server
> > >>>>> has to return OK and set the eof. Currently the linux server
> > >>>>> returns ERR_NXIO.
> > >>>>
> > >>>> Makes sense, but I think you can use the return value from vfs_llseek
> > >>>> instead of checking the file size again.  E.g.:
> > >>>>
> > >>>>        seek->seek_pos = vfs_llseek(nfs->nf_file, seek->seek_offset, whence);
> > >>>>        if (seek->seek_pos == -ENXIO)
> > >>>>                seek->seek_eof = true;
> > >>>
> > >>> I don't believe this is correct. (1) ENXIO doesn't imply eof. If the
> > >>> specified seek_offset was beyond the end of the file the server must
> > >>> return ERR_NXIO and not OK.
> > >>
> > >> OK, never mind.
> > >>
> > >>> and (2) for the same reason I need to
> > >>> check if the requested type was looking for data but didn't find it
> > >>> because the offset is in the middle of the hole but still within the
> > >>> file size (thus the need to check if the seek_offset is within the
> > >>> file size). But I'm happy to check specifically if the seek_pos was
> > >>> ENXIO (and not the generic negative error) and then also check if
> > >>> request was for data and request was within file size.
> > >>>
> > >>> Also while I'm fixing this and have your attention, Can you tell if
> > >>> the "else if" condition in the original code makes sense to you. I
> > >>> didn't touch it but I don't think it's correct. "else if
> > >>> (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))" I don't
> > >>> believe this can ever happen. How can vfs_llseek() ever return a
> > >>> position that is greater than the size of the file (or actually even
> > >>> equal to it)?
> > >>
> > >> I agree, I don't get it either.
> > >
> > > Any more thoughts about the forward progress of this patch? Are you
> > > interested in taking it?
> >
> > Bruce and I discussed this privately a few days back. He asked
> > that I not merge it until the client compatibility issue is
> > resolved. Bruce, please chime in if I misunderstood you.
>
> Honestly, I haven't even looked at what the issue is.  I think Olga
> agreed with Rick that there was one, though?

I agree that the client is broken. I have a client side patch that was
posted alongside the server side patch. I think Trond should be taking
it for whatever the next push will be. But yes the server side needs
to worry about the existing broken clients that are out there
currently. I'm not sure what the implications are. So what happens
with the fixed server is that for the request for DATA in the last
hole, the server would return OK, eof and offset that max_int (-1)
(previously it would be an error). Broken client would return that
address back in the system call. If the application tries to read from
it, it would not get anything (0, oef).

I think I'll repost the v2 and then I'll let you decide when and how
you want to take it. The client will soon be able to handle both but
it doesn't require the server to be fixed.

>
> --b.
>
> >
> >
> > >> --b.
> > >>
> > >>>
> > >>>>        else if (seek->seek_pos < 0)
> > >>>>                status = nfserrno(seek->seek_pos);
> > >>>>
> > >>>> --b.
> > >>>>
> > >>>>>
> > >>>>> Fixes: 24bab491220fa ("NFSD: Implement SEEK")
> > >>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > >>>>> ---
> > >>>>> fs/nfsd/nfs4proc.c | 10 +++++++---
> > >>>>> 1 file changed, 7 insertions(+), 3 deletions(-)
> > >>>>>
> > >>>>> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> > >>>>> index e13c4c81fb89..2e7ceb9f1d5d 100644
> > >>>>> --- a/fs/nfsd/nfs4proc.c
> > >>>>> +++ b/fs/nfsd/nfs4proc.c
> > >>>>> @@ -1737,9 +1737,13 @@ nfsd4_seek(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
> > >>>>>       *        should ever file->f_pos.
> > >>>>>       */
> > >>>>>      seek->seek_pos = vfs_llseek(nf->nf_file, seek->seek_offset, whence);
> > >>>>> -     if (seek->seek_pos < 0)
> > >>>>> -             status = nfserrno(seek->seek_pos);
> > >>>>> -     else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > >>>>> +     if (seek->seek_pos < 0) {
> > >>>>> +             if (whence == SEEK_DATA &&
> > >>>>> +                 seek->seek_offset < i_size_read(file_inode(nf->nf_file)))
> > >>>>> +                     seek->seek_eof = true;
> > >>>>> +             else
> > >>>>> +                     status = nfserrno(seek->seek_pos);
> > >>>>> +     } else if (seek->seek_pos >= i_size_read(file_inode(nf->nf_file)))
> > >>>>>              seek->seek_eof = true;
> > >>>>>
> > >>>>> out:
> > >>>>> --
> > >>>>> 2.18.2
> >
> > --
> > Chuck Lever
> >
> >
> >
>
