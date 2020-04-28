Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BB1BD04F
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Apr 2020 01:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgD1XDB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1XDA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 19:03:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EEC03C1AD
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 16:02:59 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f12so283377edn.12
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 16:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9YTlL9NFYEqNGL5jHt8OJmVTo8me1tB7nLrrpAy4Zm4=;
        b=ijgcK9CuM9fQjgzjt2XoK1uh3UVI0Ikbh6Bwzng9Bn+JW2QY2bZlGTprNxmLXvEnX4
         SguNUdpsEccoyUwyjLiaHw4Xtt2p+V+gCh4S5siGpjXPYHK2YGcf7bUjiX9rz3A0oRG1
         stMP3UrpauCqtKqEzqhnQQvdEsmNTfRD1khKmJXTOBYXYc8kz25vAxR3lizxF7PA3OuB
         MVN/TjHS1X8u7K1E7G/NmvaTOt16JVbOGz6rirQ5c9Tf9JSBd0qG0NTJAMQ8KOu/BAEm
         tKwzom6ALj8qkyOCVbd/2e2x3HB1GtVHsHUaZR9T3jQxSkimz+zFESXTruKrd/w9dDb5
         ntPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9YTlL9NFYEqNGL5jHt8OJmVTo8me1tB7nLrrpAy4Zm4=;
        b=T4IhA4SeH2Ez8c5yDvqUZPD3qcHROffYy8DDzCG2rddXuC0SDgzEK8LSqGo0flm7el
         TexlaD5w32BHqbWeajM8bk17X27vrqzfPcyMFEUqXmmTPzXdnBXDIwHlodRLh3ZW/FHR
         N2SeJUjJ5+X3nDnghqlE4TQR4kSAzlh9XIRLFjUlgD7PgDFx5j3cIqzKpHECsUl26V4f
         ZylVnMkB0R1fV95Pv6NGQfWPiM42Lr81g+SpjODeMt7RwGUYjaitQcCmMxmNngu/h1gP
         xFsqz/KfUFtt403gaOTxM7JAwqdX9nAwpzWYjnyCqPFFFEYQNEckUqXlYoNXjFgPStkn
         JulQ==
X-Gm-Message-State: AGi0PubHpfIc8mzCHBJaLr8bPtX+kJ656lbF3dEtMI3ja0ltVYb8AHM0
        XWpQa2HRHuI9ueHGRiDICkZOhIDWTKWbaCSwp5b2VQ==
X-Google-Smtp-Source: APiQypIqB8e6lPK4DRdlEFdLX4rNSosRO/xWqOOsnpXvEimm2RdFPI6Y191z3J+uHJ48BPaCPQXu9Re33YbgSaLgWp4=
X-Received: by 2002:a05:6402:1215:: with SMTP id c21mr90988edw.128.1588114977703;
 Tue, 28 Apr 2020 16:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
 <98410608e028cb4b53024c7669e0fb70fea98214.camel@hammerspace.com>
 <CAN-5tyGDC9ittxr7d4wL_fKLQu9NLdZWwB19iEPsCn+Y0_sqVg@mail.gmail.com> <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
In-Reply-To: <98a10c8775e4127419ac57630f839744bdf1063d.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 19:02:46 -0400
Message-ID: <CAN-5tyGfCXVTz4dq3Qj2eXww8BNB_dT=0QwWteEGM93MZBJudw@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 5:32 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-04-28 at 16:40 -0400, Olga Kornievskaia wrote:
> > On Tue, Apr 28, 2020 at 2:47 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > Hi Olga,
> > >
> > > On Tue, 2020-04-28 at 14:14 -0400, Olga Kornievskaia wrote:
> > > > Hi folk,
> > > >
> > > > Looking for guidance on what folks think. A client is sending a
> > > > LINK
> > > > operation to the server. This compound after the LINK has
> > > > RESTOREFH
> > > > and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But
> > > > LINK is
> > > > done successfully. Client still fails the system call with EIO.
> > > > We
> > > > have a hardline and "ln" saying hardlink failed.
> > > >
> > > > Should the client not fail the system call in this case? The fact
> > > > that
> > > > we couldn't get up-to-date attributes don't seem like the reason
> > > > to
> > > > fail the system call?
> > > >
> > > > Thank you.
> > >
> > > I don't really see this as worth fixing on the client. It is very
> > > clearly a server bug.
> >
> > Why is that a server bug? A server can legitimately have an issue
> > trying to execute an operation (RESTOREFH) and legitimately returning
> > an error.
>
> If it is happening consistently on the server, then it is a bug, and it
> gets reported by the client in the same way we always report
> NFS4ERR_SERVERFAULT, by converting to an EREMOTEIO.

Yes but the client doesn't retry so it can't assess if it's
consistently happening or not. It can be a transient error (or ENOMEM)
that's later resolved.

> > NFS client also ignores errors of the returning GETATTR after the
> > RESTOREFH. So I'm not sure why we are then not ignoring errors (or
> > some errors) of the RESTOREFH.
>
> We do need to check the value of RESTOREFH in order to figure out if we
> can continue reading the XDR buffer to decode the file attributes. We
> want to read those file attributes because we do expect the change
> attribute, the ctime and the nlinks values to all change as a result of
> the operation.

I have nothing against decoding the error and using it in a decision
to keep decoding. But the client doesn't have to propagate the
RESTOREFH error to the application?

In all other non-idempotent operations that have other operations (ie
GETATTR) following them, the client ignores the errors. Btw I just
noticed that on OPEN compound, since we ignore decode error from the
GETATTR, it would continue decoding LAYOUTGET...

CREATE has problem if the following GETFH will return EDELAY. Client
doesn't deal with retrying a part of the compound. It retries the
whole compound. It leads to an error (since non-idempotent operation
is retried). But I guess that's a 2nd issue (or a 3rd if we could the
decoding layoutget)....

All this is under the umbrella of how to handle errors on
non-idempotent operations in a compound....


>
> Cheers
>   Trond
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
