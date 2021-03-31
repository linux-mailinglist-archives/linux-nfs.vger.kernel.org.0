Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E730350906
	for <lists+linux-nfs@lfdr.de>; Wed, 31 Mar 2021 23:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCaVZx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 31 Mar 2021 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhCaVZn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 31 Mar 2021 17:25:43 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F85C061574
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 14:25:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hq27so32178905ejc.9
        for <linux-nfs@vger.kernel.org>; Wed, 31 Mar 2021 14:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVMkjAvrddQ4WVD7IOWHoxPvfRGrLUoDA0Gj4mHAC+M=;
        b=WP4E3O6GI5oR4xc7qPBIkP13z6tOzJrjdF0NVDnDOm5qSSTtlPoz9rn/R2WwEz6C8k
         QnLhZx82oy8OsYPiwmKIwL2jkNmo5yHdohn5GQOQUwCj9TpwVTYf+4peBOiF5lff9JAS
         5h5M1IOi6p5kUapfnBPtDJLvQbtsmGz1jFmeHpqIC5b01In3zeyf+Yxhg6t9UZ+OzGxT
         4cc18flqmSmiIjRS2Ovc+eOvfvEH26uz9Ne2VzX9UM1JRwRcxpAziWmxmbG6BvnPSrzx
         trHLKlXRE1XArr8Mquu/qoNfZfP2w0njmErbwiOAwoqvNnD4Oz3atiYdiTj1lXJYhZVK
         afaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVMkjAvrddQ4WVD7IOWHoxPvfRGrLUoDA0Gj4mHAC+M=;
        b=NOofQTIdOqxy3wWygq8GsJMdaH05/UEy6ZIzBRlbSj1xMFCYyoJc52AlHPjiFzmfmy
         qi+L622uMRxDKiv2E3iF3JxbhCVOUxqF/PIBFFer/AZke/lg0hvYuFllgV9nS80lreCL
         HQvUZBFmxEKnUgRagasE7Tg/U80CwxnuIXysWBSc3PEHSvMGD4jZ/Ax+nu4CC462gMnr
         fVMQDmUbQtNSIk9WHkaXcyepFWpNiMyXXqs6/0V52xPUOFrBtESwBf1cNT5oN6QEpNSG
         kzoOyzu9emcjggzUHyOF2+qW5bjBdZluTQ3MaCzohtY6sPHXvLnQK2UAINdfoa2aIVLl
         H0YQ==
X-Gm-Message-State: AOAM531hnUy+xS9Goo1W1pyxSCGaPQRAkJvC3eo6kA7kRuGMQ79QnF8T
        vYid5em9EpGQ1fjMX5gR4I25BEmikt0TptVBSghUJeGg
X-Google-Smtp-Source: ABdhPJy4MQRwhxyrvfWzoTGVItl0Q68mlHauQl2/fCe1P7uxJH4j35GvfXaBhq4FkGOyPwdidZMx4DLP4S5bIC1nqEw=
X-Received: by 2002:a17:906:9243:: with SMTP id c3mr5992201ejx.388.1617225941923;
 Wed, 31 Mar 2021 14:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210331193025.25724-1-olga.kornievskaia@gmail.com>
 <0ca40f087491acec8f26816b43b6d64bb624c35e.camel@hammerspace.com>
 <CAN-5tyHQyHO8K7UjwhKhN9Xoz1nSXMB2cv8De=w9Rx-qphaHgg@mail.gmail.com> <93c81355cfe7df2d0f42fae52a84c869a4298cef.camel@hammerspace.com>
In-Reply-To: <93c81355cfe7df2d0f42fae52a84c869a4298cef.camel@hammerspace.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Wed, 31 Mar 2021 17:25:30 -0400
Message-ID: <CAN-5tyHhL5xNaWO1kw0Z5FBbngT8YHa_GJxaXu1wFLWB6-r33Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] NFSv4.2 fix handling of sr_eof in SEEK's reply
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Mar 31, 2021 at 5:07 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Wed, 2021-03-31 at 16:34 -0400, Olga Kornievskaia wrote:
> > On Wed, Mar 31, 2021 at 3:42 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Wed, 2021-03-31 at 15:30 -0400, Olga Kornievskaia wrote:
> > > > From: Olga Kornievskaia <kolga@netapp.com>
> > > >
> > > > Currently the client ignores the value of the sr_eof of the SEEK
> > > > operation. According to the spec, if the server didn't find the
> > > > requested extent and reached the end of the file, the server
> > > > would return sr_eof=true. In case the request for DATA and no
> > > > data was found (ie in the middle of the hole), then the lseek
> > > > expects that ENXIO would be returned.
> > > >
> > > > Fixes: 1c6dcbe5ceff8 ("NFS: Implement SEEK")
> > > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > > ---
> > > >  fs/nfs/nfs42proc.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
> > > > index 094024b0aca1..d359e712c11d 100644
> > > > --- a/fs/nfs/nfs42proc.c
> > > > +++ b/fs/nfs/nfs42proc.c
> > > > @@ -659,7 +659,10 @@ static loff_t _nfs42_proc_llseek(struct file
> > > > *filep,
> > > >         if (status)
> > > >                 return status;
> > > >
> > > > -       return vfs_setpos(filep, res.sr_offset, inode->i_sb-
> > > > > s_maxbytes);
> > > > +       if (whence == SEEK_DATA && res.sr_eof)
> > > > +               return -NFS4ERR_NXIO;
> > > > +       else
> > > > +               return vfs_setpos(filep, res.sr_offset, inode-
> > > > >i_sb-
> > > > > s_maxbytes);
> > > >  }
> > > >
> > > >  loff_t nfs42_proc_llseek(struct file *filep, loff_t offset, int
> > > > whence)
> > >
> > > Don't we also need to deal with SEEK_HOLE with the offset being
> > > greater
> > > than the end-of-file in the same way?
> >
> > We do not because if there is no hole extent after the requested
> > offset, then there is an implied hole which is at the end of the file.
> > So if sr_eof is true we still need to pay attention to the returned
> > offset (ie it should be end of the file) and it's not an error
> > condition.
>
> I'm asking because according to the manpage for lseek():
>
>        ENXIO  whence is SEEK_DATA or SEEK_HOLE, and offset is beyond  the  end
>               of  the file, or whence is SEEK_DATA and offset is within a hole
>               at the end of the file.
>
> i.e. the manpage implies that we should also be returning an error for
> SEEK_HOLE if the supplied offset is beyond eof. Are you saying that we
> currently do so?

Yes the server should do that. Client doesn't need to do anything
extra. This patch is to handle the discrepancy between what the
NFSv4.2 spec says and what the linux lseek expects (specifically the
last condition is what linux expects but spec says it has to be a
non-error condition).

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
