Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC2101BD211
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgD2CG6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 22:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgD2CG6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 22:06:58 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E16C03C1AC
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 19:06:57 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s3so289824eji.6
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 19:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RHYB7piIqSayE9OxHKV4cM1EI6X3+se2sir4MhViPkY=;
        b=b+j6Gr0FmFaZtSd14OYT6otb08x5E6BKAsipAvZWkb1ykCFrNBmDmKS3BTya0X3Mmm
         MSh2fCaFbCzRWEsy2kVr8sUfFdc2AyIXVBjLSUwjZKrYaTF8QeRTB05mmQzsx/qAYQpO
         LCVqrrCpxrGJWF8KivoCB3lMl/I62mCQM298UNXA/4OKqVlit/T0cFv2hSzdiXx4FpdL
         TPhtEpw0VFvH5z67UhYE6SDsSpytMOEmOZNrUxaYEvRpXKxx2Wo7uKVGZOVTe7r4Ju5q
         +JxjJy0I/9Mh6rgiNVU3uq5XfG1Cps9piLy0FwS5Hd6En9jdgTvQ/SNIdSurj07IS7RA
         wDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RHYB7piIqSayE9OxHKV4cM1EI6X3+se2sir4MhViPkY=;
        b=Y0RmA0ZlFf3l6H4EVBby+A0hhCFdCm2UccWJ7LUbPkB5JRIZ1/2u2QGzDjsWsvKHZo
         w5TuHIla2WkO6mF22fFMqc1/X9KBbcNgS+fljs/lODeC1Hr6pXN+R8XKda/fjFtW7cPo
         fTuH2wQK4t4zr5I9X2AlTHydQ9IgoFUzhQ/gi1ujBY0+Y5G1R0CPffLT53G+2OE2SbRt
         9wCAO8ExtYpfkZW8BwAYEXIffLWpgTYS4uEjHqWJQYnW/zSL9yuUBjx7V7h7eN+Z7EJN
         jUysCNMTCe/KE/XSVkG/TnqsIkYThN24VCsoPOg4TPxgyyrKfYIwmc/PU3GIIeZuWY2p
         3VMg==
X-Gm-Message-State: AGi0PuaFvtSqmQ9Lqpupx1YbHRV6DlgOhODirELkqg2WtLW38XUzmJPq
        MysqYjGuSf/9k0dAoDu2RrPpa/+lgbikFWzwrVwSbg==
X-Google-Smtp-Source: APiQypKdU8netU5hWkespmHwwwd1n2PBJ+KmV7xDHy4QOvZ7Baewci2o0pcMjPOD61pC12VP4Xs53PVYj+R6oSnR9zI=
X-Received: by 2002:a17:906:2792:: with SMTP id j18mr569256ejc.215.1588126015306;
 Tue, 28 Apr 2020 19:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com>
 <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
 <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com> <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
In-Reply-To: <b96e65b7aeb72e466d2a0170d4347652b6ab0ec5.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 22:06:44 -0400
Message-ID: <CAN-5tyFOrb0bNWYon9QTQqWdhv4LG+-zBVbBt2E1NE=rwsBScg@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 7:42 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-04-28 at 19:02 -0400, Olga Kornievskaia wrote:
> > On Tue, Apr 28, 2020 at 5:32 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Tue, 2020-04-28 at 16:40 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Apr 28, 2020 at 2:47 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > > Hi Olga,
> > > > >
> > > > > On Tue, 2020-04-28 at 14:14 -0400, Olga Kornievskaia wrote:
> > > > > > Hi folk,
> > > > > >
> > > > > > Looking for guidance on what folks think. A client is sending
> > > > > > a
> > > > > > LINK
> > > > > > operation to the server. This compound after the LINK has
> > > > > > RESTOREFH
> > > > > > and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But
> > > > > > LINK is
> > > > > > done successfully. Client still fails the system call with
> > > > > > EIO.
> > > > > > We
> > > > > > have a hardline and "ln" saying hardlink failed.
> > > > > >
> > > > > > Should the client not fail the system call in this case? The
> > > > > > fact
> > > > > > that
> > > > > > we couldn't get up-to-date attributes don't seem like the
> > > > > > reason
> > > > > > to
> > > > > > fail the system call?
> > > > > >
> > > > > > Thank you.
> > > > >
> > > > > I don't really see this as worth fixing on the client. It is
> > > > > very
> > > > > clearly a server bug.
> > > >
> > > > Why is that a server bug? A server can legitimately have an issue
> > > > trying to execute an operation (RESTOREFH) and legitimately
> > > > returning
> > > > an error.
> > >
> > > If it is happening consistently on the server, then it is a bug,
> > > and it
> > > gets reported by the client in the same way we always report
> > > NFS4ERR_SERVERFAULT, by converting to an EREMOTEIO.
> >
> > Yes but the client doesn't retry so it can't assess if it's
> > consistently happening or not. It can be a transient error (or
> > ENOMEM)
> > that's later resolved.
>
> If the server wants to signal a transient error, it should send
> NFS4ERR_DELAY.

ERR_DELAY not an allowed error for the RESTOREFH. But let's say, the
server does return it, then client is not following the spec because
if it'll get this error, it will retry the whole compound (causing a
different error of redoing a non-idempotent operation). The spec says
client is responsible for handling partially completed compound. The
client should only retry the failed operations in a compound, I don't
see that client does that.

> > > > NFS client also ignores errors of the returning GETATTR after the
> > > > RESTOREFH. So I'm not sure why we are then not ignoring errors
> > > > (or
> > > > some errors) of the RESTOREFH.
> > >
> > > We do need to check the value of RESTOREFH in order to figure out
> > > if we
> > > can continue reading the XDR buffer to decode the file attributes.
> > > We
> > > want to read those file attributes because we do expect the change
> > > attribute, the ctime and the nlinks values to all change as a
> > > result of
> > > the operation.
> >
> > I have nothing against decoding the error and using it in a decision
> > to keep decoding. But the client doesn't have to propagate the
> > RESTOREFH error to the application?
> >
> > In all other non-idempotent operations that have other operations (ie
> > GETATTR) following them, the client ignores the errors. Btw I just
> > noticed that on OPEN compound, since we ignore decode error from the
> > GETATTR, it would continue decoding LAYOUTGET...
> >
> > CREATE has problem if the following GETFH will return EDELAY. Client
> > doesn't deal with retrying a part of the compound. It retries the
> > whole compound. It leads to an error (since non-idempotent operation
> > is retried). But I guess that's a 2nd issue (or a 3rd if we could the
> > decoding layoutget)....
> >
> > All this is under the umbrella of how to handle errors on
> > non-idempotent operations in a compound....
>
> There is no point in trying to handle errors that make no sense. If the
> server has a bug, then let's expose it instead of trying to hide it in
> the sofa cushions.

EDELAY on GETFH is a reasonable error for the server to return.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
